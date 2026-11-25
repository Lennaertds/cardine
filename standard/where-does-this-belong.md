# Where does this belong?

> **Role:** Lookup table: I want to note, add or keep something — where does it go?
> **Not here:** why ([principles](../bron/principes.md)), auditing an existing project ([classifying](../existing-project/2-classificeren.md)).

## Knowledge and decisions

| I want to note… | Place | Principle |
|-----------------|-------|-----------|
| What the project is and who it is for | `docs/context/CONTEXT.md` | P6 |
| Where it is heading in the long term | `docs/context/vision.md` | P8 |
| The assignment from school or client | `docs/context/assignment.md` | P6 |
| What a domain term or project code means | `docs/context/GLOSSARY.md` | P10 |
| That something is never allowed (as content) | `docs/rules/RULES.md` | P6 |
| That something is never allowed and that can be enforced | A hook, test or CI check, plus one line in `AGENTS.md` | P14 |
| Business intent that tests can miss ("discounts may not be switched off silently") | `docs/product/` or `CONTEXT.md`, plus a short line in `AGENTS.md` if it applies to every task | P6, P22 |
| Module boundaries / seams where AI may safely touch | `docs/architecture/ARCHITECTURE.md` (the seams + what sits behind them), tests on those seams | P12, P23 |
| How a feature behaves for the user | `docs/product/<domain>.md` | P11 |
| What we deliberately do not build | `docs/product/PRODUCT.md` § Deliberately not (without `product/`: `CONTEXT.md` § Deliberately not) | P6 |
| How something should look or feel | `docs/design/<topic>.md` (via `DESIGN.md`) | P11 |
| A read route that must fire on every task of that type (UI → DESIGN, feature → PRODUCT, …) | One line in `AGENTS.md` § Works; detail in the map (`DESIGN.md` / `PRODUCT.md` / …) | P2, P3 |
| Opt-in engineering (Strix, obs, perf, deps, polyglot, radar) | Only the INDEX + `make help`; in `AGENTS.md` at most one sentence "if the task names it" — **no** keyword catalogue, no always-on Works step | P2, P25 |
| PWA / offline / push / chrome poll | `architecture/runtime-client.md` (or the project name), do not dump it into ARCHITECTURE | P5, P12 |
| Auth-flow details (JWT TTL, demo account, onboarding keys) | `architecture/auth.md` and/or data model + legal; ARCHITECTURE keeps the principles | P5, P12 |
| Which agent role goes with which kind of task, and when to use a subagent | [agent-rollen.md](agent-rollen.md); kit: `.cursor/agents/<role>.md` | P24, P25 |
| A Cursor subagent (its own context for one role) | `.cursor/agents/<role>.md` (module `cursor` plus optionally `design`/`product`/`research`) | P24 |
| Which paths the agent may write | `docs/agent/write-rules.md` (write permissions only, no read routes) | P2 |
| How two apps talk to each other | `docs/architecture/ARCHITECTURE.md` | P12 |
| The database schema | `docs/architecture/data-model.md`, or point to the migrations if the schema is readable there | P5, P7 |
| How privacy and security are handled technically | `docs/architecture/security.md` | P17 |
| Active security scan (Strix) | `docs/architecture/security.md` + `docs/how-to/security-scan.md`; run via `make security-scan*` | P13, P17 |
| Logs, metrics, traces, SLOs, Grafana | `docs/architecture/observability.md`; stack via module `observability` | P13 |
| Latency budgets, anti-patterns, bench | `docs/architecture/performance.md`; `make perf-check` / `make bench` | P13 |
| Dependency CVEs, package ritual, faster alternatives | `docs/architecture/dependencies.md` + `docs/how-to/deps-audit.md`; `make deps-audit` / via `check-full` | P13, P17 |
| Extra language / Rust/C / FFI / "is native allowed?" | `docs/architecture/polyglot.md`; ADR; `--stacks rust` / `c` → `apps/native` / `native-c`; `polyglot-check` / `check-native*` | P13, P23 |
| Soft vs hard native FFI in CI | `docs/how-to/native-ci.md`; `NATIVE_STRICT` / `make check-full` / team `native.yml` | P13, P14 |
| Revisiting a tech choice (Adopt/Trial/Assess/Hold) | `docs/research/radar.md` (module `research`); `make radar-reminder` / `radar-check` | P5, P8, P28 |
| Inbound feed / changelog dump | Raw: `data/external/digest/`; proposal: `digest/proposals/`; curate → radar/wantlist; never a feed as SSOT | P5, P28 |
| Something the kit deliberately does not deliver yet (an extension) | `## Deliberately incomplete` (P28) in the affected architecture/radar doc; question or BACKLOG — do not make it up silently | P28 |
| A pitfall ("this column is VARCHAR, so convert ï") | At the subsystem in `architecture/<x>.md`, and a short line in `AGENTS.md` if you can hit it on every task | P6 |
| What the literature says about a topic | `docs/research/<topic>.md`. The source itself: `data/external/` | P11 |
| A source I still want | `docs/research/wantlist.md` | P8 |
| The result of an experiment | `docs/research/experiments/YYYY-MM-DD-<slug>.md` | P6 |
| Why we chose X over Y | `docs/decisions/NNNN-x-over-y.md` | P9 |
| What a function or module does | A docstring in the code, not in docs | P5, P7 |
| A step-by-step procedure I run regularly | `docs/how-to/<task>.md`, or better a script with a `make` target | P11, P13 |
| Business plan, pricing, terms | `docs/business/<topic>.md` | — |

## Work and status

| I want to note… | Place | Principle |
|-----------------|-------|-----------|
| What happens this sprint or week | Issue tracker (team) or `docs/work/BACKLOG.md` § Now as an **index line** + `specs/<slug>.md` via `make spec` (solo) — never the plan inside the BACKLOG table | P8, P27 |
| What I did today | `docs/work/logs/YYYY-MM-DD.md` or commit messages | P8 |
| A plan for a larger feature | `docs/work/specs/<slug>.md`, deleted after merge | P8 |
| An idea for later | One line in `BACKLOG.md` § Later, not in a truth doc | P8 |
| A worked-out design that has to wait | `docs/work/specs/<slug>.md`, with the line in `BACKLOG.md` § Parked | P8 |
| The minutes of a meeting | `docs/work/meetings/YYYY-MM-DD-<with-whom>.md`. What was decided becomes an ADR | P8, P9 |
| Something I delivered (report, slides) | `docs/deliverables/` | P8 |
| A lesson after an agent mistake | One line in `AGENTS.md` or the nested `AGENTS.md` if it applies to every task (only on repetition), otherwise `docs/agent/lessons.md` | P20 |
| Status of a running agent task (spine) | Solo: `BACKLOG.md` + daily log; team: issue/PR — not only in the chat history | P8, P27 |
| A prompt I reuse | `docs/agent/prompts/<task>.md` | — |
| A doc that has been replaced | `docs/archive/`, with a header line "replaced by …" | P7 |
| Which model/tooling for which task | Briefly in `AGENTS.md` § Works or `docs/agent/` if the team really agrees on it; otherwise the tool default | P26 |
| Too-heavy agent context / harness overhead | Cut it from `AGENTS.md` / rules (deletion test); not "one more line" | P20, P25 |

## Code, config and tests

| I want to add… | Place | Details |
|----------------|-------|---------|
| A new app, service or pipeline | `apps/<app>/` | [stacks](stacks.md) |
| Code that two apps share (types, ui, config) | `packages/<package>/` | [stacks](stacks.md) |
| A feature in the web app | `apps/web/src/features/<domain>/` | [stacks §2](stacks.md#2-nextjs-web) |
| A generic UI building block | `apps/web/src/components/ui/` | [stacks §2](stacks.md#2-nextjs-web) |
| An API endpoint | `apps/api/src/<domain>/` | [stacks §3](stacks.md#3-nestjs-api) |
| Pure domain logic without a framework | `<domain>-engine.ts` in the module, or a Python module | [stacks §3](stacks.md#3-nestjs-api), [stacks §4](stacks.md#4-python-data-ml-analytics) |
| A test | Next to the file (TypeScript unit) or in `apps/<app>/tests/<kind>/` | [stacks §1](stacks.md#1-every-app) |
| A script that checks something | That is a test: `tests/smoke/` or `tests/integration/` | [stacks §1](stacks.md#1-every-app) |
| A script that makes something (seed, generator) | `apps/<app>/scripts/`, or `scripts/` if it covers the whole repo; with a `make` target | [stacks §1](stacks.md#1-every-app) |
| A notebook or experiment | `apps/<app>/experiments/YYYY-MM-DD-<slug>.ipynb` | [stacks §4](stacks.md#4-python-data-ml-analytics) |
| A command for one app | target `<goal>-<app>` in `apps/<app>/app.mk` | [makefile](makefile.md) |
| A command for the whole project | target in the root `Makefile` | [makefile](makefile.md) |
| A command only you use | `local.mk` (not in git) | [makefile](makefile.md#rules-for-your-own-targets) |
| A template for a kind of doc | `_template.md` in the folder of those docs | [naming](naamgeving.md) |
| A database migration | `apps/<api>/src/database/migrations/` | [stacks §3](stacks.md#3-nestjs-api) |
| An environment variable | `.env.example` of the app that reads it (value locally in `.env`) | [stacks §1](stacks.md#1-every-app) |
| Deploy config | In the app (`Dockerfile`, `railpack.json`). Local services: `docker-compose.yml`. More: `infra/` | [skeleton](skelet.md) |
| The node or python version | `.tool-versions` | [skeleton](skelet.md) |
| An agent rule for one app | `apps/<app>/AGENTS.md` first (every tool). `.cursor/rules/<app>.mdc` only if you need a Cursor glob/description that AGENTS cannot do — never the same text in both (P7, P25); no migration of human docs to `.mdc` | P15 |
| Doubt: yet another `.mdc` or more prose in always-on? | Usually **neither**: deletion test, or an executable check (P14). Audit: [cursor-rule](../sjablonen/cursor-rule.md) | P20, P25 |
| An agent hook, git hook or CI check | `.cursor/hooks.json` · `.pre-commit-config.yaml` · `.github/workflows/` | P14 |

## Data and files

| I want to keep… | Place | Details |
|-----------------|-------|---------|
| An export I provide (Health, Hevy, the client's csv) | `data/raw/<source>/YYYY-MM-DD/` | [data](data.md) |
| A dataset or pdf from a third party | `data/external/<source>/`, with a `README.md` about origin and licence | [data](data.md) |
| A catalogue, mapping or seed I maintain by hand | `data/reference/<dataset>/` | [data](data.md) |
| The pipeline's output | `data/processed/<dataset>/` (only `demo/` in git) | [data](data.md) |
| What the app writes itself (uploads per user) | `data/runtime/` locally; a volume or object storage in production | [data](data.md) |
| A trained model | `data/models/<model>/` | [data](data.md) |
| Test data | `apps/<app>/tests/fixtures/`, synthetic | [stacks §1](stacks.md#1-every-app) |
| An image the site shows | `apps/web/public/<use>/` (logos: `public/brand/`) | [stacks §2](stacks.md#2-nextjs-web) |
| An image in a doc, or a logo master file | `docs/assets/<topic>-<what>.<ext>` | [naming](naamgeving.md) |
| Screenshots or a report from a test run | `tmp/` or the test runner's report folder (neither in git) | [git](git.md) |
| A draft, a personal note | `tmp/` or outside the repo | [git](git.md) |

---
