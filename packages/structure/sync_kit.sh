#!/usr/bin/env bash
# sync_kit.sh — copies the source kit/ (repo root) to packages/structure/kit/,
# the copy that ships with @lennaertds/cardine-structure.
#
# Replaces pull_kit.sh. There is no second repo any more: kit/ IS the source. This script
# keeps the public distribution copy identical; run it after every kit change.
#
#   bash packages/structure/sync_kit.sh          # copy
#   bash packages/structure/sync_kit.sh --check  # compare only
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
SRC="$REPO_ROOT/kit"
DST="$SCRIPT_DIR/kit"

[ -d "$SRC" ] || { echo "sync_kit: source missing: $SRC" >&2; exit 1; }

if [ "${1:-}" = "--check" ]; then
  if diff -rq --no-dereference "$SRC" "$DST" >/dev/null 2>&1; then
    echo "sync_kit: kit/ and packages/structure/kit/ are identical ✅"
    exit 0
  fi
  echo "sync_kit: kit/ and packages/structure/kit/ differ:" >&2
  diff -rq --no-dereference "$SRC" "$DST" >&2 || true
  echo "  Fix: bash packages/structure/sync_kit.sh" >&2
  exit 1
fi

rm -rf "$DST"
mkdir -p "$DST"
rsync -a --exclude 'COMMIT' "$SRC/" "$DST/"
echo "sync_kit: kit/ → packages/structure/kit/ copied ✅"
