#!/usr/bin/env bash
# check-links: reports relative links in Markdown files that point at a file that does not exist.
# Usage: packages/lab/scripts/check-links.sh [dir] [subfolders to exclude ...]
# Skips: external links, anchors, code blocks, inline code, HTML comments, <placeholders>
# and the temporary bootstrap package _bootstrap/.
set -euo pipefail

# Folders that are not in git (e.g. bron/pdfs/, via Syncthing): a link to them
# is not dead on this machine, but must not count as an error on a fresh clone.
skip_targets=()
args=()
while (($#)); do
    if [[ "$1" == "--skip-target" ]] && (($# >= 2)); then
        skip_targets+=("${2%/}"); shift 2
    else
        args+=("$1"); shift
    fi
done
set -- ${args[@]+"${args[@]}"}

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
    # A relative link that points outside the repo root (../* or deeper) refers to a
    # sibling repo in a multi-root workspace — we cannot validate those.
    if [[ ! -e "$path" ]]; then
      # Compare on the path inside the repo (e.g. bron/pdfs/x.pdf), not on the
      # raw relative link: that one is relative to the Markdown file's folder.
      rel_path="${path#"$root"/}"
      skipped=0
      for st in "${skip_targets[@]}"; do
        if [[ "$rel_path" == "$st/"* || "$rel_path" == "$st" ]]; then skipped=1; break; fi
      done
      if ((skipped)); then continue; fi
      # Compute the absolute path for the link.
      abs_target="$(cd "$dir" && realpath -m "$target" 2>/dev/null || true)"
      # If the absolute path does not fall inside the repo root, it is a sibling link.
      repo_root="$(cd "$root" && pwd)"
      if [[ -n "$abs_target" && "$abs_target" != "$repo_root" && "$abs_target" != "${repo_root}/"* ]]; then
        : # accept — points outside this repo (e.g. ../`kit/`/ — private sibling, not public)
      else
        echo "$file: dead link to $link"
        failed=1
      fi
    fi
  done < <(link_targets "$file")
done < <(find "$root" \( "${prune[@]}" \) -prune -o -name '*.md' -type f -print0)

if ((failed)); then
  echo "Dead links found." >&2
fi
exit "$failed"
