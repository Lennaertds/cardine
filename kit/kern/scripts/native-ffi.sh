#!/usr/bin/env bash
# FFI-checks voor native stacks. Soft (default) of NATIVE_STRICT=1.
# NATIVE_FFI=auto|napi|pyo3|ctypes
set -euo pipefail

kind="${1:?gebruik: native-ffi.sh rust|c <app-dir>}"
app="${2:?app-directory vereist}"
STRICT="${NATIVE_STRICT:-0}"
FFI="${NATIVE_FFI:-auto}"

die() { echo "native-ffi($kind): $*" >&2; exit 1; }
tip() { echo "native-ffi($kind): $*" >&2; }

[[ -d "$app" ]] || die "map ontbreekt: $app"

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
  *) die "NATIVE_FFI moet auto|napi|pyo3|ctypes zijn (nu: $FFI)" ;;
esac

if [[ "$kind" == c && "$want_pyo3" -eq 1 ]]; then
  die "pyo3 hoort bij stack rust, niet c — gebruik ctypes"
fi
if [[ "$kind" == rust && "$want_ctypes" -eq 1 ]]; then
  die "ctypes hoort bij stack c — gebruik pyo3"
fi

if [[ "$want_napi$want_pyo3$want_ctypes" == "000" ]]; then
  if [[ "$STRICT" == "1" ]]; then
    tip "STRICT: geen FFI-bestanden voor NATIVE_FFI=$FFI — alleen cargo/C-smoke (ok)"
  fi
  exit 0
fi

run_napi() {
  [[ -f "$app/package.json" ]] || die "napi gevraagd maar $app/package.json ontbreekt"
  if [[ ! -d "$app/node_modules" ]]; then
    if [[ "$STRICT" == "1" ]]; then
      die "STRICT napi: geen node_modules — run make setup-native / setup-native-c (pnpm install)"
    fi
    tip "napi zonder node_modules — overgeslagen (soft); setup voor JS-tests"
    return 0
  fi
  if [[ "$STRICT" == "1" ]]; then
    # Geen JS-fallback: addon moet laden.
    export NATIVE_STRICT=1
    pnpm --dir "$app" test || die "STRICT napi: pnpm test faalde (bouw .node / geen fallback)"
  else
    pnpm --dir "$app" test
  fi
}

run_pyo3() {
  [[ -f "$app/pyproject.toml" ]] || die "pyo3 gevraagd maar $app/pyproject.toml ontbreekt"
  if [[ ! -d "$app/.venv" ]]; then
    if [[ "$STRICT" == "1" ]]; then
      die "STRICT pyo3: geen .venv — uv venv + maturin develop --features pyo3-bridge"
    fi
    tip "pyo3 zonder .venv — overgeslagen (soft)"
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
  [[ -f "$app/native_c_fallback.py" ]] || die "ctypes gevraagd maar native_c_fallback.py ontbreekt"
  local so="$app/build/libnative_c.so"
  if [[ "$STRICT" == "1" ]]; then
    [[ -f "$so" ]] || die "STRICT ctypes: $so ontbreekt — check-native-c moet de .so bouwen"
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
      tip "ctypes zonder .venv — overgeslagen (soft); .so kan wel gebouwd zijn"
    fi
  fi
}

[[ "$want_napi" -eq 1 ]] && run_napi
[[ "$want_pyo3" -eq 1 ]] && run_pyo3
[[ "$want_ctypes" -eq 1 ]] && run_ctypes

echo "native-ffi($kind): klaar (STRICT=$STRICT FFI=$FFI)"
