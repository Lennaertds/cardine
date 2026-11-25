#!/usr/bin/env bash
# check-sandbox.sh — the gate of ADR 0017. One matrix: route × direction.
#
# Cells a shell can measure are measured by this script (via check-bwrap-secrets.sh).
# Cells that only exist in a DSH process (read/glob, approval, or whether the
# tool is registered at all) are checked against the profile in install-lab.sh
# — that is the repo contract. The installed profile on this
# machine is a warning: a fresh checkout does not have it, and a
# deviating profile only applies after a new DSH session.
#
# Usage: bash packages/lab/scripts/check-sandbox.sh
set -euo pipefail

LAB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CARDINE_DIR="$(cd "$LAB_DIR/../.." && pwd)"
INSTALL="$LAB_DIR/install-lab.sh"
BWRAP="$LAB_DIR/cardine-bwrap"
PROFILE="${DSH_HOME:-$HOME/.dsh}/profiles/acp/cordis.patch.yml"

fails=0
warns=0
ok() { echo "  ok    $1"; }
warn() { echo "  WARNING  $1"; warns=$((warns + 1)); }
bad() { echo "  FAIL  $1"; fails=$((fails + 1)); }

echo "check-sandbox: shell cage"
if bash "$LAB_DIR/scripts/check-bwrap-secrets.sh"; then
  ok "shell read/write: inside yes, outside no, write visible on the host"
else
  bad "shell cage (check-bwrap-secrets)"
fi

echo "check-sandbox: leesgrens en repo-secrets"
if bash "$LAB_DIR/scripts/check-secrets.sh"; then
  ok "guard tests and no secret in git"
else
  bad "leesgrens (check-secrets)"
fi

echo "check-sandbox: profielbron (install-lab.sh)"
need() {
  local label="$1" pattern="$2"
  if grep -q "$pattern" "$INSTALL"; then
    ok "$label"
  else
    bad "$label ontbreekt in install-lab.sh"
  fi
}
need "sandbox-policy workspace-write" "mode: workspace-write"
need "approval never" "policy: never"
need "tool-fs write uit" "write: false"
need "tool-fs edit uit" "edit: false"
need "tool-fs applyPatch uit" "applyPatch: false"
need "workspaceRoot is de repo" 'workspaceRoot: ${REPO_ROOT}'
if grep -q 'process.cwd()' "$INSTALL"; then
  bad "install-lab.sh still uses process.cwd()"
else
  ok "no process.cwd() in the profile"
fi
if grep -q 'danger-full-access' "$INSTALL"; then
  bad "install-lab.sh still sets danger-full-access"
else
  ok "no danger-full-access in the profile"
fi
if grep -q 'tool-fs-search' "$INSTALL" && grep -A2 'id: tool-fs-search' "$INSTALL" | grep -q 'disabled: true'; then
  bad "tool-fs-search is off (glob/grep must stay on)"
else
  ok "glob/grep blijven aan"
fi

echo "check-sandbox: kooi-bron (cardine-bwrap)"
if grep -q 'tmp-overlay\|overlay-src' "$BWRAP"; then
  bad "cardine-bwrap still uses an overlay"
else
  ok "no overlay in cardine-bwrap"
fi
if grep -q -- '--bind "$tmp_dir" /tmp' "$BWRAP"; then
  ok "/tmp is a bind to a host folder"
else
  bad "/tmp is not a shared bind"
fi
if grep -q -- '--unshare-user' "$BWRAP"; then
  ok "user-namespace in cardine-bwrap"
else
  bad "cardine-bwrap has no user namespace"
fi
if grep -E -q '^[[:space:]]*--unshare-net[[:space:]]*$' "$BWRAP"; then
  bad "cardine-bwrap cuts off the network (ADR 0017: the network stays open)"
else
  ok "the shell network stays open"
fi

echo "check-sandbox: geïnstalleerd profiel"
if [[ -f "$PROFILE" ]]; then
  live_ok=1
  grep -q 'policy: never' "$PROFILE" || live_ok=0
  grep -q 'write: false' "$PROFILE" || live_ok=0
  grep -q 'edit: false' "$PROFILE" || live_ok=0
  grep -q 'mode: workspace-write' "$PROFILE" || live_ok=0
  if grep -q 'process.cwd()' "$PROFILE"; then
    live_ok=0
  fi
  if [[ "$live_ok" -eq 1 ]]; then
    ok "profile on disk matches (applies after a new DSH session)"
  else
    warn "profile on disk differs — rerun install-lab.sh, then restart DSH"
  fi
else
  warn "no $PROFILE — expected on a fresh checkout, locally: make install-lab"
fi

echo "check-sandbox: matrix"
echo "  shell read, inside the workspace      must   (measured)"
echo "  shell read, outside the workspace     must not (measured)"
echo "  shell write, inside the workspace     must, on the host (measured)"
echo "  shell write, outside                  must not, host unchanged (measured)"
echo "  read/glob/grep, inside the workspace  must   (guard test)"
echo "  read/glob/grep, outside               must not (guard test)"
echo "  write/edit/apply_patch                tool off (profile source)"
echo "  make check inside the cage            this gate"
echo "  approval dialog                       never (profile source)"
echo "  user namespace                        must (uid map, measured)"
echo "  outgoing TCP from the shell           must (measured)"

if [[ "$fails" -gt 0 ]]; then
  echo "check-sandbox: $fails failure(s), $warns warning(s)" >&2
  exit 1
fi
echo "check-sandbox: green ($warns warning(s))"
