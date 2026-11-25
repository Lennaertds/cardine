#!/usr/bin/env bash
# bootstrap: temporarily place this standard in a project as _bootstrap/, or remove it again.
# Usage: scripts/bootstrap.sh <project>
#          scripts/bootstrap.sh --remove <project>
# The package sits in .git/info/exclude: git, rg and the link check do not see it, and it never ends up in a commit.
set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
NAME=_bootstrap

usage() {
  sed -n '3,4p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//' >&2
  exit 1
}

exclude_file() { git -C "$1" rev-parse --git-path info/exclude; }
exclude_line() { echo "/$(git -C "$1" rev-parse --show-prefix)$NAME/"; }

remove=0
if [[ "${1:-}" == --remove ]]; then remove=1; shift; fi
(($# == 1)) || usage
target="$1"

if ((remove)); then
  [[ -d "$target" ]] || { echo "No folder: $target" >&2; exit 1; }
  target="$(cd "$target" && pwd)"
  pkg="$target/$NAME"
  [[ -f "$pkg/BOOTSTRAP.md" ]] || { echo "No bootstrap package in $target (expected $pkg/BOOTSTRAP.md)." >&2; exit 1; }
  if git -C "$target" rev-parse --git-dir >/dev/null 2>&1; then
    if [[ -n "$(git -C "$target" ls-files -- "$NAME")" ]]; then
      echo "$NAME/ is in git; first: git rm -r --cached $NAME" >&2
      exit 1
    fi
    exclude="$(cd "$target" && realpath -m "$(exclude_file "$target")")"
    line="$(exclude_line "$target")"
    if [[ -f "$exclude" ]]; then
      grep -vxF -- "$line" "$exclude" >"$exclude.tmp" || true
      mv "$exclude.tmp" "$exclude"
    fi
  fi
  rm -rf -- "$pkg"
  echo "Bootstrap package removed: $pkg"
  exit 0
fi

mkdir -p "$target"
target="$(cd "$target" && pwd)"
pkg="$target/$NAME"
case "$target/" in
  "$SRC"/tmp/*) ;;
  "$SRC"/*) echo "The project sits inside the standard itself: $target" >&2; exit 1 ;;
esac
[[ ! -e "$pkg" ]] || { echo "Already exists: $pkg. First: $0 --remove $target" >&2; exit 1; }

# An empty folder gets its own repo, even inside another repo: otherwise the exclude does not apply to the new project.
if [[ -z "$(ls -A "$target")" ]] || ! git -C "$target" rev-parse --git-dir >/dev/null 2>&1; then
  git -C "$target" init -q -b main
  echo "git init: $target"
fi

mkdir "$pkg"
tar -C "$SRC" --exclude=./.git --exclude=./tmp --exclude="./$NAME" -cf - . | tar -C "$pkg" -xf -

exclude="$(cd "$target" && realpath -m "$(exclude_file "$target")")"
line="$(exclude_line "$target")"
mkdir -p "$(dirname "$exclude")"
grep -qxF -- "$line" "$exclude" 2>/dev/null || echo "$line" >>"$exclude"

cat <<EOF
Bootstrap package ready: $pkg
Invisible to git: $line in $exclude

Open $target in Cursor and tell the agent:

  Read _bootstrap/BOOTSTRAP.md and follow it for this project.

Removing it can be done by the agent at the end, or by you with:
  bash $SRC/scripts/bootstrap.sh --remove $target
EOF
