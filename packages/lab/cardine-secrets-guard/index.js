// cardine-workspace-guard — de agent staat alleen in de workspace.
//
// Waarom een plugin en niet (alleen) bwrap: bash/grep draaien ín de
// bwrap-kooi (cardine-bwrap), maar de filesystem-tools draaien in het
// DSH-hostproces (dsh-fs-local: "cwd is a resolution default, not a
// containment boundary"). Alleen een tools/pre-execute-listener zit vóór
// die tools, binnen DSH, en overleeft DSH-updates.
//
// Dit is een ALLOWLIST, geen denylijst (ADR 0017, strikt profiel):
//   * elk pad buiten de open sessie wordt geweigerd — niet gevraagd,
//     want de approval-policy staat op `never`;
//   * de cwd van de sessie wint van CARDINE_WORKSPACE. Die variabele is
//     alleen de terugval als de sessie geen cwd heeft. Een pin op de repo
//     waar het lab is geïnstalleerd zou elke andere map blokkeren;
//   * binnen de workspace blijven .env/keys/certificaten dicht;
//   * write/edit zijn in het strikte profiel sowieso niet beschikbaar
//     (tool-fs met write/applyPatch uit); deze listener dekt ze toch, voor
//     als een ander profiel ze wel mount.
//
// Deny-only: een guard kan een call alleen weigeren, nooit goedkeuren.
// Pad-resolutie (realpath + parent-walk) i.p.v. tekst-matching, zodat
// `..`, symlinks en relatieve paden de regel niet omzeilen. Een pad dat
// nog niet bestaat wordt met de bestaande voorouder opgelost; de naam
// van het (nog niet bestaande) stuk wordt alsnog per segment getoetst.
//
// Zie docs/architecture/security.md en ADR 0017.

import { realpath } from "node:fs/promises";
import { homedir } from "node:os";
import { basename, dirname, isAbsolute, resolve, sep } from "node:path";

export const name = "cardine-workspace-guard";

/** Codes in tool_result.error.info.code — de model-context en logs zien ze. */
export const WORKSPACE_GUARD_DENIED = "WORKSPACE_GUARD_DENIED";

/**
 * Bestandsnamen die nooit gelezen of geschreven mogen worden, ook niet
 * binnen de workspace. `*.example` valt er bewust buiten: dat is de
 * documentatie zonder waarden.
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
 * Resolve een pad naar een canonieke absolute vorm. Bestaat het pad niet
 * (bv. een write naar een nieuw bestand), dan wordt de eerst bestaande
 * voorouder ge-realpath't en de rest er letterlijk aan geplakt; `..` en `.`
 * daarin zijn al door `resolve` genormaliseerd.
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
 * De workspace is de cwd van de open sessie. CARDINE_WORKSPACE wint daar
 * niet van: die variabele stond in de Zed-server op de repo waar
 * install-lab draaide, en blokkeerde daarna elke andere map (Caddie,
 * 2026-11-23). Zonder sessie-cwd blijft de variabele de terugval.
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
 * Waarom een canoniek pad geweigerd is, of undefined als het mag.
 * Volgorde: de workspace-allowlist eerst (dat is de grens), daarna de
 * geheimen (die blijven dicht, óók binnen de workspace).
 */
function reasonFor(canonicalPath, root) {
  if (!isUnder(canonicalPath, root)) {
    return "ligt buiten de workspace — de agent werkt alleen binnen het project; " +
      "vraag de gebruiker om dit zelf op het systeem uit te voeren";
  }
  // Binnen de workspace: *.example is documentatie, geen secret.
  if (/\.example$/.test(canonicalPath)) return undefined;
  for (const pattern of SECRET_FILE) {
    if (pattern.test(canonicalPath)) return "is een geheim bestand (.env/keys) in de workspace";
  }
  return undefined;
}

/** Paden die een tool-aanroep raakt, per toolnaam. */
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
      // apply_patch draagt freeform patchnotatie; lastig pad-voor-pad te
      // parsen. Weiger de aanroep als een pad erin buiten de workspace valt.
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
      `cardine-workspace-guard: "${toolName}" op "${path}" geweigerd — ${reason}. ` +
      `De workspace is "${root}". Er is geen goedkeuringspad: de gebruiker voert ` +
      "wijzigingen buiten het project zelf uit. Doe een voorstel (pad + exacte inhoud) " +
      "en vraag de gebruiker het toe te passen. Toon of lees nooit geheimen.",
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
          // apply_patch: toets elk token dat een pad lijkt.
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
