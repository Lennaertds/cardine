# pipeline (apps/pipeline) — make targets of this app. The root Makefile picks this file up automatically.
PIPELINE_DIR := apps/pipeline
PIPELINE_UV := uv --directory $(PIPELINE_DIR)
PIPELINE_ENV := $(PIPELINE_DIR)/.env
# Loads DATABASE_URL from apps/pipeline/.env into the recipe's shell.
PIPELINE_LOAD_ENV = test -f $(PIPELINE_ENV) || { echo "Geen $(PIPELINE_ENV). Draai make env." >&2; exit 1; }; \
	set -a; . ./$(PIPELINE_ENV); set +a; export PGOPTIONS='--client-min-messages=warning'

TOOLS += uv psql
SETUP += setup-pipeline
CHECK += check-pipeline
CHECK_FULL += checks-pipeline
FMT += fmt-pipeline
DATA += data-pipeline
CLEAN += clean-pipeline

.PHONY: setup-pipeline check-pipeline fmt-pipeline migrate-pipeline data-pipeline checks-pipeline clean-pipeline

##@ App pipeline (apps/pipeline)
setup-pipeline: ## pipeline: virtuele omgeving en dependencies (uv sync)
	$(PIPELINE_UV) sync

check-pipeline: ## pipeline: ruff, mypy and pytest (without a database)
	$(PIPELINE_UV) run ruff check .
	$(PIPELINE_UV) run ruff format --check .
	$(PIPELINE_UV) run mypy
	$(PIPELINE_UV) run pytest -q

fmt-pipeline: ## pipeline: ruff format en ruff --fix
	$(PIPELINE_UV) run ruff format .
	$(PIPELINE_UV) run ruff check --fix .

migrate-pipeline: ## pipeline: nieuwe SQL-migraties toepassen, in volgorde
	@$(PIPELINE_LOAD_ENV); \
	psql "$$DATABASE_URL" -v ON_ERROR_STOP=1 -q \
	  -c 'CREATE TABLE IF NOT EXISTS schema_migrations (name text PRIMARY KEY, applied_at timestamptz NOT NULL DEFAULT now())'; \
	for file in $(PIPELINE_DIR)/sql/migrations/*.sql; do \
	  [ -e "$$file" ] || continue; \
	  name="$$(basename "$$file")"; \
	  done_before="$$(printf '%s\n' "SELECT 1 FROM schema_migrations WHERE name = :'name';" \
	    | psql "$$DATABASE_URL" -v ON_ERROR_STOP=1 -qAt -v name="$$name" -f -)"; \
	  if [ -z "$$done_before" ]; then \
	    echo "migratie: $$name"; \
	    { cat "$$file"; printf '\n%s\n' "INSERT INTO schema_migrations (name) VALUES (:'name');"; } \
	      | psql "$$DATABASE_URL" -v ON_ERROR_STOP=1 -q -1 -v name="$$name" -f -; \
	  fi; \
	done

data-pipeline: migrate-pipeline ## pipeline: extract en load, daarna staging en marts opbouwen
	$(PIPELINE_UV) run --env-file .env pipeline build
	@$(PIPELINE_LOAD_ENV); \
	for file in $(PIPELINE_DIR)/sql/staging/*.sql $(PIPELINE_DIR)/sql/marts/*.sql; do \
	  [ -e "$$file" ] || continue; \
	  echo "sql: $$file"; \
	  psql "$$DATABASE_URL" -v ON_ERROR_STOP=1 -q -1 -f "$$file"; \
	done

checks-pipeline: ## pipeline: data quality; every query in sql/checks/ must return zero rows
	@$(PIPELINE_LOAD_ENV); failed=0; \
	for file in $(PIPELINE_DIR)/sql/checks/*.sql; do \
	  [ -e "$$file" ] || continue; \
	  rows="$$(psql "$$DATABASE_URL" -v ON_ERROR_STOP=1 -qAt -f "$$file")"; \
	  if [ -n "$$rows" ]; then echo "FOUT  $$file"; printf '%s\n' "$$rows" | head -n 5; failed=1; \
	  else echo "ok    $$file"; fi; \
	done; exit $$failed

clean-pipeline: ## pipeline: caches weg
	rm -rf $(PIPELINE_DIR)/.pytest_cache $(PIPELINE_DIR)/.ruff_cache $(PIPELINE_DIR)/.mypy_cache
