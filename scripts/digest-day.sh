#!/usr/bin/env bash
# Daily: catch up missed HF days → fetch SOURCES → week letter(s).
# Never writes bronnen.md (P5). systemd: digest-day.timer (Persistent=true).
# DIGEST_CATCHUP_DAYS=7 — how many calendar days back to fill HF daily?date=.
# DIGEST_DAY_SKIP_FETCH=1 — rebuild the week letters only.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"
SCRIPTS="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

LOG_DIR="data/external/digest"
mkdir -p "$LOG_DIR"
LOG="$LOG_DIR/cron.log"
CATCHUP_DAYS="${DIGEST_CATCHUP_DAYS:-7}"
TODAY="$(date +%F)"

die() { echo "digest-day: $*" >&2; exit 1; }
tip() { echo "digest-day: $*" >&2; }
log() { printf '%s %s\n' "$(date -Iseconds)" "$*" | tee -a "$LOG" >&2; }

[[ -f bron/digest/SOURCES.md ]] || die "no bron/digest/SOURCES.md"

have_hf_date() {
  local day="$1" f
  while IFS= read -r f; do
    [[ -f "$f" ]] || continue
    if grep -E -q "daily_papers\?date=${day}(&|$)" "$f" 2>/dev/null; then
      return 0
    fi
  done < <(find "$LOG_DIR" -mindepth 2 -maxdepth 2 -name source.txt 2>/dev/null)
  return 1
}

catchup_hf_days() {
  local i day url n=0
  tip "catch-up: laatste ${CATCHUP_DAYS} dagen HF daily_papers?date="
  for i in $(seq 0 $((CATCHUP_DAYS - 1))); do
    day="$(date -d "$TODAY -$i days" +%F 2>/dev/null || date -v-"${i}"d +%F)"
    if have_hf_date "$day"; then
      tip "  ok  $day (al aanwezig)"
      continue
    fi
    url="https://huggingface.co/api/daily_papers?date=${day}&limit=50"
    tip "  miss $day → fetch"
    # Dump-prefix = content-dag, zodat weekbrief op kalenderdatum filtert.
    if DIGEST_ONLY_EXTRA=1 \
      DIGEST_DUMP_DATE="$day" \
      DIGEST_EXTRA_URLS="$url" \
      DIGEST_ITEM_LIMIT="${DIGEST_ITEM_LIMIT:-40}" \
      DIGEST_JSON_DAYS=0 \
      bash "$SCRIPTS/digest-fetch.sh"; then
      n=$((n + 1))
    else
      tip "  soft-fail $day"
    fi
  done
  log "catch-up klaar ($n nieuwe dagen)"
}

if [[ "${DIGEST_DAY_SKIP_FETCH:-}" != "1" ]]; then
  log "day start"
  catchup_hf_days
  log "fetch SOURCES + trending/week"
  WEEK_NOW="$(date +%G-W%V)"
  DIGEST_EXTRA_URLS="https://huggingface.co/api/daily_papers?week=${WEEK_NOW}&limit=50
https://huggingface.co/api/daily_papers?sort=trending&limit=50" \
  DIGEST_ITEM_LIMIT="${DIGEST_ITEM_LIMIT:-40}" \
  DIGEST_JSON_DAYS="${DIGEST_JSON_DAYS:-90}" \
    bash "$SCRIPTS/digest-fetch.sh"
  log "fetch klaar"
else
  tip "SKIP_FETCH=1"
fi

DIGEST_WEEK_SKIP_FETCH=1 DIGEST_WEEK="$(date +%G-W%V)" bash "$SCRIPTS/digest-week.sh"

if [[ "$(date +%u)" == "1" ]]; then
  PREV="$(date -d 'last week' +%G-W%V 2>/dev/null || date -v-7d +%G-W%V)"
  tip "maandag → herbouw vorige week $PREV"
  DIGEST_WEEK_SKIP_FETCH=1 DIGEST_WEEK="$PREV" bash "$SCRIPTS/digest-week.sh"
fi

log "day klaar"
echo "digest-day: klaar — review bron/weken/"
