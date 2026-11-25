# Example — Data_Engineering_Project_2 (team)

> **Role:** DEP2 worked out: what is good, what can improve, and the steps across one sprint.
> **Not here:** the general step-by-step plan ([INDEX](../INDEX.md)), the description of the project itself ([bron/stand-dep2](../../bron/stand-dep2.md)).

Team of five, two-week sprints. Silage maize trial for client CADS (trial farm Bottelare): Python ETL to MSSQL (staging + DWH) and analyses for three cases. Based on the snapshot in [stand-dep2](../../bron/stand-dep2.md); the repo itself was not looked at. Check the findings in the real repo first, and discuss the plan in a sprint meeting before you carry it out: it affects everyone.

## Kit

```bash
kit/new-project.sh DEP2 --team --no-git --dry-run --modules reorganise,assignment,deliverables,claude
```

No stack: the structure of `src/`, `sql/` and `scripts/` stays. Only take the `check-*` targets from [kit/stacks/python](../../kit/stacks/python/README.md) as an example for the `Makefile`.

## What is already good (keep it)

| What | Why it is good | Principle |
|-----|-------------|----------|
| Pitfalls explicit: `ï` as `├п` on disk, conversion before the insert because path columns are `VARCHAR` | Exactly what an agent finds nowhere else | P6 |
| What is **not** in `pipeline.sh` (case 3, schema `plantcount`, the old case 1 track) | Naming the boundaries prevents wrong assumptions | P6 |
| Semantics of the resets ("after a staging reset, reset the DWH too") | Destructive actions explained | P17 |
| Which DWH columns stay empty | Prevents someone from "fixing" them | P6 |
| `pipeline.sh` is idempotent (skip a successful step, empty a half-filled table) | Explained in one paragraph | P12 |
| `docs/` with CONTEXT and CASES | A start on the skeleton | [skelet](../../standard/skelet.md) |
| One test file per module | A good feedback base | P13 |

## What can improve

| # | Finding | Problem | Principle |
|---|-----------|----------|----------|
| D1 | There is no `AGENTS.md`, while five people each use their own tool | Every agent starts without commands, boundaries or the warnings about resets | P2, P17 |
| D2 | `PROJECTSTRUCTUUR.md` lists every config file, every test file and every module | Derivable; goes stale with every PR from five people | P5 |
| D3 | `configs/case1_improved.json`, `_v3`, `_v3_all`, `_v4`, `_v5` | Versions in file names: which one is canonical? | P16, §18 |
| D4 | Two parallel tracks: the star schema in `sql/` against schema `plantcount` in `dronebeelden/`; and for case 1 the pipeline via `rootscan_poc` against an older dashboard track with its own SQLite | Context clash: an agent can work in the wrong track | P7, P9, §8 |
| D5 | Architecture docs scattered: `case_wortelscans/README/db_architecture.md`, `poc/README.md`, `case_kurosens/README.md`, `docs/CASE2_DRONE.md` | Hard to find; no map | P2 |
| D6 | `case_wortelscans/README/last_changes.md` | Status in the repo, with five writers | P8 |
| D7 | No check command; no CI | Everyone tests differently | P13 |
| D8 | Mix of Dutch and English in names (`dronebeelden`, `case_wortelscans`, `plant_count`, `FactWortelmeting`, `object`, `plot`) without a glossary | The same thing has several names | P10 |
| D9 | `reset_*.sh` drop databases or wipe run folders | An agent that "just resets" destroys hours of computation | P14, P17 |
| D10 | `docs/vragen_klant.txt` | Status, not truth | P8 |

## Steps (spread over one sprint)

### Step D-1 — Agreements in the sprint meeting (15 min)

- Agree on: `AGENTS.md` as the common base, updating docs is part of the Definition of Done, status only in the tracker, one docs steward per sprint ([team](../../new-project/team.md)).
- Decide D3 and D4 together: which config and which track are canonical? Those become ADR 0001 and 0002 (step D-4).
- Minutes: `make meeting with=team`.

### Step D-2 — `make check` and CI (D7)

Kit `Makefile` as the base, with the checks in their own `CHECK` targets at the root (there is no `apps/`):

```make
CHECK += check-py check-js

check-py: ## python: ruff and pytest, without a database
	uv run ruff check src tests
	uv run pytest -q -m "not db"

check-js: ## row editor: node tests
	node --test tests/test_row_editor.js

CHECK_FULL += check-db
check-db: ## tests that need MSSQL
	uv run pytest -q -m db
```

`.github/workflows/check.yml` from the team layer runs `make check` on every PR. Tests that need MSSQL get the marker `@pytest.mark.db`.

### Step D-3 — `AGENTS.md` (D1, D9)

From the kit, filled in:

````markdown
# DEP2 group 3 — agent instructions

Silage maize trial for client CADS (trial farm Bottelare): ETL to MSSQL (staging + DWH) and analyses for three cases. For humans: [README.md](README.md).

## Never

- Do not run `scripts/reset_*.sh` without an explicit request. They drop a database or wipe run folders; measuring again takes long.
- Do not commit anything from `data/` or `artifacts/` (exception: `data/processed/demo/`).
- Do not read or show `.env`; new variables go to `.env.example`.
- Do not write to `dwh_db` outside `src/etl/`.

## Commands

| Goal | Command |
|------|---------|
| Check everything | `make check` |
| Full pipeline | `make data` (calls `scripts/pipeline.sh`; skips successful steps) |
| Database status | `uv run python -m etl.pipeline_status` |
| Dependencies | `uv add <package>` — never pip |

## Working

- Map: [docs/INDEX.md](docs/INDEX.md). Star schema and ETL: `docs/architecture/`.
- Paths with `maïs` sometimes sit on disk as `├п`; loaders convert them to `ï` before the insert (VARCHAR columns).
- Canonical tracks: ADR 0001 (configs) and 0002 (pipeline against schema plantcount). Do not work in `legacy/` unless asked.
- Terms: [GLOSSARY.md](docs/context/GLOSSARY.md).

## Finishing

1. `make check` green. 2. Docs touched updated. 3. Choice → ADR via PR. 4. Summary in the PR.
````

Plus `CLAUDE.md` → `AGENTS.md` (module `claude`) for whoever uses Claude Code.

### Step D-4 — Distractions and parallel tracks (D3, D4)

- ADR 0001: which `case1_*.json` is canonical. The others go (git keeps them). If a script still uses old variants, the variant becomes a field in the config instead of a file name.
- ADR 0002: the pipeline (`sql/` + `src/etl/`) is the source of truth. `dronebeelden/` + `*_db.py` and the SQLite dashboard track become **legacy**: to `legacy/` with a two-line `legacy/AGENTS.md` ("do not extend; read only for comparison"), or removed if nobody uses them any more.

### Step D-5 — Docs to the skeleton (D2, D5, D6, D8, D10)

#### Target structure docs

```
docs/
├── INDEX.md                         # was docs/README.md (reading order → map)
├── context/
│   ├── CONTEXT.md                   # exists
│   ├── CASES.md                     # exists (case 1, 2, 3)
│   ├── GLOSSARY.md                  # NEW — object, plot, variety, FAO, observation, flight, orthomosaic, …
│   └── assignment.md                # NEW — assignment, criteria, deadlines of the course
├── architecture/
│   ├── ARCHITECTURE.md              # NEW — from PROJECTSTRUCTUUR: layers, pipeline steps, what is in git
│   ├── database.md                  # was case_wortelscans/README/db_architecture.md
│   ├── case1-wortelscans.md         # from poc/README.md + info_data.md
│   ├── case2-drone.md               # was docs/CASE2_DRONE.md
│   └── case3-kurosens.md            # from case_kurosens/README.md
├── how-to/
│   ├── run-the-pipeline.md          # the pipeline section from PROJECTSTRUCTUUR
│   └── reset-databases.md           # reset semantics
├── decisions/
│   ├── _template.md
│   ├── 0001-canonieke-configs.md
│   └── 0002-pipeline-is-source-of-truth.md
├── work/meetings/                   # minutes with client and coach
└── deliverables/                    # submitted reports and presentations
```

- `PROJECTSTRUCTUUR.md`: the valuable parts (layers, pipeline, pitfalls, empty columns, what is not in the pipeline) go to `ARCHITECTURE.md` and `how-to/`. Cut the lists of configs, tests and modules. **The one-line description per module becomes the docstring** at the top of each `.py` file.
- `last_changes.md` and `vragen_klant.txt` → issues in the tracker, then removed.
- `example_script_rootfinder.py` (old example from the client) → `legacy/` or `docs/archive/`.
- Data into the fixed layers ([data](../../standard/data.md)): `data/derived/plots_uitgelijnd/` → `data/processed/demo/` if it is small and anonymous.

### Step D-6 — PR template and steward (team)

- `.github/pull_request_template.md` en de issue-templates uit de team-laag.
- The sprint's docs steward does the [maintenance](../../new-project/6-maintenance.md) in the last week.

### Step D-7 — Measure

- The same DEP2 tasks before D-2 (C1) and after D-5 (C2), [meten](../../measurement/INDEX.md).
- A team project with sprints is an interesting second case next to a solo project ([bachelorproef](../../measurement/bachelorproef.md)). Ask the team and the supervisor whether you may use the measurement.
