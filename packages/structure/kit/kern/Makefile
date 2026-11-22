# {{PROJECT}} — alle commando's. `make` toont ze.
#
# Elke app voegt zijn targets toe via apps/<app>/app.mk; die worden hieronder automatisch
# opgenomen. Persoonlijke targets zet je in local.mk (staat niet in git).

SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := help
MAKEFLAGS += --no-print-directory

TODAY := $(shell date +%F)
SLUG = iconv -f utf-8 -t ascii//TRANSLIT | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/^-+|-+$$//g'

# Lijsten die elke app.mk aanvult (bv. CHECK += check-web).
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

##@ Starten
help: ## dit overzicht
	@awk 'BEGIN {FS = ":[^#]*## "} /^##@/ {printf "\n%s\n", substr($$0, 5)} /^[a-zA-Z0-9_-]+:.*## / {printf "  %-18s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

setup: env $(SETUP) ## alles installeren: .env-bestanden, dependencies per app, git-hooks
	@if command -v pre-commit >/dev/null; then pre-commit install; \
	 else echo "Tip: installeer pre-commit (pipx install pre-commit) en draai make setup opnieuw." >&2; fi

env: ## .env aanmaken uit elke .env.example die er nog geen heeft
	@find . -name .env.example -not -path '*/node_modules/*' | while read -r example; do \
	  target="$${example%.example}"; \
	  if [ ! -e "$$target" ]; then cp "$$example" "$$target"; echo "aangemaakt: $$target"; fi; \
	done

doctor: ## nagaan of alle tools geïnstalleerd zijn die de apps nodig hebben
	@missing=0; for tool in $(sort $(TOOLS)); do \
	  if command -v $$tool >/dev/null; then echo "ok    $$tool"; else echo "MIST  $$tool"; missing=1; fi; \
	done; exit $$missing

env-status: jarvis-check ## status van DSH, Jarvis en deze omgeving
	@if command -v jarvis >/dev/null; then \
	  echo "env-status: ok (jarvis beschikbaar)"; \
	else \
	  echo "env-status: jarvis CLI niet gevonden" >&2; \
	fi

index: ## Jarvis code-index opbouwen voor deze repo (buiten sandbox draaien)
	@command -v jarvis >/dev/null || { echo "jarvis niet gevonden op PATH" >&2; exit 1; }
	@jarvis index "$(CURDIR)" --no-semantic

jarvis-check: ## controles: stale Jarvis-locks en of de huidige repo geïndexeerd is
	@if command -v jarvis >/dev/null; then \
	  stale=0; \
	  for lock in "$$HOME/.jarvis"/index-*.lock; do \
	    [ -e "$$lock" ] || continue; \
	    pid=$$(cat "$$lock" 2>/dev/null || true); \
	    if [ -n "$$pid" ] && ! kill -0 "$$pid" 2>/dev/null; then \
	      echo "WAARSCHUWING: stale Jarvis lock: $$lock (PID $$pid bestaat niet)"; \
	      echo "  Oplossing: rm -f $$lock"; \
	      stale=1; \
	    fi; \
	  done; \
	  if [ "$$stale" = 0 ]; then \
	    echo "jarvis-check: geen stale locks"; \
	  fi; \
	  slug=$$(basename "$(CURDIR)" | tr '[:upper:]' '[:lower:]'); \
	  if ! jarvis status "$$slug" >/dev/null 2>&1; then \
	    echo "TIP: repo '$$slug' is nog niet geïndexeerd."; \
	    echo "  Draai in je terminal (buiten sandbox): make index"; \
	  else \
	    echo "jarvis-check: repo '$$slug' is geïndexeerd"; \
	  fi; \
	else \
	  echo "jarvis-check: jarvis CLI niet gevonden — skip" >&2; \
	fi

##@ Lokaal draaien
dev: ## alle apps tegelijk starten; Ctrl-C stopt alles
	@test -n "$(strip $(DEV))" || { echo "Nog geen app met een dev-target. Kopieer een stack uit de kit." >&2; exit 1; }
	@$(MAKE) -j $(words $(DEV)) $(DEV)

up: ## lokale diensten starten (docker compose) en wachten tot ze gezond zijn
	@test -f docker-compose.yml || { echo "Geen docker-compose.yml (kit: module compose)." >&2; exit 1; }
	@docker info >/dev/null 2>&1 || { echo "Docker draait niet. Start de daemon en probeer opnieuw." >&2; exit 1; }
	docker compose up -d --wait

down: ## lokale diensten stoppen
	docker compose down

logs: ## logs van de lokale diensten volgen
	docker compose logs -f

status: ## containers, en welke poorten van de apps bezet zijn
	@docker compose ps 2>/dev/null || true
	@for port in $(PORTS); do \
	  if ss -tln "sport = :$$port" | grep -q LISTEN; then echo ":$$port bezet"; else echo ":$$port vrij"; fi; \
	done

##@ Controleren
check: links $(CHECK) ## lint, types en unit-tests van elke app, plus dode links; moet groen zijn
	@test -n "$(strip $(CHECK))" || { echo "make check controleert nog geen app. Kopieer een stack uit de kit of vul CHECK aan." >&2; exit 1; }
	@echo "make check: groen"

check-full: check deps-audit native-bindings-strict $(CHECK_FULL) ## check + deps-audit + native STRICT + CHECK_FULL

native-bindings-strict: ## NATIVE_STRICT=1 voor apps/native en/of native-c (onderdeel check-full)
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
	if [ "$$ran" = 0 ]; then echo "native-bindings-strict: geen native-stack — overgeslagen"; fi

links: ## dode relatieve links in alle Markdown-bestanden
	@bash scripts/check-links.sh .

smoke: ## smoke-tests tegen een omgeving: make smoke URL=https://…
	@test -n "$(URL)" || { echo 'gebruik: make smoke URL=https://…' >&2; exit 1; }
	@test -n "$(strip $(SMOKE))" || { echo "Geen app met smoke-tests." >&2; exit 1; }
	@$(MAKE) $(SMOKE) URL="$(URL)"

fmt: $(FMT) ## alles formatteren

build: $(BUILD) ## productiebuild van elke app

##@ Container (eenmalig per machine)
container-setup: ## container-safe functies voor npm/pip/cargo (Podman); zie docs/how-to/container-safe.md
	@bash scripts/container-safe.sh

##@ Security (niet in make check)
security-scan-quick: ## snelle Strix-scan; TARGET=pad|url (default .)
	@bash scripts/security-scan.sh --quick --target "$(or $(TARGET),.)"

security-scan: ## Strix-scan; TARGET=pad|url (default .). Zie docs/how-to/security-scan.md
	@bash scripts/security-scan.sh --target "$(or $(TARGET),.)"

##@ Performance (niet in make check)
perf-check: ## budgets-doc structuur; zie docs/architecture/performance.md
	@bash scripts/perf-check.sh

bench: ## alle bench-<app>; vereist apps/<app>/scripts/bench.sh
	@test -n "$(strip $(BENCH))" || { echo "Nog geen app met BENCH. Kopieer een stack of vul BENCH aan in app.mk." >&2; exit 1; }
	@$(MAKE) $(BENCH)

##@ Dependencies (in check-full, niet in check)
deps-audit: ## CVE-audits per stack + dependencies.md; zie docs/how-to/deps-audit.md
	@bash scripts/deps-audit.sh

##@ Polyglot (niet in make check)
polyglot-check: ## polyglot.md + voorbeeld-ADR; zie docs/architecture/polyglot.md
	@bash scripts/polyglot-check.sh

##@ Tech-radar (module research; niet in make check)
radar-check: ## docs/research/radar.md structuur; zie docs/how-to/radar.md
	@bash scripts/radar-check.sh

radar-reminder: ## tip + Laatst herzien-datum (maandelijks ritueel)
	@bash scripts/radar-reminder.sh

##@ Digest (module research; niet in make check)
digest-check: ## docs/research/digest scaffold; zie docs/how-to/digest.md
	@bash scripts/digest-check.sh

digest-reminder: ## tip: feeds/SOURCES cureren (P5)
	@bash scripts/digest-reminder.sh

digest-fetch: ## RSS/Atom → data/external/digest/; DIGEST_DRY_RUN=1 / DIGEST_FIXTURE=
	@bash scripts/digest-fetch.sh

digest-propose: ## voorstel in digest/proposals/ (geen auto-radar); DIGEST_DRY_RUN=1
	@bash scripts/digest-propose.sh

##@ Observability (module observability)
obs-up: ## LGTM-stack starten (Grafana/Prometheus/Loki/Tempo/Alloy)
	@test -f docker-compose.observability.yml || { \
	  echo "Geen docker-compose.observability.yml (kit: --modules observability)." >&2; exit 1; }
	@docker info >/dev/null 2>&1 || { echo "Docker draait niet. Start de daemon en probeer opnieuw." >&2; exit 1; }
	@if [ -f docker-compose.yml ]; then \
	  docker compose -f docker-compose.yml -f docker-compose.observability.yml up -d --wait; \
	 else \
	  docker compose -f docker-compose.observability.yml up -d --wait; \
	 fi

obs-down: ## LGTM-stack stoppen
	@test -f docker-compose.observability.yml || { \
	  echo "Geen docker-compose.observability.yml (kit: --modules observability)." >&2; exit 1; }
	@if [ -f docker-compose.yml ]; then \
	  docker compose -f docker-compose.yml -f docker-compose.observability.yml stop prometheus loki tempo alloy grafana 2>/dev/null || \
	  docker compose -f docker-compose.observability.yml down; \
	 else \
	  docker compose -f docker-compose.observability.yml down; \
	 fi

obs-status: ## status van de observability-containers
	@test -f docker-compose.observability.yml || { \
	  echo "Geen docker-compose.observability.yml (kit: --modules observability)." >&2; exit 1; }
	@if [ -f docker-compose.yml ]; then \
	  docker compose -f docker-compose.yml -f docker-compose.observability.yml ps; \
	 else \
	  docker compose -f docker-compose.observability.yml ps; \
	 fi

##@ Data en database
data: $(DATA) ## pipeline: raw, external en reference naar processed

seed: $(SEED) ## testgebruikers en demo-data laden (lokaal)

db-reset: $(DB_RESET) ## lokale database leegmaken en opnieuw seeden; weigert buiten localhost

##@ Docs en werk
adr: ## nieuwe ADR met het volgende nummer: make adr t="Postgres is de enige writer"
	@test -n "$(t)" || { echo 'gebruik: make adr t="besluit als zin"' >&2; exit 1; }
	@last=$$(ls docs/decisions | grep -oE '^[0-9]{4}' | sort | tail -n 1 || true); \
	number=$$(printf '%04d' $$((10#$${last:-0} + 1))); \
	file="docs/decisions/$$number-$$(printf '%s' "$(t)" | $(SLUG)).md"; \
	sed -e "s|^# NNNN — .*|# $$number — $(t)|" -e "s|YYYY-MM-DD|$(TODAY)|" docs/decisions/_template.md >"$$file"; \
	echo "$$file"

spec: ## nieuwe spec en een regel in de backlog: make spec s=diet-budget
	@test -n "$(s)" || { echo 'gebruik: make spec s=<slug>' >&2; exit 1; }
	@test -d docs/work/specs || { echo "Geen docs/work/specs/ (team: gebruik de issue tracker)." >&2; exit 1; }
	@file="docs/work/specs/$(s).md"; \
	test ! -e "$$file" || { echo "bestaat al: $$file" >&2; exit 1; }; \
	sed "s|<slug>|$(s)|g" docs/work/specs/_template.md >"$$file"; \
	sed -i -e '/^## Nu/,/^## /{/^|-/a\' -e '| [$(s)](specs/$(s).md) | <categorie> | open |' -e '}' docs/work/BACKLOG.md; \
	echo "$$file"

log: ## dag-log van vandaag aanmaken (als hij nog niet bestaat) en het pad tonen
	@test -d docs/work/logs || { echo "Geen docs/work/logs/ (team: de PR's zijn de log)." >&2; exit 1; }
	@file="docs/work/logs/$(TODAY).md"; \
	test -e "$$file" || sed "s|YYYY-MM-DD|$(TODAY)|" docs/work/logs/_template.md >"$$file"; \
	echo "$$file"

meeting: ## verslag van een overleg: make meeting met=coach
	@test -n "$(met)" || { echo 'gebruik: make meeting met=<met-wie>' >&2; exit 1; }
	@test -d docs/work/meetings || { echo "Geen docs/work/meetings/ (kit: module meetings)." >&2; exit 1; }
	@file="docs/work/meetings/$(TODAY)-$(met).md"; \
	test -e "$$file" || sed -e "s|YYYY-MM-DD|$(TODAY)|" -e "s|<met wie>|$(met)|" docs/work/meetings/_template.md >"$$file"; \
	echo "$$file"

experiment: ## verslag van een experiment: make experiment s=sleep-baseline
	@test -n "$(s)" || { echo 'gebruik: make experiment s=<slug>' >&2; exit 1; }
	@test -d docs/research/experiments || { echo "Geen docs/research/experiments/ (kit: module research)." >&2; exit 1; }
	@file="docs/research/experiments/$(TODAY)-$(s).md"; \
	test -e "$$file" || sed -e "s|YYYY-MM-DD|$(TODAY)|g" -e "s|<slug>|$(s)|g" docs/research/experiments/_template.md >"$$file"; \
	echo "$$file"

context: ## context-bundle voor de agent: make context s=<slug> toont RULES + BACKLOG + spec in 1 uitvoer
	@echo "=== RULES.md ===" && cat docs/rules/RULES.md 2>/dev/null || echo "(geen RULES.md)"; \
	echo ""; \
	echo "=== BACKLOG ===" && cat docs/work/BACKLOG.md 2>/dev/null || echo "(geen BACKLOG.md)"; \
	if [ -n "$(s)" ] && [ -f "docs/work/specs/$(s).md" ]; then \
	  echo ""; echo "=== SPEC: $(s) ==="; cat "docs/work/specs/$(s).md"; \
	fi

finish: ## check + log in 1 call: make finish MSG="wat gedaan"
	@$(MAKE) check; \
	if [ -d docs/work/logs ]; then \
	  file="docs/work/logs/$(TODAY).md"; \
	  test -e "$$file" || sed "s|YYYY-MM-DD|$(TODAY)|" docs/work/logs/_template.md >"$$file"; \
	  echo "" >> "$$file"; \
	  echo "### $(shell date +%H:%M) — $(MSG)" >> "$$file"; \
	  echo "" >> "$$file"; \
	  echo "Log: $$file"; \
	fi

docs-health: links ## onderhoud: dode links, lengte van de AGENTS.md-bestanden, oudste docs
	@echo "AGENTS.md (richtlijn: root ≤ 70 regels, streef ~50; per app ≤ 40):"
	@find . -name AGENTS.md -not -path '*/node_modules/*' -exec wc -l {} + | sort -n
	@echo
	@echo "Docs die het langst niet gewijzigd zijn:"
	@git ls-files 'docs/*.md' 2>/dev/null | while read -r file; do \
	  echo "$$(git log -1 --format=%cs -- "$$file")  $$file"; \
	done | sort | head -n 15 || true

##@ Opruimen
clean: $(CLEAN) ## build-output, tmp/ en data/interim/ leegmaken
	rm -rf tmp
	@find data/interim -mindepth 1 ! -name .gitkeep -delete 2>/dev/null || true
