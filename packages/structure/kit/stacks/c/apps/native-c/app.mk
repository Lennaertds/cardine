# native-c (apps/native-c) — make-targets van deze app.
NATIVE_C_DIR := apps/native-c
NATIVE_C_BUILD := $(NATIVE_C_DIR)/build
# Soft lokaal; hard via NATIVE_STRICT=1 (check-full / CI). NATIVE_FFI=auto|napi|ctypes
NATIVE_STRICT ?= 0
NATIVE_FFI ?= auto

TOOLS += cc
SETUP += setup-native-c
CHECK += check-native-c
BENCH += bench-native-c
CLEAN += clean-native-c

.PHONY: setup-native-c check-native-c native-c-check bench-native-c clean-native-c

##@ App native-c (apps/native-c)
setup-native-c: ## native-c: build-dir; starter: pnpm
	@command -v clang >/dev/null || command -v cc >/dev/null || { echo "setup-native-c: cc/clang ontbreekt." >&2; exit 1; }
	mkdir -p $(NATIVE_C_BUILD)
	@if [ -f $(NATIVE_C_DIR)/package.json ]; then \
	  command -v pnpm >/dev/null || { echo "setup-native-c: pnpm ontbreekt (N-API-starter)." >&2; exit 1; }; \
	  pnpm --dir $(NATIVE_C_DIR) install; \
	fi
	@if [ -f $(NATIVE_C_DIR)/native_c_fallback.py ]; then \
	  echo "setup-native-c: ctypes-scaffold — tip: check-native-c bouwt libnative_c.so"; \
	fi

native-c-check: ## native-c: layout-checklist
	@bash $(NATIVE_C_DIR)/scripts/native-c-check.sh

check-native-c: native-c-check ## native-c: compile-smoke + FFI (NATIVE_STRICT / NATIVE_FFI)
	@CC_BIN=$$(command -v clang || command -v cc); \
	  test -n "$$CC_BIN" || { echo "check-native-c: cc/clang ontbreekt." >&2; exit 1; }; \
	  mkdir -p $(NATIVE_C_BUILD); \
	  $$CC_BIN -Wall -Wextra -Werror -I$(NATIVE_C_DIR)/src -o $(NATIVE_C_BUILD)/test_add \
	    $(NATIVE_C_DIR)/tests/test_add.c $(NATIVE_C_DIR)/src/add.c; \
	  $(NATIVE_C_BUILD)/test_add; \
	  $$CC_BIN -Wall -Wextra -Werror -shared -fPIC -I$(NATIVE_C_DIR)/src \
	    -o $(NATIVE_C_BUILD)/libnative_c.so $(NATIVE_C_DIR)/src/add.c
	@NATIVE_STRICT=$(NATIVE_STRICT) NATIVE_FFI=$(NATIVE_FFI) bash scripts/native-ffi.sh c $(NATIVE_C_DIR)

bench-native-c: ## native-c: bench; vereist scripts/bench.sh
	@test -x $(NATIVE_C_DIR)/scripts/bench.sh || { \
	  echo "bench-native-c: voeg uitvoerbaar $(NATIVE_C_DIR)/scripts/bench.sh toe (docs/how-to/perf-bench.md)." >&2; exit 1; }
	@$(NATIVE_C_DIR)/scripts/bench.sh

clean-native-c: ## native-c: build/, node_modules, .venv weg
	rm -rf $(NATIVE_C_BUILD) $(NATIVE_C_DIR)/node_modules $(NATIVE_C_DIR)/.venv
