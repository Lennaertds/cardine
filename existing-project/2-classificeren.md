# Step 2 — Classify

> **Role:** Decide for every file what it is and where it belongs, before you move anything.
> **Not here:** the moving itself ([step 5](5-move.md)).

## Decision rules for every file, in order

Walk through every file or folder with these questions. The first "yes" decides the place.

1. **Is it generated or rebuildable** (build output, cache, test report, screenshot of a test run)? Then it does not belong in git: `tmp/`, `data/interim/` or the tool's folder. Exception: small demo data in `data/processed/demo/`.
2. **Is it secret or personal data?** Then it belongs in `.env`, `data/raw/` or `data/runtime/`, and never in git.
3. **Is it empty, duplicated, a sync conflict or generator boilerplate?** Then it may go.
4. **Does it belong to another project?** Then it moves to that project, or to your personal backlog.
5. **Is it code that runs?** Then it belongs in `apps/<app>/` following [stacks](../standard/stacks.md), or in `packages/`.
6. **Does it check something?** Then it is a test ([stacks §1](../standard/stacks.md#1-every-app)).
7. **Is it data?** Then it belongs in a layer from [data](../standard/data.md).
8. **Is it an image?** If the site shows it, it belongs in `public/`. If a doc shows it, it belongs in `docs/assets/`.
9. **Is it text?** Use the table below, per section.

A file that answers two questions, you split (P11). A file for which no rule fits is a gap in the standard: add a row to [where does this belong](../standard/where-does-this-belong.md).

## Kinds of text

Go through the quick test for documentation rules in [principes.md](../bron/principes.md#snelle-toets-voor-elke-regel-documentatie) per file, and per section for large files:

| Kind | How to recognise it | Destination |
|------|---------------------|-------------|
| **Derivable** | Folder tree, list of files, configs or tests, per-file description | Delete. A per-module description becomes the docstring of that module |
| **Duplicate** | The same fact sits in two places | Pick one place, link from the other |
| **Status** | "latest changes", TODO, sprint state, "currently working on" | `docs/work/` (solo) or the issue tracker (team) |
| **Decision** | "we chose X because…" | ADR in `docs/decisions/` |
| **Boundary** | "never", "always", "may not" | `RULES.md`, or a hook or test if it can be enforced |
| **Pitfall** | "watch out", encoding problems, odd edge cases | At the subsystem in `architecture/`, and briefly in `AGENTS.md` if it can come up on every task |
| **How** | Steps, commands | `how-to/`, or the command table of `AGENTS.md` and a make target |
| **Architecture** | Components, dataflow, who writes where | `ARCHITECTURE.md` or `architecture/<subsystem>.md` |
| **Product** | What the user can do, rules of a domain | `product/<domain>.md` |
| **Domain knowledge** | Literature, sources, research | `research/` |
| **Distraction** | Old versions, parallel tracks, `_v3` files, docs about deleted code | Out, or `docs/archive/` with an exclusion in the map |

## In the move table

Fill in **Becomes** and **Why** for every row. The why is a decision rule (`rule 3`), a kind (`status`) or a principle (`P5`). Example:

| Now | Becomes | Why | Done |
|-----|---------|-----|------|
| `docs/PROJECT_STRUCTURE.md` § tree | removed | derivable (P5) | [ ] |
| `docs/PROJECT_STRUCTURE.md` § hosting and ports | `docs/architecture/ARCHITECTURE.md` | architecture | [ ] |
| `last_changes.md` | issues in the tracker, then removed | status (P8) | [ ] |
| `configs/case1_v3.json`, `_v4` | `configs/archive/` or removed; ADR on which is canonical | distraction | [ ] |

Worked out in full: [GymFreak](examples/gymfreak.md#place-of-every-file), [DEP2](examples/dep2.md#target-structure-docs).
