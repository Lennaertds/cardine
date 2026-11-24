#!/usr/bin/env bash
# install-digest-timers is verhuisd naar scripts/install-digest-timers.sh van
# deze repo (de kennisbron bron/ leeft hier sinds de samenvoeging).
# Deze stub blijft bestaan voor backwards compat.
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
TARGET="$ROOT/scripts/install-digest-timers.sh"
if [ ! -f "$TARGET" ]; then
  echo "install-digest-timers: $TARGET niet gevonden." >&2
  exit 1
fi
exec bash "$TARGET" "$@"
