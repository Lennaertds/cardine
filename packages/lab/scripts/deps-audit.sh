#!/usr/bin/env bash
# Dependency hygiene: docs structure + CVE audits per stack. In check-full, not in check.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

file=docs/architecture/dependencies.md
die() { echo "deps-audit: $*" >&2; exit 1; }
warn() { echo "deps-audit: waarschuwing — $*" >&2; }

[[ -f "$file" ]] || die "missing $file (kit: kern)."

for heading in "## Relation to other docs" "## Audits per stack" "## Ritual" "## Faster / safer alternatives" "## Commands" "## Deliberately later"; do
  grep -qF "$heading" "$file" || die "section missing in $file: $heading"
done
# P28: at least one extension row in the Deliberately later table.
awk '
  /^## Deliberately later$/ { in_sec=1; next }
  in_sec && /^## / { exit found ? 0 : 1 }
  in_sec && /^\|/ && $0 !~ /^\|[[:space:]:|-]+\|$/ && $0 !~ /Extension/ { found=1 }
  END { exit found ? 0 : 1 }
' "$file" || die "table under ## Deliberately later has no extension rows (P28)"
echo "ok    $file (fixed sections present, incl. Deliberately later)"

failed=0
ran=0
skipped=0

# --- JS/TS -----------------------------------------------------------------
mapfile -t pkg_jsons < <(find . \( -path './node_modules' -o -path '*/node_modules/*' -o -path './.git' -o -path './tmp' -o -path './_bootstrap' -o -path './_bootstrap/*' \) -prune -o -name package.json -print 2>/dev/null | sort)
if ((${#pkg_jsons[@]} > 0)); then
  js_tool=
  if command -v pnpm >/dev/null 2>&1; then
    js_tool=pnpm
  elif command -v npm >/dev/null 2>&1; then
    js_tool=npm
  fi
  if [[ -z "$js_tool" ]]; then
    warn "package.json found but no pnpm/npm in PATH — JS audit skipped."
    skipped=$((skipped + 1))
  else
    for pkg in "${pkg_jsons[@]}"; do
      dir=$(dirname "$pkg")
      echo "— JS-audit ($js_tool) in $dir"
      ran=$((ran + 1))
      set +e
      if [[ "$js_tool" == pnpm ]]; then
        (cd "$dir" && pnpm audit --audit-level=high)
      else
        (cd "$dir" && npm audit --audit-level=high)
      fi
      rc=$?
      set -e
      if [[ $rc -ne 0 ]]; then
        warn "JS audit failed in $dir (exit $rc) — high/critical or registry error."
        failed=1
      else
        echo "ok    JS-audit $dir"
      fi
    done
  fi
fi

# --- Python ----------------------------------------------------------------
mapfile -t py_roots < <(
  find . \( -path './.git' -o -path './tmp' -o -path './_bootstrap' -o -path './_bootstrap/*' -o -path './node_modules' -o -path '*/.venv' -o -path '*/.venv/*' \) -prune -o \
    \( -name pyproject.toml -o -name 'requirements*.txt' \) -print 2>/dev/null \
    | while read -r f; do dirname "$f"; done | sort -u
)
if ((${#py_roots[@]} > 0)); then
  py_tool=
  if command -v pip-audit >/dev/null 2>&1; then
    py_tool=pip-audit
  elif command -v uv >/dev/null 2>&1; then
    py_tool=uv
  fi
  if [[ -z "$py_tool" ]]; then
    warn "Python manifest found but no pip-audit/uv — Python audit skipped. Tip: pipx install pip-audit"
    skipped=$((skipped + 1))
  else
    for dir in "${py_roots[@]}"; do
      echo "— Python-audit ($py_tool) in $dir"
      ran=$((ran + 1))
      set +e
      if [[ "$py_tool" == pip-audit ]]; then
        if [[ -f "$dir/pyproject.toml" ]]; then
          (cd "$dir" && pip-audit)
        else
          rc_inner=0
          for r in "$dir"/requirements*.txt; do
            [[ -f "$r" ]] || continue
            (cd "$dir" && pip-audit -r "$(basename "$r")") || rc_inner=1
          done
          [[ $rc_inner -eq 0 ]]
        fi
      else
        (cd "$dir" && uv pip audit)
      fi
      rc=$?
      set -e
      if [[ $rc -ne 0 ]]; then
        warn "Python-audit faalde in $dir (exit $rc)."
        failed=1
      else
        echo "ok    Python-audit $dir"
      fi
    done
  fi
fi

# --- Rust (stub) -----------------------------------------------------------
mapfile -t cargos < <(find . \( -path './.git' -o -path './tmp' -o -path './_bootstrap' -o -path './_bootstrap/*' -o -path './target' -o -path '*/target/*' \) -prune -o -name Cargo.toml -print 2>/dev/null | sort)
if ((${#cargos[@]} > 0)); then
  if command -v cargo >/dev/null 2>&1 && cargo audit --version >/dev/null 2>&1; then
    for cargo in "${cargos[@]}"; do
      dir=$(dirname "$cargo")
      echo "— Rust-audit (cargo audit) in $dir"
      ran=$((ran + 1))
      set +e
      (cd "$dir" && cargo audit)
      rc=$?
      set -e
      if [[ $rc -ne 0 ]]; then
        warn "Rust-audit faalde in $dir (exit $rc)."
        failed=1
      else
        echo "ok    Rust-audit $dir"
      fi
    done
  else
    warn "Cargo.toml found; cargo-audit not installed — stub. Tip: cargo install cargo-audit"
    skipped=$((skipped + 1))
  fi
fi

if ((ran == 0 && skipped == 0)); then
  echo "Tip: no package.json / pyproject / requirements / Cargo.toml found — docs check only."
fi

if ((failed != 0)); then
  die "one or more audits failed. See docs/architecture/dependencies.md and docs/how-to/deps-audit.md"
fi

echo "deps-audit: groen"
