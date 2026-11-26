#!/usr/bin/env bash
# Checklist for the digest scaffold (module research). Not in make check.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
cd "$ROOT"

die() { echo "digest-check: $*" >&2; exit 1; }

# Lab-only: this repo also keeps the triage notes under bron/digest/.
[[ -f bron/digest/TRIAGE.md ]] || die "missing bron/digest/TRIAGE.md"
# bron/ is Dutch by rule (AGENTS.md), so the triage note's "doubt" is "twijfel".
# Match either word: a translation of this file must not trip the check.
grep -qiE 'twijfel|doubt' bron/digest/TRIAGE.md || die "TRIAGE.md must mention twijfel/doubt → keep"
echo "ok    bron/digest/TRIAGE.md"

# The kit contract: the scaffold a fresh project gets from module research.
dir=docs/research/digest
file="$dir/README.md"

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

echo "ok    $file (fixed sections present, incl. Deliberately later)"
echo "ok    $dir/SOURCES.example.md"
if [[ -f data/external/digest/README.md ]]; then
  echo "ok    data/external/digest/README.md"
else
  echo "hint  data/external/digest/README.md is missing — the research module would add it"
fi
echo "digest-check: groen"
