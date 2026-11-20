#!/usr/bin/env bash
# new-project: zet de kit neer in een nieuw of bestaand project. Overschrijft nooit een bestaand bestand.
set -euo pipefail

KIT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

usage() {
  cat <<'EOF'
Gebruik: kit/new-project.sh <map> [opties]

  --profile NAAM     profiel (app/research/studie/schoolwerk) — zet modules, stacks en extra bestanden
                     op basis van kit/profiles/<naam>.profile. Expliciete --modules/--stacks overschrijven.
  --team             team-laag in plaats van solo; voegt de module meetings toe
  --modules a,b      extra modules (zie kit/modules/): vision, assignment, product, design, research,
                     business, agent, deliverables, meetings, archive, herordening, compose, observability,
                     packages, infra, runtime, models, cursor, claude
  --stacks a,b       stacks (zie kit/stacks/): next, nest, python, sql, rust, c. De app-map moet al bestaan:
                     draai eerst de generator uit kit/stacks/<stack>/README.md
  --starter          ook de startcode van de stacks (config met test); alleen bij een nieuw project
  --name NAAM        projectnaam voor {{PROJECT}} (standaard: de mapnaam)
  --dry-run          alleen tonen wat er zou gebeuren
  --no-git           geen git init
  -h, --help         deze hulp

Voorbeelden:
  kit/new-project.sh ~/code/nieuw --profile app --stacks next,nest,python --starter
  kit/new-project.sh ~/code/agent-engineering --profile research --dry-run
  kit/new-project.sh ~/code/oefeningen --profile schoolwerk
EOF
}

die() { echo "new-project: $*" >&2; exit 1; }

target=""
mode="solo"
modules=()
stacks=()
profile=""
name=""
dry_run=0
git_init=1
starter=0

while (($#)); do
  case "$1" in
    --profile) [[ $# -ge 2 ]] || die "--profile vraagt een naam"; profile="$2"; shift ;;
    --team) mode="team" ;;
    --modules) [[ $# -ge 2 ]] || die "--modules vraagt een lijst"; IFS=, read -ra modules <<<"$2"; shift ;;
    --stacks) [[ $# -ge 2 ]] || die "--stacks vraagt een lijst"; IFS=, read -ra stacks <<<"$2"; shift ;;
    --name) [[ $# -ge 2 ]] || die "--name vraagt een naam"; name="$2"; shift ;;
    --dry-run) dry_run=1 ;;
    --starter) starter=1 ;;
    --no-git) git_init=0 ;;
    -h | --help) usage; exit 0 ;;
    -*) die "onbekende optie: $1 (zie --help)" ;;
    *) [[ -z "$target" ]] || die "één doelmap, niet meer"; target="$1" ;;
  esac
  shift
done

[[ -n "$target" ]] || { usage >&2; exit 1; }

# Profiel laden (vóór expliciete modules/stacks, zodat die kunnen overschrijven)
if [[ -n "$profile" ]]; then
  profile_file="$KIT_DIR/profiles/$profile.profile"
  [[ -f "$profile_file" ]] || die "onbekend profiel: $profile (bestaat $profile_file niet)"
  source "$profile_file"
  # Alleen als user geen eigen modules/stacks meegaf, gebruik die uit het profiel
  if ((${#modules[@]} == 0)) && [[ -n "${MODULES:-}" ]]; then
    IFS=, read -ra modules <<<"$MODULES"
  fi
  if ((${#stacks[@]} == 0)) && [[ -n "${STACKS:-}" ]]; then
    IFS=, read -ra stacks <<<"$STACKS"
  fi
  if ((starter == 0)) && [[ "${STARTER:-false}" == "true" ]]; then
    starter=1
  fi
fi

if [[ "$mode" == team && ! " ${modules[*]} " =~ " meetings " ]]; then modules+=(meetings); fi

for module in "${modules[@]}"; do
  [[ -d "$KIT_DIR/modules/$module" ]] || die "onbekende module: $module"
done
for stack in "${stacks[@]}"; do
  [[ -d "$KIT_DIR/stacks/$stack/apps" ]] || die "onbekende stack: $stack"
done

if ((dry_run)); then
  target_abs="$(realpath -m "$target")"
else
  mkdir -p "$target"
  target_abs="$(cd "$target" && pwd)"
fi
[[ "$target_abs" != "$KIT_DIR"* ]] || die "de doelmap ligt in de kit zelf"
name="${name:-$(basename "$target_abs")}"
today="$(date +%F)"
keys=" $mode ${modules[*]} ${stacks[*]} "
name_sed="$(printf '%s' "$name" | sed 's/[\/&|]/\\&/g')"

render() {
  awk -v keys="$keys" '
    /^<!-- als: [a-z0-9-]+[ \t]*$/ { block = 1; keep = index(keys, " " $3 " ") > 0; next }
    block && /^-->[ \t]*$/ { block = 0; next }
    block && !keep { next }
    { print }
  ' "$1" | sed -e "s|{{PROJECT}}|$name_sed|g" -e "s|{{DATE}}|$today|g" >"$2"
  chmod --reference="$1" "$2"
}

created=()
skipped=()
new_gitkeeps=()

copy_layer() {
  local source="$1" dest_root="$2" file rel dest dir
  while IFS= read -r -d '' file; do
    rel="${file#"$source"/}"
    dest="$dest_root/$rel"
    dir="$(dirname "$dest")"
    if [[ "$(basename "$file")" == .gitkeep && -d "$dir" && -n "$(ls -A "$dir")" ]]; then
      continue
    fi
    if [[ -e "$dest" || -L "$dest" ]]; then
      skipped+=("${dest#"$target_abs"/}")
      continue
    fi
    created+=("${dest#"$target_abs"/}")
    ((dry_run)) && continue
    mkdir -p "$dir"
    if [[ -L "$file" ]]; then
      cp -P "$file" "$dest"
    else
      render "$file" "$dest"
    fi
    [[ "$(basename "$file")" != .gitkeep ]] || new_gitkeeps+=("$dest")
  done < <(find "$source" -mindepth 1 \( -type f -o -type l \) \
    ! -path '*/__pycache__/*' ! -name '*.pyc' ! -name '*.pyo' -print0 | sort -z)
}

missing_apps=()

copy_layer "$KIT_DIR/kern" "$target_abs"
copy_layer "$KIT_DIR/logging" "$target_abs"
copy_layer "$KIT_DIR/$mode" "$target_abs"
for module in "${modules[@]}"; do
  copy_layer "$KIT_DIR/modules/$module" "$target_abs"
done
for stack in "${stacks[@]}"; do
  for app_dir in "$KIT_DIR/stacks/$stack/apps"/*/; do
    app="$(basename "$app_dir")"
    if [[ ! -d "$target_abs/apps/$app" ]]; then
      missing_apps+=("$stack: apps/$app bestaat nog niet. Draai eerst de generator uit kit/stacks/$stack/README.md en daarna dit script opnieuw.")
      continue
    fi
    copy_layer "${app_dir%/}" "$target_abs/apps/$app"
    if ((starter)) && [[ -d "$KIT_DIR/stacks/$stack/starter/apps/$app" ]]; then
      copy_layer "$KIT_DIR/stacks/$stack/starter/apps/$app" "$target_abs/apps/$app"
    fi
  done
done

# Extra profiel-bestanden kopiëren
if [[ -n "$profile" && -d "$KIT_DIR/profiles/extra/$profile" ]]; then
  copy_layer "$KIT_DIR/profiles/extra/$profile" "$target_abs"
fi

for gitkeep in "${new_gitkeeps[@]}"; do
  if [[ -n "$(ls -A "$(dirname "$gitkeep")" | grep -vx .gitkeep)" ]]; then rm "$gitkeep"; fi
done

if ((!dry_run && git_init)) && [[ ! -e "$target_abs/.git" ]]; then
  git -C "$target_abs" init -q -b main
  echo "git init: $target_abs"
fi

verb="aangemaakt"
((dry_run)) && verb="zou aanmaken"
echo "Project: $name (profiel: ${profile:-geen}; $mode; modules: ${modules[*]:-geen}; stacks: ${stacks[*]:-geen})"
echo "$verb: ${#created[@]} bestanden"
if ((dry_run && ${#created[@]})); then printf '  + %s\n' "${created[@]}"; fi
if ((${#skipped[@]})); then
  echo "bestond al, niet aangeraakt: ${#skipped[@]} (voeg de kit-versie met de hand samen als je ze wil)"
  printf '  = %s\n' "${skipped[@]}"
fi
if ((${#missing_apps[@]})); then
  echo "overgeslagen stacks:"
  printf '  ! %s\n' "${missing_apps[@]}"
fi
if ((!dry_run)); then
  echo
  echo "Volgende stap: cd $target_abs && make setup && make check"
fi
