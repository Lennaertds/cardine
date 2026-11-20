#!/usr/bin/env bash
# Wekelijks: fetch → propose → weekbrief in Agent Engineering bron/weken/.
# Schrijft nooit bronnen.md (P5). Cron: zie docs/how-to/digest.md.
# DIGEST_WEEK=2026-W44 — ISO-week forceren (default: vorige week op ma; anders huidige).
# DIGEST_WEEK_SKIP_FETCH=1 — alleen propose + weekbrief.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"
SCRIPTS="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

AE_BRON_WEKEN="${DIGEST_AE_WEKEN:-$ROOT/../Agent_Engineering/bron/weken}"
LOG_DIR="data/external/digest"
mkdir -p "$LOG_DIR"
LOG="$LOG_DIR/cron.log"

die() { echo "digest-week: $*" >&2; exit 1; }
tip() { echo "digest-week: $*" >&2; }
log() { printf '%s %s\n' "$(date -Iseconds)" "$*" | tee -a "$LOG" >&2; }

[[ -f docs/research/digest/README.md ]] || die "ontbreekt docs/research/digest/"
[[ -f docs/research/digest/SOURCES.md ]] || die "geen SOURCES.md"
[[ -d "$AE_BRON_WEKEN" ]] || die "AE-weekmap ontbreekt: $AE_BRON_WEKEN (verwacht sibling Agent_Engineering)"

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
OUT="$AE_BRON_WEKEN/${WEEK}.md"
TODAY="$(date +%F)"
tip "ISO-week=$WEEK → $OUT"

mapfile -t DATES < <(week_dates "$WEEK")
[[ ${#DATES[@]} -eq 7 ]] || die "kon datums voor $WEEK niet bepalen"

if [[ "${DIGEST_WEEK_SKIP_FETCH:-}" != "1" ]]; then
  log "fetch start"
  # HF Daily Papers heeft week-API (geen RSS) — forceer de ISO-week dump naast SOURCES.
  # Topic-search: ~90d (niet alleen ISO-week — anders mist bv. token-consumption).
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
  log "propose klaar"
else
  tip "propose soft-fail (lege dumps? weekend-RSS?) — weekbrief gaat door"
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
  # mapnaam = YYYY-MM-DD-<slug> — niet %%-* (dat knipt bij eerste streep → alleen YYYY)
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
  # Geen HF daily?limit= hier — die dekt “vandaag”, niet de vorige ISO-week.
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
    # Korte bronlabel (niet hele API-URL in de tabel)
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
  echo "# Weekbrief — $WEEK"
  echo
  echo "> **Rol:** Inbound selectie van deze ISO-week. Geen SSOT — promote handmatig naar \`bronnen.md\` §."
  echo "> **Gegenereerd:** $TODAY via \`make digest-week\` (Cardine). Fetch-dumps blijven in IDE \`data/external/digest/\`."
  echo
  echo "## Checklist"
  echo
  echo "- [ ] Irrelevante rijen geschrapt / status \`skip\`"
  echo "- [ ] Interessant → \`§\` in [bronnen.md](../bronnen.md) + [bronnen-index.md](../bronnen-index.md); status hier \`§n\`"
  echo "- [ ] Eigen YouTube/inbox-hits van deze week hieronder of via [inbox.md](../inbox.md)"
  echo "- [ ] Lab: eventueel Trial/Assess op IDE \`docs/research/radar.md\` (niet auto)"
  echo
  echo "## Papers / feed-hits ($count uniek)"
  echo
  if [[ "$count" -eq 0 ]]; then
    echo "_Geen dump-items voor datums ${DATES[*]}. Draai weekdays \`digest-fetch\` of \`DIGEST_WEEK_SKIP_FETCH=0 make digest-week\`._"
    echo
  else
    echo "| Titel | Link | Bron | Status |"
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
