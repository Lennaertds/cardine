#!/usr/bin/env bash
# check-links: meldt relatieve links in Markdown-bestanden die naar een niet-bestaand bestand wijzen.
# Gebruik: scripts/check-links.sh [map] [uit te sluiten submap ...]
# Slaat over: externe links, ankers, codeblokken, inline code, HTML-commentaar, <placeholders>
# en het tijdelijke opstartpakket _bootstrap/.
set -euo pipefail

root="${1:-.}"
root="${root%/}"
(($#)) && shift
prune=(-path "$root/.git" -o -path '*/node_modules' -o -path "$root/tmp" -o -path "$root/_bootstrap")
for excluded in "$@"; do prune+=(-o -path "$root/${excluded%/}"); done

link_targets() {
  awk '
    /^[ \t]*<!--/ && !/-->/ { comment = 1; next }
    comment { if (/-->/) comment = 0; next }
    match($0, /^[ \t]*(```+|~~~+)/) {
      marker = substr($0, RSTART, RLENGTH); gsub(/[ \t]/, "", marker)
      if (fence == "") { fence = marker; next }
      if ($0 ~ /^[ \t]*[`~]+[ \t]*$/ && substr(marker, 1, 1) == substr(fence, 1, 1) && length(marker) >= length(fence)) fence = ""
      next
    }
    fence != "" { next }
    { gsub(/`[^`]*`/, ""); print }
  ' "$1" | grep -oE '\]\([^)[:space:]]+\)' | sed -E 's/^\]\(//; s/\)$//' || true
}

failed=0
while IFS= read -r -d '' file; do
  dir="$(dirname "$file")"
  while IFS= read -r link; do
    target="${link%%#*}"
    if [[ -z "$target" || "$target" =~ ^[a-zA-Z][a-zA-Z0-9+.-]*: || "$target" == *"<"* || "$target" == *"{{"* ]]; then
      continue
    fi
    if [[ "$target" == /* ]]; then path="$root$target"; else path="$dir/$target"; fi
    path="${path//%20/ }"
    # Relative link die buiten de repo-root wijst (../* of dieper) verwijst naar een
    # sibling repo in een multi-root workspace — die kunnen we niet valideren.
    if [[ ! -e "$path" ]]; then
      # Bereken het absolute pad voor de link.
      abs_target="$(cd "$dir" && realpath -m "$target" 2>/dev/null || true)"
      # Als het absolute pad niet binnen de repo-root valt, is het een sibling-link.
      repo_root="$(cd "$root" && pwd)"
      if [[ -n "$abs_target" && "$abs_target" != "$repo_root" && "$abs_target" != "${repo_root}/"* ]]; then
        : # accepteer — verwijst naar buiten deze repo (bv. ../Agent_Engineering/)
      else
        echo "$file: dode link naar $link"
        failed=1
      fi
    fi
  done < <(link_targets "$file")
done < <(find "$root" \( "${prune[@]}" \) -prune -o -name '*.md' -type f -print0)

if ((failed)); then
  echo "Dode links gevonden." >&2
fi
exit "$failed"
