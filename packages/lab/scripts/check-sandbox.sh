#!/usr/bin/env bash
# check-sandbox.sh — de sluis van ADR 0017. Eén matrix: route × richting.
#
# Cellen die een shell kan meten, meet dit script (via check-bwrap-secrets.sh).
# Cellen die alleen in een DSH-proces bestaan (read/glob, approval, of de
# tool wel geregistreerd is) worden aan het profiel in install-lab.sh
# getoetst — dat is het repo-contract. Het geïnstalleerde profiel op deze
# machine is een waarschuwing: een verse checkout heeft het niet, en een
# afwijkend profiel geldt pas na een nieuwe DSH-sessie.
#
# Gebruik: bash packages/lab/scripts/check-sandbox.sh
set -euo pipefail

LAB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CARDINE_DIR="$(cd "$LAB_DIR/../.." && pwd)"
INSTALL="$LAB_DIR/install-lab.sh"
BWRAP="$LAB_DIR/cardine-bwrap"
PROFILE="${DSH_HOME:-$HOME/.dsh}/profiles/acp/cordis.patch.yml"

fails=0
warns=0
ok() { echo "  ok    $1"; }
warn() { echo "  WAARSCHUWING  $1"; warns=$((warns + 1)); }
bad() { echo "  FAAL  $1"; fails=$((fails + 1)); }

echo "check-sandbox: shell-kooi"
if bash "$LAB_DIR/scripts/check-bwrap-secrets.sh"; then
  ok "shell lezen/schrijven, binnen wel en buiten niet, write zichtbaar op de host"
else
  bad "shell-kooi (check-bwrap-secrets)"
fi

echo "check-sandbox: leesgrens en repo-secrets"
if bash "$LAB_DIR/scripts/check-secrets.sh"; then
  ok "guard-tests en geen geheim in git"
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
  bad "install-lab.sh gebruikt nog process.cwd()"
else
  ok "geen process.cwd() in het profiel"
fi
if grep -q 'danger-full-access' "$INSTALL"; then
  bad "install-lab.sh zet nog danger-full-access"
else
  ok "geen danger-full-access in het profiel"
fi
if grep -q 'tool-fs-search' "$INSTALL" && grep -A2 'id: tool-fs-search' "$INSTALL" | grep -q 'disabled: true'; then
  bad "tool-fs-search staat uit (glob/grep moeten aan blijven)"
else
  ok "glob/grep blijven aan"
fi

echo "check-sandbox: kooi-bron (cardine-bwrap)"
if grep -q 'tmp-overlay\|overlay-src' "$BWRAP"; then
  bad "cardine-bwrap gebruikt nog een overlay"
else
  ok "geen overlay in cardine-bwrap"
fi
if grep -q -- '--bind "$tmp_dir" /tmp' "$BWRAP"; then
  ok "/tmp is een bind naar een host-map"
else
  bad "/tmp is geen gedeelde bind"
fi
if grep -q -- '--unshare-user' "$BWRAP"; then
  ok "user-namespace in cardine-bwrap"
else
  bad "cardine-bwrap heeft geen user-namespace"
fi
if grep -E -q '^[[:space:]]*--unshare-net[[:space:]]*$' "$BWRAP"; then
  bad "cardine-bwrap snijdt het netwerk af (ADR 0017: netwerk blijft open)"
else
  ok "netwerk van de shell blijft open"
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
    ok "profiel op schijf komt overeen (geldt na een nieuwe DSH-sessie)"
  else
    warn "profiel op schijf wijkt af — install-lab.sh opnieuw, daarna DSH herstarten"
  fi
else
  warn "geen $PROFILE — op een verse checkout verwacht, lokaal: make install-lab"
fi

echo "check-sandbox: matrix"
echo "  shell lezen, in de workspace          moet   (gemeten)"
echo "  shell lezen, buiten de workspace      mag niet (gemeten)"
echo "  shell schrijven, in de workspace      moet, op de host (gemeten)"
echo "  shell schrijven, buiten               mag niet, host ongewijzigd (gemeten)"
echo "  read/glob/grep, in de workspace       moet   (guard-test)"
echo "  read/glob/grep, buiten                mag niet (guard-test)"
echo "  write/edit/apply_patch                tool uit (profielbron)"
echo "  make check in de kooi                 deze sluis"
echo "  approval-dialoog                      never (profielbron)"
echo "  user-namespace                        moet (uid-map, gemeten)"
echo "  uitgaand TCP vanuit de shell          moet (gemeten)"

if [[ "$fails" -gt 0 ]]; then
  echo "check-sandbox: $fails fout(en), $warns waarschuwing(en)" >&2
  exit 1
fi
echo "check-sandbox: groen ($warns waarschuwing(en))"
