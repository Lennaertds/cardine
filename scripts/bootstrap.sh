#!/usr/bin/env bash
# bootstrap: zet deze standaard tijdelijk in een project als _bootstrap/, of haalt hem weer weg.
# Gebruik: scripts/bootstrap.sh <project>
#          scripts/bootstrap.sh --remove <project>
# Het pakket staat in .git/info/exclude: git, rg en de link-check zien het niet, en het komt nooit in een commit.
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
  [[ -d "$target" ]] || { echo "Geen map: $target" >&2; exit 1; }
  target="$(cd "$target" && pwd)"
  pkg="$target/$NAME"
  [[ -f "$pkg/BOOTSTRAP.md" ]] || { echo "Geen opstartpakket in $target (verwacht $pkg/BOOTSTRAP.md)." >&2; exit 1; }
  if git -C "$target" rev-parse --git-dir >/dev/null 2>&1; then
    if [[ -n "$(git -C "$target" ls-files -- "$NAME")" ]]; then
      echo "$NAME/ staat in git; eerst: git rm -r --cached $NAME" >&2
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
  echo "Opstartpakket weg: $pkg"
  exit 0
fi

mkdir -p "$target"
target="$(cd "$target" && pwd)"
pkg="$target/$NAME"
case "$target/" in
  "$SRC"/tmp/*) ;;
  "$SRC"/*) echo "Het project ligt in de standaard zelf: $target" >&2; exit 1 ;;
esac
[[ ! -e "$pkg" ]] || { echo "Bestaat al: $pkg. Eerst: $0 --remove $target" >&2; exit 1; }

# Een lege map krijgt een eigen repo, ook binnen een andere repo: anders telt de exclude niet voor het nieuwe project.
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
Opstartpakket klaar: $pkg
Niet zichtbaar voor git: $line in $exclude

Open $target in Cursor en geef de agent:

  Lees _bootstrap/BOOTSTRAP.md en volg het voor dit project.

Weghalen kan de agent zelf aan het einde, of jij met:
  bash $SRC/scripts/bootstrap.sh --remove $target
EOF
