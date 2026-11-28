#!/usr/bin/env node
// postinstall guard — the global npm prefix must be writable by the user.
//
// `npm i -g` on Arch installs into /usr/lib/node_modules (root-owned), so the
// first global install fails with EACCES before this script ever runs. The real
// value is the other case: an install that *succeeded* under sudo, or a prefix
// the user later lost write access to — then `npm update -g` fails silently
// months later, far from the cause. This script names the cause at install time.
//
// Never fails the install: a warning on stderr is enough.
"use strict";

const fs = require("fs");
const path = require("path");

const quiet = process.env.CARDINE_LAB_QUIET === "1" || process.env.CI === "true";

function warn(lines) {
  if (quiet) return;
  process.stderr.write("\n" + lines.join("\n") + "\n\n");
}

function main() {
  const pkgDir = path.resolve(__dirname, "..");
  // npm sets this for every lifecycle script; it points at the global prefix
  // for `-g` and at nothing for a local install. It also covers Windows layouts
  // (npm/, not lib/node_modules/), where walking up would land on the wrong dir.
  const globalPrefix = process.env.npm_config_prefix || null;
  // <prefix>/lib/node_modules/@lennaertds/cardine-lab  →  <prefix>
  const prefix =
    globalPrefix && path.isAbsolute(globalPrefix)
      ? globalPrefix
      : path.resolve(pkgDir, "..", "..", "..");

  // npm runs postinstall with cwd = the package dir. Install global means the
  // package dir and the cwd are the same directory; a local install runs from
  // the project root. That doubles as a fallback when the path layout differs.
  let local = false;
  try {
    local = fs.realpathSync(process.cwd()) !== fs.realpathSync(pkgDir);
  } catch {
    local = false;
  }
  if (local) return;

  let writable = false;
  try {
    fs.accessSync(prefix, fs.constants.W_OK);
    writable = true;
  } catch {
    writable = false;
  }
  if (writable) return;

  const uid = typeof process.getuid === "function" ? process.getuid() : "?";
  const hint = uid === 0 ? " (you installed as root — that is the cause)" : "";
  warn([
    "cardine-lab: installed into " + prefix + ", which is not writable by you" + hint + ".",
    "Updates will fail later with EACCES. Fix it once, then reinstall without sudo:",
    "",
    "  npm config set prefix ~/.local",
    '  export PATH="$HOME/.local/bin:$PATH"   # add to ~/.zshrc or ~/.bashrc',
    "  npm i -g @lennaertds/cardine-lab",
    "",
    "Set CARDINE_LAB_QUIET=1 to silence this notice.",
  ]);
}

try {
  main();
} catch {
  // Never break an install because of a notice.
}
