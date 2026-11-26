#!/usr/bin/env bash
# Fetch RSS/Atom/JSON API (or a fixture) into data/external/digest/.
# DIGEST_DRY_RUN=1 — show URLs only.
# DIGEST_FIXTURE=<file|dir> — offline.
# DIGEST_EXTRA_URLS=$'url1\nurl2' — extra feeds.
# DIGEST_DUMP_DATE=YYYY-MM-DD — folder prefix (default: today); for catching up missed days.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"
SCRIPTS="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DUMP_DAY="${DIGEST_DUMP_DATE:-$(date +%F)}"
# Live sources live in bron/digest/ next to the briefs; docs/research/digest/ is
# the kit scaffold and only a fallback (fresh project). digest-day.sh and
# digest-week.sh guard bron/digest/SOURCES.md, so resolve the same file here.
SOURCES="${DIGEST_SOURCES:-}"
if [[ -z "$SOURCES" ]]; then
  for cand in bron/digest/SOURCES.md docs/research/digest/SOURCES.md; do
    [[ -f "$cand" ]] && { SOURCES="$cand"; break; }
  done
  : "${SOURCES:=bron/digest/SOURCES.md}"
fi
OUT_ROOT="data/external/digest"
LIMIT="${DIGEST_ITEM_LIMIT:-40}"
# DIGEST_FETCH_BETWEEN=YYYY-MM-DD,YYYY-MM-DD — keep only items published in this
# window (catching up a past week; arXiv RSS/Atom only carry today's list).
BETWEEN="${DIGEST_FETCH_BETWEEN:-}"

die() { echo "digest-fetch: $*" >&2; exit 1; }
tip() { echo "digest-fetch: $*" >&2; }

[[ -f "$SOURCES" ]] || die "missing $SOURCES"

extract_urls() {
  # Only explicit feed URLs in <https://…> (not markdown links in notes).
  grep -Eo '<https?://[^>]+>' "$SOURCES" 2>/dev/null | sed 's/^<//; s/>$//; s/[.,;:]$//' | sort -u || true
  if [[ -n "${DIGEST_EXTRA_URLS:-}" ]]; then
    printf '%s\n' "$DIGEST_EXTRA_URLS" | grep -Eo 'https?://[^[:space:]]+' | sed 's/[.,;:]$//' || true
  fi
}

slug_from_url() {
  local u="$1" host path query slug qpart
  host="$(printf '%s' "$u" | sed -E 's|https?://||; s|/.*||; s|[^a-zA-Z0-9._-]|-|g')"
  path="$(printf '%s' "$u" | sed -E 's|https?://[^/]+/||; s|[?#].*||; s|[^a-zA-Z0-9]+|-|g; s|^-||; s|-$||')"
  query="$(printf '%s' "$u" | sed -nE 's|^[^?]+\?||p')"
  qpart=""
  if [[ -n "$query" ]]; then
    qpart="$(printf '%s' "$query" | sed -E 's|%20|-|g; s|\+|_|g; s|[^a-zA-Z0-9._=-]+|-|g; s|=|-|g; s|^-||; s|-$||')"
    qpart="${qpart:0:40}"
  fi
  slug="${host}${path:+-$path}${qpart:+-$qpart}"
  printf '%s' "${slug:0:80}"
}

if [[ "${DIGEST_ONLY_EXTRA:-}" == "1" ]]; then
  [[ -n "${DIGEST_EXTRA_URLS:-}" ]] || die "DIGEST_ONLY_EXTRA=1 requires DIGEST_EXTRA_URLS"
else
  [[ -f "$SOURCES" ]] || die "no $SOURCES — copy SOURCES.example.md"
fi

mapfile -t URLS < <(
  if [[ "${DIGEST_ONLY_EXTRA:-}" == "1" ]]; then
    printf '%s\n' "$DIGEST_EXTRA_URLS" | grep -Eo 'https?://[^[:space:]]+' | sed 's/[.,;:]$//' || true
  else
    extract_urls
  fi | awk 'NF && !seen[$0]++'
)
[[ ${#URLS[@]} -gt 0 ]] || die "no http(s) URLs to fetch"

if [[ "${1:-}" == "--dry-run" ]] || [[ "${DIGEST_DRY_RUN:-}" == "1" ]]; then
  tip "dry-run — would fetch ${#URLS[@]} feed(s) into $OUT_ROOT/${DUMP_DAY}-*/"
  for u in "${URLS[@]}"; do echo "  - $u"; done
  echo "digest-fetch: dry-run done"
  exit 0
fi

mkdir -p "$OUT_ROOT"
command -v python3 >/dev/null || die "python3 required"

is_json_api() {
  [[ "$1" == *"/api/"* ]] || [[ "$1" == *.json ]] || [[ "$1" == *".json?"* ]]
}

has_dump_for() {
  # Is there already a dump whose source.txt holds this URL (whatever the dump day)?
  local url="$1" f
  while IFS= read -r f; do
    [[ -f "$f" ]] || continue
    grep -Fxq "$url" "$f" 2>/dev/null && return 0
  done < <(find "$OUT_ROOT" -mindepth 2 -maxdepth 2 -name source.txt 2>/dev/null)
  return 1
}

fetch_one() {
  local url="$1" slug dest raw
  if [[ "${DIGEST_SKIP_EXISTING:-}" == "1" ]] && has_dump_for "$url"; then
    tip "skip (al aanwezig) → $url"
    return 0
  fi
  slug="$(slug_from_url "$url")"
  dest="$OUT_ROOT/${DUMP_DAY}-${slug}"
  mkdir -p "$dest"
  printf '%s\n' "$url" >"$dest/source.txt"
  if is_json_api "$url"; then
    raw="$dest/raw.json"
  else
    raw="$dest/raw.xml"
  fi

  if [[ -n "${DIGEST_FIXTURE:-}" ]]; then
    if [[ -f "$DIGEST_FIXTURE" ]]; then
      cp "$DIGEST_FIXTURE" "$raw"
    elif [[ -d "$DIGEST_FIXTURE" ]]; then
      local hit
      hit="$(find "$DIGEST_FIXTURE" -maxdepth 1 -type f \( -name '*.xml' -o -name '*.rss' -o -name '*.atom' -o -name '*.json' \) | head -n1)"
      [[ -n "$hit" ]] || die "DIGEST_FIXTURE dir has no feed file"
      cp "$hit" "$raw"
    else
      die "DIGEST_FIXTURE does not exist: $DIGEST_FIXTURE"
    fi
    tip "fixture → $dest"
  else
    if command -v curl >/dev/null; then
      curl -fsSL --max-time 60 -A "agent-engineering-digest/1" \
        -H "Accept: application/json, application/atom+xml, application/rss+xml, */*" \
        -o "$raw" "$url" \
        || die "HTTP failed for $url"
    elif command -v wget >/dev/null; then
      wget -q -O "$raw" "$url" || die "HTTP failed for $url"
    else
      die "curl or wget required"
    fi
    tip "fetched → $dest"
  fi

  python3 "$SCRIPTS/digest-rss.py" -i "$raw" -o "$dest/items.md" -s "$url" -n "$LIMIT" \
    ${BETWEEN:+-b "$BETWEEN"} \
    || tip "parse soft-fail for $url — $(basename "$raw") kept"
}

for u in "${URLS[@]}"; do
  fetch_one "$u"
done

echo "digest-fetch: klaar (${#URLS[@]} bron(nen)). Cureren: make digest-day / weekbrief (P5)."
