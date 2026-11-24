#!/usr/bin/env bash
# Bouwt een voorstel-Markdown uit recente digest-dumps. Wijzigt nooit radar.md (P5).
# DIGEST_DRY_RUN=1 — pad tonen zonder schrijven.
# DIGEST_PROPOSE_FROM=<dir> — alleen die dump-map (default: nieuwste onder data/external/digest/).
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"
TODAY="$(date +%F)"
DUMP_ROOT="data/external/digest"
PROP_DIR="docs/research/digest/proposals"
OUT="$PROP_DIR/${TODAY}-draft.md"
MAX_ITEMS="${DIGEST_PROPOSE_LIMIT:-15}"

die() { echo "digest-propose: $*" >&2; exit 1; }
tip() { echo "digest-propose: $*" >&2; }

[[ -f docs/research/digest/README.md ]] || die "ontbreekt docs/research/digest/ (kit: --modules research)."
[[ -d "$DUMP_ROOT" ]] || die "geen $DUMP_ROOT — eerst make digest-fetch"

pick_dumps() {
  if [[ -n "${DIGEST_PROPOSE_FROM:-}" ]]; then
    [[ -d "$DIGEST_PROPOSE_FROM" ]] || die "DIGEST_PROPOSE_FROM is geen map: $DIGEST_PROPOSE_FROM"
    printf '%s\n' "$DIGEST_PROPOSE_FROM"
    return
  fi
  # Nieuwste dump-mappen (datum-prefix), max 5
  find "$DUMP_ROOT" -mindepth 1 -maxdepth 1 -type d ! -name '.*' \
    | sort -r | head -n 5
}

mapfile -t DUMPS < <(pick_dumps)
[[ ${#DUMPS[@]} -gt 0 ]] || die "geen dump-mappen in $DUMP_ROOT — make digest-fetch eerst"

if [[ "${1:-}" == "--dry-run" ]] || [[ "${DIGEST_DRY_RUN:-}" == "1" ]]; then
  tip "dry-run — zou voorstel schrijven naar $OUT uit:"
  for d in "${DUMPS[@]}"; do echo "  - $d"; done
  echo "digest-propose: dry-run klaar"
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
  [[ -f "$items" ]] || { tip "geen items.md in $d — overgeslagen"; continue; }
  # Tabelrijen na header (skip tot eerste | Titel of na tweede |---|)
  while IFS= read -r line; do
    [[ "$line" == \|* ]] || continue
    [[ "$line" =~ Tit[e]?l ]] && continue
    [[ "$line" =~ ^\|[-:[:space:]\|]+\|$ ]] && continue
    # | title | link |
    title="$(printf '%s' "$line" | awk -F'|' '{gsub(/^ +| +$/,"",$2); print $2}')"
    link="$(printf '%s' "$line" | awk -F'|' '{gsub(/^ +| +$/,"",$3); print $3}')"
    [[ -n "$title" ]] || continue
    [[ "$title" != "—" ]] || continue
    printf '| Assess | tooling | %s | digest-kandidaat — cureren; bron %s · %s |\n' \
      "$title" "${src:-$d}" "${link:-—}" >>"$candidates"
    count=$((count + 1))
    [[ "$count" -ge "$MAX_ITEMS" ]] && break 2
  done <"$items"
done

[[ "$count" -gt 0 ]] || die "geen items om voor te stellen (lege items.md?)"

mkdir -p "$PROP_DIR"
{
  echo "# Digest-voorstel — $TODAY"
  echo
  echo "> **Geen SSOT.** Gegenereerd door \`make digest-propose\`. Kopieer geaccepteerde rijen handmatig naar [radar.md](../../radar.md) (Trial/Assess) of wantlist. Merge van een draft-PR = voorstel binnen, niet auto-radar (P5)."
  echo
  echo "## Kandidaat-rijen"
  echo
  echo "| Ring | Categorie | Item | Notitie / ADR |"
  echo "|------|-----------|------|---------------|"
  cat "$candidates"
  echo
  echo "## Checklist"
  echo
  echo "- [ ] Irrelevante rijen geschrapt"
  echo "- [ ] Ring aangepast (Assess → Trial alleen met intent)"
  echo "- [ ] Geaccepteerd → in \`radar.md\` geplakt; dump blijft in \`data/external/digest/\`"
  echo "- [ ] Agent Engineering-repo: eerst \`bron/bronnen.md\` §, dan brug"
} >"$OUT"

tip "geschreven: $OUT ($count kandidaten)"
echo "digest-propose: klaar — review $OUT; open desnoods draft-PR (team: .github/workflows/digest.yml)"
