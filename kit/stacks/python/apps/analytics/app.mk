# analytics (apps/analytics) — make targets of this app. The root Makefile picks this file up automatically.
ANALYTICS_DIR := apps/analytics
ANALYTICS_UV := uv --directory $(ANALYTICS_DIR)

TOOLS += uv
SETUP += setup-analytics
CHECK += check-analytics
FMT += fmt-analytics
BENCH += bench-analytics
DATA += data-analytics
CLEAN += clean-analytics

.PHONY: setup-analytics check-analytics fmt-analytics bench-analytics data-analytics clean-analytics

##@ App analytics (apps/analytics)
setup-analytics: ## analytics: virtuele omgeving en dependencies (uv sync)
	$(ANALYTICS_UV) sync

check-analytics: ## analytics: ruff, mypy en pytest
	$(ANALYTICS_UV) run ruff check .
	$(ANALYTICS_UV) run ruff format --check .
	$(ANALYTICS_UV) run mypy
	$(ANALYTICS_UV) run pytest -q

fmt-analytics: ## analytics: ruff format en ruff --fix
	$(ANALYTICS_UV) run ruff format .
	$(ANALYTICS_UV) run ruff check --fix .

data-analytics: ## analytics: raw, external en reference verwerken naar processed
	$(ANALYTICS_UV) run --env-file .env analytics build

bench-analytics: ## analytics: job-duur bench; vereist apps/analytics/scripts/bench.sh
	@test -x $(ANALYTICS_DIR)/scripts/bench.sh || { \
	  echo "bench-analytics: add an executable $(ANALYTICS_DIR)/scripts/bench.sh (docs/how-to/perf-bench.md)." >&2; exit 1; }
	@$(ANALYTICS_DIR)/scripts/bench.sh

clean-analytics: ## analytics: caches weg
	rm -rf $(ANALYTICS_DIR)/.pytest_cache $(ANALYTICS_DIR)/.ruff_cache $(ANALYTICS_DIR)/.mypy_cache
