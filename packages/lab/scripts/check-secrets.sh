#!/usr/bin/env bash
# check-secrets.sh — proves the secrets boundary exists and is closed.
#
# 1. ~/.secrets: mode 700 (folder) and 600 (env files), no other readers.
# 2. No secret file or outward file symlink in a repo.
# 3. The secrets-guard plugin: unit tests green and registered in the DSH profile.
# 4. The bwrap boundary: ~/.secrets is not reachable from the shell cage.
#
# Usage: bash packages/lab/scripts/check-secrets.sh   (also via make check)
set -euo pipefail

LAB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CARDINE_DIR="$(cd "$LAB_DIR/../.." && pwd)"
SECRETS_DIR="${HOME}/.secrets"
PROFILE="${DSH_HOME:-$HOME/.dsh}/profiles/acp/cordis.patch.yml"
GUARD_DIR="$LAB_DIR/cardine-secrets-guard"

fails=0
warns=0
ok() { echo "  ok    $1"; }
warn() { echo "  WARNING  $1"; warns=$((warns + 1)); }
bad() { echo "  FAIL  $1"; fails=$((fails + 1)); }

###############################################################################
# 1. Secrets store — LOCAL ENVIRONMENT, not a repo contract.
#
# Modes on ~/.secrets say nothing about the repository and differ per
# machine; so a wrong mode must not make `make check` red on every
# checkout/CI. But it is a finding you must see straight away.
###############################################################################
mode_of() { stat -c '%a' "$1" 2>/dev/null || echo "?"; }

if [ -n "${DSH_SESSION_ID:-}" ]; then
  # Inside the cage ~/.secrets deliberately does not exist; modes are unmeasurable here.
  ok "~/.secrets not visible from the cage (modes: run this check in your terminal)"
elif [ -d "$SECRETS_DIR" ]; then
  bad_modes=0
  m="$(mode_of "$SECRETS_DIR")"
  case "$m" in
    700) ok "~/.secrets is 700" ;;
    *) warn "~/.secrets is $m (recommended: 700)"; bad_modes=1 ;;
  esac
  while IFS= read -r -d '' f; do
    m="$(mode_of "$f")"
    case "$m" in
      600|400) ok "$(basename "$(dirname "$f")")/$(basename "$f") is $m" ;;
      *) warn "${f#"$HOME"/} is $m (recommended: 600)"; bad_modes=1 ;;
    esac
  done < <(find "$SECRETS_DIR" -type f -print0 2>/dev/null)
  if [ "$bad_modes" -eq 1 ]; then
    echo "        fix with: bash packages/lab/scripts/secrets-init.sh"
  fi
else
  warn "~/.secrets is missing (no secrets store yet)"
fi

###############################################################################
# 2. Repos: no secret file, no outward symlink
###############################################################################
# This repo only: there is no second repo to walk any more.
declare -A seen_repo=()
for root in "$CARDINE_DIR"; do
  [ -d "$root/.git" ] || continue
  [ -n "${seen_repo[$root]+x}" ] && continue
  seen_repo[$root]=1
  repo="$(basename "$root")"
  found="$(git -C "$root" ls-files | grep -E '(^|/)\.env$|(^|/)\.env\.[^/]+$' | grep -v '\.example$' || true)"
  if [ -n "$found" ]; then bad "$repo: secret file in git: $(echo "$found" | tr '\n' ' ')"; else ok "$repo: no .env in git"; fi
  # tmp/ is test debris (gitignored) and does not count as a secret on disk.
  ondisk="$(find "$root" -name '.env' -o -name '.env.*' 2>/dev/null | grep -v '\.example$' | grep -v '/node_modules/' | grep -v '/\.git/' | grep -v '/tmp/' || true)"
  if [ -n "$ondisk" ]; then warn "$repo: .env on disk (outside ~/.secrets): $(echo "$ondisk" | sed "s|$root/||" | tr '\n' ' ')"; else ok "$repo: no .env on disk"; fi
  escape="$(find "$root" -maxdepth 3 -type l 2>/dev/null | while read -r l; do t="$(readlink -f "$l" 2>/dev/null || true)"; case "$t" in ""|"$HOME"|"$root"/*) ;; *) echo "$(readlink "$l") -> $t" ;; esac; done | head -5)"
  if [ -n "$escape" ]; then warn "$repo: outward symlink: $(echo "$escape" | tr '\n' ' ')"; else ok "$repo: no outward symlinks"; fi
done

###############################################################################
# 3. Guard-plugin
###############################################################################
if [ -f "$GUARD_DIR/index.js" ]; then
  if command -v node >/dev/null; then
    if (cd "$GUARD_DIR" && node --test >/dev/null 2>&1); then
      ok "secrets-guard: unit tests green"
    else
      bad "secrets-guard: unit tests fail (cd packages/lab/cardine-secrets-guard && node --test)"
    fi
  else
    warn "secrets-guard: node not found — tests skipped"
  fi
else
  bad "secrets-guard missing ($GUARD_DIR/index.js)"
fi

if [ -f "$PROFILE" ]; then
  if grep -q 'cardine-secrets-guard' "$PROFILE"; then
    ok "secrets-guard: registered in $PROFILE"
  else
    bad "secrets-guard: not registered in the DSH profile — run install-lab.sh"
  fi
else
  warn "DSH profile not found ($PROFILE) — cannot check registration"
fi

###############################################################################
# 4. bwrap boundary: ~/.secrets unreachable from the cage
#
# Careful: "ls fails" alone is no proof — a cage that does not start also
# fails. So first prove THAT the cage runs, and only then ~/.secrets.
###############################################################################
if [ -x "$LAB_DIR/cardine-bwrap" ] && command -v bwrap >/dev/null; then
  if ! "$LAB_DIR/cardine-bwrap" -- /bin/true >/dev/null 2>&1; then
    warn "shell cage does not start here — ~/.secrets boundary not measurable"
  elif "$LAB_DIR/cardine-bwrap" -- /bin/bash -c 'ls -d "$HOME/.secrets" >/dev/null 2>&1'; then
    bad "~/.secrets is reachable from the shell cage"
  else
    ok "~/.secrets unreachable from the shell cage"
  fi
fi

###############################################################################
if [ "$fails" -gt 0 ]; then
  echo "check-secrets: $fails failure(s), $warns warning(s)" >&2
  exit 1
fi
echo "check-secrets: green ($warns warning(s))"
