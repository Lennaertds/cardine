# native (apps/native) — make targets of this app. The root Makefile picks this file up automatically.
NATIVE_DIR := apps/native
# Soft lokaal; hard via NATIVE_STRICT=1 (check-full / CI). NATIVE_FFI=auto|napi|pyo3
NATIVE_STRICT ?= 0
NATIVE_FFI ?= auto

TOOLS += cargo
SETUP += setup-native
CHECK += check-native
BENCH += bench-native
CLEAN += clean-native

.PHONY: setup-native check-native native-check bench-native clean-native

##@ App native (apps/native)
setup-native: ## native: Rust-deps; starter: pnpm en/of maturin/uv
	@command -v cargo >/dev/null || { echo "setup-native: cargo ontbreekt (rustup)." >&2; exit 1; }
	cd $(NATIVE_DIR) && cargo fetch
	@if [ -f $(NATIVE_DIR)/package.json ]; then \
	  command -v pnpm >/dev/null || { echo "setup-native: pnpm ontbreekt (napi-starter)." >&2; exit 1; }; \
	  pnpm --dir $(NATIVE_DIR) install; \
	fi
	@if [ -f $(NATIVE_DIR)/pyproject.toml ]; then \
	  echo "setup-native: PyO3-scaffold — tip: uv --directory $(NATIVE_DIR) run maturin develop --features pyo3-bridge"; \
	fi

native-check: ## native: Cargo-layout-checklist
	@bash $(NATIVE_DIR)/scripts/native-check.sh

check-native: native-check ## native: cargo test + FFI (NATIVE_STRICT / NATIVE_FFI)
	@command -v cargo >/dev/null || { echo "check-native: cargo ontbreekt (rustup)." >&2; exit 1; }
	cd $(NATIVE_DIR) && cargo test
	@NATIVE_STRICT=$(NATIVE_STRICT) NATIVE_FFI=$(NATIVE_FFI) bash scripts/native-ffi.sh rust $(NATIVE_DIR)

bench-native: ## native: bench; vereist apps/native/scripts/bench.sh
	@test -x $(NATIVE_DIR)/scripts/bench.sh || { \
	  echo "bench-native: add an executable $(NATIVE_DIR)/scripts/bench.sh (docs/how-to/perf-bench.md)." >&2; exit 1; }
	@$(NATIVE_DIR)/scripts/bench.sh

clean-native: ## native: target/, node_modules, .venv weg
	rm -rf $(NATIVE_DIR)/target $(NATIVE_DIR)/node_modules $(NATIVE_DIR)/.venv
