#!/usr/bin/env bash
# Layout check for apps/native-c.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

die() { echo "native-c-check: $*" >&2; exit 1; }

[[ -f src/add.c ]] || die "missing src/add.c"
[[ -f src/add.h ]] || die "missing src/add.h"
[[ -f tests/test_add.c ]] || die "missing tests/test_add.c"
[[ -f AGENTS.md ]] || die "missing AGENTS.md"
grep -q 'polyglot' AGENTS.md || die "AGENTS.md must link to polyglot"

if [[ -f package.json ]]; then
  echo "ok    N-API starter (package.json) present"
fi
if [[ -f native_c_fallback.py ]]; then
  echo "ok    ctypes starter (native_c_fallback.py) present"
fi
if [[ ! -f package.json && ! -f native_c_fallback.py ]]; then
  echo "hint  no FFI starter — pure C; --starter adds the N-API + ctypes scaffolds"
fi

echo "ok    apps/native-c layout"
echo "native-c-check: green"
