#!/usr/bin/env bash
# Layout-check voor apps/native. Onderdeel van check-native.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

die() { echo "native-check: $*" >&2; exit 1; }

[[ -f Cargo.toml ]] || die "ontbreekt Cargo.toml"
[[ -f src/lib.rs ]] || die "ontbreekt src/lib.rs"
[[ -f AGENTS.md ]] || die "ontbreekt AGENTS.md"

grep -q 'polyglot' AGENTS.md || die "AGENTS.md moet naar polyglot verwijzen"
grep -q '\[package\]' Cargo.toml || die "Cargo.toml mist [package]"

if [[ -f package.json ]]; then
  echo "ok    napi-starter (package.json) aanwezig"
fi
if [[ -f pyproject.toml ]]; then
  echo "ok    PyO3/maturin-starter (pyproject.toml) aanwezig"
  grep -q 'pyo3-bridge\|maturin' pyproject.toml Cargo.toml 2>/dev/null \
    || echo "tip   verwacht maturin + feature pyo3-bridge in starter-Cargo.toml"
fi
if [[ ! -f package.json && ! -f pyproject.toml ]]; then
  echo "tip   geen FFI-starter — pure Rust; --starter levert napi + PyO3-scaffolds"
fi

echo "ok    apps/native layout"
echo "native-check: groen"
