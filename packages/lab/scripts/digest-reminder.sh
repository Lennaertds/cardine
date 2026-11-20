#!/usr/bin/env bash
# Tip voor inbound digest. Niet in make check. Geen scrapers.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

file=docs/research/digest/README.md
die() { echo "digest-reminder: $*" >&2; exit 1; }

[[ -f "$file" ]] || die "ontbreekt $file (kit: --modules research)."

echo "digest-reminder: bekijk feeds/SOURCES en curatie (P5 — geen dump als SSOT)."
if [[ -f docs/research/digest/SOURCES.md ]]; then
  echo "ok    docs/research/digest/SOURCES.md aanwezig"
else
  echo "tip   kopieer SOURCES.example.md → SOURCES.md en vul feeds in"
fi
if [[ -d data/external/digest ]]; then
  count=$(find data/external/digest -mindepth 1 ! -name README.md ! -name .gitkeep 2>/dev/null | wc -l | tr -d ' ')
  echo "info  data/external/digest/: $count niet-meta bestanden/mappen"
else
  echo "tip   maak data/external/digest/ voor ruwe dumps (gitignored)"
fi
echo "Volgende: cureren → docs/research/radar.md of wantlist.md"
echo "Zie: docs/how-to/digest.md · make digest-fetch · make digest-propose"
echo "digest-reminder: klaar"
