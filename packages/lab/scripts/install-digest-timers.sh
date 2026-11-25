#!/usr/bin/env bash
# install-digest-timers has moved to scripts/install-digest-timers.sh of
# this repo (the knowledge source bron/ lives here since the merge).
# This stub stays for backwards compatibility.
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
TARGET="$ROOT/scripts/install-digest-timers.sh"
if [ ! -f "$TARGET" ]; then
  echo "install-digest-timers: $TARGET not found." >&2
  exit 1
fi
exec bash "$TARGET" "$@"
