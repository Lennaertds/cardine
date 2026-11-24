# Voorbeeld — GymFreak (solo)

> **Rol:** GymFreak volledig uitgewerkt: wat goed is, wat beter kan, de stappen, en de plaats van elk bestand.
> **Niet hier:** het algemene stappenplan ([INDEX](../INDEX.md)).

Stand van `GymFreak/` in oktober 2026: solo, Next.js (`apps/web`), NestJS (`apps/api`), Python (`apps/analytics`), Postgres via docker compose, gehost op Railway. Verwerkt gezondheidsdata.

## Kit

Droge run in fase 1, het echte script pas in G-3, ná het verhuizen. Geen `--starter` (de apps bestaan), geen `compose` (de `docker-compose.yml` van GymFreak heeft al een healthcheck en vaste poorten), geen `cursor` of `claude` (de router wordt `AGENTS.md`, `.cursorrules` blijft als dunne laag).

```bash
kit/new-project.sh GymFreak --no-git --dry-run \
  --modules herordening,vision,product,design,research,business,agent,archive,runtime \
  --stacks next,nest,python
```

Op de stand van oktober 2026: 53 nieuw (`+`), 7 bestaand (`=`: `.gitignore`, `Makefile`, `README.md`, `.cursorrules`, `apps/{web,api}/.env.example`, `apps/analytics/experiments/README.md`). Elf van de `+` hebben de rol van een bestaand bestand onder een andere naam; die verhuizen eerst, anders staan ze dubbel:

| Kit zou aanmaken | Bestaat al als |
|------------------|----------------|
| `docs/INDEX.md` | `docs/INDEX_DOCS.md` |
| `docs/rules/RULES.md` | `docs/rules/REGELS.md` |
| `docs/architecture/security.md` | `docs/architecture/SECURITY.md` |
| `docs/architecture/ARCHITECTURE.md` | `docs/architecture/PROJECT_STRUCTURE.md` |
| `docs/context/vision.md` | `docs/vision/GYMFREAK.md` |
| `docs/product/PRODUCT.md` | `docs/product/CUT.md` (als § Bewust niet) |
| `docs/design/DESIGN.md` | `docs/design/INDEX.md` |
| `docs/work/BACKLOG.md` | `docs/backlog/INDEX_BACKLOG.md` |
| `docs/agent/lessons.md` | `docs/agent/PROMPT_ENGINEER.md` |
| `docs/research/wantlist.md` | `data/evidence/WANTLIST.md` |
| `apps/*/tests/{integration,smoke,fixtures}/.gitkeep` | `apps/api/test/`, `apps/*/scripts/smoke-*` (na het verhuizen niet meer nodig) |

## Wat al goed is (behouden)

| Wat | Waarom goed | Principe |
|-----|-------------|----------|
| Router → `INDEX_DOCS` → één bestand | Precies het patroon van progressive disclosure | P2 |
| "Kwaliteit boven tokenzuinigheid", maar geen hele map blind laden | Juiste balans tussen relevant en minimaal lezen | P4 |
| `DECISIONS.md` als licht ADR-log, oude entries niet herschrijven, `Status: vervangen` | Kern van P9 is er al | P9 |
| `REGELS.md` apart voor inhoudelijke grenzen | Niet-afleidbaar, op één plek | P6 |
| Status in backlog, logs en besluiten; niet in README of router | Stabiel en vluchtig gescheiden | P8 |
| Regels per app (`.cursor/rules/{web,api,analytics}.mdc`) | Regels dicht bij de code | P15 |
| `PROMPT_ENGINEER.md` met lessen na mislukkingen | Groeien op fouten | P20 |
| `CUT.md`: wat bewust niet gebouwd wordt | Niet-afleidbare kennis | P6 |
| `Makefile` met `start`, `seed`, `status` en duidelijke foutmeldingen ("Docker is not running") | Eén ingang voor commando's | P13 |
| `docker-compose.yml` met healthcheck, poort 5433 | `make up` kan op een gezonde database wachten | P13 |

## Wat beter kan

| # | Bevinding | Probleem | Principe |
|---|-----------|----------|----------|
| G1 | Er is geen check-commando. Lint en typecheck van web, typecheck en unit-tests van api, en pytest van analytics zijn losse scripts. De root-`typecheck` dekt alleen web. Web heeft geen unit-tests, api geen linter, analytics geen ruff of mypy. De Makefile-targets (`api`, `web`, `start`) hebben eigen namen en `help` is met de hand bijgehouden | Een agent weet niet wat "groen" betekent en draait maar een deel | P13 |
| G2 | De router staat in `.cursorrules` (60 regels), met projectregels, schrijfrechten en lessen samen. Er is geen `AGENTS.md` | Andere tools lezen het niet; alles wordt bij elke taak geladen | P2, P15 |
| G3 | De router heeft geen "Nooit"-blok voor security en data. Er is wel een `SECURITY.md`, maar de router verwijst er niet naar | Guardrails ontbreken op de plek die altijd geladen wordt | P17 |
| G4 | `PROJECT_STRUCTURE.md` is voor een groot deel een mappenboom en een tabel "waar zit wat" | Afleidbaar. Het waardevolle deel (vier vlakken, hosting, poorten, "Postgres is de enige writer", AI-schema, wat in git staat) zit ertussen verstopt | P5, P12 |
| G5 | Elke doc heeft een kop van vier regels (`Mode`, `Rol`, `Notatie`, `Structuur`) | Elke lezing betaalt vier regels meta; `Notatie` en `Structuur` zijn schrijfconventies | P3, [naamgeving](../../standaard/naamgeving.md#kopregel-van-een-doc) |
| G6 | Eigen codes: `H N L S D Q`, `ML/F`, `WRITE`/`ASK`, `PE` | Een frisse agent moet ze eerst ontcijferen. Er is geen glossarium | P10 |
| G7 | `DECISIONS.md` telt 68 entries in 610 regels, geldende en vervangen besluiten door elkaar | Vervangen besluiten zijn afleiders; vindbaarheid per besluit is zwak | P7, P9, §18 |
| G8 | De workspace-`.cursorrules` zegt "alleen hits lezen, niet herlezen", de GymFreak-router "bij twijfel meer lezen". De workspace-rule `gymfreak.mdc` verwijst naar `docs/ops/TODO.md`, dat niet bestaat | Context clash en een dode verwijzing in een bestand dat altijd geladen wordt | P7, §8 |
| G9 | Het routerbestand is ook een schrijfrechtentabel (Lees/Schrijf per opdracht) | Waardevol, maar een lang blok dat bij elke taak geladen wordt | P1, P20 |
| G10 | Ruis in git: `.pnpm-store/` (924 bestanden), `tmp/` (22), `*.egg-info/` (5), zes `sync-conflict`-bestanden. Daarnaast een losse `apps/web/.git/` met alleen `hooks/`, en in `apps/analytics` zowel `pytest.ini` als `[tool.pytest.ini_options]` | Afleiders in elke zoekopdracht; twee pytest-configs waarvan er één stil genegeerd wordt | P7, P16 |

## Stappen

Dit is de volgorde van het [stappenplan](../INDEX.md), en die van het [opstartpakket](../../BOOTSTRAP.md): na elke stap `make check`, `git status --short` en een commit door jou. Meet eerst als je wil vergelijken: vijf GymFreak-taken op de huidige stand (C1, [meten](../../meten/INDEX.md)).

### Stap G-0 — Inventaris en plan (alleen lezen)

- De inventaris uit [stap 1](../1-nulmeting-en-inventaris.md), de droge run hierboven, en de tabel [Plaats van elk bestand](#plaats-van-elk-bestand) als verhuistabel in `docs/work/specs/herordening.md`. Dat sjabloon is het enige bestand dat in deze stap bijkomt.
- Data alleen op naam en grootte: `data/user/`, `data/apple_health_export/` en `workouts.csv` zijn gezondheidsdata.

### Stap G-1 — `make check` en de vaste targets (G1)

- Kit-`Makefile` als root (de oude tijdelijk als `Makefile.oud`), `scripts/check-links.sh`, en per app een `app.mk` uit de stack, met de hand gekopieerd. De poorten van GymFreak bovenaan elke `app.mk`: `WEB_PORT ?= 3002`, `API_PORT ?= 3003`.
- Commando's in de `app.mk`'s op de bestaande scripts afstemmen. Wat niet bestaat, staat er niet in; het wordt een backlog-item:

  ```make
  check-web: ## web: lint en types (nog geen unit-tests: backlog)
  	pnpm --filter @gymfreak/web lint
  	pnpm --filter @gymfreak/web typecheck

  check-api: ## api: types en unit-tests (nog geen linter: backlog)
  	pnpm --filter @gymfreak/api typecheck
  	pnpm --filter @gymfreak/api test:unit

  check-analytics: ## analytics: pytest (nog geen ruff of mypy: backlog)
  	pnpm test:analytics

  check-full-web: ## web: e2e met Playwright
  	pnpm --filter @gymfreak/web test:e2e

  check-full-api: ## api: e2e met Postgres
  	pnpm --filter @gymfreak/api test
  ```

  `setup-analytics` wordt `cd apps/analytics && uv sync` (maakt de `.venv` die `test:analytics` gebruikt). `dev-web` blijft `node server.mjs` via `pnpm --filter @gymfreak/web dev`.

- De bestaande targets naar de vaste namen:

  | Oud | Nieuw | Waar |
  |-----|-------|------|
  | `help` (met de hand) | `help` (uit de `##`-uitleg) | root |
  | — | `up` (`docker compose up -d --wait`; de healthcheck staat er al) | root |
  | `down`, `status` | `down`, `status` (`PORTS` uit de `app.mk`'s: 3002, 3003) | root |
  | `api`, `web` | `dev-api`, `dev-web` | `app.mk` |
  | `start` (up + clean + api, wachten, web) | `make dev`; `dev-api` start eerst `up`. Moet web op de API wachten, voeg dan de wachtlus uit `start` toe aan `dev-web` | root + `app.mk` |
  | `clean` (alleen `.next`) | `clean-web`; `make clean` doet alle apps, `tmp/` en `data/interim/` | `app.mk` |
  | `seed` | `seed-api` (`pnpm seed:test-user`) | `app.mk` |
  | `boost` (eigen account, max coins) | `boost` | `local.mk`: gebruikt je eigen account en staat dus niet in git |

- `"check": "make check"` in de root-`package.json`, zodat ook `pnpm check` werkt. `Makefile.oud` weg.

### Stap G-2 — Opruimen (G10)

- `.gitignore`: het kit-blok bovenaan; de huidige GymFreak-regels onderaan tot G-3 klaar is.
- Uit git, niet van schijf: `git rm -r --cached .pnpm-store tmp apps/analytics/src/gymfreak_analytics.egg-info`.
- Weg: de zes `sync-conflict`-bestanden, `regels-van-chacha.md` (leeg), `apps/web/.git/` (alleen `hooks/`, geen repo).
- `apps/analytics/pytest.ini` weg; wat erin staat en nog niet in `[tool.pytest.ini_options]` zit, gaat daarheen.
- `.editorconfig` en `.pre-commit-config.yaml` uit de kit, `pre-commit install`, `pre-commit run --all-files`.

### Stap G-3 — Verhuizen, dan de kit (G4)

1. **Docs**, per map een commit, volgens [Plaats van elk bestand](#plaats-van-elk-bestand). Eerst de elf uit de tabel bij [Kit](#kit). `PROJECT_STRUCTURE.md` wordt `ARCHITECTURE.md` en wordt ingekort:
   - behouden: de vier vlakken, hosting (Railway, `gymfreak.be`, geen basePath), poorten, het stack-overzicht, "Postgres is de enige writer", het AI-schema (Mermaid), wat van `data/` in git staat;
   - schrappen: de boom onder `docs/` (dat is de kaart) en de tabel "waar zit wat" voor zover die naar voor de hand liggende mappen verwijst.
2. **Data** naar de lagen. Vooraf de code die paden noemt: `rg -l 'data/(user|derived|evidence|routines|food|maps)|USER_DATA_DIR' apps` (27 bestanden in oktober 2026, onder meer `apps/api/src/uploads/paths.ts` en `load-demo.ts`). Elk pad mee aanpassen, de default van `USER_DATA_DIR` wordt `data/runtime/user`. Daarna de oude dataregels onderaan `.gitignore` weg.
3. **Apps**: `apps/api/test/` → `tests/{integration,fixtures}/` met de unit-specs naast hun bron, `scripts/smoke-*` → `tests/smoke/`, `apps/analytics/tests/test_*.py` → `tests/unit/`, `apps/web/e2e/` → `tests/e2e/`. De jest-, Playwright- en pytest-config mee aanpassen. De rest van de code: bij aanraking.
4. **De kit** voor wat nu nog ontbreekt (`AGENTS.md`'s, `CONTEXT.md`, `GLOSSARY.md`, `write-rules.md`, `data/README.md`, …), met het commando uit [Kit](#kit) zonder `--dry-run`.

### Stap G-4 — Router en kaart (G2, G3, G9)

- `GymFreak/AGENTS.md` uit de kit, met de huidige inhoud van `.cursorrules` als bron ([stap 6](../6-router-en-kaart.md)). De koppen blijven die van de kit, zodat elk project dezelfde vorm heeft:
  - **Nooit** bovenaan: niet zelf committen; geen user-data uit `data/runtime/` of Health-exports lezen, loggen of tonen; secrets en `.env`; geen GymFreak-code in `Caddie/`; ASK-bestanden alleen na toestemming. Links: `RULES.md` + `security.md` (live); obs/perf/deps/polyglot via INDEX — niet als zes always-on-links.
  - **Commando's:** dagelijks (`check`, `check-full`, `dev`, `seed`, één test, dependency toevoegen, `make help`). Opt-in kit-targets in één zin + `make help`, niet acht tabelrijen.
  - **Werken:** RULES → backlog-item → kaart; UI/PWA → `DESIGN.md` → één craft; feature → `PRODUCT.md`; architectuur → `ARCHITECTURE.md` → één subsystem. Opt-in (Strix/obs/perf/…) alleen via INDEX als de opdracht het noemt — geen keyword-catalogus. Shortcut Doel/In/Out/Test mag. Geen genummerde always-on kit-routes.
  - **Afronden:** zoals nu (test groen → log → backlog → besluit).
- De **schrijf**-tabel naar `docs/agent/write-rules.md`, met één regel in `AGENTS.md`: "Mag ik dit bestand schrijven? → write-rules". Leesroutes per soort opdracht (Product-UI → DESIGN, …) horen in `AGENTS.md` § Werken, niet in write-rules.
- `.cursorrules` blijft, als dunne persoonlijke laag van ≤ 15 regels ([gids](../../sjablonen/cursorrules.md)): de verwijzing naar `AGENTS.md`, Nederlands, kort in de chat, browser-check **na** een UI-fix. Niets dat ook in `AGENTS.md` staat.
- De drie `.cursor/rules/{web,api,analytics}.mdc` gaan op in `apps/{web,api,analytics}/AGENTS.md` en verdwijnen. Daarmee zijn de regels per app ook voor andere tools leesbaar.
- `docs/INDEX.md` (was `INDEX_DOCS.md`) herschrijven met de nieuwe paden; obs/perf/deps/polyglot als opt-in markeren.
- `ARCHITECTURE.md` dun houden (containers/stack/dataflow/hosting/seams). PWA/offline/push → `architecture/runtime-client.md`; JWT/demo/onboarding-details → `architecture/auth.md` (of data-model + legal).

### Stap G-5 — Kop inkorten en glossarium (G5, G6)

- Kop van elke doc: `Rol` + `Niet hier` (+ `Schrijven: vrij | na toestemming` in plaats van `Mode: WRITE/ASK`). `Notatie` en `Structuur` gaan naar `docs/agent/doc-conventions.md`.
- `docs/context/GLOSSARY.md` met de codes: H = gym, N = navigatie, L = core, kalender en insights, S = slaap, D = dieet, Q = ladder, telefoon en showcase, ML/F, ASK = alleen na toestemming, PE = prompt engineer, plus de domeintermen (split, slot, evidence, vlak).

### Stap G-6 — Besluiten opsplitsen (G7), alleen als de meting erom vraagt

- Script: elke `## YYYY-MM-DD — titel` in `DECISIONS.md` wordt `docs/decisions/NNNN-<slug>.md`, met de status uit het blok, chronologisch genummerd.
- `DECISIONS.md` wordt de lijst van **geldende** besluiten (titel + link).
- Eén groot bestand is ook makkelijk te greppen. Doe deze stap alleen als de meting (taak "waarom is X zo") toont dat de agent vervangen besluiten aanhaalt of het besluit niet vindt.

### Stap G-7 — Regels buiten de repo gelijktrekken (G8)

Dit valt buiten `GymFreak/` en dus buiten het opstartpakket; je doet het met de hand of in een aparte taak.

- Workspace-`.cursorrules` (Student_Zelfstandige): het context-budget mag blijven voor de workspace, met de zin "binnen een project wint de router van dat project". "Niet herlezen / alleen hits lezen" afzwakken, want het botst met P4.
- `.cursor/rules/gymfreak.mdc`: de dode verwijzing `docs/ops/TODO.md` vervangen door `docs/work/BACKLOG.md`, en "volg `GymFreak/.cursorrules`" vervangen door "volg `GymFreak/AGENTS.md` en `GymFreak/.cursorrules`". Werk je vanuit de workspace `Student_Zelfstandige`, dan is deze rule wat beide bestanden binnenhaalt.

### Stap G-8 — Meten

Dezelfde vijf taken op de nieuwe stand (C2), vergelijken, en een ADR met de resultaten ([stap 7](../7-meten-en-vastleggen.md)).

### Stap G-9 — Kit-delta (al op de standaard)

Als GymFreak de herordening al achter de rug heeft en alleen nieuwe kitbestanden / router-vorm moet bijtrekken: volg [BOOTSTRAP — Al op de standaard](../../BOOTSTRAP.md#al-op-de-standaard--kit-delta). Modules/stacks:

```bash
bash _bootstrap/kit/new-project.sh . --no-git --dry-run \
  --modules herordening,vision,product,design,research,business,agent,archive,runtime,cursor,observability \
  --stacks next,nest,python
```

(`observability` / `cursor` alleen als je die compose of subagents wilt; docs voor obs/perf/deps/polyglot zitten in kern en komen ook zonder die modules mee bij een verse kit-kopie.)

Merge-checklist specifiek GymFreak:

| Actie | Klaar als |
|-------|-----------|
| `AGENTS.md` dun (INDEX i.p.v. keyword-catalogus) | Geen acht always-on kit-stappen; `make help`/INDEX voor opt-in; projectfeiten (Caddie, Health-data, Postgres writer) blijven |
| Vet `ARCHITECTURE.md` splitsen | Runtime-client + auth (of bestaande satellieten); startdoc ≤ ~100 regels containers/stack/dataflow |
| Nieuwe `+`-docs | Geen `kit/stacks/`-paden, geen “Agent Engineering bron §…”; polyglot zegt “geen `apps/native` tot stack + ADR” |
| BACKLOG § Straks | Strix-install, OTel in apps, perf-budgets, digest-feeds — wat docs beloven maar tooling nog mist |

## Plaats van elk bestand

Elk bestand en elke map heeft hieronder een plaats. Verplaatsingen binnen `apps/` doe je **bij aanraking**: wanneer je toch aan dat bestand werkt, niet in één grote verhuizing.

**Root**

| Nu | Wordt | Waarom |
|----|-------|--------|
| `.cursorrules` | inhoud → `AGENTS.md`, `docs/agent/write-rules.md`, `docs/agent/lessons.md`; zelf blijft hij als dunne persoonlijke laag | G-4 |
| `.cursor/rules/{analytics,api,web}.mdc` | `apps/{analytics,api,web}/AGENTS.md`; de `.mdc`'s weg | G-4, P15 |
| `README.md`, `package.json`, `pnpm-workspace.yaml`, `pnpm-lock.yaml`, `docker-compose.yml` | blijft | — |
| `Makefile` | [kit/kern/Makefile](../../kit/kern/Makefile) + `apps/<app>/app.mk`; oude targets omgezet, `boost` naar `local.mk` | G-1 |
| `.gitignore` | [kit/kern/.gitignore](../../kit/kern/.gitignore), met de GymFreak-specifieke regels onderaan | [git](../../standaard/git.md) |
| — | `.editorconfig`, `.pre-commit-config.yaml` (nieuw, uit de kit) | G-2, P14 |
| `regels-van-chacha.md` (leeg) | weg | G-2, regel 3 |
| `.pnpm-store/` (924 bestanden in git) | `git rm -r --cached .pnpm-store` | G-2; staat al in `.gitignore`, maar werd eerder gecommit |
| `tmp/` (22 screenshots en een rapport in git) | `git rm -r --cached tmp` | G-2, regel 1 |

**docs/**

| Nu | Wordt | Waarom |
|----|-------|--------|
| `INDEX_DOCS.md` | `docs/INDEX.md` | [naamgeving](../../standaard/naamgeving.md) |
| — | `context/CONTEXT.md`, `context/GLOSSARY.md` (nieuw; codes H, N, L, S, D, Q, ML/F, ASK, PE en de domeinen) | G-5 |
| `vision/GYMFREAK.md` | `context/vision.md` | [skelet](../../standaard/skelet.md) |
| `rules/REGELS.md` | `rules/RULES.md` | [naamgeving](../../standaard/naamgeving.md) |
| `product/CUT.md` | `product/PRODUCT.md` § Bewust niet, plus de tabel van de domeinen | [bestanden](../../standaard/bestanden.md) |
| `product/{D-diet,H-gym,L-calendar,L-core,L-insights,N-nav,Q-ladder,Q-phone,Q-showcase,S-sleep}.md` | blijft | code vooraan mag ([naamgeving](../../standaard/naamgeving.md)) |
| `design/INDEX.md` | `design/DESIGN.md` | [naamgeving](../../standaard/naamgeving.md) |
| `design/{desktop,iphone,shared}/**` | blijft | platformmappen ([skelet](../../standaard/skelet.md)) |
| `architecture/PROJECT_STRUCTURE.md` | `architecture/ARCHITECTURE.md`, ingekort | G-3 |
| `architecture/TECH.md` | stack en runtime → `ARCHITECTURE.md`; data → `data-model.md`; engine → `architecture/engine.md`; routelijsten schrappen (afleidbaar uit de controllers) | P5, P7 |
| `architecture/SECURITY.md` | `architecture/security.md` | [naamgeving](../../standaard/naamgeving.md) |
| `architecture/{DATA_IMPORT,LLM,ML}.md` | `architecture/{data-import,llm,ml}.md` | [naamgeving](../../standaard/naamgeving.md) |
| `architecture/TOPICLIJST.md`, `TOPICLIJST_DEKKING.md` | `research/topics.md`, `research/topics-coverage.md` | domeinkennis, geen architectuur |
| `architecture/recovery_factors.md` | `research/recovery-factors.md` | idem |
| `agent/PROMPT_ENGINEER.md` | `agent/lessons.md`; wat bij elke taak geldt → `AGENTS.md` | P20 |
| `agent/PROMPT_ENGINEER_ARCHIVE.md` | `archive/prompt-engineer-archive.md` | [skelet](../../standaard/skelet.md) |
| Lees/Schrijf-tabel uit `.cursorrules` | `agent/write-rules.md` | G-4 |
| `Notatie` en `Structuur` uit de doc-koppen | `agent/doc-conventions.md` | G-5 |
| `archive/AI_KLUIS.md` (ontwerp dat wacht) | `work/specs/ai-kluis.md` + regel in `BACKLOG.md` § Geparkeerd | geparkeerd is geen vervangen ([waar hoort dit](../../standaard/waar-hoort-dit.md)) |
| `backlog/INDEX_BACKLOG.md` | `work/BACKLOG.md` | [skelet](../../standaard/skelet.md) |
| `backlog/{ML,NEW_FEATURES,UI}/<X>-<slug>.md` | `work/specs/<slug>.md`; de categorie (ML, feature, UI) als kolom in `BACKLOG.md` | een item dat van categorie wisselt, verhuist dan niet |
| `backlog/NEW_FEATURES/PERSONAL-SITE.md` | naar een eigen projectmap | regel 4; het bestand zegt dat zelf |
| `business/{BUSINESSPLAN,LEGAL}.md` | `business/{businessplan,legal}.md` | [naamgeving](../../standaard/naamgeving.md) |
| `decisions/DECISIONS.md` | `decisions/DECISIONS.md` als lijst van geldende besluiten + `NNNN-<slug>.md` | G-6 |
| `logs/YYYY-MM-DD.md` | `work/logs/` | [skelet](../../standaard/skelet.md) |
| `logs/INDEX_LOGS.md` | weg | `ls` volstaat (P5) |

**data/**

| Nu | Wordt | Waarom |
|----|-------|--------|
| `user/` (gitignored, schrijft de API) | `runtime/user/`; default in `apps/api/src/uploads/paths.ts`, overschrijfbaar met `USER_DATA_DIR` | app-runtime, geen bron ([data](../../standaard/data.md)) |
| `apple_health_export/`, `workouts.csv` | `raw/apple-health/YYYY-MM-DD/`, `raw/hevy/YYYY-MM-DD/` | [data](../../standaard/data.md) |
| `derived/demo/` | `processed/demo/`; paden in `load-demo.ts`, de analytics-`pack`-stap en `derive:demo` mee aanpassen | [data](../../standaard/data.md) |
| `evidence/{sources,passages,priors}.yaml` | `reference/evidence/` | met de hand samengesteld |
| `evidence/pdfs/` (lokaal) + `pdfs/INDEX.md` | `external/evidence-pdfs/` + `README.md` | licentie van derden |
| `evidence/{txt,drafts}/`, `index.duckdb` | `interim/evidence/` | herbouwbaar |
| `evidence/WANTLIST.md` | `docs/research/wantlist.md` | tekst, geen data |
| `food/`, `maps/`, `routines/*.yaml`, `tips/` | `reference/{food,maps,routines,tips}/` | met de hand samengesteld |
| `routines/RULES.md` (programmeerregels van de engine) | `docs/product/programming-rules.md` | productgedrag, geen data |
| `GymFreakProjectStructuurEngineering.png`, `IMG_0086.PNG`, `IMG_0087.PNG` | `docs/assets/` met een beschrijvende naam, of weg | regel 8 |
| `.gitkeep`, `evidence/.gitkeep` | weg | de mappen zijn niet leeg |

**apps/analytics/**

| Nu | Wordt | Waarom |
|----|-------|--------|
| `README.md`, `pyproject.toml`, `uv.lock`, `src/gymfreak_analytics/*.py` | blijft | [stacks §4](../../standaard/stacks.md#4-python-data-ml-analytics) |
| `pytest.ini` | weg; `[tool.pytest.ini_options]` in `pyproject.toml` bestaat al, aanvullen met wat ontbreekt | G-2, één config-plek |
| `src/gymfreak_analytics.egg-info/` | `git rm -r --cached`; staat in het `.gitignore`-blok | G-2, build-output |
| `tests/test_*.py` | `tests/unit/` | [stacks §1](../../standaard/stacks.md#1-elke-app) |
| `tests/fixtures/` | blijft; nagaan dat `hevy_user.csv` en de Health-XML synthetisch zijn | [data](../../standaard/data.md) |
| `tests/test_routines.sync-conflict-*.py` | weg | G-2, regel 3 |
| `experiments/` | blijft; nieuwe bestanden met datum vooraan; resultaten → `docs/research/experiments/` | [stacks §4](../../standaard/stacks.md#4-python-data-ml-analytics) |

**apps/api/**

| Nu | Wordt | Waarom |
|----|-------|--------|
| `.env.example`, `Dockerfile`, `railpack.json`, `nest-cli.json`, `tsconfig*.json`, `package.json`, `README.md` | blijft | [stacks §1](../../standaard/stacks.md#1-elke-app) |
| `src/main.ts`, `src/app.module.ts` | blijft | [stacks §3](../../standaard/stacks.md#3-nestjs-api) |
| `src/{configure-app,load-env,security,health.controller}.ts` | `src/common/` | [stacks §3](../../standaard/stacks.md#3-nestjs-api) |
| `src/{database,column-types}.ts` | `src/database/` | [stacks §3](../../standaard/stacks.md#3-nestjs-api) |
| `src/<domein>/` (account, auth, demo, diet, feed, life, lifestyle, plans, profile, progress, push, sleep, social, tips, uploads, users) | blijft | [stacks §3](../../standaard/stacks.md#3-nestjs-api) |
| `test/*.e2e-spec.ts` | `tests/integration/` | [stacks §1](../../standaard/stacks.md#1-elke-app) |
| `test/*.spec.ts` (unit, bv. `diet-macros`, `split-score`) | naast het geteste bestand in `src/<domein>/` | [stacks §3](../../standaard/stacks.md#3-nestjs-api) |
| `test/{fixtures,setup-env.ts,jest-*.json}` | `tests/fixtures/`, `tests/setup-env.ts`, `jest.config.ts` op app-root | [stacks §3](../../standaard/stacks.md#3-nestjs-api) |
| `scripts/{seed-test-user,delete-user}.mjs` | blijft | maakt iets |
| `scripts/smoke-{auth,upload}.mjs` | `tests/smoke/` | controleert iets |

**apps/web/**

| Nu | Wordt | Waarom |
|----|-------|--------|
| configs, `server.mjs`, `package.json`, `README.md` | blijft | [stacks §2](../../standaard/stacks.md#2-nextjs-web) |
| `.git/` (alleen `hooks/`, geen repo) | weg | G-2 |
| `public/{favicon.ico,icon*,apple-touch-icon.png,og.jpg,sw.js,google*.html}` | blijft op de root van `public/` | browsers en crawlers zoeken ze daar |
| `public/{brand,about,themes,showcase}/` | blijft | per gebruik |
| `public/{next,vercel,file,globe,window}.svg` | weg als ze ongebruikt zijn (`rg` eerst) | boilerplate van create-next-app |
| `public/**/*.sync-conflict-*` | weg | G-2, regel 3 |
| `src/app/**` | blijft; pagina's dun houden | [stacks §2](../../standaard/stacks.md#2-nextjs-web) |
| `src/components/*.tsx` (119 bestanden, plat) | domein → `features/<domein>/components/`; generiek (confirm-dialog, date-field, drag-list, clock-input) → `components/ui/`; chrome en navigatie → `components/layout/` | bij aanraking |
| `src/components/showcase/` | `features/showcase/` | [stacks §2](../../standaard/stacks.md#2-nextjs-web) |
| `src/lib/<domein>.ts` (diet, sleep, plans, feed, progress, …) | `features/<domein>/` | [stacks §2](../../standaard/stacks.md#2-nextjs-web) |
| `src/lib/{api,haptics,parse-decimal,routes,site,…}.ts`, `src/lib/i18n/` | blijft in `lib/` | generiek |
| `src/lib/propose-split.selftest.mts` | `features/plans/propose-split.test.ts` met Vitest | [stacks §2](../../standaard/stacks.md#2-nextjs-web) |
| `src/hooks/` | generiek blijft; domeinhooks → `features/<domein>/hooks/` | [stacks §2](../../standaard/stacks.md#2-nextjs-web) |
| `src/types/` | blijft | [stacks §2](../../standaard/stacks.md#2-nextjs-web) |
| `e2e/*.spec.ts` | `tests/e2e/` (`testDir` in `playwright.config.ts`) | [stacks §1](../../standaard/stacks.md#1-elke-app) |
| `scripts/smoke-*.mjs`, `scripts/check-pwa-logic.mts` | `tests/smoke/` | controleert iets |
| `scripts/{gen-*,persona-probe}.mjs` | blijft; uitvoer naar `tmp/` | maakt iets |

---
