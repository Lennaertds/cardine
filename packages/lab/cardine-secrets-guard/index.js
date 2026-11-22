// cardine-secrets-guard — houdt de agent bij geheimen weg.
//
// Waarom een plugin en niet bwrap: bash/grep draaien ín de bwrap-kooi
// (cardine-bwrap), maar de filesystem-tools (read/write/edit/apply_patch)
// draaien in de DSH-hostprocess (dsh-fs-local: "cwd is a resolution
// default, not a containment boundary"). Alleen een tools/pre-execute-
// listener zit vóór die tools, binnen DSH, en overleeft DSH-updates.
//
// Deny-only: een guard kan een call alleen weigeren, nooit goedkeuren.
// Pad-resolutie (realpath + parent-walk) i.p.v. tekst-matching, zodat
// `..`, symlinks en relatieve paden de regel niet omzeilen. Een pad dat
// nog niet bestaat wordt met de bestaande voorouder opgelost; de naam
// van het (nog niet bestaande) stuk wordt alsnog per segment getoetst.
//
// Zie docs/architecture/security.md en ADR 0016.

import { realpath } from "node:fs/promises";
import { homedir } from "node:os";
import { basename, dirname, isAbsolute, resolve } from "node:path";

export const name = "cardine-secrets-guard";

/** Codes in tool_result.error.info.code — de model-context en logs zien ze. */
export const SECRETS_GUARD_DENIED = "SECRETS_GUARD_DENIED";

/**
 * Bestandsnamen die nooit gelezen of geschreven mogen worden. `*.example`
 * valt er bewust buiten: dat is de documentatie zonder waarden.
 */
const SECRET_FILE = [
  /(^|\/)\.env$/,
  /(^|\/)\.env\.(?!example$)[^/]+$/, // .env.local, .env.production, .env.observability.example? -> zie below
  /(^|\/)id_(rsa|ed25519|ecdsa|dsa)$/,
  /\.pem$/,
  /\.p12$/,
  /\.pfx$/,
];

/**
 * Mappen die de agent nooit in mag: de secrets-centrale, de DSH-home
 * (API-keys) en de SSH-map. Alles **binnen** een van deze paden is verboden,
 * ook als het bestand zelf niet op de lijst staat.
 */
function secretDirs(home) {
  return [
    resolve(home, ".secrets"),
    resolve(home, ".dsh"),
    resolve(home, ".ssh"),
    resolve(home, ".aws"),
    resolve(home, ".config", "gcloud"),
    resolve(home, ".kube"),
  ];
}

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

/** Waarom een canoniek pad geweigerd is, of undefined als het mag. */
function reasonFor(canonicalPath, home) {
  if (/\.example$/.test(canonicalPath)) return undefined;
  for (const dir of secretDirs(home)) {
    if (canonicalPath === dir || canonicalPath.startsWith(`${dir}/`)) {
      return `valt onder de afgeschermde map ${dir}`;
    }
  }
  for (const pattern of SECRET_FILE) {
    if (pattern.test(canonicalPath)) return "is een geheim bestand (.env/keys)";
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
      add(args.file_path);
      break;
    case "glob":
    case "grep":
      add(args.path);
      break;
    case "apply_patch":
      // apply_patch draagt freeform patchnotatie; lastig pad-voor-pad te
      // parsen. Weiger de aanroep als een geheim pad erin voorkomt.
      add(args.input);
      break;
    default:
      break;
  }
  return out;
}

/** greet de cwd van de sessie: relatief pad hoort bij die map. */
function cwdOf(exec) {
  try {
    return exec.agent?.session?.cwd ?? process.cwd();
  } catch {
    return process.cwd();
  }
}

function denial(toolName, path, reason) {
  return {
    kind: "deny",
    reason:
      `cardine-secrets-guard: "${toolName}" op "${path}" geweigerd — ${reason}. ` +
      "Geheimen staan in ~/.secrets (buiten de agent) en zijn nooit in code, tests, " +
      "logs of antwoorden te lezen. Vraag de gebruiker om de waarde via de shell-env " +
      "als je hem echt nodig hebt; lees of toon hem nooit.",
    info: { name: "SecretsGuardDenied", code: SECRETS_GUARD_DENIED },
  };
}

/** Installeer de guard vóór alle andere pre-execute-listeners. */
export function apply(ctx) {
  const home = homedir();
  ctx.effect(function* () {
    yield ctx.on(
      "tools/pre-execute",
      async (exec, next) => {
        const paths = targetsOf(exec.name, exec.arguments);
        if (paths.length === 0) return next();
        const cwd = cwdOf(exec);
        for (const path of paths) {
          // apply_patch: toets elk token dat een pad lijkt.
          const candidates =
            exec.name === "apply_patch" ? path.split(/\s+/).filter((t) => t.includes("/") || t.startsWith(".") || t.includes(".env")) : [path];
          for (const candidate of candidates) {
            const canon = await canonical(candidate, cwd);
            const reason = reasonFor(canon, home);
            if (reason !== undefined) return denial(exec.name, candidate, reason);
          }
        }
        return next();
      },
      { prepend: true },
    );
  });
}
