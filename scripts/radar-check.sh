#!/usr/bin/env bash
# Checklist tech-radar (module research). Niet in make check. Geen scrapers (v1).
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

file=docs/research/radar.md
die() { echo "radar-check: $*" >&2; exit 1; }

[[ -f "$file" ]] || die "ontbreekt $file (kit: --modules research)."

for heading in "## Ritueel" "## Laatst herzien" "## Ringen" "## Radar" "## Commando's" "## Bewust later"; do
  grep -qF "$heading" "$file" || die "sectie ontbreekt in $file: $heading"
done

grep -qE 'Laatst herzien:' "$file" || die "regel 'Laatst herzien:' ontbreekt in $file"

for ring in Adopt Trial Assess Hold; do
  grep -qF "$ring" "$file" || die "ring '$ring' ontbreekt in $file"
done

for cat in talen frameworks deps tooling; do
  grep -qiE "$cat" "$file" || die "categorie '$cat' ontbreekt in $file"
done

awk '
  /^## Bewust later$/ { in_sec=1; next }
  in_sec && /^## / { exit found ? 0 : 1 }
  in_sec && /^\|/ && $0 !~ /^\|[[:space:]:|-]+\|$/ && $0 !~ /Uitbreiding/ { found=1 }
  END { exit found ? 0 : 1 }
' "$file" || die "tabel onder ## Bewust later mist uitbreidingsrijen (P28)"

# Minstens één datarij in de Radar-tabel (header + separator + rij).
awk '
  /^## Radar$/ { in_sec=1; next }
  in_sec && /^## / { exit rows >= 1 ? 0 : 1 }
  in_sec && /^\|/ && $0 !~ /^\|[[:space:]:|-]+\|$/ && $0 !~ /Categorie/ { rows++ }
  END { exit rows >= 1 ? 0 : 1 }
' "$file" || die "Radar-tabel mist rijen (vervang of houd voorbeeldrijen)"

echo "ok    $file (vaste secties aanwezig, incl. Bewust later)"
echo "Tip: maandelijks make radar-reminder; Adopt/Hold met impact → make adr."
echo "radar-check: groen"
