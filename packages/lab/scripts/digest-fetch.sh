#!/usr/bin/env bash
# Haal RSS/Atom/JSON-API (of fixture) op naar data/external/digest/. Niet in make check (P25).
# DIGEST_DRY_RUN=1 — alleen URLs tonen.
# DIGEST_FIXTURE=<file|dir> — geen netwerk; gebruik lokale XML/JSON (test-kit / offline).
# DIGEST_EXTRA_URLS=$'url1\nurl2' — extra feeds (bv. HF week-API vanuit digest-week).
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"
SCRIPTS="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TODAY="$(date +%F)"
SOURCES="docs/research/digest/SOURCES.md"
OUT_ROOT="data/external/digest"
LIMIT="${DIGEST_ITEM_LIMIT:-30}"

die() { echo "digest-fetch: $*" >&2; exit 1; }
tip() { echo "digest-fetch: $*" >&2; }

[[ -f docs/research/digest/README.md ]] || die "ontbreekt docs/research/digest/ (kit: --modules research)."

extract_urls() {
  # URLs uit SOURCES.md (markdown-tabel, backticks, <…>, kale https)
  grep -Eo 'https?://[^[:space:]|>`)]+' "$SOURCES" 2>/dev/null | sed 's/[.,;:]$//' | sort -u || true
  if [[ -n "${DIGEST_EXTRA_URLS:-}" ]]; then
    printf '%s\n' "$DIGEST_EXTRA_URLS" | grep -Eo 'https?://[^[:space:]]+' | sed 's/[.,;:]$//' || true
  fi
}

slug_from_url() {
  local u="$1" host path query slug qpart
  host="$(printf '%s' "$u" | sed -E 's|https?://||; s|/.*||; s|[^a-zA-Z0-9._-]|-|g')"
  # pad behouden (niet bij eerste / afknippen) — anders botsen alle rss.arxiv.org-feeds
  path="$(printf '%s' "$u" | sed -E 's|https?://[^/]+/||; s|[?#].*||; s|[^a-zA-Z0-9]+|-|g; s|^-||; s|-$||')"
  # query meenemen (HF search/week) — anders botsen alle /api/papers/search?*
  query="$(printf '%s' "$u" | sed -nE 's|^[^?]+\?||p')"
  qpart=""
  if [[ -n "$query" ]]; then
    qpart="$(printf '%s' "$query" | sed -E 's|%20|-|g; s|\+|_|g; s|[^a-zA-Z0-9._=-]+|-|g; s|=|-|g; s|^-||; s|-$||')"
    qpart="${qpart:0:40}"
  fi
  slug="${host}${path:+-$path}${qpart:+-$qpart}"
  printf '%s' "${slug:0:80}"
}

[[ -f "$SOURCES" ]] || die "geen $SOURCES — kopieer SOURCES.example.md en vul feeds in."

mapfile -t URLS < <(extract_urls)
[[ ${#URLS[@]} -gt 0 ]] || die "geen http(s)-URL's in $SOURCES"

if [[ "${1:-}" == "--dry-run" ]] || [[ "${DIGEST_DRY_RUN:-}" == "1" ]]; then
  tip "dry-run — zou ${#URLS[@]} feed(s) ophalen naar $OUT_ROOT/${TODAY}-*/"
  for u in "${URLS[@]}"; do echo "  - $u"; done
  if [[ -n "${DIGEST_FIXTURE:-}" ]]; then
    tip "DIGEST_FIXTURE=$DIGEST_FIXTURE (offline)"
  fi
  tip "daarna: make digest-propose (voorstel, geen auto-radar — P5)"
  echo "digest-fetch: dry-run klaar"
  exit 0
fi

mkdir -p "$OUT_ROOT"
command -v python3 >/dev/null || die "python3 vereist voor RSS/Atom/JSON-parse"

is_json_api() {
  [[ "$1" == *"/api/"* ]] || [[ "$1" == *.json ]] || [[ "$1" == *".json?"* ]]
}

fetch_one() {
  local url="$1" slug dest raw
  slug="$(slug_from_url "$url")"
  dest="$OUT_ROOT/${TODAY}-${slug}"
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
      [[ -n "$hit" ]] || die "DIGEST_FIXTURE-dir heeft geen .xml/.rss/.atom/.json"
      cp "$hit" "$raw"
    else
      die "DIGEST_FIXTURE bestaat niet: $DIGEST_FIXTURE"
    fi
    tip "fixture → $dest"
  else
    if command -v curl >/dev/null; then
      curl -fsSL --max-time 60 -A "agent-engineering-digest/1" \
        -H "Accept: application/json, application/atom+xml, application/rss+xml, */*" \
        -o "$raw" "$url" \
        || die "HTTP faalde voor $url"
    elif command -v wget >/dev/null; then
      wget -q -O "$raw" "$url" || die "HTTP faalde voor $url"
    else
      die "curl of wget vereist voor live fetch (of zet DIGEST_FIXTURE=…)"
    fi
    tip "opgehaald → $dest"
  fi

  python3 "$SCRIPTS/digest-rss.py" -i "$raw" -o "$dest/items.md" -s "$url" -n "$LIMIT" \
    || tip "parse soft-fail voor $url — $(basename "$raw") bewaard"
}

for u in "${URLS[@]}"; do
  fetch_one "$u"
done

echo "digest-fetch: klaar (${#URLS[@]} bron(nen)). Cureren: make digest-propose (P5 — geen dump als SSOT)."
