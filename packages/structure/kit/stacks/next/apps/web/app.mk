# web (apps/web) — make targets of this app. The root Makefile picks this file up automatically.
WEB_DIR := apps/web
WEB_PORT ?= 3000

TOOLS += node pnpm
SETUP += setup-web
DEV += dev-web
CHECK += check-web
CHECK_FULL += e2e-web
FMT += fmt-web
BUILD += build-web
SMOKE += smoke-web
BENCH += bench-web
CLEAN += clean-web
PORTS += $(WEB_PORT)

.PHONY: setup-web dev-web check-web e2e-web fmt-web build-web smoke-web bench-web clean-web

##@ App web (apps/web)
setup-web: ## web: dependencies en de Playwright-browser installeren
	pnpm --dir $(WEB_DIR) install
	pnpm --dir $(WEB_DIR) exec playwright install chromium

dev-web: ## web: Next dev-server (poort WEB_PORT, standaard 3000)
	pnpm --dir $(WEB_DIR) exec next dev --port $(WEB_PORT)

check-web: ## web: lint, types en unit-tests
	pnpm --dir $(WEB_DIR) run lint
	pnpm --dir $(WEB_DIR) run typecheck
	pnpm --dir $(WEB_DIR) run test

e2e-web: ## web: Playwright end-to-end tegen de lokale app
	pnpm --dir $(WEB_DIR) run test:e2e

fmt-web: ## web: Prettier en ESLint --fix
	pnpm --dir $(WEB_DIR) run format
	pnpm --dir $(WEB_DIR) exec eslint . --fix

build-web: ## web: productiebuild; daarna eerst clean-web vóór dev-web
	pnpm --dir $(WEB_DIR) run build

smoke-web: ## web: smoke-tests tegen URL (of WEB_URL)
	BASE_URL="$(or $(WEB_URL),$(URL))" pnpm --dir $(WEB_DIR) run test:smoke

bench-web: ## web: perf-bench; vereist apps/web/scripts/bench.sh
	@test -x $(WEB_DIR)/scripts/bench.sh || { \
	  echo "bench-web: add an executable $(WEB_DIR)/scripts/bench.sh (docs/how-to/perf-bench.md)." >&2; exit 1; }
	@$(WEB_DIR)/scripts/bench.sh

clean-web: ## web: .next en testrapporten weg; lost "Cannot find module './NNN.js'" op
	rm -rf $(WEB_DIR)/.next $(WEB_DIR)/test-results $(WEB_DIR)/playwright-report
