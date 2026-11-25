# Bootstrap package — instructions for the agent

> **Role:** The procedure for an agent that brings a project to the standard: set up an empty project or reorganise an existing one, and then remove this package again.
> **Not here:** the standard itself ([standaard](standard/INDEX.md)), the step-by-step plan in detail ([nieuw-project](new-project/INDEX.md), [bestaand-project](existing-project/INDEX.md)).

You are in the root of a project. There this folder is called `_bootstrap/` and it is temporary: it is in `.git/info/exclude`, never ends up in a commit, and is removed at the end. All paths below are relative to the project root, unless they are inside a link.

The human put the package here with `make bootstrap DIR=<project>` in the standard. They asked you: "Read `_bootstrap/BOOTSTRAP.md` and follow it for this project."

## Hard rules, throughout the procedure

1. **Never read, show or commit:** `.env` and any other secret, and data in `data/raw/`, `data/runtime/` or a folder with user or health data. Inventory such folders by name and size (`fd`, `du`), never by content.
2. **The project's rules win.** If `AGENTS.md`, `.cursorrules` or a workspace rule says something stricter (do not commit, do not touch a folder), you follow that.
3. **Do not commit yourself**, unless the human explicitly allows it in this conversation. After every phase you stop with `git status --short`, a summary and a proposed commit message; the human commits.
4. **Move with `git mv`**, never copy and delete. Overwrite nothing: the kit script never does, and neither do you by hand.
5. **Do not rewrite code** except paths that change because of a move. Code moves "on touch", later.
6. **`make check` after every phase.** Red: fix it or report it first, do not continue.
7. **Doubt is a question**, not a guess. A file without a clear place goes to the human as a question.
8. **Standard features that the docs describe but that are not wired up here yet** (tooling, Make target, secrets, Docker): do not ignore them. Solo: one line in `docs/work/BACKLOG.md` (§ Later or § Parked) with *what* is missing and *what* you are waiting for. Team: an equivalent issue. The documentation stays the source of truth about *how* it should work.

## What sits where in this package

Read just in time, only what the phase asks for.

| Needed for | Read |
|------------|------|
| Where does a file belong? | [standard/where-does-this-belong](standard/where-does-this-belong.md), [standard/skelet](standard/skelet.md) |
| What belongs in a file, and what does not? | [standard/per-file](standard/per-file.md), and the guide in [sjablonen](sjablonen/INDEX.md) |
| Makefile, targets, `app.mk` | [standard/makefile](standard/makefile.md) |
| Datalagen | [standard/data](standard/data.md) |
| The files themselves, and the script | [kit](kit/README.md): `bash _bootstrap/kit/new-project.sh . …` |
| A worked example | [GymFreak](existing-project/examples/gymfreak.md) (solo), [DEP2](existing-project/examples/dep2.md) (team) |

## Phase 0 — Determine the kind of project

```bash
git status --short | head; ls -A | grep -vx -e .git -e _bootstrap
```

- **Empty** (nothing outside `.git` and `_bootstrap`): go to [New project](#nieuw-project).
- **Existing**: go to [Existing project](#bestaand-project). If there is a worked example for this project, use it as a starting point, but check every fact again: the project may have changed in the meantime.

Ask in both cases: **solo or team?** Solo gets `.cursorrules` as a thin personal layer; team does not.

## New project

1. **Align.** Ask what the project does (one sentence), which apps (web, API, data, pipeline), whether there is a database, and whether it has an assignment or a client. Based on that, propose the command from the table in [new-project](new-project/INDEX.md), with `--starter`. **Stop** until the human agrees.
2. **Copy the kit:** `--dry-run` first, show the list, then for real. Follow [step 1](new-project/1-copy-the-kit.md).
3. **Context and boundaries:** fill in together with the human, [step 2](new-project/2-context-and-boundaries.md). Fill in nothing the human did not say; leave the `<placeholder>` and ask.
4. **Apps and feedback loop:** generators per stack, then the stack again with `--starter`, until `make check` is green. [Step 3](new-project/3-apps-and-feedback-loop.md).
5. **Agent:** finish `AGENTS.md` and (solo) `.cursorrules`, [step 4](new-project/4-agent.md).
6. Go to [Closing](#afsluiten).

## Existing project

Follow [bestaand-project](existing-project/INDEX.md), with these pauses.

### Phase 1 — Inventory and plan (read only)

1. The inventory from [step 1](existing-project/1-baseline-and-inventory.md): all docs, routers, rules, build output in git, sync leftovers, the largest files, the Makefile targets and package scripts per app.
2. The dry run of the kit, **without** `--starter`. Choose modules and stacks based on the inventory.
3. A kind and a destination for every file ([step 2](existing-project/2-classificeren.md)).
4. **Show the plan** to the human, in this shape, and **stop**:

   | Phase | Is executed | Changes |
   |------|------------------|-----------|
   | Feedback loop | … | which files are new, which targets renamed |
   | Clean up | … | what disappears from git (with counts), what goes away |
   | Move | … | every `git mv` (old → new), every code path that changes with it |
   | Router and map | … | what from the old router goes where |

   Plus: the questions (files without a clear place, choices between two tracks) and what you do **not** touch.

You only write after agreement. The plan goes as the move table into `docs/work/specs/reorganise.md` (copy the template by hand, see step 1). Ask whether the human wants a baseline ([meten](measurement/INDEX.md)); if so, that first.

### Phases 2 to 5 — Execute, each with a pause

| Phase | Step | Done when |
|------|------|-----------|
| 2 | [Feedback loop](existing-project/3-feedbacklus.md) | `make check` exists, covers every app and is green |
| 3 | [Clean up](existing-project/4-opruimen.md) | `git ls-files -ci --exclude-standard` is empty |
| 4 | [Move](existing-project/5-move.md): docs, data, apps, **only then** the kit | every row of the move table ticked off; no dead links |
| 5 | [Router and map](existing-project/6-router-and-map.md) | one `AGENTS.md`; solo a thin `.cursorrules`; nested `AGENTS.md` per app |

After every phase: `make check`, `git status --short`, a short list of what changed, a commit message, and **stop**. A phase with many moves (docs per folder) you may split into several pauses.

### Phase 6 — Measure and record

If there was a baseline: [step 7](existing-project/7-measure-and-record.md). Otherwise only the ADR "reorganise to the standard" with what changed and what deliberately did not.

## Already on the standard — kit delta

Use this if the project **already** has an `AGENTS.md`, `docs/INDEX.md` and `make check` (e.g. GymFreak after an earlier bootstrap), and you only want to catch up on new kit files + the router shape. No reorganise, no `--starter`.

1. **Dry run** (same modules/stacks as before; GymFreak: see [gymfreak.md](existing-project/examples/gymfreak.md)):

   ```bash
   bash _bootstrap/kit/new-project.sh . --modules <…> --stacks <…> --no-git --dry-run
   ```

   Show `+` (new) vs `=` (exists). **Never overwrite** an existing file with the script.

2. **New kit files** (`+`): run the script for real, or copy by hand. Typically: `docs/architecture/{observability,performance,dependencies,polyglot}.md`, how-tos, scripts, research radar/digest, example ADR `0000-…`.

3. **Merge existing files** (shape = kit, facts = project):

   | File | Do |
   |---------|------|
   | `AGENTS.md` | Kit shape: brief Never (RULES + security live; the rest via INDEX — **no** polyglot/keyword catalogue always-on); command table = daily + one sentence on opt-in → INDEX/`make help`; Working = hard read routes + intent/seams/slice brief. Keep the project facts. No eight always-on kit routes, no path table for rarely used docs. |
   | `docs/INDEX.md` | New satellites + "opt-in" for obs/perf/deps/polyglot; ARCHITECTURE line: not a PWA/auth dump. |
   | `Makefile` | Add the kit targets (`security-scan*`, `obs-*`, `perf-*`, `deps-audit`, `polyglot-check`, …) without wiping project targets. |
   | `docs/architecture/security.md` etc. | Only the missing sections (Strix, `## Deliberately later`); do not wipe the project list. |
   | A thick `ARCHITECTURE.md` (>~100 lines of runtime/auth catalogue) | Keep containers/stack/dataflow/hosting/seams; PWA/offline/push → `architecture/runtime-client.md`; JWT/demo/onboarding details → `architecture/auth.md` (or the existing data model/legal). Update INDEX. |
   | Kit docs that just came in | No `kit/stacks/…` paths, no "Agent Engineering source §…"; a native folder only if that stack exists. |

4. Solo: BACKLOG § Later/Parked for what the docs promise but the tooling still lacks (Strix install, OTel in apps, perf budgets, digest feeds, …) — see hard rule 8.
5. `make check` (and `polyglot-check` / `perf-check` where useful). `make deps-audit` may be red until the CVEs are fixed — do not quietly put it into `make check`.
6. Go to [Closing](#afsluiten) (remove the package).

## Closing

1. **Final check:**

   ```bash
   make check
   make docs-health
   bash _bootstrap/kit/new-project.sh . --modules <the same> --stacks <the same> --no-git --dry-run   # only deliberately skipped templates
   rg -n '\{\{PROJECT\}\}|\{\{DATE\}\}' --hidden --glob '!_bootstrap' --glob '!node_modules' .   # leeg
   rg -n '_bootstrap' --hidden --glob '!_bootstrap' --glob '!.git' .                             # empty: nothing points at the package
   ```

2. **Remove the package:**

   ```bash
   bash _bootstrap/scripts/bootstrap.sh --remove .
   git status --short          # no traces of _bootstrap
   ```

3. **Final report** to the human: what changed per phase, what deliberately stayed, the open questions, and the follow-up tasks outside the project (workspace rules, user rules). The links in this report must not point at `_bootstrap/`: that folder no longer exists.
