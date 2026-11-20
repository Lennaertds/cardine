#!/usr/bin/env bash
# Maandelijkse tip voor tech-radar. Niet in make check. Geen scrapers.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

file=docs/research/radar.md
die() { echo "radar-reminder: $*" >&2; exit 1; }

[[ -f "$file" ]] || die "ontbreekt $file (kit: --modules research)."

line=$(grep -E '^Laatst herzien:' "$file" | head -n1 || true)
[[ -n "$line" ]] || die "geen regel 'Laatst herzien:' in $file"

date_raw=$(printf '%s' "$line" | sed -E 's/^Laatst herzien:[[:space:]]*//; s/[[:space:]]*$//')
echo "radar-reminder: $line"

# Placeholder of ongeldig → altijd tip.
if [[ "$date_raw" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
  if date -d "$date_raw" +%s >/dev/null 2>&1; then
    then_s=$(date -d "$date_raw" +%s)
  elif date -j -f '%Y-%m-%d' "$date_raw" +%s >/dev/null 2>&1; then
    then_s=$(date -j -f '%Y-%m-%d' "$date_raw" +%s)
  else
    then_s=
  fi
  now_s=$(date +%s)
  if [[ -n "${then_s:-}" ]]; then
    days=$(( (now_s - then_s) / 86400 ))
    if (( days > 30 )); then
      echo "Tip: laatste herziening was $days dagen geleden — plan een radar-pass (ringen + ADR indien nodig)."
    elif (( days < 0 )); then
      echo "Tip: datum ligt in de toekomst — corrigeer 'Laatst herzien:'."
    else
      echo "Tip: herziening is $days dagen oud (richtlijn: maandelijks)."
    fi
  else
    echo "Tip: kon datum niet parsen — herzie toch maandelijks (zie docs/how-to/radar.md)."
  fi
else
  echo "Tip: zet een echte datum (YYYY-MM-DD) bij 'Laatst herzien:' en herzie maandelijks."
fi

echo "Zie: docs/research/radar.md · make radar-check"
echo "radar-reminder: klaar"
