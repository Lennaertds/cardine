#!/usr/bin/env bash
# FFI checks for native stacks. Soft (default) or NATIVE_STRICT=1.
# NATIVE_FFI=auto|napi|pyo3|ctypes
set -euo pipefail

kind="${1:?usage: native-ffi.sh rust|c <app-dir>}"
app="${2:?app directory required}"
STRICT="${NATIVE_STRICT:-0}"
FFI="${NATIVE_FFI:-auto}"

die() { echo "native-ffi($kind): $*" >&2; exit 1; }
tip() { echo "native-ffi($kind): $*" >&2; }

[[ -d "$app" ]] || die "folder missing: $app"

want_napi=0
want_pyo3=0
want_ctypes=0

case "$FFI" in
  auto)
    [[ -f "$app/package.json" ]] && want_napi=1
    if [[ "$kind" == rust ]] && [[ -f "$app/pyproject.toml" ]] && grep -q 'pyo3-bridge\|maturin' "$app/pyproject.toml" 2>/dev/null; then
      want_pyo3=1
    fi
    if [[ "$kind" == c ]] && [[ -f "$app/native_c_fallback.py" ]]; then
      want_ctypes=1
    fi
    ;;
  napi) want_napi=1 ;;
  pyo3) want_pyo3=1 ;;
  ctypes) want_ctypes=1 ;;
  *) die "NATIVE_FFI must be auto|napi|pyo3|ctypes (now: $FFI)" ;;
esac

if [[ "$kind" == c && "$want_pyo3" -eq 1 ]]; then
  die "pyo3 belongs to stack rust, not c — use ctypes"
fi
if [[ "$kind" == rust && "$want_ctypes" -eq 1 ]]; then
  die "ctypes belongs to stack c — use pyo3"
fi

if [[ "$want_napi$want_pyo3$want_ctypes" == "000" ]]; then
  if [[ "$STRICT" == "1" ]]; then
    tip "STRICT: no FFI files for NATIVE_FFI=$FFI — cargo/C smoke only (ok)"
  fi
  exit 0
fi

run_napi() {
  [[ -f "$app/package.json" ]] || die "napi requested but $app/package.json is missing"
  if [[ ! -d "$app/node_modules" ]]; then
    if [[ "$STRICT" == "1" ]]; then
      die "STRICT napi: no node_modules — run make setup-native / setup-native-c (pnpm install)"
    fi
    tip "napi without node_modules — skipped (soft); setup for JS tests"
    return 0
  fi
  if [[ "$STRICT" == "1" ]]; then
    # No JS fallback: the addon must load.
    export NATIVE_STRICT=1
    pnpm --dir "$app" test || die "STRICT napi: pnpm test failed (build the .node / no fallback)"
  else
    pnpm --dir "$app" test
  fi
}

run_pyo3() {
  [[ -f "$app/pyproject.toml" ]] || die "pyo3 requested but $app/pyproject.toml is missing"
  if [[ ! -d "$app/.venv" ]]; then
    if [[ "$STRICT" == "1" ]]; then
      die "STRICT pyo3: no .venv — uv venv + maturin develop --features pyo3-bridge"
    fi
    tip "pyo3 without .venv — skipped (soft)"
    return 0
  fi
  if [[ "$STRICT" == "1" ]]; then
    export NATIVE_STRICT=1
    uv --directory "$app" run maturin develop --features pyo3-bridge \
      || die "STRICT pyo3: maturin develop faalde"
    uv --directory "$app" run pytest -q || die "STRICT pyo3: pytest faalde"
  else
    uv --directory "$app" run pytest -q
  fi
}

run_ctypes() {
  [[ -f "$app/native_c_fallback.py" ]] || die "ctypes requested but native_c_fallback.py is missing"
  local so="$app/build/libnative_c.so"
  if [[ "$STRICT" == "1" ]]; then
    [[ -f "$so" ]] || die "STRICT ctypes: $so is missing — check-native-c must build the .so"
    export NATIVE_STRICT=1
    if [[ -d "$app/.venv" ]]; then
      uv --directory "$app" run pytest -q || die "STRICT ctypes: pytest faalde"
    else
      PYTHONPATH="$app" NATIVE_STRICT=1 python3 -c \
        "from native_c_fallback import add; assert add(2, 3) == 5" \
        || die "STRICT ctypes: python-smoke faalde"
    fi
  else
    if [[ -d "$app/.venv" ]]; then
      uv --directory "$app" run pytest -q
    else
      tip "ctypes without .venv — skipped (soft); the .so may still be built"
    fi
  fi
}

[[ "$want_napi" -eq 1 ]] && run_napi
[[ "$want_pyo3" -eq 1 ]] && run_pyo3
[[ "$want_ctypes" -eq 1 ]] && run_ctypes

echo "native-ffi($kind): klaar (STRICT=$STRICT FFI=$FFI)"
