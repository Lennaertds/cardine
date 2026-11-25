# {{PROJECT}} — all commands. `make` lists them.
#
# Every app adds its targets via apps/<app>/app.mk; those are picked up below
# automatically. Personal targets go in local.mk (not in git).

SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := help
MAKEFLAGS += --no-print-directory

TODAY := $(shell date +%F)
SLUG = iconv -f utf-8 -t ascii//TRANSLIT | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/^-+|-+$$//g'

# Lists every app.mk adds to (e.g. CHECK += check-web).
TOOLS := git make
SETUP :=
DEV :=
CHECK :=
CHECK_FULL :=
FMT :=
BUILD :=
SMOKE :=
BENCH :=
DATA :=
SEED :=
DB_RESET :=
CLEAN :=
PORTS :=

-include $(sort $(wildcard apps/*/app.mk))
-include local.mk

.PHONY: help setup env doctor dev up down logs status check check-full links smoke fmt build \
	    data seed db-reset adr spec log meeting experiment docs-health clean \
	    container-setup context finish env-status index jarvis-check \
	    security-scan security-scan-quick obs-up obs-down obs-status \
	    bench perf-check deps-audit polyglot-check radar-check radar-reminder \
	    digest-check digest-reminder digest-fetch digest-propose native-bindings-strict

##@ Starting
help: ## this overview
	@awk 'BEGIN {FS = ":[^#]*## "} /^##@/ {printf "\n%s\n", substr($$0, 5)} /^[a-zA-Z0-9_-]+:.*## / {printf "  %-18s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

setup: env $(SETUP) ## install everything: .env files, per-app dependencies, git hooks
	@if command -v pre-commit >/dev/null; then pre-commit install; \
	 else echo "Tip: install pre-commit (pipx install pre-commit) and run make setup again." >&2; fi

env: ## create .env from every .env.example that has none yet
	@find . -name .env.example -not -path '*/node_modules/*' | while read -r example; do \
	  target="$${example%.example}"; \
	  if [ ! -e "$$target" ]; then cp "$$example" "$$target"; echo "created: $$target"; fi; \
	done

doctor: ## check that every tool the apps need is installed
	@missing=0; for tool in $(sort $(TOOLS)); do \
	  if command -v $$tool >/dev/null; then echo "ok    $$tool"; else echo "MISSING  $$tool"; missing=1; fi; \
	done; exit $$missing

env-status: jarvis-check ## status of DSH, Jarvis and this environment
	@if command -v jarvis >/dev/null; then \
	  echo "env-status: ok (jarvis available)"; \
	else \
	  echo "env-status: jarvis CLI not found" >&2; \
	fi

index: ## build the Jarvis code index for this repo (run outside the sandbox)
	@command -v jarvis >/dev/null || { echo "jarvis not found on PATH" >&2; exit 1; }
	@jarvis index "$(CURDIR)" --no-semantic

jarvis-check: ## checks: stale Jarvis locks and whether the current repo is indexed
	@if command -v jarvis >/dev/null; then \
	  stale=0; \
	  for lock in "$$HOME/.jarvis"/index-*.lock; do \
	    [ -e "$$lock" ] || continue; \
	    pid=$$(cat "$$lock" 2>/dev/null || true); \
	    if [ -n "$$pid" ] && ! kill -0 "$$pid" 2>/dev/null; then \
	      echo "WARNING: stale Jarvis lock: $$lock (PID $$pid does not exist)"; \
	      echo "  Fix: rm -f $$lock"; \
	      stale=1; \
	    fi; \
	  done; \
	  if [ "$$stale" = 0 ]; then \
	    echo "jarvis-check: no stale locks"; \
	  fi; \
	  slug=$$(basename "$(CURDIR)" | tr '[:upper:]' '[:lower:]'); \
	  if ! jarvis status "$$slug" >/dev/null 2>&1; then \
	    echo "TIP: repo '$$slug' is not indexed yet."; \
	    echo "  Run this in your terminal (outside the sandbox): make index"; \
	  else \
	    echo "jarvis-check: repo '$$slug' is indexed"; \
	  fi; \
	else \
	  echo "jarvis-check: jarvis CLI not found — skipped" >&2; \
	fi

##@ Running locally
dev: ## start all apps at once; Ctrl-C stops everything
	@test -n "$(strip $(DEV))" || { echo "No app with a dev target yet. Copy a stack from the kit." >&2; exit 1; }
	@$(MAKE) -j $(words $(DEV)) $(DEV)

up: ## start local services (docker compose) and wait until they are healthy
	@test -f docker-compose.yml || { echo "No docker-compose.yml (kit: module compose)." >&2; exit 1; }
	@docker info >/dev/null 2>&1 || { echo "Docker is not running. Start the daemon and try again." >&2; exit 1; }
	docker compose up -d --wait

down: ## stop local services
	docker compose down

logs: ## follow the logs of the local services
	docker compose logs -f

status: ## containers, and which app ports are taken
	@docker compose ps 2>/dev/null || true
	@for port in $(PORTS); do \
	  if ss -tln "sport = :$$port" | grep -q LISTEN; then echo ":$$port taken"; else echo ":$$port free"; fi; \
	done

##@ Checking
check: links $(CHECK) ## lint, types and unit tests of every app, plus dead links; must be green
	@test -n "$(strip $(CHECK))" || { echo "make check does not check any app yet. Copy a stack from the kit or add to CHECK." >&2; exit 1; }
	@echo "make check: green"

check-full: check deps-audit native-bindings-strict $(CHECK_FULL) ## check + deps-audit + native STRICT + CHECK_FULL

native-bindings-strict: ## NATIVE_STRICT=1 for apps/native and/or native-c (part of check-full)
	@ran=0; \
	if [ -f apps/native/Cargo.toml ]; then \
	  echo "native-bindings-strict: check-native (NATIVE_STRICT=1)"; \
	  $(MAKE) check-native NATIVE_STRICT=1 NATIVE_FFI="$(or $(NATIVE_FFI),auto)"; \
	  ran=1; \
	fi; \
	if [ -f apps/native-c/src/add.c ]; then \
	  echo "native-bindings-strict: check-native-c (NATIVE_STRICT=1)"; \
	  $(MAKE) check-native-c NATIVE_STRICT=1 NATIVE_FFI="$(or $(NATIVE_FFI),auto)"; \
	  ran=1; \
	fi; \
	if [ "$$ran" = 0 ]; then echo "native-bindings-strict: no native stack — skipped"; fi

links: ## dead relative links in all Markdown files
	@bash scripts/check-links.sh .

smoke: ## smoke tests against an environment: make smoke URL=https://…
	@test -n "$(URL)" || { echo 'usage: make smoke URL=https://…' >&2; exit 1; }
	@test -n "$(strip $(SMOKE))" || { echo "No app with smoke tests." >&2; exit 1; }
	@$(MAKE) $(SMOKE) URL="$(URL)"

fmt: $(FMT) ## format everything

build: $(BUILD) ## production build of every app

##@ Container (once per machine)
container-setup: ## container-safe wrappers for npm/pip/cargo (Podman); see docs/how-to/container-safe.md
	@bash scripts/container-safe.sh

##@ Security (not in make check)
security-scan-quick: ## quick Strix scan; TARGET=path|url (default .)
	@bash scripts/security-scan.sh --quick --target "$(or $(TARGET),.)"

security-scan: ## Strix scan; TARGET=path|url (default .). See docs/how-to/security-scan.md
	@bash scripts/security-scan.sh --target "$(or $(TARGET),.)"

##@ Performance (not in make check)
perf-check: ## structure of the budgets doc; see docs/architecture/performance.md
	@bash scripts/perf-check.sh

bench: ## every bench-<app>; requires apps/<app>/scripts/bench.sh
	@test -n "$(strip $(BENCH))" || { echo "No app with BENCH yet. Copy a stack or add to BENCH in app.mk." >&2; exit 1; }
	@$(MAKE) $(BENCH)

##@ Dependencies (in check-full, not in check)
deps-audit: ## CVE audits per stack + dependencies.md; see docs/how-to/deps-audit.md
	@bash scripts/deps-audit.sh

##@ Polyglot (not in make check)
polyglot-check: ## polyglot.md + example ADR; see docs/architecture/polyglot.md
	@bash scripts/polyglot-check.sh

##@ Tech radar (module research; not in make check)
radar-check: ## structure of docs/research/radar.md; see docs/how-to/radar.md
	@bash scripts/radar-check.sh

radar-reminder: ## hint + Last reviewed date (monthly ritual)
	@bash scripts/radar-reminder.sh

##@ Digest (module research; not in make check)
digest-check: ## docs/research/digest scaffold; see docs/how-to/digest.md
	@bash scripts/digest-check.sh

digest-reminder: ## hint: curate feeds/SOURCES (P5)
	@bash scripts/digest-reminder.sh

digest-fetch: ## RSS/Atom → data/external/digest/; DIGEST_DRY_RUN=1 / DIGEST_FIXTURE=
	@bash scripts/digest-fetch.sh

digest-propose: ## proposal in digest/proposals/ (no auto-radar); DIGEST_DRY_RUN=1
	@bash scripts/digest-propose.sh

##@ Observability (module observability)
obs-up: ## start the LGTM stack (Grafana/Prometheus/Loki/Tempo/Alloy)
	@test -f docker-compose.observability.yml || { \
	  echo "No docker-compose.observability.yml (kit: --modules observability)." >&2; exit 1; }
	@docker info >/dev/null 2>&1 || { echo "Docker is not running. Start the daemon and try again." >&2; exit 1; }
	@if [ -f docker-compose.yml ]; then \
	  docker compose -f docker-compose.yml -f docker-compose.observability.yml up -d --wait; \
	 else \
	  docker compose -f docker-compose.observability.yml up -d --wait; \
	 fi

obs-down: ## stop the LGTM stack
	@test -f docker-compose.observability.yml || { \
	  echo "No docker-compose.observability.yml (kit: --modules observability)." >&2; exit 1; }
	@if [ -f docker-compose.yml ]; then \
	  docker compose -f docker-compose.yml -f docker-compose.observability.yml stop prometheus loki tempo alloy grafana 2>/dev/null || \
	  docker compose -f docker-compose.observability.yml down; \
	 else \
	  docker compose -f docker-compose.observability.yml down; \
	 fi

obs-status: ## status of the observability containers
	@test -f docker-compose.observability.yml || { \
	  echo "No docker-compose.observability.yml (kit: --modules observability)." >&2; exit 1; }
	@if [ -f docker-compose.yml ]; then \
	  docker compose -f docker-compose.yml -f docker-compose.observability.yml ps; \
	 else \
	  docker compose -f docker-compose.observability.yml ps; \
	 fi

##@ Data and database
data: $(DATA) ## pipeline: raw, external and reference into processed

seed: $(SEED) ## load test users and demo data (local)

db-reset: $(DB_RESET) ## empty the local database and seed it again; refuses outside localhost

##@ Docs and work
adr: ## new ADR with the next number: make adr t="Postgres is the only writer"
	@test -n "$(t)" || { echo 'usage: make adr t="decision as a sentence"' >&2; exit 1; }
	@last=$$(ls docs/decisions | grep -oE '^[0-9]{4}' | sort | tail -n 1 || true); \
	number=$$(printf '%04d' $$((10#$${last:-0} + 1))); \
	file="docs/decisions/$$number-$$(printf '%s' "$(t)" | $(SLUG)).md"; \
	sed -e "s|^# NNNN — .*|# $$number — $(t)|" -e "s|YYYY-MM-DD|$(TODAY)|" docs/decisions/_template.md >"$$file"; \
	echo "$$file"

spec: ## new spec and a line in the backlog: make spec s=diet-budget
	@test -n "$(s)" || { echo 'usage: make spec s=<slug>' >&2; exit 1; }
	@test -d docs/work/specs || { echo "No docs/work/specs/ (team: use the issue tracker)." >&2; exit 1; }
	@file="docs/work/specs/$(s).md"; \
	test ! -e "$$file" || { echo "already exists: $$file" >&2; exit 1; }; \
	sed "s|<slug>|$(s)|g" docs/work/specs/_template.md >"$$file"; \
	sed -i -e '/^## Now/,/^## /{/^|-/a\' -e '| [$(s)](specs/$(s).md) | <category> | open |' -e '}' docs/work/BACKLOG.md; \
	echo "$$file"

log: ## create today's daily log (if it does not exist) and show the path
	@test -d docs/work/logs || { echo "No docs/work/logs/ (team: the PRs are the log)." >&2; exit 1; }
	@file="docs/work/logs/$(TODAY).md"; \
	test -e "$$file" || sed "s|YYYY-MM-DD|$(TODAY)|" docs/work/logs/_template.md >"$$file"; \
	echo "$$file"

meeting: ## minutes of a meeting: make meeting with=coach
	@test -n "$(with)" || { echo 'usage: make meeting with=<with-whom>' >&2; exit 1; }
	@test -d docs/work/meetings || { echo "No docs/work/meetings/ (kit: module meetings)." >&2; exit 1; }
	@file="docs/work/meetings/$(TODAY)-$(with).md"; \
	test -e "$$file" || sed -e "s|YYYY-MM-DD|$(TODAY)|" -e "s|<with whom>|$(with)|" docs/work/meetings/_template.md >"$$file"; \
	echo "$$file"

experiment: ## report of an experiment: make experiment s=sleep-baseline
	@test -n "$(s)" || { echo 'usage: make experiment s=<slug>' >&2; exit 1; }
	@test -d docs/research/experiments || { echo "No docs/research/experiments/ (kit: module research)." >&2; exit 1; }
	@file="docs/research/experiments/$(TODAY)-$(s).md"; \
	test -e "$$file" || sed -e "s|YYYY-MM-DD|$(TODAY)|g" -e "s|<slug>|$(s)|g" docs/research/experiments/_template.md >"$$file"; \
	echo "$$file"

context: ## context bundle for the agent: make context s=<slug> shows RULES + BACKLOG + spec in one output
	@echo "=== RULES.md ===" && cat docs/rules/RULES.md 2>/dev/null || echo "(no RULES.md)"; \
	echo ""; \
	echo "=== BACKLOG ===" && cat docs/work/BACKLOG.md 2>/dev/null || echo "(no BACKLOG.md)"; \
	if [ -n "$(s)" ] && [ -f "docs/work/specs/$(s).md" ]; then \
	  echo ""; echo "=== SPEC: $(s) ==="; cat "docs/work/specs/$(s).md"; \
	fi

finish: ## check + log in one call: make finish MSG="what was done"
	@$(MAKE) check; \
	if [ -d docs/work/logs ]; then \
	  file="docs/work/logs/$(TODAY).md"; \
	  test -e "$$file" || sed "s|YYYY-MM-DD|$(TODAY)|" docs/work/logs/_template.md >"$$file"; \
	  echo "" >> "$$file"; \
	  echo "### $(shell date +%H:%M) — $(MSG)" >> "$$file"; \
	  echo "" >> "$$file"; \
	  echo "Log: $$file"; \
	fi

docs-health: links ## maintenance: dead links, length of the AGENTS.md files, oldest docs
	@echo "AGENTS.md (guideline: root ≤ 70 lines, aim for ~50; per app ≤ 40):"
	@find . -name AGENTS.md -not -path '*/node_modules/*' -exec wc -l {} + | sort -n
	@echo
	@echo "Docs that have not changed for the longest time:"
	@git ls-files 'docs/*.md' 2>/dev/null | while read -r file; do \
	  echo "$$(git log -1 --format=%cs -- "$$file")  $$file"; \
	done | sort | head -n 15 || true

##@ Cleaning up
clean: $(CLEAN) ## remove build output, tmp/ and empty data/interim/
	rm -rf tmp
	@find data/interim -mindepth 1 ! -name .gitkeep -delete 2>/dev/null || true
