# Profiles — fixed module combinations per kind of project

> **Role:** Per profile, which modules, stacks, folders and files a project gets by default.
> **Not here:** content per doc ([per-doc reference](per-file.md)), how to start a project ([new-project](../new-project/INDEX.md), [existing-project](../existing-project/INDEX.md)).

A **profile** is a predefined set of modules and config that fits a kind of project. Instead of typing `--modules a,b,c --stacks x,y` every time, you pick `--profile app` and everything is in place.

## Profiles

| Profile | For | Modules (on top of kern) | Stacks | Starter | `make finish` logs to |
|---------|-----|--------------------------|--------|---------|-----------------------|
| `app` | Building an application | vision, assignment, product, design, research, business, agent, deliverables, meetings, compose, observability | user chooses | optional | `docs/work/logs/<date>.md` |
| `research` | Research with software (no app) | assignment, research, agent, deliverables, meetings | python | no | `docs/work/logs/<date>.md` |
| `studie` | Keeping a study plan | assignment | — | no | `docs/work/logs/<date>.md` (plus `make log`) |
| `schoolwerk` | Exercises in DL/DB/Python/algorithms | assignment, compose | python | no | `docs/work/logs/<date>.md` |

## Per profile in detail

### `app` — Building an application

Projects like GymFreak, Caddie. The full kit with every module a software project needs.

- **Modules:** vision, assignment, product, design, research, business, agent, deliverables, meetings, compose, observability
- **Stacks:** the user chooses (next, nest, python, sql, rust, c)
- **Starter:** optional with `--starter`
- **Why these modules:** an app has domain knowledge (product), UI (design), deployment (compose), observability (monitoring), literature (research), a client (assignment), a roadmap (vision), decisions (agent), consultation (meetings), delivery (deliverables), a revenue model (business)

### `research` — Research with software

Projects like Agent Engineering, Cardine. No product/UI, but literature, experiments and software.

- **Modules:** assignment, research, agent, deliverables, meetings
- **Stacks:** python (for scripts, experiments)
- **No:** product, design, business, compose, observability
- **Extra:** `docs/research/experiments/` takes precedence over `apps/`
- **AGENTS.md:** emphasis on sources, experiments, literature — not on building a product

### `studie` — Study planning

Calendar, deadlines, study log. No code, no product.

- **Modules:** assignment
- **No stacks, no `apps/`**
- **Extra files:** `werk/kalender.md`, `werk/deadlines.md`, `werk/studielog.md`
- **Makefile:** `make log` (short note), `make deadline` (add a deadline) and `make kalender` come from the profile's `local.mk`; there is **no** `make check` with test-kit (no code to test)
- **AGENTS.md:** planning and reminders, not a coding workflow

### `schoolwerk` — Exercises

Basic scripts for Deep Learning, Databases, Python, algorithms. Podman/Docker for dependencies.

- **Modules:** assignment, compose
- **Stacks:** python (for exercise scripts)
- **Extra:** `containers/` folder with the compose setup for exercises; `make build`, `make run`, `make test` and `make stop` come from the profile's `local.mk`
- **Emphasis:** a reproducible environment in containers, no CI/CD, no production

## How a profile works

1. `kit/new-project.sh` gets a `--profile <name>` flag.
2. The script reads `kit/profiles/<name>.profile` — a simple text file with variables.
3. Those variables determine which modules, stacks and extra steps run.
4. Without `--profile` the script falls back to the earlier behaviour (everything by hand via `--modules`, `--stacks`).

See [kit/profiles/](../kit/profiles/README.md) for the existing profiles and how to add your own.

## Making your own profile

A profile is a file `kit/profiles/<name>.profile` with:

```bash
# kit/profiles/<name>.profile
PROFILE_NAME="<name>"
PROFILE_DESCRIPTION="<short description>"
MODULES="<module1,module2,…>"
STACKS="<stack1,…>"           # empty if no stacks
STARTER=false
EXTRA_DIRS="<folder1,folder2,…>"    # folders that are not in kern
```

Add a row to the table in this file and to `kit/README.md`.

---
