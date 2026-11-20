#!/usr/bin/env bash
# Checklist digest-scaffold (module research). Niet in make check.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

dir=docs/research/digest
file="$dir/README.md"
die() { echo "digest-check: $*" >&2; exit 1; }

[[ -f "$file" ]] || die "ontbreekt $file (kit: --modules research)."
[[ -f "$dir/SOURCES.example.md" ]] || die "ontbreekt $dir/SOURCES.example.md"

for heading in "## Ritueel" "## Bronnenlijst" "## Commando's" "## Bewust later"; do
  grep -qF "$heading" "$file" || die "sectie ontbreekt in $file: $heading"
done

grep -qiE 'data/external/digest' "$file" || die "$file moet data/external/digest noemen"
grep -qF 'P5' "$file" || die "$file moet P5 (geen dump als SSOT) noemen"

awk '
  /^## Bewust later$/ { in_sec=1; next }
  in_sec && /^## / { exit found ? 0 : 1 }
  in_sec && /^\|/ && $0 !~ /^\|[[:space:]:|-]+\|$/ && $0 !~ /Uitbreiding/ { found=1 }
  END { exit found ? 0 : 1 }
' "$file" || die "tabel onder ## Bewust later mist uitbreidingsrijen (P28)"

echo "ok    $file (vaste secties aanwezig, incl. Bewust later)"
echo "ok    $dir/SOURCES.example.md"
if [[ -f data/external/digest/README.md ]]; then
  echo "ok    data/external/digest/README.md"
else
  echo "tip   data/external/digest/README.md ontbreekt — module research zou die zetten"
fi
echo "digest-check: groen"
