# api (apps/api) — make targets of this app. The root Makefile picks this file up automatically.
API_DIR := apps/api
API_PORT ?= 3001
API_ENV := $(API_DIR)/.env

TOOLS += node pnpm curl
SETUP += setup-api
DEV += dev-api
CHECK += check-api
CHECK_FULL += integration-api
FMT += fmt-api
BUILD += build-api
SMOKE += smoke-api
BENCH += bench-api
SEED += seed-api
DB_RESET += db-reset-api
PORTS += $(API_PORT)

.PHONY: setup-api dev-api check-api integration-api fmt-api build-api smoke-api bench-api seed-api db-reset-api

##@ App api (apps/api)
setup-api: ## api: dependencies installeren
	pnpm --dir $(API_DIR) install

dev-api: ## api: Nest in watch-modus (poort API_PORT, standaard 3001); start eerst de lokale diensten
	@if [ -f docker-compose.yml ]; then $(MAKE) up; fi
	PORT=$(API_PORT) pnpm --dir $(API_DIR) run start:dev

check-api: ## api: lint, types en unit-tests
	pnpm --dir $(API_DIR) run lint:check
	pnpm --dir $(API_DIR) run typecheck
	pnpm --dir $(API_DIR) run test

integration-api: ## api: integratietests tegen de lokale database
	pnpm --dir $(API_DIR) run test:integration

fmt-api: ## api: Prettier en ESLint --fix
	pnpm --dir $(API_DIR) run format
	pnpm --dir $(API_DIR) run lint

build-api: ## api: productiebuild naar apps/api/dist
	pnpm --dir $(API_DIR) run build

smoke-api: ## api: GET /health tegen URL (of API_URL)
	@url="$(or $(API_URL),$(URL))"; curl -fsS "$$url/health" >/dev/null && echo "api: $$url/health ok"

bench-api: ## api: latency-bench; vereist apps/api/scripts/bench.sh
	@test -x $(API_DIR)/scripts/bench.sh || { \
	  echo "bench-api: add an executable $(API_DIR)/scripts/bench.sh (docs/how-to/perf-bench.md)." >&2; exit 1; }
	@$(API_DIR)/scripts/bench.sh

seed-api: ## api: load test users and demo data
	pnpm --dir $(API_DIR) run seed

db-reset-api: ## api: empty, migrate and seed the local database; refuses outside localhost
	@test -f $(API_ENV) || { echo "No $(API_ENV). Run make env." >&2; exit 1; }
	@set -a; . ./$(API_ENV); set +a; \
	case "$${DATABASE_URL:-}" in \
	  *@localhost[:/]*|*@127.0.0.1[:/]*) ;; \
	  *) echo "db-reset refuses: DATABASE_URL in $(API_ENV) does not point at localhost." >&2; exit 1 ;; \
	esac
	pnpm --dir $(API_DIR) run db:reset
	$(MAKE) seed-api
