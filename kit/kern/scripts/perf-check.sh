#!/usr/bin/env bash
# Checklist performance-docs. Niet in make check. Geen code-heuristiek (v1).
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

file=docs/architecture/performance.md
die() { echo "perf-check: $*" >&2; exit 1; }

[[ -f "$file" ]] || die "ontbreekt $file (kit: kern)."

for heading in "## Relatie tot observability" "## Lagen (prioriteit)" "## Budgets" "## Anti-patronen" "## Commando's" "## Bewust later"; do
  grep -qF "$heading" "$file" || die "sectie ontbreekt in $file: $heading"
done

# Budgets-tabel: minstens een header-rij met Metric of Budget.
grep -qE '\|.*[Mm]etric.*\|' "$file" || die "budgets-tabel met kolom Metric ontbreekt in $file"

# P28: minstens één uitbreidingsrij in de Bewust later-tabel.
awk '
  /^## Bewust later$/ { in_sec=1; next }
  in_sec && /^## / { exit found ? 0 : 1 }
  in_sec && /^\|/ && $0 !~ /^\|[[:space:]:|-]+\|$/ && $0 !~ /Uitbreiding/ { found=1 }
  END { exit found ? 0 : 1 }
' "$file" || die "tabel onder ## Bewust later mist uitbreidingsrijen (P28)"

echo "ok    $file (vaste secties aanwezig, incl. Bewust later)"
echo "Tip: vul projectcijfers in de budgets-tabel; zet apps/<app>/scripts/bench.sh voor echte metingen."
echo "Uitbreidingen: zie ## Bewust later in $file (P28)."
echo "perf-check: groen"
