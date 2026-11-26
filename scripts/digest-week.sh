#!/usr/bin/env bash
# Build the week letter in bron/weken/YYYY-Www.md from dumps. Never writes bronnen.md (P5).
# DIGEST_WEEK=2026-W45 — force it (default: the current ISO week; on Monday optionally the previous one via digest-day).
# DIGEST_WEEK_SKIP_FETCH=1 — build the letter from existing dumps only.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"
SCRIPTS="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

WEKEN="${DIGEST_AE_WEKEN:-$ROOT/bron/weken}"
LOG_DIR="data/external/digest"
mkdir -p "$LOG_DIR" "$WEKEN"
LOG="$LOG_DIR/cron.log"
TODAY="$(date +%F)"

die() { echo "digest-week: $*" >&2; exit 1; }
tip() { echo "digest-week: $*" >&2; }
log() { printf '%s %s\n' "$(date -Iseconds)" "$*" | tee -a "$LOG" >&2; }

# Feeds live in docs/research/digest/SOURCES.md (write zone); the digest fetch script
# reads them from there. Checking bron/digest/SOURCES.md here stopped every run.
[[ -f docs/research/digest/SOURCES.md ]] || die "no docs/research/digest/SOURCES.md"
[[ -d "$WEKEN" ]] || die "weekmap ontbreekt: $WEKEN"

iso_week_default() {
  if [[ -n "${DIGEST_WEEK:-}" ]]; then
    printf '%s' "$DIGEST_WEEK"
    return
  fi
  date +%G-W%V
}

week_dates() {
  local week="$1"
  python3 - "$week" <<'PY'
import sys
from datetime import date, timedelta
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

label_for() {
  local src="$1" base="$2" label="$2"
  [[ "$src" == *rss.arxiv.org*cs.SE* ]] && label="rss cs.SE"
  [[ "$src" == *rss.arxiv.org*cs.MA* ]] && label="rss cs.MA"
  [[ "$src" == *cs.AI* || "$src" == *cs.LG* ]] && label="rss AI+LG+CL"
  [[ "$src" == *export.arxiv.org* ]] && label="api recent"
  [[ "$src" == *huggingface.co/blog* ]] && label="HF blog"
  [[ "$src" == *sort=trending* || "$src" == *sort%3Dtrending* ]] && label="HF trending"
  [[ "$src" == *daily_papers*week=* ]] && label="HF week"
  [[ "$src" == *daily_papers*date=* ]] && label="HF day"
  [[ "$src" == *daily_papers* && "$label" == "$base" ]] && label="HF daily"
  [[ "$src" == *papers/search*token* ]] && label="HF q:token"
  [[ "$src" == *papers/search*agent*harness* ]] && label="HF q:harness"
  [[ "$src" == *papers/search*context*engineering* ]] && label="HF q:context"
  [[ "$src" == *papers/search*agentic*coding* ]] && label="HF q:agentic"
  [[ "$src" == *papers/search*codebase*indexing* || "$src" == *papers/search*indexing* ]] && label="HF q:index"
  # Bachelorproef-stukken na de brede matches (laatste match wint).
  [[ "$src" == *papers/search*token*cost* ]] && label="HF q:tokencost"
  [[ "$src" == *papers/search*tool*output* ]] && label="HF q:toolout"
  [[ "$src" == *papers/search*lexical*retrieval* ]] && label="HF q:lexical"
  [[ "$src" == *papers/search*semantic*code*search* ]] && label="HF q:semantic"
  [[ "$src" == *papers/search*repository*context* ]] && label="HF q:repocontext"
  [[ "$src" == *papers/search*repository*exploration* ]] && label="HF q:explore"
  [[ "$src" == *papers/search*coding*agent*context* ]] && label="HF q:agentctx"
  printf '%s' "$label"
}

WEEK="$(iso_week_default)"
OUT="$WEKEN/${WEEK}.md"
tip "ISO-week=$WEEK → $OUT"

# A brief is written once and then curated by hand (statuses, §n, notes). Rebuilding
# it would wipe that work, so an existing brief is kept unless DIGEST_WEEK_FORCE=1.
if [[ -f "$OUT" && "${DIGEST_WEEK_FORCE:-}" != "1" ]]; then
  log "keep   $OUT (exists; DIGEST_WEEK_FORCE=1 to rebuild)"
  echo "digest-week: $OUT (kept)"
  exit 0
fi

mapfile -t DATES < <(week_dates "$WEEK")
[[ ${#DATES[@]} -eq 7 ]] || die "could not determine the dates for $WEEK"

if [[ "${DIGEST_WEEK_SKIP_FETCH:-}" != "1" ]]; then
  log "fetch start ($WEEK)"
  DIGEST_EXTRA_URLS="https://huggingface.co/api/daily_papers?week=${WEEK}&limit=50
https://huggingface.co/api/daily_papers?sort=trending&limit=50" \
  DIGEST_ITEM_LIMIT="${DIGEST_ITEM_LIMIT:-40}" \
  DIGEST_JSON_DAYS="${DIGEST_JSON_DAYS:-90}" \
    bash "$SCRIPTS/digest-fetch.sh"
  log "fetch klaar"
else
  tip "SKIP_FETCH=1"
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
  # Also take the content date in the HF date=/week= URL into account (catch-up dumps).
  for want in "${DATES[@]}"; do
    [[ "$src" == *"date=${want}"* ]] && keep=1 && break
  done
  [[ "$src" == *"week=${WEEK}"* ]] && keep=1
  # Trending / topic search / HF blog: the dump day may be earlier than the run day
  # (catch-up, Monday), so every dump inside this week counts — the 90-day window
  # in the search APIs keeps the noise low, the triage does the rest.
  case "$src" in
    *sort=trending* | *huggingface.co/api/papers/search* | *huggingface.co/blog*) keep=1 ;;
  esac
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
    label="$(label_for "$src" "$base")"
    printf '| %s | %s | %s | open |\n' "$title" "${link:-—}" "$label" >>"$rows"
    count=$((count + 1))
  done <"$items"
done

{
  echo "# Week letter — $WEEK"
  echo
  echo "> **Role:** inbound selection for this ISO week. Not SSOT — promote by hand into \`bronnen.md\` §."
  echo "> **Generated:** $TODAY via \`make digest-week\` (Cardine). Dumps: \`data/external/digest/\`."
  echo
  echo "## Checklist"
  echo
  echo "> After the fetch: \`make digest-triage\` — rules in [../digest/TRIAGE.md](../digest/TRIAGE.md); interests [../digest/interests.md](../digest/interests.md)."
  echo
  echo "- [ ] \`make digest-triage\` run (have/keep/skip)"
  echo "- [ ] \`keep\` scanned → \`§\` in [bronnen.md](../bronnen.md) + [bronnen-index.md](../bronnen-index.md) where needed; status \`§n\`"
  echo "- [ ] Own YouTube/inbox hits below or via [inbox.md](../inbox.md)"
  echo

  echo "## Papers / feed hits ($count unique)"
  echo
  if [[ "$count" -eq 0 ]]; then
    echo "_No dump items for dates ${DATES[*]}. Run \`make digest-day\`._"
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
