#!/usr/bin/env bash
# Hint for the inbound digest. Not in make check. No scrapers.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

file=docs/research/digest/README.md
die() { echo "digest-reminder: $*" >&2; exit 1; }

[[ -f "$file" ]] || die "ontbreekt $file (kit: --modules research)."

echo "digest-reminder: review feeds/SOURCES and curation (P5 — no dump as SSOT)."
if [[ -f docs/research/digest/SOURCES.md ]]; then
  echo "ok    docs/research/digest/SOURCES.md aanwezig"
else
  echo "tip   kopieer SOURCES.example.md → SOURCES.md en vul feeds in"
fi
if [[ -d data/external/digest ]]; then
  count=$(find data/external/digest -mindepth 1 ! -name README.md ! -name .gitkeep 2>/dev/null | wc -l | tr -d ' ')
  echo "info  data/external/digest/: $count non-meta files/folders"
else
  echo "tip   create data/external/digest/ for raw dumps (gitignored)"
fi
echo "Volgende: cureren → docs/research/radar.md of wantlist.md"
echo "Zie: docs/how-to/digest.md · make digest-fetch · make digest-propose"
echo "digest-reminder: klaar"
