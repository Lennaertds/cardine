#!/usr/bin/env bash
# cardine-move.sh — the project moved: re-point the lab and repair what the move broke.
#
# Usage:
#   bash packages/lab/cardine-move.sh               dry run: report every stale path
#   bash packages/lab/cardine-move.sh --fix         write the repairs and re-index
#   bash packages/lab/cardine-move.sh --fix --skip-index
#   bash packages/lab/cardine-move.sh --profile bp  only that profile (no index)
#
# The profile (~/.dsh/profiles/acp/cordis.patch.yml) stores ABSOLUTE paths:
# workspaceRoot, mcp-jarvis.cwd, the runnerCommand, both plugin names. A moved
# repo leaves DSH with "spawn .../cardine-bwrap ENOENT" and nothing else.
#
# Why not cardine-status.sh --fix: that repairs only the runner and the
# slice-check, and only in ~/.dsh — not workspaceRoot, not mcp-jarvis.cwd, and it
# ignores DSH_HOME. Here: the full profile rewrite (paths only), the jarvis CLI
# and wrapper in ~/.local/bin (a crash can wipe them), and the index of the root.
#
# It never restarts DSH. Kill the server yourself (dsh kill) and start a new
# thread from inside the new root; the profile and the plugins load at start.
set -euo pipefail

SELF="$(readlink -f "${BASH_SOURCE[0]}")"
LAB_DIR="$(cd "$(dirname "${SELF}")" && pwd)"
STATUS="${LAB_DIR}/cardine-status.sh"
PROJECT_DIR="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
# DSH_HOME wins only when it is a real directory: after moving the DSH home
# itself it is stale, and then ~/.dsh is the profile DSH will load.
if [ -n "${DSH_HOME:-}" ] && [ -d "${DSH_HOME}" ]; then
  DSH_HOME_DIR="${DSH_HOME}"
else
  DSH_HOME_DIR="${HOME}/.dsh"
fi
DSH_PROFILE="${DSH_HOME_DIR}/profiles/acp/cordis.patch.yml"

# The profile that owns this root: the one whose workspaceRoot is the git root.
# Every other profile is someone else's project and is not touched.
own_profile() {
  local p
  for p in "${DSH_HOME_DIR}"/profiles/*/cordis.patch.yml; do
    [ -f "$p" ] || continue
    [ "$(awk '/^ *workspaceRoot:/{sub(/^ *workspaceRoot: */,""); print; exit}' "$p")" = "$PROJECT_DIR" ] && { echo "$p"; return 0; }
  done
  return 1
}
JARVIS_CLI="${HOME}/.local/bin/jarvis"
JARVIS_WRAPPER="${HOME}/.local/bin/jarvis-server-wrapper.sh"
JARVIS_SERVER="${HOME}/.local/bin/jarvis-server"

FIX=false
SKIP_INDEX=false
ONLY_PROFILE=""
PREV=""
for arg in "$@"; do
  if [ "$PREV" = "--profile" ]; then ONLY_PROFILE="$arg"; PREV=""; continue; fi
  case "$arg" in
    --fix) FIX=true ;;
    --skip-index) SKIP_INDEX=true ;;
    --profile) PREV="--profile" ;;
    -h | --help)
      sed -n '2,13p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'
      exit 0
      ;;
    *)
      echo "cardine-move: unknown option '$arg' (--fix, --skip-index, --profile NAME, --help)" >&2
      exit 1
      ;;
  esac
done

ok() { printf '  \033[0;32m✓\033[0m %s\n' "$*"; }
bad() { printf '  \033[0;31m✗\033[0m %s\n' "$*"; }
todo() { printf '  \033[0;33m→\033[0m %s\n' "$*"; }
fixed() { printf '    \033[0;32m✓ fixed\033[0m %s\n' "$*"; }

problems=0
wanted=""
if $FIX; then wanted=" (with --fix)"; fi

echo "cardine-move — $PROJECT_DIR$wanted"
echo

# 1. This must be a project root with the lab inside it.
if [ ! -d "${PROJECT_DIR}/.git" ]; then
  bad "$PROJECT_DIR is not a git repo — run this from inside the project"
  exit 1
fi
if [ ! -f "${LAB_DIR}/cardine-bwrap" ]; then
  bad "the lab is not next to this project ($LAB_DIR has no cardine-bwrap)"
  echo "    install it with: bash <cardine>/packages/lab/install-lab.sh" >&2
  exit 1
fi
ok "project root: $PROJECT_DIR"
echo

# 2. The profiles: each stores absolute paths. With --profile NAME only that one
#    is checked. Without it: the profile that owns this root, and the others (so
#    a move that broke another project shows up here too).
echo "=== DSH profiles ==="
. "${LAB_DIR}/lib/profile-paths.sh"
if [ -n "$ONLY_PROFILE" ]; then
  PROFILE_LIST=("${DSH_HOME_DIR}/profiles/${ONLY_PROFILE}/cordis.patch.yml")
  [ -f "${PROFILE_LIST[0]}" ] || { bad "no profile ${ONLY_PROFILE} in ${DSH_HOME_DIR}/profiles"; exit 1; }
else
  own="$(own_profile || true)"
  PROFILE_LIST=()
  [ -n "$own" ] && PROFILE_LIST+=("$own")
  for p in "${DSH_HOME_DIR}"/profiles/*/cordis.patch.yml; do
    [ -f "$p" ] || continue
    [ "$p" = "$own" ] && continue
    PROFILE_LIST+=("$p")
  done
  [ "${#PROFILE_LIST[@]}" -gt 0 ] || PROFILE_LIST=("$DSH_PROFILE")
fi

for PROFILE_FILE in "${PROFILE_LIST[@]}"; do
  name="$(basename "$(dirname "$PROFILE_FILE")")"
  if [ ! -f "$PROFILE_FILE" ]; then
    bad "$name: no profile at $PROFILE_FILE — run install-lab.sh here"
    problems=$((problems + 1))
    continue
  fi
  old_root="$(pp_profile_root)"
  case "${old_root:-}" in
    "")
      bad "$name: no workspaceRoot — regenerate it with install-lab.sh"
      problems=$((problems + 1))
      continue
      ;;
  esac
  if [ "$old_root" != "$PROJECT_DIR" ]; then
    # Another project's profile that is intact is not a problem here.
    if [ -e "$old_root" ]; then
      ok "$name: points at $old_root (another project, intact)"
    else
      bad "$name: points at $old_root, which no longer exists"
      printf '    expected (this root): %s\n' "$PROJECT_DIR"
      problems=$((problems + 1))
      if $FIX; then
        EXPECT_ROOT="$PROJECT_DIR"
        if ! pp_repair; then
          bad "$name: cannot write ${PROFILE_FILE}.bak — run this outside the DSH sandbox (on the host)"
          exit 1
        fi
        check_root="$(pp_profile_root)"
        if [ "$check_root" = "$PROJECT_DIR" ]; then
          fixed "$name: re-pointed (backups: ${PROFILE_FILE}.bak${pp_pkg_changed:+, package.json.bak})"
          [ -n "${pp_pkg_changed:-}" ] && fixed "$name: package.json link: paths followed"
          problems=$((problems - 1))
        else
          bad "$name: the rewrite did not take — check the file by hand"
        fi
      fi
    fi
    continue
  fi
  # This profile owns this root: the package.json links and the slice gate too.
  slice_state="$(pp_slice_link || true)"
  case "$slice_state" in
    ok) ok "$name: every path points here; the slice-check link resolves" ;;
    dead | missing)
      bad "$name: the cardine-slice-check link is $slice_state (the turn-end make check does not load)"
      problems=$((problems + 1))
      if $FIX; then
        EXPECT_ROOT="$PROJECT_DIR"
        pp_repair || true
        # Point it by hand only as a last resort; pnpm install is the durable fix.
        if [ "$(pp_slice_link || true)" != ok ]; then
          link="$(dirname "$PROFILE_FILE")/node_modules/cardine-slice-check"
          if [ -d "${LAB_DIR}/cardine-slice-check" ]; then
            mkdir -p "$(dirname "$link")" && rm -f "$link" && ln -s "${LAB_DIR}/cardine-slice-check" "$link" \
              && fixed "$name: slice-check link → ${LAB_DIR}/cardine-slice-check (pnpm install in the profile dir keeps it)" \
              && problems=$((problems - 1))
          fi
        else
          fixed "$name: slice-check link resolves again"
          problems=$((problems - 1))
        fi
      fi
      ;;
    "") ok "$name: every path points here (no package.json beside the profile)" ;;
  esac
done

# The one profile DSH will load for this cwd is the one that owns it.
if [ -z "$ONLY_PROFILE" ] && [ -z "${own:-}" ]; then
  bad "no profile points at $PROJECT_DIR — run install-lab.sh here first"
  problems=$((problems + 1))
fi
echo

# 3. The jarvis client: the profile starts the wrapper, the manual step uses the CLI.
echo "=== jarvis client ==="
if [ -x "$JARVIS_WRAPPER" ]; then
  ok "wrapper: $JARVIS_WRAPPER"
else
  bad "wrapper missing: $JARVIS_WRAPPER (mcp-jarvis has failOnStartupError)"
  problems=$((problems + 1))
  if $FIX; then
    target="$(readlink -f "$JARVIS_SERVER" 2>/dev/null || true)"
    if [ -n "$target" ] && [ -f "$target" ]; then
      printf '#!/usr/bin/env bash\n# Wrapper for jarvis-server (bwrap cannot follow symlinks).\nexec %s "$@"\n' "$target" >"$JARVIS_WRAPPER"
      chmod +x "$JARVIS_WRAPPER"
      fixed "$JARVIS_WRAPPER → $target"
    else
      todo "jarvis-server itself is missing — run install-lab.sh"
    fi
  fi
fi
if [ -x "$JARVIS_CLI" ]; then
  ok "CLI: $JARVIS_CLI"
else
  bad "CLI missing: $JARVIS_CLI (jarvis index cannot run)"
  problems=$((problems + 1))
  if $FIX; then
    todo "run install-lab.sh — it installs jarvis-mcp via uv tool install"
  fi
fi
echo

# 4. The index labels the repo by its folder name, so a rename leaves an
#    orphan and the new root unindexed.
echo "=== jarvis index ==="
if ! $SKIP_INDEX && $FIX && [ -x "$JARVIS_CLI" ]; then
  if "$JARVIS_CLI" index "$PROJECT_DIR" --no-semantic; then
    ok "indexed $(basename "$PROJECT_DIR")"
  else
    bad "jarvis index failed"
    problems=$((problems + 1))
  fi
else
  todo "jarvis index \"$PROJECT_DIR\" --no-semantic"
fi
echo

echo "============================================================"
if $FIX && [ "$problems" -eq 0 ]; then
  echo "cardine-move: done"
elif $FIX; then
  echo "cardine-move: $problems thing(s) still open — see above"
else
  echo "cardine-move: dry run — nothing written. Apply with: $0 --fix"
fi
echo
echo "Next, by you (the script does not restart DSH):"
echo "  1. dsh kill"
echo "  2. start Zed / DSH from inside: $PROJECT_DIR"
echo "  3. a new thread; the profile and the plugins load at start"
echo "============================================================"
$FIX && [ "$problems" -eq 0 ]
