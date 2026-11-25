# Example — GymFreak (solo)

> **Role:** GymFreak worked out in full: what is good, what can improve, the steps, and the place of every file.
> **Not here:** the general step-by-step plan ([INDEX](../INDEX.md)).

State of `GymFreak/` in October 2026: solo, Next.js (`apps/web`), NestJS (`apps/api`), Python (`apps/analytics`), Postgres via docker compose, hosted on Railway. Handles health data.

## Kit

Dry run in phase 1, the real script only in G-3, *after* the move. No `--starter` (the apps exist), no `compose` (GymFreak's `docker-compose.yml` already has a healthcheck and fixed ports), no `cursor` or `claude` (the router becomes `AGENTS.md`, `.cursorrules` stays as a thin layer).

```bash
kit/new-project.sh GymFreak --no-git --dry-run \
  --modules reorganise,vision,product,design,research,business,agent,archive,runtime \
  --stacks next,nest,python
```

As of October 2026: 53 new (`+`), 7 existing (`=`: `.gitignore`, `Makefile`, `README.md`, `.cursorrules`, `apps/{web,api}/.env.example`, `apps/analytics/experiments/README.md`). Eleven of the `+` have the role of an existing file under another name; those move first, otherwise they appear twice:

| Kit would create | Already exists as |
|------------------|----------------|
| `docs/INDEX.md` | `docs/INDEX_DOCS.md` |
| `docs/rules/RULES.md` | `docs/rules/REGELS.md` |
| `docs/architecture/security.md` | `docs/architecture/SECURITY.md` |
| `docs/architecture/ARCHITECTURE.md` | `docs/architecture/PROJECT_STRUCTURE.md` |
| `docs/context/vision.md` | `docs/vision/GYMFREAK.md` |
| `docs/product/PRODUCT.md` | `docs/product/CUT.md` (as § Deliberately not) |
| `docs/design/DESIGN.md` | `docs/design/INDEX.md` |
| `docs/work/BACKLOG.md` | `docs/backlog/INDEX_BACKLOG.md` |
| `docs/agent/lessons.md` | `docs/agent/PROMPT_ENGINEER.md` |
| `docs/research/wantlist.md` | `data/evidence/WANTLIST.md` |
| `apps/*/tests/{integration,smoke,fixtures}/.gitkeep` | `apps/api/test/`, `apps/*/scripts/smoke-*` (not needed any more after the move) |

## What is already good (keep it)

| What | Why it is good | Principle |
|-----|-------------|----------|
| Router → `INDEX_DOCS` → one file | Exactly the progressive-disclosure pattern | P2 |
| "Quality over token thrift", but never loading a whole folder blindly | The right balance between reading what is relevant and reading minimally | P4 |
| `DECISIONS.md` as a light ADR log, old entries not rewritten, `Status: superseded` | The core of P9 is already there | P9 |
| `REGELS.md` separately for content boundaries | Not derivable, in one place | P6 |
| Status in backlog, logs and decisions; not in the README or the router | Stable and transient kept apart | P8 |
| Rules per app (`.cursor/rules/{web,api,analytics}.mdc`) | Rules close to the code | P15 |
| `PROMPT_ENGINEER.md` with lessons after failures | Growing on mistakes | P20 |
| `CUT.md`: what is deliberately not built | Knowledge that cannot be derived | P6 |
| `Makefile` with `start`, `seed`, `status` and clear error messages ("Docker is not running") | One entry point for commands | P13 |
| `docker-compose.yml` with a healthcheck, port 5433 | `make up` can wait for a healthy database | P13 |

## What can improve

| # | Finding | Problem | Principle |
|---|-----------|----------|----------|
| G1 | There is no check command. Web lint and typecheck, API typecheck and unit tests, and analytics pytest are separate scripts. The root `typecheck` only covers web. Web has no unit tests, the API no linter, analytics no ruff or mypy. The Makefile targets (`api`, `web`, `start`) have their own names and `help` is maintained by hand | An agent does not know what "green" means and runs only part of it | P13 |
| G2 | The router sits in `.cursorrules` (60 lines), with project rules, write permissions and lessons together. There is no `AGENTS.md` | Other tools do not read it; everything is loaded on every task | P2, P15 |
| G3 | The router has no "Never" block for security and data. There is a `SECURITY.md`, but the router does not link to it | Guardrails are missing where they are always loaded | P17 |
| G4 | `PROJECT_STRUCTURE.md` is largely a folder tree and a "where is what" table | Derivable. The valuable part (the four surfaces, hosting, ports, "Postgres is the only writer", the AI schema, what is in git) is hidden in between | P5, P12 |
| G5 | Every doc has a four-line header (`Mode`, `Rol`, `Notatie`, `Structuur`) | Every read pays four lines of meta; `Notatie` and `Structuur` are writing conventions | P3, [naming](../../standard/naamgeving.md#doc-header) |
| G6 | Own codes: `H N L S D Q`, `ML/F`, `WRITE`/`ASK`, `PE` | A fresh agent has to decode them first. There is no glossary | P10 |
| G7 | `DECISIONS.md` has 68 entries in 610 lines, active and superseded decisions mixed together | Superseded decisions are distractions; findability per decision is weak | P7, P9, §18 |
| G8 | The workspace `.cursorrules` says "read hits only, do not re-read", the GymFreak router says "in doubt, read more". The workspace rule `gymfreak.mdc` points at `docs/ops/TODO.md`, which does not exist | Context clash and a dead reference in a file that is always loaded | P7, §8 |
| G9 | The router file is also a write-permission table (Read/Write per task) | Valuable, but a long block loaded on every task | P1, P20 |
| G10 | Noise in git: `.pnpm-store/` (924 files), `tmp/` (22), `*.egg-info/` (5), six `sync-conflict` files. Plus a stray `apps/web/.git/` with only `hooks/`, and in `apps/analytics` both a `pytest.ini` and `[tool.pytest.ini_options]` | Distractions in every search; two pytest configs, one of which is silently ignored | P7, P16 |

## Steps

This is the order of the [step-by-step plan](../INDEX.md), and of the [bootstrap package](../../BOOTSTRAP.md): after every step `make check`, `git status --short` and a commit by you. Measure first if you want to compare: five GymFreak tasks on the current state (C1, [meten](../../measurement/INDEX.md)).

### Step G-0 — Inventory and plan (read only)

- The inventory from [step 1](../1-baseline-and-inventory.md), the dry run above, and the table [Place of every file](#place-of-every-file) as the move table in `docs/work/specs/reorganise.md`. That template is the only file added in this step.
- Data by name and size only: `data/user/`, `data/apple_health_export/` and `workouts.csv` are health data.

### Step G-1 — `make check` and the fixed targets (G1)

- Kit `Makefile` as the root (the old one temporarily as `Makefile.old`), `scripts/check-links.sh`, and an `app.mk` per app from the stack, copied by hand. GymFreak's ports at the top of each `app.mk`: `WEB_PORT ?= 3002`, `API_PORT ?= 3003`.
- Align the commands in the `app.mk` files to the existing scripts. What does not exist is left out; it becomes a backlog item:

  ```make
  check-web: ## web: lint and types (no unit tests yet: backlog)
  	pnpm --filter @gymfreak/web lint
  	pnpm --filter @gymfreak/web typecheck

  check-api: ## api: types and unit tests (no linter yet: backlog)
  	pnpm --filter @gymfreak/api typecheck
  	pnpm --filter @gymfreak/api test:unit

  check-analytics: ## analytics: pytest (no ruff or mypy yet: backlog)
  	pnpm test:analytics

  check-full-web: ## web: e2e with Playwright
  	pnpm --filter @gymfreak/web test:e2e

  check-full-api: ## api: e2e with Postgres
  	pnpm --filter @gymfreak/api test
  ```

  `setup-analytics` becomes `cd apps/analytics && uv sync` (creates the `.venv` that `test:analytics` uses). `dev-web` stays `node server.mjs` via `pnpm --filter @gymfreak/web dev`.

- Bring the existing targets to the fixed names:

  | Old | New | Where |
  |-----|-----|-------|
  | `help` (by hand) | `help` (from the `##` explanations) | root |
  | — | `up` (`docker compose up -d --wait`; the healthcheck is already there) | root |
  | `down`, `status` | `down`, `status` (`PORTS` uit de `app.mk`'s: 3002, 3003) | root |
  | `api`, `web` | `dev-api`, `dev-web` | `app.mk` |
  | `start` (up + clean + api, wait, web) | `make dev`; `dev-api` runs `up` first. If web must wait for the API, add the wait loop from `start` to `dev-web` | root + `app.mk` |
  | `clean` (only `.next`) | `clean-web`; `make clean` does all apps, `tmp/` and `data/interim/` | `app.mk` |
  | `seed` | `seed-api` (`pnpm seed:test-user`) | `app.mk` |
  | `boost` (own account, max coins) | `boost` | `local.mk`: uses your own account and is therefore not in git |

- `"check": "make check"` in the root `package.json`, so that `pnpm check` works too. `Makefile.old` gone.

### Step G-2 — Clean up (G10)

- `.gitignore`: the kit block on top; the current GymFreak rules at the bottom until G-3 is done.
- Out of git, not from disk: `git rm -r --cached .pnpm-store tmp apps/analytics/src/gymfreak_analytics.egg-info`.
- Gone: the six `sync-conflict` files, `regels-van-chacha.md` (empty), `apps/web/.git/` (only `hooks/`, not a repo).
- `apps/analytics/pytest.ini` gone; what is in it and not yet in `[tool.pytest.ini_options]` goes there.
- `.editorconfig` and `.pre-commit-config.yaml` from the kit, `pre-commit install`, `pre-commit run --all-files`.

### Step G-3 — Move, then the kit (G4)

1. **Docs**, one commit per folder, following [Place of every file](#place-of-every-file). The eleven from the table at [Kit](#kit) first. `PROJECT_STRUCTURE.md` becomes `ARCHITECTURE.md` and is shortened:
   - keep: the four surfaces, hosting (Railway, `gymfreak.be`, no basePath), ports, the stack overview, "Postgres is the only writer", the AI schema (Mermaid), what from `data/` is in git;
   - cut: the tree under `docs/` (that is the map) and the "where is what" table as far as it points at obvious folders.
2. **Data** into the layers. First the code that names paths: `rg -l 'data/(user|derived|evidence|routines|food|maps)|USER_DATA_DIR' apps` (27 files in October 2026, including `apps/api/src/uploads/paths.ts` and `load-demo.ts`). Change every path along the way; the default of `USER_DATA_DIR` becomes `data/runtime/user`. Then remove the old data rules at the bottom of `.gitignore`.
3. **Apps**: `apps/api/test/` → `tests/{integration,fixtures}/` with the unit specs next to their source, `scripts/smoke-*` → `tests/smoke/`, `apps/analytics/tests/test_*.py` → `tests/unit/`, `apps/web/e2e/` → `tests/e2e/`. Adapt the jest, Playwright and pytest config along. The rest of the code: on touch.
4. **The kit** for what is still missing (`AGENTS.md` files, `CONTEXT.md`, `GLOSSARY.md`, `write-rules.md`, `data/README.md`, …), with the command from [Kit](#kit) without `--dry-run`.

### Step G-4 — Router and map (G2, G3, G9)

- `GymFreak/AGENTS.md` from the kit, with the current content of `.cursorrules` as the source ([step 6](../6-router-and-map.md)). The headings stay the kit's, so every project has the same shape:
  - **Never** at the top: do not commit yourself; do not read, log or show user data from `data/runtime/` or Health exports; secrets and `.env`; no GymFreak code in `Caddie/`; ASK files only after permission. Links: `RULES.md` + `security.md` (live); obs/perf/deps/polyglot via INDEX — not as six always-on links.
  - **Commands:** daily (`check`, `check-full`, `dev`, `seed`, one test, adding a dependency, `make help`). Opt-in kit targets in one sentence + `make help`, not eight table rows.
  - **Working:** RULES → backlog item → map; UI/PWA → `DESIGN.md` → one craft; feature → `PRODUCT.md`; architecture → `ARCHITECTURE.md` → one subsystem. Opt-in (Strix/obs/perf/…) only via INDEX when the task names it — no keyword catalogue. A Goal/In/Out/Test shortcut is fine. No numbered always-on kit routes.
  - **Finishing:** as now (test green → log → backlog → decision).
- The **write** table goes to `docs/agent/write-rules.md`, with one line in `AGENTS.md`: "May I write this file? → write-rules". Read routes per kind of task (product UI → DESIGN, …) belong in `AGENTS.md` § Working, not in write-rules.
- `.cursorrules` stays, as a thin personal layer of ≤ 15 lines ([guide](../../sjablonen/cursorrules.md)): the reference to `AGENTS.md`, the answer language, brevity in the chat, a browser check **after** a UI fix. Nothing that is also in `AGENTS.md`.
- The three `.cursor/rules/{web,api,analytics}.mdc` merge into `apps/{web,api,analytics}/AGENTS.md` and disappear. That makes the per-app rules readable for other tools too.
- Rewrite `docs/INDEX.md` (was `INDEX_DOCS.md`) with the new paths; mark obs/perf/deps/polyglot as opt-in.
- Keep `ARCHITECTURE.md` thin (containers/stack/dataflow/hosting/seams). PWA/offline/push → `architecture/runtime-client.md`; JWT/demo/onboarding details → `architecture/auth.md` (or data model + legal).

### Step G-5 — Shorten the header and add the glossary (G5, G6)

- Header of every doc: `Role` + `Not here` (+ `Writing: free | after permission` instead of `Mode: WRITE/ASK`). `Notatie` and `Structuur` go to `docs/agent/doc-conventions.md`.
- `docs/context/GLOSSARY.md` with the codes: H = gym, N = navigation, L = core, calendar and insights, S = sleep, D = diet, Q = ladder, phone and showcase, ML/F, ASK = only after permission, PE = prompt engineer, plus the domain terms (split, slot, evidence, surface).

### Step G-6 — Split the decisions (G7), only if the measurement asks for it

- Script: every `## YYYY-MM-DD — title` in `DECISIONS.md` becomes `docs/decisions/NNNN-<slug>.md`, with the status from the block, numbered chronologically.
- `DECISIONS.md` becomes the list of **active** decisions (title + link).
- One big file is also easy to grep. Do this step only if the measurement (task "why is X like this") shows the agent cites superseded decisions or cannot find the decision.

### Step G-7 — Align rules outside the repo (G8)

This falls outside `GymFreak/` and therefore outside the bootstrap package; you do it by hand or in a separate task.

- Workspace `.cursorrules` (Student_Zelfstandige): the context budget may stay for the workspace, with the sentence "inside a project the router of that project wins". Soften "do not re-read / read hits only", because it clashes with P4.
- `.cursor/rules/gymfreak.mdc`: replace the dead reference `docs/ops/TODO.md` with `docs/work/BACKLOG.md`, and "follow `GymFreak/.cursorrules`" with "follow `GymFreak/AGENTS.md` and `GymFreak/.cursorrules`". If you work from the `Student_Zelfstandige` workspace, this rule is what brings both files in.

### Step G-8 — Measure

The same five tasks on the new state (C2), compare, and an ADR with the results ([step 7](../7-measure-and-record.md)).

### Step G-9 — Kit delta (already on the standard)

If GymFreak has already done the reorganisation and only needs to catch up on new kit files / the router shape: follow [BOOTSTRAP — already on the standard](../../BOOTSTRAP.md#already-on-the-standard-kit-delta). Modules/stacks:

```bash
bash _bootstrap/kit/new-project.sh . --no-git --dry-run \
  --modules reorganise,vision,product,design,research,business,agent,archive,runtime,cursor,observability \
  --stacks next,nest,python
```

(`observability` / `cursor` only if you want that compose or subagents; docs for obs/perf/deps/polyglot are in kern and come along with a fresh kit copy even without those modules.)

GymFreak-specific merge checklist:

| Action | Done when |
|-------|-----------|
| `AGENTS.md` thin (INDEX instead of keyword catalogue) | No eight always-on kit steps; `make help`/INDEX for opt-in; project facts (Caddie, Health data, Postgres writer) stay |
| Split a thick `ARCHITECTURE.md` | Runtime client + auth (or existing satellites); start doc ≤ ~100 lines of containers/stack/dataflow |
| New `+` docs | No `kit/stacks/` paths, no "Agent Engineering source §…"; polyglot says "no `apps/native` until stack + ADR" |
| BACKLOG § Later | Strix install, OTel in apps, perf budgets, digest feeds — what docs promise but the tooling still lacks |

## Place of every file

Every file and folder has a place below. Moves inside `apps/` you do **on touch**: when you are working on that file anyway, not in one big move.

**Root**

| Now | Becomes | Why |
|----|-------|--------|
| `.cursorrules` | content → `AGENTS.md`, `docs/agent/write-rules.md`, `docs/agent/lessons.md`; itself it stays as a thin personal layer | G-4 |
| `.cursor/rules/{analytics,api,web}.mdc` | `apps/{analytics,api,web}/AGENTS.md`; the `.mdc` files gone | G-4, P15 |
| `README.md`, `package.json`, `pnpm-workspace.yaml`, `pnpm-lock.yaml`, `docker-compose.yml` | stays | — |
| `Makefile` | [kit/kern/Makefile](../../kit/kern/Makefile) + `apps/<app>/app.mk`; old targets converted, `boost` to `local.mk` | G-1 |
| `.gitignore` | [kit/kern/.gitignore](../../kit/kern/.gitignore), with the GymFreak-specific rules at the bottom | [git](../../standard/git.md) |
| — | `.editorconfig`, `.pre-commit-config.yaml` (new, from the kit) | G-2, P14 |
| `regels-van-chacha.md` (empty) | removed | G-2, rule 3 |
| `.pnpm-store/` (924 files in git) | `git rm -r --cached .pnpm-store` | G-2; already in `.gitignore`, but committed earlier |
| `tmp/` (22 screenshots and a report in git) | `git rm -r --cached tmp` | G-2, rule 1 |

**docs/**

| Now | Becomes | Why |
|----|-------|--------|
| `INDEX_DOCS.md` | `docs/INDEX.md` | [naming](../../standard/naamgeving.md) |
| — | `context/CONTEXT.md`, `context/GLOSSARY.md` (new; codes H, N, L, S, D, Q, ML/F, ASK, PE and the domains) | G-5 |
| `vision/GYMFREAK.md` | `context/vision.md` | [skelet](../../standard/skelet.md) |
| `rules/REGELS.md` | `rules/RULES.md` | [naming](../../standard/naamgeving.md) |
| `product/CUT.md` | `product/PRODUCT.md` § Deliberately not, plus the table of the domains | [per file](../../standard/per-file.md) |
| `product/{D-diet,H-gym,L-calendar,L-core,L-insights,N-nav,Q-ladder,Q-phone,Q-showcase,S-sleep}.md` | stays | a code in front is fine ([naming](../../standard/naamgeving.md)) |
| `design/INDEX.md` | `design/DESIGN.md` | [naming](../../standard/naamgeving.md) |
| `design/{desktop,iphone,shared}/**` | stays | platform folders ([skelet](../../standard/skelet.md)) |
| `architecture/PROJECT_STRUCTURE.md` | `architecture/ARCHITECTURE.md`, shortened | G-3 |
| `architecture/TECH.md` | stack and runtime → `ARCHITECTURE.md`; data → `data-model.md`; engine → `architecture/engine.md`; cut the route lists (derivable from the controllers) | P5, P7 |
| `architecture/SECURITY.md` | `architecture/security.md` | [naming](../../standard/naamgeving.md) |
| `architecture/{DATA_IMPORT,LLM,ML}.md` | `architecture/{data-import,llm,ml}.md` | [naming](../../standard/naamgeving.md) |
| `architecture/TOPICLIJST.md`, `TOPICLIJST_DEKKING.md` | `research/topics.md`, `research/topics-coverage.md` | domain knowledge, not architecture |
| `architecture/recovery_factors.md` | `research/recovery-factors.md` | idem |
| `agent/PROMPT_ENGINEER.md` | `agent/lessons.md`; what applies to every task → `AGENTS.md` | P20 |
| `agent/PROMPT_ENGINEER_ARCHIVE.md` | `archive/prompt-engineer-archive.md` | [skelet](../../standard/skelet.md) |
| Read/Write table from `.cursorrules` | `agent/write-rules.md` | G-4 |
| `Notatie` and `Structuur` from the doc headers | `agent/doc-conventions.md` | G-5 |
| `archive/AI_KLUIS.md` (a design that is waiting) | `work/specs/ai-vault.md` + a line in `BACKLOG.md` § Parked | parked is not superseded ([where does this belong](../../standard/where-does-this-belong.md)) |
| `backlog/INDEX_BACKLOG.md` | `work/BACKLOG.md` | [skelet](../../standard/skelet.md) |
| `backlog/{ML,NEW_FEATURES,UI}/<X>-<slug>.md` | `work/specs/<slug>.md`; the category (ML, feature, UI) as a column in `BACKLOG.md` | an item that changes category then does not move |
| `backlog/NEW_FEATURES/PERSONAL-SITE.md` | to its own project folder | rule 4; the file says so itself |
| `business/{BUSINESSPLAN,LEGAL}.md` | `business/{businessplan,legal}.md` | [naming](../../standard/naamgeving.md) |
| `decisions/DECISIONS.md` | `decisions/DECISIONS.md` as the list of active decisions + `NNNN-<slug>.md` | G-6 |
| `logs/YYYY-MM-DD.md` | `work/logs/` | [skelet](../../standard/skelet.md) |
| `logs/INDEX_LOGS.md` | removed | `ls` is enough (P5) |

**data/**

| Now | Becomes | Why |
|----|-------|--------|
| `user/` (gitignored, written by the API) | `runtime/user/`; default in `apps/api/src/uploads/paths.ts`, overridable with `USER_DATA_DIR` | app runtime, not a source ([data](../../standard/data.md)) |
| `apple_health_export/`, `workouts.csv` | `raw/apple-health/YYYY-MM-DD/`, `raw/hevy/YYYY-MM-DD/` | [data](../../standard/data.md) |
| `derived/demo/` | `processed/demo/`; adapt the paths in `load-demo.ts`, the analytics `pack` step and `derive:demo` too | [data](../../standard/data.md) |
| `evidence/{sources,passages,priors}.yaml` | `reference/evidence/` | hand-assembled |
| `evidence/pdfs/` (local) + `pdfs/INDEX.md` | `external/evidence-pdfs/` + `README.md` | third-party licence |
| `evidence/{txt,drafts}/`, `index.duckdb` | `interim/evidence/` | rebuildable |
| `evidence/WANTLIST.md` | `docs/research/wantlist.md` | text, not data |
| `food/`, `maps/`, `routines/*.yaml`, `tips/` | `reference/{food,maps,routines,tips}/` | hand-assembled |
| `routines/RULES.md` (programming rules of the engine) | `docs/product/programming-rules.md` | product behaviour, not data |
| `GymFreakProjectStructuurEngineering.png`, `IMG_0086.PNG`, `IMG_0087.PNG` | `docs/assets/` with a descriptive name, or removed | rule 8 |
| `.gitkeep`, `evidence/.gitkeep` | removed | the folders are not empty |

**apps/analytics/**

| Now | Becomes | Why |
|----|-------|--------|
| `README.md`, `pyproject.toml`, `uv.lock`, `src/gymfreak_analytics/*.py` | stays | [stacks §4](../../standard/stacks.md#4-python-data-ml-analytics) |
| `pytest.ini` | removed; `[tool.pytest.ini_options]` in `pyproject.toml` already exists, complete it with what is missing | G-2, one config place |
| `src/gymfreak_analytics.egg-info/` | `git rm -r --cached`; it is in the `.gitignore` block | G-2, build output |
| `tests/test_*.py` | `tests/unit/` | [stacks §1](../../standard/stacks.md#1-every-app) |
| `tests/fixtures/` | stays; check that `hevy_user.csv` and the Health XML are synthetic | [data](../../standard/data.md) |
| `tests/test_routines.sync-conflict-*.py` | removed | G-2, rule 3 |
| `experiments/` | stays; new files with the date first; results → `docs/research/experiments/` | [stacks §4](../../standard/stacks.md#4-python-data-ml-analytics) |

**apps/api/**

| Now | Becomes | Why |
|----|-------|--------|
| `.env.example`, `Dockerfile`, `railpack.json`, `nest-cli.json`, `tsconfig*.json`, `package.json`, `README.md` | stays | [stacks §1](../../standard/stacks.md#1-every-app) |
| `src/main.ts`, `src/app.module.ts` | stays | [stacks §3](../../standard/stacks.md#3-nestjs-api) |
| `src/{configure-app,load-env,security,health.controller}.ts` | `src/common/` | [stacks §3](../../standard/stacks.md#3-nestjs-api) |
| `src/{database,column-types}.ts` | `src/database/` | [stacks §3](../../standard/stacks.md#3-nestjs-api) |
| `src/<domain>/` (account, auth, demo, diet, feed, life, lifestyle, plans, profile, progress, push, sleep, social, tips, uploads, users) | stays | [stacks §3](../../standard/stacks.md#3-nestjs-api) |
| `test/*.e2e-spec.ts` | `tests/integration/` | [stacks §1](../../standard/stacks.md#1-every-app) |
| `test/*.spec.ts` (unit, e.g. `diet-macros`, `split-score`) | next to the file under test in `src/<domain>/` | [stacks §3](../../standard/stacks.md#3-nestjs-api) |
| `test/{fixtures,setup-env.ts,jest-*.json}` | `tests/fixtures/`, `tests/setup-env.ts`, `jest.config.ts` at the app root | [stacks §3](../../standard/stacks.md#3-nestjs-api) |
| `scripts/{seed-test-user,delete-user}.mjs` | stays | makes something |
| `scripts/smoke-{auth,upload}.mjs` | `tests/smoke/` | checks something |

**apps/web/**

| Now | Becomes | Why |
|----|-------|--------|
| configs, `server.mjs`, `package.json`, `README.md` | stays | [stacks §2](../../standard/stacks.md#2-nextjs-web) |
| `.git/` (only `hooks/`, not a repo) | removed | G-2 |
| `public/{favicon.ico,icon*,apple-touch-icon.png,og.jpg,sw.js,google*.html}` | stays at the root of `public/` | browsers and crawlers look for them there |
| `public/{brand,about,themes,showcase}/` | stays | per use |
| `public/{next,vercel,file,globe,window}.svg` | removed if unused (`rg` first) | create-next-app boilerplate |
| `public/**/*.sync-conflict-*` | removed | G-2, rule 3 |
| `src/app/**` | stays; keep pages thin | [stacks §2](../../standard/stacks.md#2-nextjs-web) |
| `src/components/*.tsx` (119 files, flat) | domain → `features/<domain>/components/`; generic (confirm-dialog, date-field, drag-list, clock-input) → `components/ui/`; chrome and navigation → `components/layout/` | on touch |
| `src/components/showcase/` | `features/showcase/` | [stacks §2](../../standard/stacks.md#2-nextjs-web) |
| `src/lib/<domain>.ts` (diet, sleep, plans, feed, progress, …) | `features/<domain>/` | [stacks §2](../../standard/stacks.md#2-nextjs-web) |
| `src/lib/{api,haptics,parse-decimal,routes,site,…}.ts`, `src/lib/i18n/` | stays in `lib/` | generic |
| `src/lib/propose-split.selftest.mts` | `features/plans/propose-split.test.ts` with Vitest | [stacks §2](../../standard/stacks.md#2-nextjs-web) |
| `src/hooks/` | generic stays; domain hooks → `features/<domain>/hooks/` | [stacks §2](../../standard/stacks.md#2-nextjs-web) |
| `src/types/` | stays | [stacks §2](../../standard/stacks.md#2-nextjs-web) |
| `e2e/*.spec.ts` | `tests/e2e/` (`testDir` in `playwright.config.ts`) | [stacks §1](../../standard/stacks.md#1-every-app) |
| `scripts/smoke-*.mjs`, `scripts/check-pwa-logic.mts` | `tests/smoke/` | checks something |
| `scripts/{gen-*,persona-probe}.mjs` | stays; output to `tmp/` | makes something |

---
