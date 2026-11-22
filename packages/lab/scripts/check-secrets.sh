#!/usr/bin/env bash
# check-secrets.sh — bewijst dat de secrets-grens er is en dicht zit.
#
# 1. ~/.secrets: rechten 700 (map) en 600 (env-bestanden), geen andere lezers.
# 2. Geen geheim bestand of bestandssymlink naar buiten in een repo.
# 3. De secrets-guard-plugin: unit-tests groen en geregistreerd in het DSH-profiel.
# 4. De bwrap-grens: ~/.secrets is niet bereikbaar uit de shell-kooi.
#
# Gebruik: bash packages/lab/scripts/check-secrets.sh   (ook via make check)
set -euo pipefail

LAB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CARDINE_DIR="$(cd "$LAB_DIR/../.." && pwd)"
SECRETS_DIR="${HOME}/.secrets"
PROFILE="${DSH_HOME:-$HOME/.dsh}/profiles/acp/cordis.patch.yml"
GUARD_DIR="$LAB_DIR/cardine-secrets-guard"

fails=0
warns=0
ok() { echo "  ok    $1"; }
warn() { echo "  WAARSCHUWING  $1"; warns=$((warns + 1)); }
bad() { echo "  FAAL  $1"; fails=$((fails + 1)); }

###############################################################################
# 1. Secrets-centrale — LOKALE OMGEVING, geen repo-contract.
#
# Rechten op ~/.secrets zeggen niets over de repository en verschillen per
# machine; een verkeerde mode mag `make check` dus niet rood maken op elke
# checkout/CI. Het is wel een bevinding die je meteen moet zien.
###############################################################################
mode_of() { stat -c '%a' "$1" 2>/dev/null || echo "?"; }

if [ -n "${DSH_SESSION_ID:-}" ]; then
  # In de kooi bestaat ~/.secrets bewust niet; de rechten zijn hier onmeetbaar.
  ok "~/.secrets niet zichtbaar uit de kooi (rechten: draai deze check in je terminal)"
elif [ -d "$SECRETS_DIR" ]; then
  bad_modes=0
  m="$(mode_of "$SECRETS_DIR")"
  case "$m" in
    700) ok "~/.secrets is 700" ;;
    *) warn "~/.secrets is $m (aanbevolen: 700)"; bad_modes=1 ;;
  esac
  while IFS= read -r -d '' f; do
    m="$(mode_of "$f")"
    case "$m" in
      600|400) ok "$(basename "$(dirname "$f")")/$(basename "$f") is $m" ;;
      *) warn "${f#"$HOME"/} is $m (aanbevolen: 600)"; bad_modes=1 ;;
    esac
  done < <(find "$SECRETS_DIR" -type f -print0 2>/dev/null)
  if [ "$bad_modes" -eq 1 ]; then
    echo "        oplossen met: bash packages/lab/scripts/secrets-init.sh"
  fi
else
  warn "~/.secrets ontbreekt (nog geen secrets-centrale)"
fi

###############################################################################
# 2. Repo's: geen geheim bestand, geen symlink naar buiten
###############################################################################
# De repo zelf + zusterrepos naast de workspace (bv. Cardine/Agent_Engineering).
declare -A seen_repo=()
for root in "$CARDINE_DIR" "$(dirname "$CARDINE_DIR")"/*; do
  [ -d "$root/.git" ] || continue
  [ -n "${seen_repo[$root]+x}" ] && continue
  seen_repo[$root]=1
  repo="$(basename "$root")"
  found="$(git -C "$root" ls-files | grep -E '(^|/)\.env$|(^|/)\.env\.[^/]+$' | grep -v '\.example$' || true)"
  if [ -n "$found" ]; then bad "$repo: geheim bestand in git: $(echo "$found" | tr '\n' ' ')"; else ok "$repo: geen .env in git"; fi
  ondisk="$(find "$root" -name '.env' -o -name '.env.*' 2>/dev/null | grep -v '\.example$' | grep -v '/node_modules/' | grep -v '/\.git/' || true)"
  if [ -n "$ondisk" ]; then warn "$repo: .env op schijf (buiten ~/.secrets): $(echo "$ondisk" | sed "s|$root/||" | tr '\n' ' ')"; else ok "$repo: geen .env op schijf"; fi
  escape="$(find "$root" -maxdepth 3 -type l 2>/dev/null | while read -r l; do t="$(readlink -f "$l" 2>/dev/null || true)"; case "$t" in ""|"$HOME"|"$root"/*) ;; *) echo "$(readlink "$l") -> $t" ;; esac; done | head -5)"
  if [ -n "$escape" ]; then warn "$repo: symlink naar buiten: $(echo "$escape" | tr '\n' ' ')"; else ok "$repo: geen symlinks naar buiten"; fi
done

###############################################################################
# 3. Guard-plugin
###############################################################################
if [ -f "$GUARD_DIR/index.js" ]; then
  if command -v node >/dev/null; then
    if (cd "$GUARD_DIR" && node --test >/dev/null 2>&1); then
      ok "secrets-guard: unit-tests groen"
    else
      bad "secrets-guard: unit-tests falen (cd packages/lab/cardine-secrets-guard && node --test)"
    fi
  else
    warn "secrets-guard: node niet gevonden — tests overgeslagen"
  fi
else
  bad "secrets-guard ontbreekt ($GUARD_DIR/index.js)"
fi

if [ -f "$PROFILE" ]; then
  if grep -q 'cardine-secrets-guard' "$PROFILE"; then
    ok "secrets-guard: geregistreerd in $PROFILE"
  else
    bad "secrets-guard: niet geregistreerd in het DSH-profiel — run install-lab.sh"
  fi
else
  warn "DSH-profiel niet gevonden ($PROFILE) — kan registratie niet controleren"
fi

###############################################################################
# 4. bwrap-grens: ~/.secrets onbereikbaar uit de kooi
#
# Let op: "ls faalt" alleen is géén bewijs — een kooi die zelf niet start
# faalt ook. Daarom eerst bewijzen dát de kooi draait, en dán pas ~/.secrets.
###############################################################################
if [ -x "$LAB_DIR/cardine-bwrap" ] && command -v bwrap >/dev/null; then
  if ! "$LAB_DIR/cardine-bwrap" -- /bin/true >/dev/null 2>&1; then
    warn "shell-kooi start niet hier — grens ~/.secrets niet meetbaar"
  elif "$LAB_DIR/cardine-bwrap" -- /bin/bash -c 'ls -d "$HOME/.secrets" >/dev/null 2>&1'; then
    bad "~/.secrets is bereikbaar uit de shell-kooi"
  else
    ok "~/.secrets onbereikbaar uit de shell-kooi"
  fi
fi

###############################################################################
if [ "$fails" -gt 0 ]; then
  echo "check-secrets: $fails fout(en), $warns waarschuwing(en)" >&2
  exit 1
fi
echo "check-secrets: groen ($warns waarschuwing(en))"
