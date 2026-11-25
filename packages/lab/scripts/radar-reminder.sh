#!/usr/bin/env bash
# Monthly hint for the tech radar. Not in make check. No scrapers.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

file=docs/research/radar.md
die() { echo "radar-reminder: $*" >&2; exit 1; }

[[ -f "$file" ]] || die "missing $file (kit: --modules research)."

line=$(grep -E '^Last reviewed:' "$file" | head -n1 || true)
[[ -n "$line" ]] || die "no line 'Last reviewed:' in $file"

date_raw=$(printf '%s' "$line" | sed -E 's/^Last reviewed:[[:space:]]*//; s/[[:space:]]*$//')
echo "radar-reminder: $line"

# Placeholder or invalid → always a hint.
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
      echo "Tip: the last review was $days days ago — plan a radar pass (rings + ADR if needed)."
    elif (( days < 0 )); then
      echo "Tip: the date lies in the future — correct 'Last reviewed:'."
    else
      echo "Tip: the review is $days days old (guideline: monthly)."
    fi
  else
    echo "Tip: could not parse the date — review monthly anyway (see docs/how-to/radar.md)."
  fi
else
  echo "Tip: put a real date (YYYY-MM-DD) after 'Last reviewed:' and review monthly."
fi

echo "See: docs/research/radar.md · make radar-check"
echo "radar-reminder: done"
