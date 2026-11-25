#!/usr/bin/env bash
# Weekly: fetch → propose → week letter in bron/weken/ of this repo.
# The knowledge source (bron/) lives in this repo itself since the merge; no
# sibling repo is needed any more.
# Never writes bronnen.md (P5). Cron: see docs/how-to/digest.md.
# DIGEST_WEEK=2026-W44 — force the ISO week (default: last week on Monday; otherwise the current one).
# DIGEST_WEEK_SKIP_FETCH=1 — propose + week letter only.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"
SCRIPTS="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

BRON_WEKEN="${DIGEST_AE_WEKEN:-$ROOT/bron/weken}"
LOG_DIR="data/external/digest"
mkdir -p "$LOG_DIR"
LOG="$LOG_DIR/cron.log"

die() { echo "digest-week: $*" >&2; exit 1; }
tip() { echo "digest-week: $*" >&2; }
log() { printf '%s %s\n' "$(date -Iseconds)" "$*" | tee -a "$LOG" >&2; }

[[ -f docs/research/digest/README.md ]] || die "ontbreekt docs/research/digest/"
[[ -f docs/research/digest/SOURCES.md ]] || die "no SOURCES.md"
[[ -d "$BRON_WEKEN" ]] || die "weekmap ontbreekt: $BRON_WEKEN"

# ISO-week: op maandag = vorige volledige week; anders huidige week.
iso_week() {
  if [[ -n "${DIGEST_WEEK:-}" ]]; then
    printf '%s' "$DIGEST_WEEK"
    return
  fi
  if [[ "$(date +%u)" == "1" ]]; then
    date -d 'last week' +%G-W%V 2>/dev/null || date -v-7d +%G-W%V
  else
    date +%G-W%V
  fi
}

# Datums (YYYY-MM-DD) die bij ISO-week WEEK horen (ma–zo).
week_dates() {
  local week="$1"
  python3 - "$week" <<'PY'
import sys
from datetime import timedelta
from datetime import date
w = sys.argv[1]
try:
    year_s, rest = w.split("-W", 1)
    year, num = int(year_s), int(rest)
    mon = date.fromisocalendar(year, num, 1)
except Exception as e:
    print(f"digest-week: ongeldige ISO-week {w!r}: {e}", file=sys.stderr)
    sys.exit(1)
for i in range(7):
    print((mon + timedelta(days=i)).isoformat())
PY
}

WEEK="$(iso_week)"
OUT="$BRON_WEKEN/${WEEK}.md"
TODAY="$(date +%F)"
tip "ISO-week=$WEEK → $OUT"

mapfile -t DATES < <(week_dates "$WEEK")
[[ ${#DATES[@]} -eq 7 ]] || die "could not determine the dates for $WEEK"

if [[ "${DIGEST_WEEK_SKIP_FETCH:-}" != "1" ]]; then
  log "fetch start"
  # HF Daily Papers has a week API (no RSS) — force the ISO-week dump next to SOURCES.
  # Topic search: ~90d (not just the ISO week — otherwise e.g. token consumption is missed).
  DIGEST_EXTRA_URLS="https://huggingface.co/api/daily_papers?week=${WEEK}&limit=50" \
  DIGEST_ITEM_LIMIT="${DIGEST_ITEM_LIMIT:-40}" \
  DIGEST_JSON_DAYS="${DIGEST_JSON_DAYS:-90}" \
    bash "$SCRIPTS/digest-fetch.sh"
  log "fetch klaar"
else
  tip "SKIP_FETCH=1"
fi

log "propose start"
if DIGEST_PROPOSE_LIMIT="${DIGEST_PROPOSE_LIMIT:-40}" \
  DIGEST_PROPOSE_MAX_DUMPS="${DIGEST_PROPOSE_MAX_DUMPS:-30}" \
  bash "$SCRIPTS/digest-propose.sh"; then
  log "propose done"
else
  tip "propose soft-fail (empty dumps? weekend RSS?) — the week letter continues"
  log "propose soft-fail"
fi

tmpdir="$(mktemp -d)"
trap 'rm -rf "$tmpdir"' EXIT
rows="$tmpdir/rows.md"
: >"$rows"
seen="$tmpdir/seen"
: >"$seen"
count=0

for d in data/external/digest/*/; do
  [[ -d "$d" ]] || continue
  base="$(basename "$d")"
  # folder name = YYYY-MM-DD-<slug> — not %%-* (that cuts at the first dash → YYYY only)
  [[ "$base" =~ ^([0-9]{4}-[0-9]{2}-[0-9]{2})- ]] || continue
  day="${BASH_REMATCH[1]}"
  items="$d/items.md"
  [[ -f "$items" ]] || continue
  src=""
  [[ -f "$d/source.txt" ]] && src="$(tr -d '\r' <"$d/source.txt" | head -n1)"
  keep=0
  for want in "${DATES[@]}"; do
    [[ "$day" == "$want" ]] && keep=1 && break
  done
  # Maandag-fetch: HF week-API + topic-search vallen vaak buiten ma–zo (dump-datum = vandaag).
  # No HF daily?limit= here — that covers "today", not the previous ISO week.
  [[ "$src" == *"week=${WEEK}"* ]] && keep=1
  [[ "$day" == "$TODAY" && "$src" == *huggingface.co/api/papers/search* ]] && keep=1
  [[ "$keep" -eq 1 ]] || continue
  while IFS= read -r line; do
    [[ "$line" == \|* ]] || continue
    [[ "$line" =~ Tit[e]?l ]] && continue
    [[ "$line" =~ ^\|[-:[:space:]\|]+\|$ ]] && continue
    title="$(printf '%s' "$line" | awk -F'|' '{gsub(/^ +| +$/,"",$2); print $2}')"
    link="$(printf '%s' "$line" | awk -F'|' '{gsub(/^ +| +$/,"",$3); print $3}')"
    [[ -n "$title" && "$title" != "—" ]] || continue
    key="$(printf '%s' "$link" | tr '[:upper:]' '[:lower:]')"
    [[ -z "$key" || "$key" == "—" ]] && key="$title"
    grep -Fxq "$key" "$seen" 2>/dev/null && continue
    printf '%s\n' "$key" >>"$seen"
    # Short source label (not the whole API URL in the table)
    label="$base"
    [[ "$src" == *rss.arxiv.org*cs.SE* ]] && label="rss cs.SE"
    [[ "$src" == *rss.arxiv.org*cs.MA* ]] && label="rss cs.MA"
    [[ "$src" == *cs.AI* || "$src" == *cs.LG* ]] && label="rss AI+LG+CL"
    [[ "$src" == *export.arxiv.org* ]] && label="api recent"
    [[ "$src" == *huggingface.co/api/daily_papers*week=* ]] && label="HF week"
    [[ "$src" == *huggingface.co/api/daily_papers* && "$label" == "$base" ]] && label="HF daily"
    [[ "$src" == *huggingface.co/api/papers/search*token* ]] && label="HF q:token"
    [[ "$src" == *huggingface.co/api/papers/search*agent*harness* ]] && label="HF q:harness"
    [[ "$src" == *huggingface.co/api/papers/search*context*engineering* ]] && label="HF q:context"
    [[ "$src" == *huggingface.co/api/papers/search*agentic*coding* ]] && label="HF q:agentic"
    printf '| %s | %s | %s | open |\n' "$title" "${link:-—}" "$label" >>"$rows"
    count=$((count + 1))
  done <"$items"
done

{
  echo "# Week letter — $WEEK"
  echo
  echo "> **Role:** inbound selection for this ISO week. Not SSOT — promote by hand into \`bronnen.md\` §."
  echo "> **Generated:** $TODAY via \`make digest-week\` (Cardine). Fetch dumps stay in the IDE \`data/external/digest/\`."
  echo
  echo "## Checklist"
  echo
  echo "- [ ] Irrelevant rows removed / status \`skip\`"
  echo "- [ ] Interesting → \`§\` in [bronnen.md](../bronnen.md) + [bronnen-index.md](../bronnen-index.md); status here \`§n\`"
  echo "- [ ] Your own YouTube/inbox hits for this week below or via [inbox.md](../inbox.md)"
  echo "- [ ] Lab: optionally Trial/Assess on IDE \`docs/research/radar.md\` (not automatic)"
  echo
  echo "## Papers / feed hits ($count unique)"
  echo
  if [[ "$count" -eq 0 ]]; then
    echo "_No dump items for dates ${DATES[*]}. Run \`digest-fetch\` on weekdays or \`DIGEST_WEEK_SKIP_FETCH=0 make digest-week\`._"
    echo
  else
    echo "| Title | Link | Source | Status |"
    echo "|-------|------|------|--------|"
    cat "$rows"
    echo
  fi
  echo "## Eigen hits (YouTube / inbox)"
  echo
  echo "| Onderwerp | Pointer | → §? |"
  echo "|-----------|---------|------|"
  echo "| _…_ | | |"
  echo
  echo "## Notities"
  echo
  echo "_Korte weeksamenvatting (3–8 bullets) na review:_"
  echo
} >"$OUT"

log "weekbrief → $OUT ($count items)"
tip "klaar — review $OUT; promote naar bronnen.md § (P5)"
echo "digest-week: $OUT"
