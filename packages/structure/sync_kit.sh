#!/usr/bin/env bash
# sync_kit.sh — kopieert de bron kit/ (repo-root) naar packages/structure/kit/,
# de kopie die met @lennaertds/cardine-structure meegaat.
#
# Vervangt pull_kit.sh. Er is geen tweede repo meer: kit/ IS de bron. Dit script
# houdt de publieke distributiekopie gelijk; draai het na elke kit-wijziging.
#
#   bash packages/structure/sync_kit.sh          # kopiëren
#   bash packages/structure/sync_kit.sh --check  # alleen vergelijken
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
SRC="$REPO_ROOT/kit"
DST="$SCRIPT_DIR/kit"

[ -d "$SRC" ] || { echo "sync_kit: bron ontbreekt: $SRC" >&2; exit 1; }

if [ "${1:-}" = "--check" ]; then
  if diff -rq --no-dereference "$SRC" "$DST" >/dev/null 2>&1; then
    echo "sync_kit: kit/ en packages/structure/kit/ zijn gelijk ✅"
    exit 0
  fi
  echo "sync_kit: kit/ en packages/structure/kit/ verschillen:" >&2
  diff -rq --no-dereference "$SRC" "$DST" >&2 || true
  echo "  Oplossing: bash packages/structure/sync_kit.sh" >&2
  exit 1
fi

rm -rf "$DST"
mkdir -p "$DST"
rsync -a --exclude 'COMMIT' "$SRC/" "$DST/"
echo "sync_kit: kit/ → packages/structure/kit/ gekopieerd ✅"
