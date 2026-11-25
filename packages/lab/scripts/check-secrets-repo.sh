#!/usr/bin/env bash
# check-secrets.sh — no secrets in this repo.
#
# Runs in every repo that uses the kit, also without cardine-lab. It
# checks the repo contract: no .env/keys in git, no secret
# files on disk, no outward symlinks, and no secrets in the
# git history. The modes of ~/.secrets and the agent boundary live in the
# lab (cardine-lab); this check does not touch them.
#
# Usage: bash scripts/check-secrets.sh   (also via make check)
set -euo pipefail

# The repo root: this script sits in <repo>/scripts/ (via the kit), in
# <repo>/packages/lab/scripts/ (inside cardine itself) or in the kit mould
# <kit>/kern/scripts/. In the mould the surrounding git root is wrong (it is
# this repo, not the future project), so the mould wins then.
# Otherwise: find the git root instead of counting levels.
_here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
_parent="$(cd "$_here/.." && pwd)"
if [ -f "$_parent/Makefile" ] && [ -d "$_parent/docs" ] && [ -d "$_parent/scripts" ] \
   && [ -f "$(dirname "$_parent")/new-project.sh" ]; then
  ROOT="$_parent"                      # kit mould (kern)
else
  ROOT="$(git -C "$_here" rev-parse --show-toplevel 2>/dev/null || true)"
  [ -n "$ROOT" ] || ROOT="$_parent"
fi

fails=0
warns=0
ok() { echo "  ok    $1"; }
warn() { echo "  WARNING  $1"; warns=$((warns + 1)); }
bad() { echo "  FAIL  $1"; fails=$((fails + 1)); }

# Pattern for secret files. *.example is documentation, not a secret.
SECRET_GLOB='(^|/)\.env$|(^|/)\.env\.[^/]+$|(^|/)id_(rsa|ed25519|ecdsa|dsa)$|\.pem$|\.p12$|\.pfx$'

###############################################################################
# 1. Nothing secret in git (index and history)
###############################################################################
in_index="$(git -C "$ROOT" ls-files | grep -E "$SECRET_GLOB" | grep -v '\.example$' || true)"
if [ -n "$in_index" ]; then
  bad "secret file in git: $(echo "$in_index" | tr '\n' ' ')"
else
  ok "no .env/keys in git"
fi

if git -C "$ROOT" rev-parse --verify HEAD >/dev/null 2>&1; then
  in_history="$(git -C "$ROOT" log --all --name-only --pretty=format: | grep -E "$SECRET_GLOB" | grep -v '\.example$' | sort -u | head -5 || true)"
  if [ -n "$in_history" ]; then
    bad "secret file in the git history: $(echo "$in_history" | tr '\n' ' ') — remove with git-filter-repo and rotate the key"
  else
    ok "no .env/keys in the history"
  fi
fi

###############################################################################
# 2. On disk: belongs in ~/.secrets, not in the repo
###############################################################################
on_disk="$(find "$ROOT" \( -name '.git' -o -name 'node_modules' \) -prune -o -type f \
  \( -name '.env' -o -name '.env.*' -o -name 'id_rsa' -o -name 'id_ed25519' \
     -o -name 'id_ecdsa' -o -name 'id_dsa' -o -name '*.pem' -o -name '*.p12' -o -name '*.pfx' \) -print 2>/dev/null \
  | grep -v '\.example$' || true)"
if [ -n "$on_disk" ]; then
  warn "secret file on disk (belongs in ~/.secrets/$(basename "$ROOT")/): $(echo "$on_disk" | sed "s|$ROOT/||" | tr '\n' ' ')"
else
  ok "no .env/keys on disk"
fi

###############################################################################
# 3. No symlinks pointing out of the repo
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
  bad "outward symlink: $(echo "$escape" | tr '\n' ' ')"
else
  ok "no outward symlinks"
fi

###############################################################################
# 4. .gitignore covers the secrets
###############################################################################
if [ -f "$ROOT/.gitignore" ] && grep -qE '^\.env$|^\.env\*|^\.env\.\*|^\.env\.' "$ROOT/.gitignore"; then
  ok ".gitignore covers .env"
else
  bad ".gitignore does not cover .env — add '.env' and '.env.*'"
fi

###############################################################################
if [ "$fails" -gt 0 ]; then
  echo "check-secrets: $fails failure(s), $warns warning(s)" >&2
  exit 1
fi
echo "check-secrets: green ($warns warning(s))"
