# shellcheck shell=bash
# dsh-schema.sh — the one place that knows which DSH knobs this lab depends on,
# and how to find the installed @deepseek-ai package the questions are asked of.
#
# Why: spec dsh-profile-cardine wants one boundary that is wider in exactly one
# zone, and the first question is which knob can express that. Guessing the
# schema of a pinned preview package is how a profile ends up asking on every
# repo write, or writing without asking at all. So the probe reads the installed
# upstream code itself — never a copy.
#
# Sourced by scripts/check-dsh-schema.sh.

# dsh_find_pkg — the node_modules dir that holds @deepseek-ai/<domain>, or empty.
# Order: an explicit DSH_PKG_ROOT, the prefix of the dsh on PATH (every npm
# layout), npm's global root, the lab prefix (~/.local), then a search by
# package name. A `nobody`-owned tree that cannot be read is skipped and the
# search keeps going: find cannot descend into it and says so on stderr, which
# must not be read as "not installed".
dsh_find_pkg() {
  local domain="${1:-}"
  local d cmd hit
  local -a roots=()
  if [ -n "${DSH_PKG_ROOT:-}" ] && [ -d "${DSH_PKG_ROOT}/@deepseek-ai" ]; then
    printf '%s\n' "$DSH_PKG_ROOT"; return 0
  fi
  cmd="$(command -v dsh 2>/dev/null || true)"
  if [ -n "$cmd" ]; then
    cmd="$(readlink -f "$cmd" 2>/dev/null || printf '%s' "$cmd")"
    d="$(dirname "$cmd")"
    roots+=("$d/../lib/node_modules" "$d/../../lib/node_modules" "$d/.." "$d")
  fi
  roots+=("$(npm root -g 2>/dev/null || true)"
          "/usr/lib/node_modules" "/usr/local/lib/node_modules"
          "${HOME}/.local/lib/node_modules" "${HOME}/.local/lib" "${HOME}/.local")
  if [ -n "${NPM_CONFIG_PREFIX:-}" ]; then
    roots+=("${NPM_CONFIG_PREFIX}/lib/node_modules" "${NPM_CONFIG_PREFIX}")
  fi
  if [ -n "${NVM_DIR:-}" ]; then
    # shellcheck disable=SC2086  # a glob on purpose
    roots+=(${NVM_DIR}/versions/node/*/lib/node_modules)
  fi
  for d in "${roots[@]}"; do
    [ -n "$d" ] || continue
    d="$(readlink -m "$d")"
    if [ -d "$d/@deepseek-ai" ]; then printf '%s\n' "$d"; return 0; fi
  done
  local -a search=("${HOME}/.local" "${HOME}/.npm-global" "${HOME}/.nvm/versions/node"
                   "/usr/lib/node_modules" "/usr/local/lib/node_modules")
  for d in "${search[@]}"; do
    [ -d "$d" ] || continue
    if [ -n "$domain" ]; then
      hit="$(find "$d" -maxdepth 6 -type d -path "*/@deepseek-ai/${domain}" 2>/dev/null | head -1)"
    else
      hit="$(find "$d" -maxdepth 6 -type d -name '@deepseek-ai' 2>/dev/null | head -1)"
    fi
    if [ -n "$hit" ]; then printf '%s\n' "$(dirname "$hit")"; return 0; fi
  done
  return 1
}

# dsh_pkg_roots — every node_modules dir with a @deepseek-ai tree (normally one).
dsh_pkg_roots() {
  local r
  r="$(dsh_find_pkg "${1:-}")" || return 0
  [ -n "$r" ] && printf '%s\n' "$r"
}

# dsh_pkg_hint — what happened, when the search came up empty.
dsh_pkg_hint() {
  local cmd
  cmd="$(command -v dsh 2>/dev/null || true)"
  echo "  dsh on PATH: ${cmd:-<none>}" >&2
  [ -n "$cmd" ] && echo "  resolves to: $(readlink -f "$cmd" 2>/dev/null || echo "$cmd")" >&2
  echo "  npm root -g: $(npm root -g 2>/dev/null || echo '<npm failed>')" >&2
  echo "  searched the npm prefix and ~/.local, ~/.npm-global, ~/.nvm, /usr{,/local}/lib/node_modules for @deepseek-ai" >&2
}

# json_keys FILE — the keys under `const Config = ...` in a dsh plugin file, one
# per line. Only a key directly followed by `:` counts (`edit:`), not a value
# (`edit: false`) and not a string. That is what keeps Q1's `roots` from matching
# `writableRoots`.
json_keys() {
  sed -n '/Config[[:space:]]*=/,/^})/p' "$1" 2>/dev/null \
    | grep -oE '(^|[,{([[:space:]])[A-Za-z_][A-Za-z0-9_]*[[:space:]]*:' \
    | sed -E 's/^[[:space:],{([ ]*//; s/[[:space:]]*:$//' \
    | grep -vxE 'Schema|union|object|const|array|boolean|string|number|default|optional'
}

# exact_key DOMAIN KEY — is KEY declared exactly as a config key? Prints file:line.
exact_key() {
  local domain="$1" key="$2" root f line
  while IFS= read -r root; do
    [ -d "${root}/@deepseek-ai/${domain}" ] || continue
    while IFS= read -r f; do
      line="$(json_keys "$f" | grep -nx -- "$key" || true)"
      [ -n "$line" ] && printf '%s:%s\n' "$f" "$(printf '%s' "$line" | cut -d: -f1)"
    done < <(find "${root}/@deepseek-ai/${domain}" \( -name '*.js' -o -name '*.mjs' -o -name '*.cjs' \) 2>/dev/null)
  done < <(dsh_pkg_roots "$domain")
}

# text_hits DOMAIN PATTERN — a literal in the package, for questions a key cannot
# answer (does the ACP app mention request_permission at all?).
text_hits() {
  local domain="$1" pattern="$2" root
  while IFS= read -r root; do
    [ -d "${root}/@deepseek-ai/${domain}" ] || continue
    grep -rIn -E "$pattern" "${root}/@deepseek-ai/${domain}" 2>/dev/null | head -10
  done < <(dsh_pkg_roots "$domain")
}
