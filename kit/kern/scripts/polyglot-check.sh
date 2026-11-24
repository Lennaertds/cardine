#!/usr/bin/env bash
# Checklist polyglot-docs. Niet in make check. Geen Rust-stack (v1).
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

file=docs/architecture/polyglot.md
voorbeeld=docs/decisions/0000-voorbeeld-native-module-na-budget-breuk.md
die() { echo "polyglot-check: $*" >&2; exit 1; }

[[ -f "$file" ]] || die "ontbreekt $file (kit: kern)."
[[ -f "$voorbeeld" ]] || die "ontbreekt voorbeeld-ADR $voorbeeld (kit: kern)."

for heading in "## Relatie tot andere docs" "## Beslisboom" "## Integratievormen" "## Wat de agent mag" "## Commando's" "## Bewust later"; do
  grep -qF "$heading" "$file" || die "sectie ontbreekt in $file: $heading"
done

awk '
  /^## Bewust later$/ { in_sec=1; next }
  in_sec && /^## / { exit found ? 0 : 1 }
  in_sec && /^\|/ && $0 !~ /^\|[[:space:]:|-]+\|$/ && $0 !~ /Uitbreiding/ { found=1 }
  END { exit found ? 0 : 1 }
' "$file" || die "tabel onder ## Bewust later mist uitbreidingsrijen (P28)"

grep -qF 'voorbeeld' "$voorbeeld" || die "$voorbeeld moet status/rol 'voorbeeld' bevatten"
grep -qE 'FFI|sidecar|apart proces' "$file" || die "$file moet integratievormen FFI/sidecar/proces noemen"

echo "ok    $file (vaste secties aanwezig, incl. Bewust later)"
echo "ok    $voorbeeld (voorbeeld-ADR aanwezig)"
echo "Tip: vóór native code — meet (bench/obs), dan make adr t=\"…\", dan pas crate/map."
echo "polyglot-check: groen"
