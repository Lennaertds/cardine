#!/usr/bin/env bash
# Layout check for apps/native. Part of check-native.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

die() { echo "native-check: $*" >&2; exit 1; }

[[ -f Cargo.toml ]] || die "missing Cargo.toml"
[[ -f src/lib.rs ]] || die "missing src/lib.rs"
[[ -f AGENTS.md ]] || die "missing AGENTS.md"

grep -q 'polyglot' AGENTS.md || die "AGENTS.md must link to polyglot"
grep -q '\[package\]' Cargo.toml || die "Cargo.toml lacks [package]"

if [[ -f package.json ]]; then
  echo "ok    napi starter (package.json) present"
fi
if [[ -f pyproject.toml ]]; then
  echo "ok    PyO3/maturin starter (pyproject.toml) present"
  grep -q 'pyo3-bridge\|maturin' pyproject.toml Cargo.toml 2>/dev/null \
    || echo "hint  expected maturin + feature pyo3-bridge in the starter Cargo.toml"
fi
if [[ ! -f package.json && ! -f pyproject.toml ]]; then
  echo "hint  no FFI starter — pure Rust; --starter adds the napi + PyO3 scaffolds"
fi

echo "ok    apps/native layout"
echo "native-check: green"
