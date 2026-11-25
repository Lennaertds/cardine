# Kit

> **Role:** The files you copy into a project. Every layer is a slice of the project root: what sits in `kern/docs/INDEX.md` lands in `<project>/docs/INDEX.md`.
> **Not here:** why the structure is the way it is ([standard](../standard/INDEX.md)), how to fill in each file ([sjablonen](../sjablonen/INDEX.md)).

## Usage

```bash
kit/new-project.sh <dir> [--profile app|research|studie|schoolwerk] [--team] [--modules a,b] [--stacks a,b] [--starter] [--name NAME] [--dry-run] [--no-git]
```

- **New project:** follow [new-project](../new-project/INDEX.md). The script creates the folder, copies the layers and runs `git init`.
- **Existing project:** follow [existing-project](../existing-project/INDEX.md). Start with `--dry-run`: it shows what is missing. The script never overwrites an existing file; what was already there appears in the output with `=`, so you can merge it by hand.
- **By hand:** copy the contents of a layer into the project root (`cp -rn kit/kern/. <project>/`). Then replace `{{PROJECT}}` and `{{DATE}}` yourself, and remove the `<!-- als: … -->` blocks that do not apply.

## Layers

| Layer | When | What it installs |
|-------|------|------------------|
| `kern/` | always | `README.md`, `AGENTS.md`, `Makefile`, `.gitignore`, `.editorconfig`, `.pre-commit-config.yaml`, `scripts/check-links.sh`, `docs/` (INDEX, context, rules, architecture, decisions, how-to), `data/` with the five fixed layers, `apps/` |
| `solo/` | only you work on it (default) | `.cursorrules` (thin personal layer), `docs/work/BACKLOG.md`, `specs/_template.md`, `logs/_template.md` |
| `logging/` | always (topic-centred logging) | `logs/status-log.md`, `logs/topics/_template.md` |
| `team/` | with `--team` | `.github/` (CI with `make check`, PR template, issue templates); adds the `meetings` module |
| `modules/<name>/` | with `--modules`, or later | one folder or file in its fixed place, see below |
| `stacks/<stack>/apps/<app>/` | with `--stacks`, after the generator | `app.mk`, `AGENTS.md`, `.env.example`, the app's fixed folders |
| `stacks/<stack>/starter/apps/<app>/` | with `--stacks` and `--starter`, new apps only | starter code with a test (Python, SQL): `config.py` and `test_config.py` |
| `profiles/<name>.profile` | with `--profile` | predefined set of modules, stacks and extra files for a kind of project |

### Profiles

| Profile | For | Modules | Stacks | Extra |
|---------|-----|---------|--------|-------|
| `app` | Application (GymFreak, Caddie) | vision, assignment, product, design, research, business, agent, deliverables, meetings, compose, observability | user chooses | — |
| `research` | Research with software (Agent Engineering) | assignment, research, agent, deliverables, meetings | python | — |
| `studie` | Study planning | assignment | — | werk/kalender.md, werk/deadlines.md, werk/studielog.md, local.mk |
| `schoolwerk` | Exercises (DL/DB/Python/algorithms) | assignment, compose | python | containers/, local.mk |

See [profiles/](profiles/README.md) for details.

### Modules

| Module | Installs | Take it when |
|--------|----------|--------------|
| `vision` | `docs/context/vision.md` | the project runs longer than one semester |
| `assignment` | `docs/context/assignment.md` | there is a client: school or customer |
| `product` | `docs/product/PRODUCT.md`, `_template.md`, `.cursor/agents/product.md` | there is more than one domain |
| `design` | `docs/design/DESIGN.md`, house-standard craft (`shared/`, `desktop/`, `iphone/`), `.cursor/agents/ui.md` | there is a UI with its own house style (premium look / PWA) |
| `research` | `docs/research/` (RESEARCH, wantlist, **radar**, **digest/**, experiments), how-to radar/digest, `data/external/digest/`, `.cursor/agents/research.md` | literature/experiments; tech radar; digest fetch/propose |
| `business` | `docs/business/` | there is a revenue model, pricing or terms |
| `agent` | `docs/agent/` with write-rules, doc-conventions, lessons, `prompts/` | you let an agent do many meta tasks |
| `deliverables` | `docs/deliverables/` | you submit something: report, poster, presentation |
| `meetings` | `docs/work/meetings/_template.md` | you consult with client, coach or team |
| `archive` | `docs/archive/` | you want to keep old docs without them counting |
| `reorganise` | `docs/work/specs/reorganise.md` | you reorganise an existing project |
| `compose` | `docker-compose.yml` (Postgres 17), `.env.example` | an app needs a database or another service |
| `observability` | `docker-compose.observability.yml`, `infra/observability/` (LGTM) | metrics/logs/traces locally; the docs are always in kern |
| `packages` | `packages/` | two apps share code that does not deploy separately |
| `infra` | `infra/` | one compose file is no longer enough |
| `runtime` | `data/runtime/README.md` | the app writes files locally (uploads) |
| `models` | `data/models/README.md` | you train models |
| `cursor` | `.cursor/rules/_template.mdc`, `.cursor/agents/{architecture,reviewer,clarify}.md` | you use Cursor (path rules and/or subagents); see [agent-rollen](../standard/agent-rollen.md) |
| `claude` | `CLAUDE.md` → `AGENTS.md` (symlink) | you use a tool that reads `CLAUDE.md` |

## Stacks

Every stack has its own guide with the generator, the scripts `app.mk` expects and the check afterwards. The generator comes **first**, because it refuses a folder that is not empty.

| Stack | App | Guide | Main targets |
|-------|-----|-------|--------------|
| `next` | `apps/web` | [stacks/next](stacks/next/README.md) | `dev-web`, `check-web`, `e2e-web`, `clean-web` |
| `nest` | `apps/api` | [stacks/nest](stacks/nest/README.md) | `dev-api`, `check-api`, `integration-api`, `db-reset-api` |
| `python` | `apps/analytics` | [stacks/python](stacks/python/README.md) | `check-analytics`, `data-analytics` |
| `sql` | `apps/pipeline` | [stacks/sql](stacks/sql/README.md) | `migrate-pipeline`, `data-pipeline`, `checks-pipeline` |
| `rust` | `apps/native` | [stacks/rust](stacks/rust/README.md) | `check-native`, `native-check`, `setup-native` (napi **+** PyO3 via `--starter`) |
| `c` | `apps/native-c` | [stacks/c](stacks/c/README.md) | `check-native-c`, `native-c-check`, `setup-native-c` (N-API **+** ctypes via `--starter`) |

A second app of the same stack (e.g. `apps/admin` with Next) you copy by hand from `stacks/next/apps/web/`. Then rename `WEB_` and `-web` in `app.mk`.

## Conventions in the kit files

- `{{PROJECT}}` and `{{DATE}}` are filled in; `<…>` you fill in yourself.
- A block between `<!-- als: <key>` and `-->` stays only if that layer, module or stack was chosen.
- Recipes in `Makefile` and `app.mk` are indented with a tab.
- A `.gitkeep` keeps a fixed empty folder in git. The script removes it as soon as that folder holds anything else.

## Changing the kit

Change a kit file, and then the guide in [sjablonen](../sjablonen/INDEX.md) that goes with it. Then run `make check` in the root of this repo: it assembles a project with all layers and tests it.
