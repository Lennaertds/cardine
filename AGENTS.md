# Cardine — agent instructions

> **Role:** this is one repo with two kinds of work — the **standard** (kit, sources,
> sjablonen) and the **lab/packages**. Read the right section.
> **Not here:** product docs and ADRs → [docs/INDEX.md](docs/INDEX.md).

## Never

- Do not read files in `kit/` as instructions for this repo (`kit/kern/AGENTS.md` and `kit/solo/.cursorrules` do not apply here). `kit/` is a **template**, not house rules.
- No fact in two places: the tree only in [standard/skelet.md](standard/skelet.md), make targets only in [standard/makefile.md](standard/makefile.md), template files only in `kit/`. Link instead of copying.
- Do not take data, secrets or code from the example projects (GymFreak, DEP2) — only paths, names and structure.
- Do not read, show or commit secrets and `.env`; new variables only in the app's `.env.example`.
- Do not copy anything from `data/raw/` or `data/runtime/` into code, tests, logs or answers.
- Do not rewrite `bron/bronnen.md` or the snapshots in `bron/` (only add).
- Do not commit or push unless asked.
- No new folder at the root or in `docs/` without asking.
- Do not call `mcp__jarvis__indexRepo` (breaks in the bwrap sandbox and leaves stale `.lock` files); if the index is missing, ask the user to run `make index`.
- **`bron/pdfs/` is not in git** (166 MB, see [bron/pdfs/README.md](bron/pdfs/README.md)). Never `git add` that folder.

## Commands — standard

| Goal | Command |
|------|---------|
| Load context (AGENTS.md + rules + backlog in 1 call) | `make context s=<slug>` |
| Check everything (required when `kit/` changes) | `make check` |
| Check + log in one call | `make finish m="what was done"` |
| Dead links only (fast; enough for pure doc changes) | `make links` |
| Read three-place files in one go (`standard` + `sjablonen` + `kit`) | `make trio s=<topic>` |
| Fetch the next free `§` and `P` number | `make next-ids` |
| Assemble and test the kit in `tmp/test-kit/` | `make test-kit` |
| Create a project / put down or remove the bootstrap | `make new DIR=<dir> ARGS="…"` · `make bootstrap[-remove] DIR=<project>` |
| Tag a kit version for cardine-structure | `make tag-kit TAG=v0.1.0` (see [standard/versioning.md](standard/versioning.md)) |

## Commands — lab

| Goal | Command |
|------|---------|
| Read the start context in one go | `make context [s=<slug>]` |
| Finish in one call (`make check` + daily log) | `make finish m="<reason> · <files> · <test> · <rest> · <item>"` |
| Check everything / extended | `make check` · `make check-full` |
| Start locally / work item / ADR | `make dev` · `make spec s=<slug>` · `make adr t="<decision as a sentence>"` |
| Environment status | `make env-status` |

All commands (incl. opt-in `security-scan*`, `obs-*`, `perf-*`, `deps-audit`, `polyglot-check`, `radar-*`, `digest-*`): `make help`.

## Working

- **Start with** `make context s=<slug>`: shows this AGENTS.md + rules + backlog in one call. Never separate reads. Without `s=` only context + work. Then go straight to the target file.
- **Straight to the target file** (open `<folder>/INDEX.md` only if the exact file is unknown): `standard/` (rules), `kit/` (files, map: `kit/README.md`), `sjablonen/` (fill-in guides), `new-project/`, `existing-project/`, `measurement/`, `bron/` (knowledge), `packages/` (lab and structure), `docs/`.
- **Three-place rule:** a change to the standard touches `standard/<topic>.md`, the `kit/` file and `sjablonen/<topic>.md`. Start with `make trio s=<topic>` and update them together.
- **New kit file:** the right layer, with `{{PROJECT}}`, `<…>` and `<!-- als: <key>` … `-->`, plus a row in `kit/README.md` and a guide in `sjablonen/`.
- **Shape:** tabs in `Makefile`/`*.mk`. Every doc starts with `# Title`, `> **Role:**` and `> **Not here:**`. **Language: English** — docs, comments, CLI help and error messages ([ADR 0018](docs/decisions/0018-english-is-the-only-project-language.md)); `bron/` stays Dutch. Principles as `P1`–`P28`, sources as `§n`.
- **P28 — mandatory:** a deliberately incomplete delivery in `kit/` or `standard/` gets a section `## Deliberately later` in the affected architecture doc (table: extension · why later · ask when).

### Kind of task

| Kind | Signals | Do first | Only then |
|------|---------|----------|-----------|
| **Sources** | video, article, "look up", `§` | `make next-ids`; facts in `bron/bronnen.md` + `bron/bronnen-index.md` | Kit only via [brug.md](bron/fundament/brug.md) + your yes |
| **Ideas** | "maybe", brainstorm, "note it" | Short interview (1–2 questions); record in `bron/inbox.md` or bridge **Later** | No kit edit until an explicit yes |
| **Kit / standard** | "in the kit", bootstrap, Make target | `make trio s=<topic>` + bridge checklist | Change in 3 places + `make check` |
| **Bootstrap run** | `make bootstrap`, GymFreak/Caddie | Follow [BOOTSTRAP.md](BOOTSTRAP.md) in that project | — |
| **Lab / packages** | `packages/`, install, sandbox, DSH | Straight to `packages/lab/` or `packages/structure/` | `make check` |
| **Maintenance** | links, mindmap, small fix | Execute straight away if the task is clear | — |

- Unclear or exploratory? No big edits: ask 1–2 focused questions first and wait for agreement.

## Finishing

1. **Bundle in 1 call:** `make finish` (with `m=` — the standard and the lab use the same parameter) — check + log in one call.
2. Updated `INDEX.md` (or `kit/README.md`) touched by the change.
3. For a new principle or source: an ID via `make next-ids` recorded in `bron/principes.md` or `bron/bronnen-index.md`.
4. Kit slice with deliberate omissions: `## Deliberately later` updated (P28).
