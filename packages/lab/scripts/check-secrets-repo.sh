#!/usr/bin/env bash
# check-secrets.sh — geen geheimen in deze repo.
#
# Draait in elke repo die de kit gebruikt, ook zonder cardine-lab. Het
# controleert het repo-contract: geen .env/keys in git, geen geheime
# bestanden op schijf, geen symlinks naar buiten, en geen secrets in de
# git-historie. De rechten van ~/.secrets en de agent-grens leven in het
# lab (cardine-lab); deze check raakt ze niet aan.
#
# Gebruik: bash scripts/check-secrets.sh   (ook via make check)
set -euo pipefail

# De repo-root: dit script staat in <repo>/scripts/ (via de kit), in
# <repo>/packages/lab/scripts/ (in cardine zelf) of in de kit-MAL
# <kit>/kern/scripts/. Bij de mal is de omringende git-root verkeerd (dat is
# deze repo, niet het toekomstige project), dus de mal wint dan.
# Verder: zoek de git-root in plaats van niveaus te tellen.
_here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
_parent="$(cd "$_here/.." && pwd)"
if [ -f "$_parent/Makefile" ] && [ -d "$_parent/docs" ] && [ -d "$_parent/scripts" ] \
   && [ -f "$(dirname "$_parent")/new-project.sh" ]; then
  ROOT="$_parent"                      # kit-mal (kern)
else
  ROOT="$(git -C "$_here" rev-parse --show-toplevel 2>/dev/null || true)"
  [ -n "$ROOT" ] || ROOT="$_parent"
fi

fails=0
warns=0
ok() { echo "  ok    $1"; }
warn() { echo "  WAARSCHUWING  $1"; warns=$((warns + 1)); }
bad() { echo "  FAAL  $1"; fails=$((fails + 1)); }

# Patroon voor geheime bestanden. *.example is documentatie, geen geheim.
SECRET_GLOB='(^|/)\.env$|(^|/)\.env\.[^/]+$|(^|/)id_(rsa|ed25519|ecdsa|dsa)$|\.pem$|\.p12$|\.pfx$'

###############################################################################
# 1. Niets geheim in git (index en historie)
###############################################################################
in_index="$(git -C "$ROOT" ls-files | grep -E "$SECRET_GLOB" | grep -v '\.example$' || true)"
if [ -n "$in_index" ]; then
  bad "geheim bestand in git: $(echo "$in_index" | tr '\n' ' ')"
else
  ok "geen .env/keys in git"
fi

if git -C "$ROOT" rev-parse --verify HEAD >/dev/null 2>&1; then
  in_history="$(git -C "$ROOT" log --all --name-only --pretty=format: | grep -E "$SECRET_GLOB" | grep -v '\.example$' | sort -u | head -5 || true)"
  if [ -n "$in_history" ]; then
    bad "geheim bestand in de git-historie: $(echo "$in_history" | tr '\n' ' ') — verwijder met git-filter-repo en roteer de key"
  else
    ok "geen .env/keys in de historie"
  fi
fi

###############################################################################
# 2. Op schijf: hoort in ~/.secrets, niet in de repo
###############################################################################
on_disk="$(find "$ROOT" \( -name '.git' -o -name 'node_modules' \) -prune -o -type f \
  \( -name '.env' -o -name '.env.*' -o -name 'id_rsa' -o -name 'id_ed25519' \
     -o -name 'id_ecdsa' -o -name 'id_dsa' -o -name '*.pem' -o -name '*.p12' -o -name '*.pfx' \) -print 2>/dev/null \
  | grep -v '\.example$' || true)"
if [ -n "$on_disk" ]; then
  warn "geheim bestand op schijf (hoort in ~/.secrets/$(basename "$ROOT")/): $(echo "$on_disk" | sed "s|$ROOT/||" | tr '\n' ' ')"
else
  ok "geen .env/keys op schijf"
fi

###############################################################################
# 3. Geen symlinks die de repo uit wijzen
###############################################################################
escape="$(find "$ROOT" \( -name '.git' -o -name 'node_modules' \) -prune -o -type l -print 2>/dev/null \
  | while read -r link; do
      target="$(readlink -f "$link" 2>/dev/null || true)"
      case "$target" in
        ""|"$ROOT"/*) ;;
        *) echo "$(readlink "$link") -> $target" ;;
      esac
    done | head -5)"
if [ -n "$escape" ]; then
  bad "symlink naar buiten: $(echo "$escape" | tr '\n' ' ')"
else
  ok "geen symlinks naar buiten"
fi

###############################################################################
# 4. .gitignore dekt de geheimen
###############################################################################
if [ -f "$ROOT/.gitignore" ] && grep -qE '^\.env$|^\.env\*|^\.env\.\*|^\.env\.' "$ROOT/.gitignore"; then
  ok ".gitignore dekt .env"
else
  bad ".gitignore dekt .env niet — voeg '.env' en '.env.*' toe"
fi

###############################################################################
if [ "$fails" -gt 0 ]; then
  echo "check-secrets: $fails fout(en), $warns waarschuwing(en)" >&2
  exit 1
fi
echo "check-secrets: groen ($warns waarschuwing(en))"
