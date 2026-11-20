#!/usr/bin/env bash
# Layout-check voor apps/native-c.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

die() { echo "native-c-check: $*" >&2; exit 1; }

[[ -f src/add.c ]] || die "ontbreekt src/add.c"
[[ -f src/add.h ]] || die "ontbreekt src/add.h"
[[ -f tests/test_add.c ]] || die "ontbreekt tests/test_add.c"
[[ -f AGENTS.md ]] || die "ontbreekt AGENTS.md"
grep -q 'polyglot' AGENTS.md || die "AGENTS.md moet naar polyglot verwijzen"

if [[ -f package.json ]]; then
  echo "ok    N-API-starter (package.json) aanwezig"
fi
if [[ -f native_c_fallback.py ]]; then
  echo "ok    ctypes-starter (native_c_fallback.py) aanwezig"
fi
if [[ ! -f package.json && ! -f native_c_fallback.py ]]; then
  echo "tip   geen FFI-starter — pure C; --starter levert N-API + ctypes-scaffolds"
fi

echo "ok    apps/native-c layout"
echo "native-c-check: groen"
