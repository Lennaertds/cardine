// cardine-workspace-guard — the agent stays inside the workspace.
//
// Why a plugin and not (only) bwrap: bash/grep run inside the bwrap cage
// (cardine-bwrap), but the filesystem tools run in the DSH host process
// (dsh-fs-local: "cwd is a resolution default, not a containment
// boundary"). Only a tools/pre-execute listener sits in front of those
// tools, inside DSH, and survives DSH updates.
//
// This is an ALLOWLIST, not a denylist (ADR 0017, strict profile):
//   * every path outside the open session is refused — not asked,
//     because the approval policy is `never`;
//   * the session's cwd wins over CARDINE_WORKSPACE. That variable is
//     only the fallback when the session has no cwd. Pinning it to the repo
//     where the lab was installed would block every other directory;
//   * inside the workspace .env files, keys and certificates stay closed;
//   * write/edit are not available in the strict profile anyway
//     (tool-fs with write/applyPatch off); this listener covers them in case
//     another profile does mount them.
//
// Deny-only: a guard can only refuse a call, never approve it.
// Path resolution (realpath + parent walk) instead of text matching, so that
// `..`, symlinks and relative paths cannot bypass the rule. A path that does
// not exist yet is resolved against its existing ancestor; the name of the
// (not yet existing) part is still checked per segment.
//
// See docs/architecture/security.md and ADR 0017.

import { realpath } from "node:fs/promises";
import { homedir } from "node:os";
import { basename, dirname, isAbsolute, resolve, sep } from "node:path";

export const name = "cardine-workspace-guard";

/** Codes in tool_result.error.info.code — the model context and logs see them. */
export const WORKSPACE_GUARD_DENIED = "WORKSPACE_GUARD_DENIED";

/**
 * File names that may never be read or written, not even inside the
 * workspace. `*.example` is deliberately excluded: that is the
 * documentation without values.
 */
const SECRET_FILE = [
  /(^|\/)\.env$/,
  /(^|\/)\.env\.(?!example$)[^/]+$/,
  /(^|\/)id_(rsa|ed25519|ecdsa|dsa)$/,
  /\.pem$/,
  /\.p12$/,
  /\.pfx$/,
];

/**
 * Resolve a path to a canonical absolute form. If the path does not exist
 * (e.g. a write to a new file), the nearest existing ancestor is realpath'd
 * and the rest is appended literally; `..` and `.` in it are already
 * normalised by `resolve`.
 */
async function canonical(path, cwd) {
  const absolute = isAbsolute(path) ? resolve(path) : resolve(cwd, path);
  let probe = absolute;
  const missing = [];
  for (;;) {
    try {
      const real = await realpath(probe);
      return missing.length === 0 ? real : resolve(real, ...missing.reverse());
    } catch (error) {
      if (error?.code !== "ENOENT" && error?.code !== "ENOTDIR") return absolute;
      const parent = dirname(probe);
      if (parent === probe) return absolute;
      missing.push(basename(probe));
      probe = parent;
    }
  }
}

/**
 * The workspace is the cwd of the open session. CARDINE_WORKSPACE does not
 * override that: the variable pointed at the repo where install-lab ran in
 * the Zed server, and then blocked every other folder (Caddie, 2026-11-23).
 * Without a session cwd the variable remains the fallback.
 */
function workspaceRootOf(exec) {
  const session = exec.agent?.session?.cwd;
  if (typeof session === "string" && session.trim() !== "") {
    return resolve(session);
  }
  const fromEnv = process.env.CARDINE_WORKSPACE;
  if (typeof fromEnv === "string" && fromEnv.trim() !== "") {
    return resolve(fromEnv);
  }
  return process.cwd();
}

/** Liggen `target` en `root` gelijk of onder elkaar? (`/a/b` ⊂ `/a`) */
function isUnder(target, root) {
  return target === root || target.startsWith(`${root}${sep}`);
}

/**
 * Why a canonical path is refused, or undefined when it is allowed.
 * Order: the workspace allowlist first (that is the boundary), then the
 * secrets (they stay closed, also inside the workspace).
 */
function reasonFor(canonicalPath, root) {
  if (!isUnder(canonicalPath, root)) {
    return "is outside the workspace — the agent works inside the project only; " +
      "ask the user to do this on the system themselves";
  }
  // Inside the workspace: *.example is documentation, not a secret.
  if (/\.example$/.test(canonicalPath)) return undefined;
  for (const pattern of SECRET_FILE) {
    if (pattern.test(canonicalPath)) return "is a secret file (.env/keys) inside the workspace";
  }
  return undefined;
}

/** Paths a tool call touches, per tool name. */
function targetsOf(toolName, args) {
  if (args === null || typeof args !== "object") return [];
  const out = [];
  const add = (value) => {
    if (typeof value === "string" && value.trim() !== "") out.push(value);
  };
  switch (toolName) {
    case "read":
    case "read_image":
    case "write":
    case "edit":
    case "list":
      add(args.file_path ?? args.path ?? args.dir);
      break;
    case "glob":
    case "grep":
      add(args.path);
      break;
    case "apply_patch":
      // apply_patch carries freeform patch notation; hard to parse path by
      // path. Refuse the call when any path inside it falls outside the workspace.
      add(args.input);
      break;
    default:
      break;
  }
  return out;
}

function cwdOf(exec) {
  try {
    return exec.agent?.session?.cwd ?? process.cwd();
  } catch {
    return process.cwd();
  }
}

async function denial(toolName, path, reason, root) {
  const canon = await canonical(isAbsolute(path) ? path : resolve(cwdOf({}), path), process.cwd()).catch(() => path);
  return {
    kind: "deny",
    reason:
      `cardine-workspace-guard: refused "${toolName}" on "${path}" — ${reason}. ` +
      `The workspace is "${root}". There is no approval path: the user makes ` +
      "changes outside the project themselves. Propose one (path plus exact contents) " +
      "and ask the user to apply it. Never show or read secrets.",
    info: { name: "WorkspaceGuardDenied", code: WORKSPACE_GUARD_DENIED, path: canon, workspace: root },
  };
}

/** Installeer de guard vóór alle andere pre-execute-listeners. */
export function apply(ctx) {
  ctx.effect(function* () {
    yield ctx.on(
      "tools/pre-execute",
      async (exec, next) => {
        const paths = targetsOf(exec.name, exec.arguments);
        if (paths.length === 0) return next();
        const cwd = cwdOf(exec);
        const root = await canonical(workspaceRootOf(exec), cwd);
        for (const path of paths) {
          // apply_patch: check every token that looks like a path.
          const candidates =
            exec.name === "apply_patch"
              ? path.split(/\s+/).filter((t) => t.includes("/") || t.startsWith(".") || t.includes(".env"))
              : [path];
          for (const candidate of candidates) {
            const canon = await canonical(candidate, cwd);
            const reason = reasonFor(canon, root);
            if (reason !== undefined) {
              return denial(exec.name, candidate, reason, root);
            }
          }
        }
        return next();
      },
      { prepend: true },
    );
  });
}
