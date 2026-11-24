# Waar hoort dit?

> **Rol:** Opzoektabel: ik wil iets noteren, toevoegen of bewaren, waar komt het?
> **Niet hier:** waarom ([principes](../bron/principes.md)), een bestaand project uitzoeken ([classificeren](../bestaand-project/2-classificeren.md)).

## Kennis en besluiten

| Ik wil noteren… | Plaats | Principe |
|-----------------|--------|----------|
| Wat het project is en voor wie | `docs/context/CONTEXT.md` | P6 |
| Waar het op lange termijn heen gaat | `docs/context/vision.md` | P8 |
| De opdracht van school of klant | `docs/context/assignment.md` | P6 |
| Wat een domeinbegrip of projectcode betekent | `docs/context/GLOSSARY.md` | P10 |
| Dat iets nooit mag (inhoudelijk) | `docs/rules/RULES.md` | P6 |
| Dat iets nooit mag en dat afdwingbaar is | Hook, test of CI-check, en één regel in `AGENTS.md` | P14 |
| Zakelijke intentie die tests kunnen missen ("korting mag niet stil worden uitgezet") | `docs/product/` of `CONTEXT.md`, plus een korte regel in `AGENTS.md` als ze bij elke taak geldt | P6, P22 |
| Modulegrenzen / seams waar AI veilig mag raken | `docs/architecture/ARCHITECTURE.md` (naden + wat erachter zit), tests op die naden | P12, P23 |
| Hoe een feature zich gedraagt voor de gebruiker | `docs/product/<domein>.md` | P11 |
| Wat we bewust niet bouwen | `docs/product/PRODUCT.md` § Bewust niet (zonder `product/`: `CONTEXT.md` § Bewust niet) | P6 |
| Hoe iets eruit moet zien of aanvoelen | `docs/design/<onderwerp>.md` (via `DESIGN.md`) | P11 |
| Een leesroute die bij elke taak van dat type moet vuren (UI → DESIGN, feature → PRODUCT, …) | Eén regel in `AGENTS.md` § Werken; detail in de kaart (`DESIGN.md` / `PRODUCT.md` / …) | P2, P3 |
| Opt-in engineering (Strix, obs, perf, deps, polyglot, radar) | Alleen INDEX + `make help`; in `AGENTS.md` hooguit één zin “als de opdracht het noemt” — **geen** keyword-catalogus, geen always-on Werken-stap | P2, P25 |
| PWA / offline / push / chrome-poll | `architecture/runtime-client.md` (of projectnaam), niet in ARCHITECTURE dumpen | P5, P12 |
| Auth-flow details (JWT-TTL, demo-account, onboarding-keys) | `architecture/auth.md` en/of data-model + legal; ARCHITECTURE houdt principes | P5, P12 |
| Welke agent-rol bij welk soort opdracht hoort, en wanneer een subagent | [agent-rollen.md](agent-rollen.md); kit: `.cursor/agents/<rol>.md` | P24, P25 |
| Een Cursor-subagent (eigen context voor één rol) | `.cursor/agents/<rol>.md` (module `cursor` + eventueel `design`/`product`/`research`) | P24 |
| Welke paden de agent mag schrijven | `docs/agent/write-rules.md` (alleen schrijfrechten, geen leesroutes) | P2 |
| Hoe twee apps met elkaar praten | `docs/architecture/ARCHITECTURE.md` | P12 |
| Het schema van de database | `docs/architecture/data-model.md`, of verwijzen naar de migraties als het schema daar leesbaar staat | P5, P7 |
| Hoe privacy en security technisch geregeld zijn | `docs/architecture/security.md` | P17 |
| Actieve security-scan (Strix) | `docs/architecture/security.md` + `docs/how-to/security-scan.md`; uitvoeren via `make security-scan*` | P13, P17 |
| Logs, metrics, traces, SLO’s, Grafana | `docs/architecture/observability.md`; stack via module `observability` | P13 |
| Latency-budgets, anti-patronen, bench | `docs/architecture/performance.md`; `make perf-check` / `make bench` | P13 |
| Dependency-CVE’s, package-ritueel, snellere alternatieven | `docs/architecture/dependencies.md` + `docs/how-to/deps-audit.md`; `make deps-audit` / via `check-full` | P13, P17 |
| Extra taal / Rust/C / FFI / “mag native?” | `docs/architecture/polyglot.md`; ADR; `--stacks rust` / `c` → `apps/native` / `native-c`; `polyglot-check` / `check-native*` | P13, P23 |
| Soft vs harde native FFI in CI | `docs/how-to/native-ci.md`; `NATIVE_STRICT` / `make check-full` / team `native.yml` | P13, P14 |
| Tech-keuze herijken (Adopt/Trial/Assess/Hold) | `docs/research/radar.md` (module `research`); `make radar-reminder` / `radar-check` | P5, P8, P28 |
| Inbound feed / changelog-dump | Ruwe: `data/external/digest/`; voorstel: `digest/proposals/`; cureren → radar/wantlist; geen feed als SSOT | P5, P28 |
| Iets dat de kit bewust nog niet levert (uitbreiding) | `## Bewust later` in het geraakte architecture-/radar-doc; vraag of BACKLOG — niet stil verzinnen | P28 |
| Een valkuil ("deze kolom is VARCHAR, dus ï omzetten") | Bij het subsysteem in `architecture/<x>.md`, en een korte regel in `AGENTS.md` als je er bij elke taak tegenaan kan lopen | P6 |
| Wat de literatuur zegt over een onderwerp | `docs/research/<onderwerp>.md`. De bron zelf: `data/external/` | P11 |
| Een bron die ik nog wil hebben | `docs/research/wantlist.md` | P8 |
| Het resultaat van een experiment | `docs/research/experiments/YYYY-MM-DD-<slug>.md` | P6 |
| Waarom we X kozen boven Y | `docs/decisions/NNNN-x-boven-y.md` | P9 |
| Wat een functie of module doet | Een docstring in de code, niet in docs | P5, P7 |
| Een stappenplan dat ik vaker uitvoer | `docs/how-to/<taak>.md`, of beter een script met een `make`-target | P11, P13 |
| Businessplan, prijzen, voorwaarden | `docs/business/<onderwerp>.md` | — |

## Werk en status

| Ik wil noteren… | Plaats | Principe |
|-----------------|--------|----------|
| Wat er deze sprint of week gebeurt | Issue tracker (team) of `docs/work/BACKLOG.md` § Nu als **indexregel** + `specs/<slug>.md` via `make spec` (solo) — nooit het plan in de BACKLOG-tabel | P8, P27 |
| Wat ik vandaag deed | `docs/work/logs/YYYY-MM-DD.md` of commitberichten | P8 |
| Een plan voor een grotere feature | `docs/work/specs/<slug>.md`, na merge weg | P8 |
| Een idee voor later | Eén regel in `BACKLOG.md` § Straks, niet in een truth-doc | P8 |
| Een uitgewerkt ontwerp dat moet wachten | `docs/work/specs/<slug>.md`, met de regel in `BACKLOG.md` § Geparkeerd | P8 |
| Het verslag van een overleg | `docs/work/meetings/YYYY-MM-DD-<met-wie>.md`. Wat er beslist is, wordt een ADR | P8, P9 |
| Iets dat ik opleverde (verslag, slides) | `docs/deliverables/` | P8 |
| Een les na een fout van de agent | Eén regel in `AGENTS.md` of de geneste `AGENTS.md` als ze bij elke taak geldt (alleen bij herhaling), anders `docs/agent/lessons.md` | P20 |
| Status van een lopende agent-taak (spine) | Solo: `BACKLOG.md` + dag-log; team: issue/PR — niet alleen in de chatgeschiedenis | P8, P27 |
| Een prompt die ik herhaal | `docs/agent/prompts/<taak>.md` | — |
| Een doc dat vervangen is | `docs/archive/`, met een kopregel "vervangen door …" | P7 |
| Welk model/tooling voor welke taak | Kort in `AGENTS.md` § Werken of `docs/agent/` als het team het echt afspreekt; anders tool-default | P26 |
| Te zware agent-context / harness-overhead | Schrappen uit `AGENTS.md` / rules (deletion test); niet “nog één regel” | P20, P25 |

## Code, config en tests

| Ik wil toevoegen… | Plaats | Details |
|-------------------|--------|---------|
| Een nieuwe app, service of pipeline | `apps/<app>/` | [stacks](stacks.md) |
| Code die twee apps delen (types, ui, config) | `packages/<pakket>/` | [stacks](stacks.md) |
| Een feature in de web-app | `apps/web/src/features/<domein>/` | [stacks §2](stacks.md#2-nextjs-web) |
| Een generieke UI-bouwsteen | `apps/web/src/components/ui/` | [stacks §2](stacks.md#2-nextjs-web) |
| Een API-endpoint | `apps/api/src/<domein>/` | [stacks §3](stacks.md#3-nestjs-api) |
| Pure domeinlogica zonder framework | `<domein>-engine.ts` in de module, of een Python-module | [stacks §3](stacks.md#3-nestjs-api), [stacks §4](stacks.md#4-python-data-ml-analytics) |
| Een test | Naast het bestand (TypeScript-unit) of in `apps/<app>/tests/<soort>/` | [stacks §1](stacks.md#1-elke-app) |
| Een script dat iets controleert | Dat is een test: `tests/smoke/` of `tests/integration/` | [stacks §1](stacks.md#1-elke-app) |
| Een script dat iets maakt (seed, generator) | `apps/<app>/scripts/`, of `scripts/` als het over de hele repo gaat; met een `make`-target | [stacks §1](stacks.md#1-elke-app) |
| Een notebook of probeersel | `apps/<app>/experiments/YYYY-MM-DD-<slug>.ipynb` | [stacks §4](stacks.md#4-python-data-ml-analytics) |
| Een commando voor één app | target `<doel>-<app>` in `apps/<app>/app.mk` | [makefile](makefile.md) |
| Een commando voor het hele project | target in de root-`Makefile` | [makefile](makefile.md) |
| Een commando dat alleen jij gebruikt | `local.mk` (niet in git) | [makefile](makefile.md#regels-voor-eigen-targets) |
| Een sjabloon voor een soort doc | `_template.md` in de map van die docs | [naamgeving](naamgeving.md) |
| Een databasemigratie | `apps/<api>/src/database/migrations/` | [stacks §3](stacks.md#3-nestjs-api) |
| Een omgevingsvariabele | `.env.example` van de app die hem leest (waarde lokaal in `.env`) | [stacks §1](stacks.md#1-elke-app) |
| Deploy-config | In de app (`Dockerfile`, `railpack.json`). Lokale diensten: `docker-compose.yml`. Meer: `infra/` | [skelet](skelet.md) |
| De versie van node of python | `.tool-versions` | [skelet](skelet.md) |
| Een regel voor de agent in één app | Eerst `apps/<app>/AGENTS.md` (elke tool). `.cursor/rules/<app>.mdc` alleen als je Cursor-glob/description nodig hebt die AGENTS niet kan — nooit dezelfde tekst in beide (P7, P25); geen migratie van mensdocs naar `.mdc` | P15 |
| Twijfel: nóg een `.mdc` of meer prose in always-on? | Meestal **geen van beide**: deletion test, of uitvoerbare check (P14). Audit: [cursor-rule](../sjablonen/cursor-rule.md) | P20, P25 |
| Een agent-hook, git-hook of CI-check | `.cursor/hooks.json` · `.pre-commit-config.yaml` · `.github/workflows/` | P14 |

## Data en bestanden

| Ik wil bewaren… | Plaats | Details |
|-----------------|--------|---------|
| Een export die ik aanlever (Health, Hevy, csv van de klant) | `data/raw/<bron>/YYYY-MM-DD/` | [data](data.md) |
| Een dataset of pdf van derden | `data/external/<bron>/`, met een `README.md` over herkomst en licentie | [data](data.md) |
| Een catalogus, mapping of seed die ik met de hand onderhoud | `data/reference/<dataset>/` | [data](data.md) |
| De uitvoer van de pipeline | `data/processed/<dataset>/` (alleen `demo/` in git) | [data](data.md) |
| Wat de app zelf schrijft (uploads per gebruiker) | `data/runtime/` lokaal; in productie een volume of object storage | [data](data.md) |
| Een getraind model | `data/models/<model>/` | [data](data.md) |
| Testdata | `apps/<app>/tests/fixtures/`, synthetisch | [stacks §1](stacks.md#1-elke-app) |
| Een afbeelding die de site toont | `apps/web/public/<gebruik>/` (logo's: `public/brand/`) | [stacks §2](stacks.md#2-nextjs-web) |
| Een afbeelding in een doc, of een masterbestand van een logo | `docs/assets/<onderwerp>-<wat>.<ext>` | [naamgeving](naamgeving.md) |
| Screenshots of rapport van een testrun | `tmp/` of de rapportmap van de testrunner (beide niet in git) | [git](git.md) |
| Klad, een persoonlijke notitie | `tmp/` of buiten de repo | [git](git.md) |

---
