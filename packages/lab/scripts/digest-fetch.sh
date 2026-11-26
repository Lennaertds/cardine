#!/usr/bin/env bash
# digest-fetch (lab entry point) → forwards to scripts/digest-fetch.sh at the repo
# root, which is where bron/ (SOURCES, weken) and data/external/digest/ live.
# One implementation only, so the lab copy cannot drift from the live fetch again.
# Env: DIGEST_DRY_RUN=1, DIGEST_FIXTURE=<file|dir>, DIGEST_EXTRA_URLS, DIGEST_DUMP_DATE.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
TARGET="$ROOT/scripts/digest-fetch.sh"
[[ -f "$TARGET" ]] || { echo "digest-fetch: $TARGET not found." >&2; exit 1; }
exec bash "$TARGET" "$@"
