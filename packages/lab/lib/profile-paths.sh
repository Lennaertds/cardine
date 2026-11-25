# shellcheck shell=bash
# profile-paths.sh — the one place that knows where a DSH profile hides paths.
#
# Sourced by cardine-move.sh and install-lab.sh. Call after setting:
#   PROFILE_FILE   the profile yml
#   EXPECT_ROOT    the git root the profile should point at
#
# What a stale path does: DSH starts, then every bash call fails with
# `spawn .../cardine-bwrap ENOENT`, and only the runner crashes — read, glob and
# grep keep working. A dead `cardine-slice-check` link in the profile's
# package.json fails differently: pnpm does not link a missing target, so the
# `make check` gate silently disappears.
#
# Nothing here writes except profile_repair, once per file, after a backup.

# The project root as the profile records it (workspaceRoot).
pp_profile_root() {
  [ -f "$PROFILE_FILE" ] || return 1
  awk '/^ *workspaceRoot:/{sub(/^ *workspaceRoot: */,""); print; exit}' "$PROFILE_FILE"
}

# The package.json beside the profile, if there is one.
pp_pkg_file() {
  local f="$(dirname "$PROFILE_FILE")/package.json"
  [ -f "$f" ] && echo "$f"
}

# Repair the profile and the package.json links. Backups only once: a second run
# must not overwrite the only copy of the pre-move state with a moved one.
pp_repair() {
  local old_root f
  old_root="$(pp_profile_root)"
  [ -n "$old_root" ] || return 1
  pp_pkg_changed=0
  f="$PROFILE_FILE"
  if [ "$old_root" != "$EXPECT_ROOT" ]; then
    [ -e "${f}.bak" ] || cp "$f" "${f}.bak" 2>/dev/null || return 1
    # '#' delimiter: neither root contains it, a path does contain '/'.
    sed -i "s#${old_root//./\\.}#${EXPECT_ROOT}#g" "$f"
  fi
  # A moved lab moved every "link:<profile root>/..." too.
  f="$(pp_pkg_file)"
  if [ -n "$f" ] && grep -q "link:${old_root}/" "$f" 2>/dev/null; then
    [ -e "${f}.bak" ] || cp "$f" "${f}.bak" 2>/dev/null || return 1
    sed -i "s#link:${old_root}/#link:${EXPECT_ROOT}/#g" "$f"
    pp_pkg_changed=1
  fi
  return 0
}

# ok | missing | dead — does the slice-check link resolve? A dead or missing
# link means the turn-end `make check` gate does not load.
pp_slice_link() {
  local dir target f
  f="$(pp_pkg_file)"
  [ -n "$f" ] || return 1
  grep -q '"cardine-slice-check"' "$f" 2>/dev/null || return 1
  dir="$(dirname "$f")"
  target="$dir/node_modules/cardine-slice-check"
  if [ -L "$target" ] && [ ! -e "$target" ]; then echo dead; return 0; fi
  [ -e "$target" ] && echo ok || echo missing
}
