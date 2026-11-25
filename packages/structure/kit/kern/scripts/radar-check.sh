#!/usr/bin/env bash
# Checklist tech-radar (module research). Niet in make check. Geen scrapers (v1).
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

file=docs/research/radar.md
die() { echo "radar-check: $*" >&2; exit 1; }

[[ -f "$file" ]] || die "missing $file (kit: --modules research)."

for heading in "## Ritual" "## Last reviewed" "## Rings" "## Radar" "## Commands" "## Deliberately later"; do
  grep -qF "$heading" "$file" || die "section missing in $file: $heading"
done

grep -qE 'Last reviewed:' "$file" || die "the line 'Last reviewed:' is missing in $file"

for ring in Adopt Trial Assess Hold; do
  grep -qF "$ring" "$file" || die "ring '$ring' missing in $file"
done

for cat in languages frameworks deps tooling; do
  grep -qiE "$cat" "$file" || die "category '$cat' missing in $file"
done

awk '
  /^## Deliberately later$/ { in_sec=1; next }
  in_sec && /^## / { exit found ? 0 : 1 }
  in_sec && /^\|/ && $0 !~ /^\|[[:space:]:|-]+\|$/ && $0 !~ /Extension/ { found=1 }
  END { exit found ? 0 : 1 }
' "$file" || die "table under ## Deliberately later has no extension rows (P28)"

# Minstens één datarij in de Radar-tabel (header + separator + rij).
awk '
  /^## Radar$/ { in_sec=1; next }
  in_sec && /^## / { exit rows >= 1 ? 0 : 1 }
  in_sec && /^\|/ && $0 !~ /^\|[[:space:]:|-]+\|$/ && $0 !~ /Categorie/ { rows++ }
  END { exit rows >= 1 ? 0 : 1 }
' "$file" || die "Radar-tabel mist rijen (vervang of houd voorbeeldrijen)"

echo "ok    $file (fixed sections present, incl. Deliberately later)"
echo "Tip: run make radar-reminder monthly; Adopt/Hold with impact → make adr."
echo "radar-check: groen"
