#!/usr/bin/env bash
# secrets-apply.sh — zet de secrets-standaard in een bestaande repo.
#
# Doet in een willekeurige repo hetzelfde als de kit voor nieuwe projecten:
#   1. scripts/check-secrets.sh       (repo-contract; mag en moet in de repo)
#   2. Makefile-wiring                (check-secrets in `make check`)
#   3. .gitignore-regels              (.env, .env.*, !.env.example)
#   4. AGENTS.md-regel                (als het bestand bestaat en de regel mist)
#   5. rapport                        (welke secrets-.env naar ~/.secrets horen)
#
# Idempotent: draait vaker zonder iets te dupliceren. Overschrijft nooit
# een bestaand check-secrets.sh; maakt geen back-ups aan als er niets
# verandert. Verplaatst GEEN secrets: alleen melden.
#
# Gebruik:
#   bash packages/lab/scripts/secrets-apply.sh <repo> --dry-run
#   bash packages/lab/scripts/secrets-apply.sh <repo>
set -euo pipefail

SELF_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CHECK_SRC="$SELF_DIR/check-secrets-repo.sh"

DRY=0
TARGET=""
for arg in "$@"; do
  case "$arg" in
    --dry-run) DRY=1 ;;
    -h|--help) sed -n '2,20p' "${BASH_SOURCE[0]}"; exit 0 ;;
    -*) echo "secrets-apply: onbekende optie $arg" >&2; exit 1 ;;
    *) TARGET="$arg" ;;
  esac
done

[ -n "$TARGET" ] || { echo "gebruik: secrets-apply.sh <repo> [--dry-run]" >&2; exit 1; }
[ -d "$TARGET" ] || { echo "secrets-apply: $TARGET bestaat niet" >&2; exit 1; }
[ -f "$CHECK_SRC" ] || { echo "secrets-apply: $CHECK_SRC ontbreekt" >&2; exit 1; }

REPO="$(cd "$TARGET" && pwd)"
REPO_NAME="$(basename "$REPO")"
run() { if [ "$DRY" = 1 ]; then echo "  [dry-run] $*"; else "$@"; fi; }
say() { echo "  $*"; }

echo "secrets-apply: $REPO$([ "$DRY" = 1 ] && echo '  (dry-run)')"

# 1. check-secrets.sh
if [ -f "$REPO/scripts/check-secrets.sh" ]; then
  say "scripts/check-secrets.sh bestaat al (niet overschreven)"
else
  run mkdir -p "$REPO/scripts"
  run cp "$CHECK_SRC" "$REPO/scripts/check-secrets.sh"
  # 755, niet "+x": de bron kan strikte rechten hebben en de repo mag de
  # check gewoon door iedereen laten draaien.
  run chmod 755 "$REPO/scripts/check-secrets.sh"
  say "scripts/check-secrets.sh toegevoegd"
fi

# 2. Makefile-wiring
if [ -f "$REPO/Makefile" ]; then
  if grep -q 'check-secrets' "$REPO/Makefile"; then
    say "Makefile: check-secrets al gekoppeld"
  else
    # Target toevoegen na het laatste uitvoerbare recept of aan het einde.
    if [ "$DRY" = 1 ]; then
      say "[dry-run] Makefile: target check-secrets + koppeling in check toevoegen"
    else
      {
        echo
        echo "check-secrets: ## geen .env/keys in de repo (scripts/check-secrets.sh)"
        echo "	@bash scripts/check-secrets.sh"
      } >>"$REPO/Makefile"
      if grep -qE '^check:.*##' "$REPO/Makefile"; then
        sed -i -E '/^check:/{/check-secrets/!s/^(check:[[:space:]]*)/\1check-secrets /}' "$REPO/Makefile"
      fi
      say "Makefile: target toegevoegd en gekoppeld aan check"
      say "        (staat 'check' er niet of zonder recept: koppel check-secrets zelf)"
    fi
  fi
else
  say "geen Makefile — step 2 overgeslagen"
fi

# 3. .gitignore — alle drie de regels, anders is `.env.local` e.d. nog niet gedekt.
if [ -f "$REPO/.gitignore" ] \
   && grep -qxF '.env' "$REPO/.gitignore" \
   && grep -qxF '.env.*' "$REPO/.gitignore" \
   && grep -qxF '!.env.example' "$REPO/.gitignore"; then
  say ".gitignore dekt .env al"
else
  if [ "$DRY" = 1 ]; then
    say "[dry-run] .gitignore: .env, .env.*, !.env.example toevoegen"
  else
    {
      echo
      echo "# Secrets — nooit committen; echte waarden leven in ~/.secrets/${REPO_NAME}/"
      echo ".env"
      echo ".env.*"
      echo "!.env.example"
    } >>"$REPO/.gitignore"
    say ".gitignore aangevuld"
  fi
fi

# 4. AGENTS.md
if [ -f "$REPO/AGENTS.md" ]; then
  if grep -qi '~/.secrets' "$REPO/AGENTS.md"; then
    say "AGENTS.md noemt ~/.secrets al"
  else
    if [ "$DRY" = 1 ]; then
      say "[dry-run] AGENTS.md: regel over .env/~/.secrets toevoegen"
    else
      # Heredoc met quoted delimiter: backticks blijven letterlijk tekst.
      if ! {
        echo
        cat <<EOF
- Secrets (\`.env\`, keys) leven in \`~/.secrets/${REPO_NAME}/\`, nooit in deze repo; in de repo alleen \`.env.example\`. Niet lezen, tonen of committen.
EOF
      } >>"$REPO/AGENTS.md"; then
        echo "secrets-apply: kon AGENTS.md niet bijwerken" >&2
        exit 1
      fi
      say "AGENTS.md aangevuld"
    fi
  fi
else
  say "geen AGENTS.md — step 4 overgeslagen"
fi

# 5. Rapport: welke secrets-.env staan nu in de repo?
found="$(find "$REPO" \( -name '.git' -o -name 'node_modules' \) -prune -o -type f -name '.env' -print 2>/dev/null || true)"
found="$(echo "$found" | grep -v '\.example$' || true)"
echo
if [ -n "$found" ]; then
  echo "  LET OP: deze .env-bestanden staan in de repo (horen in ~/.secrets/${REPO_NAME}/):"
  echo "$found" | sed "s|$REPO/|    |"
else
  echo "  geen .env-bestanden op schijf"
fi

echo
if [ "$DRY" = 1 ]; then
  echo "secrets-apply: dry-run klaar (niets geschreven)"
else
  echo "secrets-apply: klaar — controleer met: cd $REPO && bash scripts/check-secrets.sh"
fi
