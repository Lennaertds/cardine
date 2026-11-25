#!/usr/bin/env bash
# new-project: lays the kit down in a new or existing project. Never overwrites an existing file.
set -euo pipefail

# Resolve symlinks first: through an npm bin symlink BASH_SOURCE[0] is the link in
# <prefix>/bin, and KIT_DIR would point there (profiles/stacks not found).
KIT_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"

usage() {
  cat <<'EOF'
Usage: kit/new-project.sh <dir> [options]

  --profile NAME     profile (app/research/studie/schoolwerk) — sets modules, stacks and extra files
                     from kit/profiles/<name>.profile. Explicit --modules/--stacks win.
  --team             team layer instead of solo; adds the meetings module
  --modules a,b      extra modules (see kit/modules/): vision, assignment, product, design, research,
                     business, agent, deliverables, meetings, archive, reorganise, compose, observability,
                     packages, infra, runtime, models, cursor, claude
  --stacks a,b       stacks (see kit/stacks/): next, nest, python, sql, rust, c. The app directory must
                     already exist: run the generator in kit/stacks/<stack>/README.md first
  --starter          also the stacks' starter code (config with test); new projects only
  --name NAME        project name for {{PROJECT}} (default: the directory name)
  --dry-run          show what would happen, change nothing
  --no-git           skip git init
  -h, --help         this help

Examples:
  kit/new-project.sh ~/code/new --profile app --stacks next,nest,python --starter
  kit/new-project.sh ~/code/agent-engineering --profile research --dry-run
  kit/new-project.sh ~/code/exercises --profile schoolwerk
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
    --profile) [[ $# -ge 2 ]] || die "--profile needs a name"; profile="$2"; shift ;;
    --team) mode="team" ;;
    --modules) [[ $# -ge 2 ]] || die "--modules needs a list"; IFS=, read -ra modules <<<"$2"; shift ;;
    --stacks) [[ $# -ge 2 ]] || die "--stacks needs a list"; IFS=, read -ra stacks <<<"$2"; shift ;;
    --name) [[ $# -ge 2 ]] || die "--name needs a name"; name="$2"; shift ;;
    --dry-run) dry_run=1 ;;
    --starter) starter=1 ;;
    --no-git) git_init=0 ;;
    -h | --help) usage; exit 0 ;;
    -*) die "unknown option: $1 (see --help)" ;;
    *) [[ -z "$target" ]] || die "one target directory, not more"; target="$1" ;;
  esac
  shift
done

[[ -n "$target" ]] || { usage >&2; exit 1; }

# Profiel laden (vóór expliciete modules/stacks, zodat die kunnen overschrijven)
if [[ -n "$profile" ]]; then
  profile_file="$KIT_DIR/profiles/$profile.profile"
  [[ -f "$profile_file" ]] || die "unknown profile: $profile ($profile_file does not exist)"
  source "$profile_file"
  # Use the profile modules/stacks only if the user passed none
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
  [[ -d "$KIT_DIR/modules/$module" ]] || die "unknown module: $module"
done
for stack in "${stacks[@]}"; do
  [[ -d "$KIT_DIR/stacks/$stack/apps" ]] || die "unknown stack: $stack"
done

if ((dry_run)); then
  target_abs="$(realpath -m "$target")"
else
  mkdir -p "$target"
  target_abs="$(cd "$target" && pwd)"
fi
[[ "$target_abs" != "$KIT_DIR"* ]] || die "the target directory is inside the kit itself"
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
      missing_apps+=("$stack: apps/$app does not exist yet. Run the generator in kit/stacks/$stack/README.md first, then this script again.")
      continue
    fi
    copy_layer "${app_dir%/}" "$target_abs/apps/$app"
    if ((starter)) && [[ -d "$KIT_DIR/stacks/$stack/starter/apps/$app" ]]; then
      copy_layer "$KIT_DIR/stacks/$stack/starter/apps/$app" "$target_abs/apps/$app"
    fi
  done
done

# Copy extra profile files
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

verb="created"
((dry_run)) && verb="would create"
echo "Project: $name (profile: ${profile:-none}; $mode; modules: ${modules[*]:-none}; stacks: ${stacks[*]:-none})"
echo "$verb: ${#created[@]} files"
if ((dry_run && ${#created[@]})); then printf '  + %s\n' "${created[@]}"; fi
if ((${#skipped[@]})); then
  echo "already present, left alone: ${#skipped[@]} (merge the kit version by hand if you want them)"
  printf '  = %s\n' "${skipped[@]}"
fi
if ((${#missing_apps[@]})); then
  echo "skipped stacks:"
  printf '  ! %s\n' "${missing_apps[@]}"
fi
if ((!dry_run)); then
  echo
  echo "Next step: cd $target_abs && make setup && make check"
fi
