#!/usr/bin/env bash
# Checklist digest-scaffold (module research). Niet in make check.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

dir=docs/research/digest
file="$dir/README.md"
die() { echo "digest-check: $*" >&2; exit 1; }

[[ -f "$file" ]] || die "missing $file (kit: --modules research)."
[[ -f "$dir/SOURCES.example.md" ]] || die "missing $dir/SOURCES.example.md"

for heading in "## Ritual" "## Source list" "## Commands" "## Deliberately later"; do
  grep -qF "$heading" "$file" || die "section missing in $file: $heading"
done

grep -qiE 'data/external/digest' "$file" || die "$file must mention data/external/digest"
grep -qF 'P5' "$file" || die "$file must mention P5 (no dump as SSOT)"

awk '
  /^## Deliberately later$/ { in_sec=1; next }
  in_sec && /^## / { exit found ? 0 : 1 }
  in_sec && /^\|/ && $0 !~ /^\|[[:space:]:|-]+\|$/ && $0 !~ /Extension/ { found=1 }
  END { exit found ? 0 : 1 }
' "$file" || die "table under ## Deliberately later has no extension rows (P28)"

echo "ok    $file (vaste secties aanwezig, incl. Bewust later)"
echo "ok    $dir/SOURCES.example.md"
if [[ -f data/external/digest/README.md ]]; then
  echo "ok    data/external/digest/README.md"
else
  echo "tip   data/external/digest/README.md ontbreekt — module research zou die zetten"
fi
echo "digest-check: groen"
