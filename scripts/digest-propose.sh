#!/usr/bin/env bash
# Builds proposal Markdown from recent dumps. Never changes bronnen.md (P5).
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"
TODAY="$(date +%F)"
DUMP_ROOT="data/external/digest"
PROP_DIR="bron/digest/proposals"
OUT="$PROP_DIR/${TODAY}-draft.md"
MAX_ITEMS="${DIGEST_PROPOSE_LIMIT:-25}"

die() { echo "digest-propose: $*" >&2; exit 1; }
tip() { echo "digest-propose: $*" >&2; }

[[ -f bron/digest/README.md ]] || die "ontbreekt bron/digest/"
[[ -d "$DUMP_ROOT" ]] || die "no $DUMP_ROOT — run make digest-fetch first"

pick_dumps() {
  if [[ -n "${DIGEST_PROPOSE_FROM:-}" ]]; then
    [[ -d "$DIGEST_PROPOSE_FROM" ]] || die "DIGEST_PROPOSE_FROM is not a folder"
    printf '%s\n' "$DIGEST_PROPOSE_FROM"
    return
  fi
  local max="${DIGEST_PROPOSE_MAX_DUMPS:-8}"
  find "$DUMP_ROOT" -mindepth 1 -maxdepth 1 -type d ! -name '.*' | sort -r | head -n "$max"
}

mapfile -t DUMPS < <(pick_dumps)
[[ ${#DUMPS[@]} -gt 0 ]] || die "no dump folders — run make digest-fetch first"

if [[ "${1:-}" == "--dry-run" ]] || [[ "${DIGEST_DRY_RUN:-}" == "1" ]]; then
  tip "dry-run — zou $OUT schrijven uit:"
  for d in "${DUMPS[@]}"; do echo "  - $d"; done
  exit 0
fi

tmpdir="$(mktemp -d)"
trap 'rm -rf "$tmpdir"' EXIT
candidates="$tmpdir/rows.md"
: >"$candidates"
count=0

for d in "${DUMPS[@]}"; do
  items="$d/items.md"
  src=""
  [[ -f "$d/source.txt" ]] && src="$(tr -d '\r' <"$d/source.txt" | head -n1)"
  [[ -f "$items" ]] || continue
  while IFS= read -r line; do
    [[ "$line" == \|* ]] || continue
    [[ "$line" =~ Tit[e]?l ]] && continue
    [[ "$line" =~ ^\|[-:[:space:]\|]+\|$ ]] && continue
    title="$(printf '%s' "$line" | awk -F'|' '{gsub(/^ +| +$/,"",$2); print $2}')"
    link="$(printf '%s' "$line" | awk -F'|' '{gsub(/^ +| +$/,"",$3); print $3}')"
    [[ -n "$title" && "$title" != "—" ]] || continue
    printf '| %s | %s | %s | open |\n' "$title" "${link:-—}" "${src:-$d}" >>"$candidates"
    count=$((count + 1))
    [[ "$count" -ge "$MAX_ITEMS" ]] && break 2
  done <"$items"
done

[[ "$count" -gt 0 ]] || die "no items to propose"

mkdir -p "$PROP_DIR"
{
  echo "# Digest-voorstel — $TODAY"
  echo
  echo "> **Geen SSOT.** Review → promote naar [bronnen.md](../../bronnen.md) § + weekbrief-status."
  echo
  echo "| Titel | Link | Bron | Status |"
  echo "|-------|------|------|--------|"
  cat "$candidates"
  echo
} >"$OUT"

tip "geschreven: $OUT ($count kandidaten)"
echo "digest-propose: klaar — review $OUT"
