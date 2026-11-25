#!/usr/bin/env bash
# secrets-apply.sh — apply the secrets standard to an existing repo.
#
# Does in any repo the same as the kit does for new projects:
#   1. scripts/check-secrets.sh       (repo contract; may and must live in the repo)
#   2. Makefile wiring                (check-secrets in `make check`)
#   3. .gitignore rules               (.env, .env.*, !.env.example)
#   4. AGENTS.md rule                 (if the file exists and lacks the rule)
#   5. report                         (which secret .env files belong in ~/.secrets)
#
# Idempotent: runs repeatedly without duplicating anything. Never overwrites
# an existing check-secrets.sh; creates no backups when nothing
# changes. Moves NO secrets: reports only.
#
# Usage:
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

[ -n "$TARGET" ] || { echo "usage: secrets-apply.sh <repo> [--dry-run]" >&2; exit 1; }
[ -d "$TARGET" ] || { echo "secrets-apply: $TARGET does not exist" >&2; exit 1; }
[ -f "$CHECK_SRC" ] || { echo "secrets-apply: $CHECK_SRC ontbreekt" >&2; exit 1; }

REPO="$(cd "$TARGET" && pwd)"
REPO_NAME="$(basename "$REPO")"
run() { if [ "$DRY" = 1 ]; then echo "  [dry-run] $*"; else "$@"; fi; }
say() { echo "  $*"; }

echo "secrets-apply: $REPO$([ "$DRY" = 1 ] && echo '  (dry-run)')"

# 1. check-secrets.sh
if [ -f "$REPO/scripts/check-secrets.sh" ]; then
  say "scripts/check-secrets.sh already exists (not overwritten)"
else
  run mkdir -p "$REPO/scripts"
  run cp "$CHECK_SRC" "$REPO/scripts/check-secrets.sh"
  # 755, not "+x": the source may have strict modes and the repo may let
  # anyone run the check.
  run chmod 755 "$REPO/scripts/check-secrets.sh"
  say "scripts/check-secrets.sh added"
fi

# 2. Makefile wiring
if [ -f "$REPO/Makefile" ]; then
  if grep -q 'check-secrets' "$REPO/Makefile"; then
    say "Makefile: check-secrets already wired"
  else
    # Add the target after the last executable recipe or at the end.
    if [ "$DRY" = 1 ]; then
      say "[dry-run] Makefile: add target check-secrets + the wiring in check"
    else
      {
        echo
        echo "check-secrets: ## no .env/keys in the repo (scripts/check-secrets.sh)"
        echo "	@bash scripts/check-secrets.sh"
      } >>"$REPO/Makefile"
      if grep -qE '^check:.*##' "$REPO/Makefile"; then
        sed -i -E '/^check:/{/check-secrets/!s/^(check:[[:space:]]*)/\1check-secrets /}' "$REPO/Makefile"
      fi
      say "Makefile: target added and wired into check"
      say "        (if 'check' is missing or has no recipe: wire check-secrets yourself)"
    fi
  fi
else
  say "no Makefile — step 2 skipped"
fi

# 3. .gitignore — all three rules, otherwise `.env.local` etc. is not covered yet.
if [ -f "$REPO/.gitignore" ] \
   && grep -qxF '.env' "$REPO/.gitignore" \
   && grep -qxF '.env.*' "$REPO/.gitignore" \
   && grep -qxF '!.env.example' "$REPO/.gitignore"; then
  say ".gitignore already covers .env"
else
  if [ "$DRY" = 1 ]; then
    say "[dry-run] .gitignore: add .env, .env.*, !.env.example"
  else
    {
      echo
      echo "# Secrets — never commit; real values live in ~/.secrets/${REPO_NAME}/"
      echo ".env"
      echo ".env.*"
      echo "!.env.example"
    } >>"$REPO/.gitignore"
    say ".gitignore updated"
  fi
fi

# 4. AGENTS.md
if [ -f "$REPO/AGENTS.md" ]; then
  if grep -qi '~/.secrets' "$REPO/AGENTS.md"; then
    say "AGENTS.md already mentions ~/.secrets"
  else
    if [ "$DRY" = 1 ]; then
      say "[dry-run] AGENTS.md: add a rule about .env/~/.secrets"
    else
      # Heredoc with a quoted delimiter: backticks stay literal text.
      if ! {
        echo
        cat <<EOF
- Secrets (\`.env\`, keys) live in \`~/.secrets/${REPO_NAME}/\`, never in this repo; only \`.env.example\` in the repo. Do not read, show or commit them.
EOF
      } >>"$REPO/AGENTS.md"; then
        echo "secrets-apply: could not update AGENTS.md" >&2
        exit 1
      fi
      say "AGENTS.md updated"
    fi
  fi
else
  say "no AGENTS.md — step 4 skipped"
fi

# 5. Report: which secret .env files are in the repo now?
found="$(find "$REPO" \( -name '.git' -o -name 'node_modules' \) -prune -o -type f -name '.env' -print 2>/dev/null || true)"
found="$(echo "$found" | grep -v '\.example$' || true)"
echo
if [ -n "$found" ]; then
  echo "  NOTE: these .env files are in the repo (they belong in ~/.secrets/${REPO_NAME}/):"
  echo "$found" | sed "s|$REPO/|    |"
else
  echo "  no .env files on disk"
fi

echo
if [ "$DRY" = 1 ]; then
  echo "secrets-apply: dry-run done (nothing written)"
else
  echo "secrets-apply: done — check with: cd $REPO && bash scripts/check-secrets.sh"
fi
