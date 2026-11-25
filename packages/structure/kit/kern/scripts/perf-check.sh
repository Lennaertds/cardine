#!/usr/bin/env bash
# Checklist performance-docs. Niet in make check. Geen code-heuristiek (v1).
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

file=docs/architecture/performance.md
die() { echo "perf-check: $*" >&2; exit 1; }

[[ -f "$file" ]] || die "missing $file (kit: kern)."

for heading in "## Relation to observability" "## Layers (priority)" "## Budgets" "## Anti-patterns" "## Commands" "## Deliberately later"; do
  grep -qF "$heading" "$file" || die "section missing in $file: $heading"
done

# Budgets table: at least one header row with Metric or Budget.
grep -qE '\|.*[Mm]etric.*\|' "$file" || die "budgets table with a Metric column missing in $file"

# P28: minstens één uitbreidingsrij in de Bewust later-tabel.
awk '
  /^## Deliberately later$/ { in_sec=1; next }
  in_sec && /^## / { exit found ? 0 : 1 }
  in_sec && /^\|/ && $0 !~ /^\|[[:space:]:|-]+\|$/ && $0 !~ /Extension/ { found=1 }
  END { exit found ? 0 : 1 }
' "$file" || die "table under ## Deliberately later has no extension rows (P28)"

echo "ok    $file (vaste secties aanwezig, incl. Bewust later)"
echo "Tip: put project numbers in the budgets table; add apps/<app>/scripts/bench.sh for real measurements."
echo "Extensions: see ## Deliberately later in $file (P28)."
echo "perf-check: groen"
