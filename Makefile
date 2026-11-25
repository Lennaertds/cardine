# Cardine — all commands. `make` lists them.
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
CHECK := sandbox-check
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
	    security-scan security-scan-quick obs-up obs-down obs-status \
	    bench perf-check deps-audit polyglot-check radar-check radar-reminder \
	    digest-check digest-reminder digest-fetch digest-propose digest-week native-bindings-strict \
	    install-lab move move-fix env-status index jarvis-check sandbox-check sandbox-secrets secrets-check \
	    test-kit trio next-ids mindmap bootstrap bootstrap-remove new tag-kit digest-day \
	    digest-triage install-digest-timers sync-kit

# The kit layers contain links that are only correct once a project is assembled;
# test-kit checks those.
KIT_LAYERS := kit/kern kit/solo kit/team kit/modules kit/stacks/*/apps

##@ Standard (kit, sources, sjablonen)
sync-kit: ## copy source kit/ to packages/structure/kit/ (public distribution copy)
	@bash packages/structure/sync_kit.sh

test-kit: ## assemble projects with the kit in tmp/test-kit/ and check them
	@bash scripts/test-kit.sh

trio: ## show the three-place files: make trio s=<topic>
	@test -n "$(s)" || { echo 'usage: make trio s=<topic>' >&2; exit 1; }
	@for f in "standard/$(s).md" "sjablonen/$(s).md"; do \
		if [ -f "$$f" ]; then echo "=== $$f ===" && cat "$$f"; fi; \
	done
	@echo "=== kit/ matches ===" && find kit -iname "*$(s)*" -exec head -n 120 {} +

next-ids: ## show the next free § and P number
	@next_s=$$(grep -oE '§[0-9]+' bron/bronnen-index.md 2>/dev/null | tr -d '§' | sort -n | tail -n 1 || echo 0); \
	next_p=$$(grep -oE '\bP[0-9]+\b' bron/principes.md 2>/dev/null | tr -d 'P' | sort -n | tail -n 1 || echo 0); \
	echo "Volgende bron: §$$((next_s + 1)) | Volgende principe: P$$((next_p + 1))"

mindmap: ## Markmap HTML of the knowledge-map outline → bron/fundament/exports/
	@mkdir -p bron/fundament/exports
	@npx --yes markmap-cli --no-open --offline bron/fundament/kenniskaart-outline.md -o bron/fundament/exports/kenniskaart.html
	@echo "mindmap: bron/fundament/exports/kenniskaart.html"

new: ## create a project: make new DIR=~/code/demo ARGS="--profile app"
	@test -n "$(DIR)" || { echo 'usage: make new DIR=<dir> [ARGS="--profile app --team --modules … --stacks …"]' >&2; exit 1; }
	@bash kit/new-project.sh "$(DIR)" $(ARGS)

bootstrap: ## temporarily put this standard in a project: make bootstrap DIR=../GymFreak
	@test -n "$(DIR)" || { echo 'usage: make bootstrap DIR=<project>' >&2; exit 1; }
	@bash scripts/bootstrap.sh "$(DIR)"

bootstrap-remove: ## remove the bootstrap package again: make bootstrap-remove DIR=../GymFreak
	@test -n "$(DIR)" || { echo 'usage: make bootstrap-remove DIR=<project>' >&2; exit 1; }
	@bash scripts/bootstrap.sh --remove "$(DIR)"

tag-kit: ## tag a kit version for cardine-structure: make tag-kit TAG=v0.1.0
	@test -n "$(TAG)" || { echo 'usage: make tag-kit TAG=v0.1.0' >&2; exit 1; }
	@bash scripts/tag-kit.sh "$(TAG)"

digest-day: ## daily: catch up + fetch + week letter(s); CATCHUP_DAYS=7
	@bash scripts/digest-day.sh

digest-triage: ## week letter status have/keep/skip; WEEK= / FORCE=1
	@python3 scripts/digest-triage.py $(if $(WEEK),--week $(WEEK),) $(if $(FORCE),--force,)

install-digest-timers: ## systemd --user digest-day.timer (daily 07:00)
	@bash scripts/install-digest-timers.sh

##@ Starting
help: ## this overview
	@awk 'BEGIN {FS = ":[^#]*## "} /^##@/ {printf "\n%s\n", substr($$0, 5)} /^[a-zA-Z0-9_-]+:.*## / {printf "  %-18s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

setup: env $(SETUP) ## install everything: .env files, per-app dependencies, git hooks
	@if command -v pre-commit >/dev/null; then pre-commit install; \
	 else echo "Tip: installeer pre-commit (pipx install pre-commit) en draai make setup opnieuw." >&2; fi

env: ## create .env from every .env.example that has none yet
	@find . -name .env.example -not -path '*/node_modules/*' | while read -r example; do \
	  target="$${example%.example}"; \
	  if [ ! -e "$$target" ]; then cp "$$example" "$$target"; echo "aangemaakt: $$target"; fi; \
	done

doctor: ## check that every tool the apps need is installed
	@missing=0; for tool in $(sort $(TOOLS)); do \
	  if command -v $$tool >/dev/null; then echo "ok    $$tool"; else echo "MIST  $$tool"; missing=1; fi; \
	done; exit $$missing

##@ Running locally
dev: ## start all apps at once; Ctrl-C stops everything
	@test -n "$(strip $(DEV))" || { echo "No app with a dev target yet. Copy a stack from the kit." >&2; exit 1; }
	@$(MAKE) -j $(words $(DEV)) $(DEV)

up: ## start local services (docker compose) and wait until they are healthy
	@test -f docker-compose.yml || { echo "Geen docker-compose.yml (kit: module compose)." >&2; exit 1; }
	@docker info >/dev/null 2>&1 || { echo "Docker is not running. Start the daemon and try again." >&2; exit 1; }
	docker compose up -d --wait

down: ## stop local services
	docker compose down

logs: ## follow the logs of the local services
	docker compose logs -f

status: ## containers, and which app ports are taken
	@docker compose ps 2>/dev/null || true
	@for port in $(PORTS); do \
	  if ss -tln "sport = :$$port" | grep -q LISTEN; then echo ":$$port bezet"; else echo ":$$port vrij"; fi; \
	done

##@ Checking
check: lang links $(CHECK) ## language, dead links, lint, types and unit tests of every app; must be green
	@if [ -z "$(strip $(CHECK))" ]; then \
	  echo "make check: no apps to check (links only)"; \
	 fi
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

# Language guard (ADR 0018), part of `make check`. It is in the main set rather
# than an opt-in target: the failure mode is slow drift, and drift never reports
# itself. It runs before the others so the report leads with language errors.
lang: ## language guard: Dutch outside bron/ and history (ADR 0018); VERBOSE=1 for the lines
	@bash packages/lab/scripts/check-language.sh .

links: ## dead relative links (except the kit layers and files whose names are fixed by history)
	@bash packages/lab/scripts/check-links.sh . $(KIT_LAYERS) packages/structure/kit --skip-target bron/pdfs

sandbox-check: ## proof matrix of the cage: route × direction (packages/lab/scripts/check-sandbox.sh)
	@bash packages/lab/scripts/check-sandbox.sh

sandbox-secrets: ## alias: the shell cage only (packages/lab/scripts/check-bwrap-secrets.sh)
	@bash packages/lab/scripts/check-bwrap-secrets.sh

secrets-check: ## alias: read boundary and repo secrets (packages/lab/scripts/check-secrets.sh)
	@bash packages/lab/scripts/check-secrets.sh

smoke: ## smoke tests against an environment: make smoke URL=https://…
	@test -n "$(URL)" || { echo 'usage: make smoke URL=https://…' >&2; exit 1; }
	@test -n "$(strip $(SMOKE))" || { echo "Geen app met smoke-tests." >&2; exit 1; }
	@$(MAKE) $(SMOKE) URL="$(URL)"

fmt: $(FMT) ## format everything

build: $(BUILD) ## production build of every app

##@ Security (not in make check)
security-scan-quick: ## quick Strix scan; TARGET=path|url (default .)
	@bash packages/lab/scripts/security-scan.sh --quick --target "$(or $(TARGET),.)"

security-scan: ## Strix scan; TARGET=path|url (default .). See docs/how-to/security-scan.md
	@bash packages/lab/scripts/security-scan.sh --target "$(or $(TARGET),.)"

##@ Performance (not in make check)
perf-check: ## structure of the budgets doc; see docs/architecture/performance.md
	@bash packages/lab/scripts/perf-check.sh

bench: ## every bench-<app>; requires apps/<app>/scripts/bench.sh
	@test -n "$(strip $(BENCH))" || { echo "No app with BENCH yet. Copy a stack or add to BENCH in app.mk." >&2; exit 1; }
	@$(MAKE) $(BENCH)

##@ Dependencies (in check-full, not in check)
deps-audit: ## CVE audits per stack + dependencies.md; see docs/how-to/deps-audit.md
	@bash packages/lab/scripts/deps-audit.sh

##@ Polyglot (not in make check)
polyglot-check: ## polyglot.md + example ADR; see docs/architecture/polyglot.md
	@bash packages/lab/scripts/polyglot-check.sh

##@ Tech radar (module research; not in make check)
radar-check: ## structure of docs/research/radar.md; see docs/how-to/radar.md
	@bash packages/lab/scripts/radar-check.sh

radar-reminder: ## hint + Last reviewed date (monthly ritual)
	@bash packages/lab/scripts/radar-reminder.sh

##@ Digest (module research; not in make check)
digest-check: ## docs/research/digest scaffold; see docs/how-to/digest.md
	@bash packages/lab/scripts/digest-check.sh

digest-reminder: ## hint: curate feeds/SOURCES (P5)
	@bash packages/lab/scripts/digest-reminder.sh

digest-fetch: ## RSS/Atom or JSON API → data/external/digest/; DIGEST_DRY_RUN=1 / DIGEST_FIXTURE=
	@bash packages/lab/scripts/digest-fetch.sh

digest-propose: ## proposal in digest/proposals/ (no auto-radar); DIGEST_DRY_RUN=1
	@bash packages/lab/scripts/digest-propose.sh

digest-week: ## week letter from dumps → bron/weken/ (DIGEST_WEEK=2026-W45 to force it)
	@bash scripts/digest-week.sh

##@ Observability (module observability)
obs-up: ## start the LGTM stack (Grafana/Prometheus/Loki/Tempo/Alloy)
	@test -f docker-compose.observability.yml || { \
	  echo "Geen docker-compose.observability.yml (kit: --modules observability)." >&2; exit 1; }
	@docker info >/dev/null 2>&1 || { echo "Docker is not running. Start the daemon and try again." >&2; exit 1; }
	@if [ -f docker-compose.yml ]; then \
	  docker compose -f docker-compose.yml -f docker-compose.observability.yml up -d --wait; \
	 else \
	  docker compose -f docker-compose.observability.yml up -d --wait; \
	 fi

obs-down: ## stop the LGTM stack
	@test -f docker-compose.observability.yml || { \
	  echo "Geen docker-compose.observability.yml (kit: --modules observability)." >&2; exit 1; }
	@if [ -f docker-compose.yml ]; then \
	  docker compose -f docker-compose.yml -f docker-compose.observability.yml stop prometheus loki tempo alloy grafana 2>/dev/null || \
	  docker compose -f docker-compose.observability.yml down; \
	 else \
	  docker compose -f docker-compose.observability.yml down; \
	 fi

obs-status: ## status of the observability containers
	@test -f docker-compose.observability.yml || { \
	  echo "Geen docker-compose.observability.yml (kit: --modules observability)." >&2; exit 1; }
	@if [ -f docker-compose.yml ]; then \
	  docker compose -f docker-compose.yml -f docker-compose.observability.yml ps; \
	 else \
	  docker compose -f docker-compose.observability.yml ps; \
	 fi

##@ Data and database
data: $(DATA) ## pipeline: raw, external en reference naar processed

seed: $(SEED) ## testgebruikers en demo-data laden (lokaal)

db-reset: $(DB_RESET) ## lokale database leegmaken en opnieuw seeden; weigert buiten localhost

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
	test ! -e "$$file" || { echo "bestaat al: $$file" >&2; exit 1; }; \
	sed "s|<slug>|$(s)|g" docs/work/specs/_template.md >"$$file"; \
	sed -i -e '/^## Nu/,/^## /{/^|-/a\' -e '| [$(s)](specs/$(s).md) | <categorie> | open |' -e '}' docs/work/BACKLOG.md; \
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
	@test -d docs/research/experiments || { echo "Geen docs/research/experiments/ (kit: module research)." >&2; exit 1; }
	@file="docs/research/experiments/$(TODAY)-$(s).md"; \
	test -e "$$file" || sed -e "s|YYYY-MM-DD|$(TODAY)|g" -e "s|<slug>|$(s)|g" docs/research/experiments/_template.md >"$$file"; \
	echo "$$file"

docs-health: links ## maintenance: dead links, length of the AGENTS.md files, oldest docs
	@echo "AGENTS.md (richtlijn: root ≤ 70 regels, streef ~50; per app ≤ 40):"
	@find . -name AGENTS.md -not -path '*/node_modules/*' -exec wc -l {} + | sort -n
	@echo
	@echo "Docs that have not changed for the longest time:"
	@git ls-files 'docs/*.md' 2>/dev/null | while read -r file; do \
	  echo "$$(git log -1 --format=%cs -- "$$file")  $$file"; \
	done | sort | head -n 15 || true

context: jarvis-check ## show the start context in one go (incl. jarvis-check): make context [s=<slug>]
	@echo "=== RULES ===" && cat docs/rules/RULES.md
	@echo "\n=== BACKLOG ===" && cat docs/work/BACKLOG.md
	@if [ -n "$(s)" ] && [ -f "docs/work/specs/$(s).md" ]; then \
		echo "\n=== SPEC: $(s) ===" && cat "docs/work/specs/$(s).md"; \
	fi

# The message goes through the environment, not through the shell line. Otherwise a
# `·` in m= silently dropped out of the daily log (2026-11-22) while finish still
# printed "Logged". Reading it back is the gate: if the line is missing, red.
finish: export FINISH_MSG := $(m)
finish: check ## finish in one call: make finish m="reason · files · test · rest · item"
	@test -n "$$FINISH_MSG" || { echo 'usage: make finish m="reason · files · test · rest · item"' >&2; exit 1; }
	@file="$$($(MAKE) -s log)"; \
	awk ' \
		BEGIN { entry = "- " ENVIRON["FINISH_MSG"] " · written via the cage" } \
		/^## Done/ { print; print ""; print entry; added=1; next } \
		{ print } \
		END { if (!added) print "\n## Done\n\n" entry } \
	' "$$file" > "$$file.tmp" && mv "$$file.tmp" "$$file"; \
	awk 'BEGIN { found = 0 } index($$0, ENVIRON["FINISH_MSG"]) { found = 1 } END { exit !found }' "$$file" \
		|| { echo "finish: the line is not in $$file" >&2; exit 1; }; \
	echo "Logged in $$file"

env-status: jarvis-check ## status of DSH, Jarvis and this environment (packages/lab/cardine-status.sh + jarvis-check)
	@bash packages/lab/cardine-status.sh

index: ## build the Jarvis code index for this repo (run outside the sandbox)
	@command -v jarvis >/dev/null || { echo "jarvis not found on PATH" >&2; exit 1; }
	@jarvis index "$(CURDIR)" --no-semantic

jarvis-check: ## controles: stale Jarvis-locks en of de huidige repo geïndexeerd is
	@if command -v jarvis >/dev/null; then \
	  stale=0; \
	  for lock in "$$HOME/.jarvis"/index-*.lock; do \
	    [ -e "$$lock" ] || continue; \
	    pid=$$(cat "$$lock" 2>/dev/null || true); \
	    if [ -n "$$pid" ] && ! kill -0 "$$pid" 2>/dev/null; then \
	      echo "WARNING: stale Jarvis lock: $$lock (PID $$pid does not exist)"; \
	      echo "  Oplossing: rm -f $$lock"; \
	      stale=1; \
	    fi; \
	  done; \
	  if [ "$$stale" = 0 ]; then \
	    echo "jarvis-check: no stale locks"; \
	  fi; \
	  slug=$$(basename "$(CURDIR)" | tr '[:upper:]' '[:lower:]'); \
	  if ! jarvis status "$$slug" >/dev/null 2>&1; then \
	    echo "TIP: repo '$$slug' is not indexed yet."; \
	    echo "  Draai in je terminal (buiten sandbox): make index"; \
	  else \
	    echo "jarvis-check: repo '$$slug' is geïndexeerd"; \
	  fi; \
	else \
	  echo "jarvis-check: jarvis CLI not found — install via packages/lab/install-lab.sh" >&2; \
	fi

install-lab: ## set up the lab environment on a fresh Arch Linux Hyprland machine; a second project: make install-lab A="--profile bp --name Bachelorproef"
	@bash packages/lab/install-lab.sh $(A)

move: ## this repo moved: which profile paths and tools are stale? (dry run)
	@bash packages/lab/cardine-move.sh

move-fix: ## this repo moved: re-point the DSH profile, repair the jarvis client, re-index
	@bash packages/lab/cardine-move.sh --fix

##@ Cleaning up
clean: $(CLEAN) ## build-output, tmp/ en data/interim/ leegmaken
	rm -rf tmp
	@find data/interim -mindepth 1 ! -name .gitkeep -delete 2>/dev/null || true
