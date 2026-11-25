# Makefile

> **Role:** Which make targets every project has, what they do, and how an app adds its own.
> **Not here:** the Makefile itself ([kit/kern/Makefile](../kit/kern/Makefile)), the targets of one stack ([kit](../kit/README.md#stacks)), how to adapt it per project ([template](../sjablonen/makefile.md)).

## Why one Makefile

- **Fixed names across all projects.** `make check` means the same everywhere: green or not. Human, agent and CI never have to look anything up per project (P13).
- **The agent reads one table.** `AGENTS.md` names the targets, not the `pnpm`, `uv` or `docker` commands underneath. When a tool changes, only the Makefile changes.
- **`make` with no argument shows everything.** Every target with `## explanation` appears in `make help`, grouped by its `##@` heading.

## How apps register

The root `Makefile` knows no app at all. Every app has its own `apps/<app>/app.mk`, and the root picks those up automatically:

```make
-include $(sort $(wildcard apps/*/app.mk))
-include local.mk
```

An `app.mk` adds to lists and defines its own targets with the suffix `-<app>`:

```make
CHECK += check-web
check-web: ## web: lint, types and unit tests
	pnpm --dir apps/web run lint
```

The root target `check` depends on `$(CHECK)` and therefore runs every `check-<app>`. When an app is added, you copy one `app.mk` and the root needs no change.

| List | Root target | What an app adds to it |
|------|-------------|------------------------|
| `TOOLS` | `doctor` | the tools it needs (`node pnpm`, `uv`, `psql`) |
| `SETUP` | `setup` | `setup-<app>`: install dependencies |
| `DEV` | `dev` | `dev-<app>`: dev server; `make dev` starts them in parallel |
| `CHECK` | `check` | `check-<app>`: lint, types, unit tests. Fast, without network or database |
| `CHECK_FULL` | `check-full` | integration, e2e, data quality: everything that needs a service |
| `FMT` | `fmt` | `fmt-<app>` |
| `BUILD` | `build` | `build-<app>` |
| `SMOKE` | `smoke` | `smoke-<app>`: against `URL=`, or its own `<APP>_URL` |
| `BENCH` | `bench` | `bench-<app>`: perf smoke; requires `apps/<app>/scripts/bench.sh`. **Not** in `check` |
| `DATA` | `data` | pipeline steps into `data/processed/` |
| `SEED` | `seed` | test users and demo data |
| `DB_RESET` | `db-reset` | empty the local database; **refuses** if `DATABASE_URL` does not point at localhost |
| `CLEAN` | `clean` | `clean-<app>`: build output and caches |
| `PORTS` | `status` | the ports the app uses locally |

## The targets

### Starting

| Target | What |
|--------|------|
| `help` | All targets with their explanation. The default for `make`. |
| `setup` | `env`, then `setup-<app>` for every app, then `pre-commit install`. Once, after a clone. |
| `env` | Copies every `.env.example` to `.env` if it does not exist yet. Never overwrites. |
| `doctor` | Shows for each tool in `TOOLS` whether it is installed; fails if one is missing. |

### Running locally

| Target | What |
|--------|------|
| `dev` | All `dev-<app>` at once (`make -j`). Ctrl-C stops everything. |
| `up` · `down` · `logs` | Start `docker compose` (and wait until the health checks are green), stop it, follow the logs. |
| `status` | Containers and which ports from `PORTS` are taken. |

### Checking

| Target | What |
|--------|------|
| `context s=<slug>` | Context bundle: RULES.md + BACKLOG + spec in one output. Replaces 3–4 separate `read_file` calls. Without `s=` only RULES + BACKLOG. |
| `finish MSG=…` | `check` + logging in one call. Creates a log entry with the message in `docs/work/logs/<today>.md`. |
| `check` | `links` and every `check-<app>`. **Must be green before you finish.** It also fails while there is no app yet, so an empty project never looks "green". |
| `check-full` | `check` plus `deps-audit` plus `native-bindings-strict` plus `CHECK_FULL`. Runs before a release or in nightly CI. |
| `links` | Dead relative links in all `.md` files ([check-links.sh](../kit/kern/scripts/check-links.sh)). |
| `smoke URL=…` | Smoke tests against a running environment, e.g. after a deploy. |
| `fmt` · `build` | Format and production build, per app. |
| `security-scan` · `security-scan-quick` | Strix pentest on `TARGET=` (default `.`). **Not** in `check`. Requires Docker + `strix` + an LLM key. |
| `container-setup` | Container-safe helpers for npm/pip/cargo. Does not install Podman — that is system administration. Sets shell functions up in `scripts/container-safe.sh`. **Not** in `check`. |
| `obs-up` · `obs-down` · `obs-status` | LGTM stack (module `observability`). Fails clearly without that module. |
| `perf-check` | Structure of `docs/architecture/performance.md`. **Not** in `check`. |
| `bench` | Every `bench-<app>` (BENCH list). Fails until `scripts/bench.sh` exists. |
| `deps-audit` | CVE audits (npm/pnpm, pip-audit/uv; Cargo stub) + structure of `dependencies.md`. **In** `check-full`, not in `check`. |
| `native-bindings-strict` | `NATIVE_STRICT=1` for `apps/native` and/or `native-c` (no JS/Python fallback). **In** `check-full`, not in the soft `check`. See the how-to `native-ci.md`. |
| `polyglot-check` | Structure of `docs/architecture/polyglot.md` + presence of the example ADR. **Not** in `check`. |
| `radar-check` | Structure of `docs/research/radar.md` (module `research`). Fails clearly without the module. **Not** in `check`. |
| `radar-reminder` | Hint + the `Last reviewed:` date (monthly ritual). **Not** in `check`. |
| `digest-check` | Scaffold `docs/research/digest/` (module `research`). **Not** in `check`. |
| `digest-reminder` | Hint: curate SOURCES/feeds (P5). **Not** in `check`. |
| `digest-fetch` | RSS/Atom → `data/external/digest/`; `DIGEST_DRY_RUN=1` / `DIGEST_FIXTURE=`. **Not** in `check`. |
| `digest-propose` | Proposal in `docs/research/digest/proposals/` (no auto-write to `radar.md`). **Not** in `check`. |

### Data and database

| Target | What |
|--------|------|
| `data` | The pipeline: `raw/`, `external/` and `reference/` to `processed/`. Repeatable. |
| `seed` | Test users and demo data in the local database. |
| `db-reset` | Empty the local database, migrate, seed. With a guard on localhost. |

### Docs and work

| Target | Creates | From template |
|--------|---------|---------------|
| `adr t="Postgres is the only writer"` | `docs/decisions/0007-postgres-is-the-only-writer.md` with the next number and the date | `docs/decisions/_template.md` |
| `spec s=diet-budget` | `docs/work/specs/diet-budget.md` and a line at the top of **Now** in `BACKLOG.md` | `docs/work/specs/_template.md` |
| `log` | `docs/work/logs/<today>.md` if it does not exist yet; shows the path | `docs/work/logs/_template.md` |
| `meeting met=coach` | `docs/work/meetings/<today>-coach.md` | `docs/work/meetings/_template.md` |
| `experiment s=sleep-baseline` | `docs/research/experiments/<today>-sleep-baseline.md` | `docs/research/experiments/_template.md` |
| `docs-health` | Dead links, the length of every `AGENTS.md`, the fifteen docs that have not changed for the longest time | — |

Every target that needs a folder not in the project (e.g. `spec` in a team project) fails with a message naming the kit module that installs it.

### Cleaning up

| Target | What |
|--------|------|
| `clean` | `clean-<app>` for every app, `tmp/` removed, `data/interim/` emptied. Never `raw/`, `processed/` or a database. |

## Rules for your own targets

1. **Project targets in `app.mk` or the root, personal ones in `local.mk`.** `local.mk` is in `.gitignore`. A target only you use (e.g. a dev boost for your own test account) goes there.
2. **Every target that does something meaningful gets `## explanation`.** Without it, the target does not appear in `make help` and therefore not for the agent either.
3. **Destructive = guard.** A target that deletes data first checks where it is writing, and otherwise refuses with a clear message.
4. **No logic in the Makefile that needs a test.** Once a recipe grows past ±10 lines, turn it into `scripts/<name>.sh` or `apps/<app>/scripts/` and have the target call that.
5. **Messages say what to do.** Not "Error 1", but "Docker is not running. Start the daemon and try again."
6. **Recipes are indented with a tab.** The kit's `.editorconfig` sets that correctly for `Makefile` and `*.mk`.

---
