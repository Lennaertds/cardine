# Existing project — step by step

> **Role:** Bring a running project to the standard without losing work or history.
> **Not here:** a new project ([nieuw-project](../new-project/INDEX.md)), the target structure itself ([skelet](../standard/skelet.md)).

Two rules up front:

1. **Measure before and after** (P21). Otherwise you do not know whether the reorganisation achieved anything.
2. **One step per commit**, moving with `git mv`. That way every step can be reverted on its own and every file keeps its history.

## What you copy

The script never overwrites anything, but it only looks at the target name. So: a dry run in step 1 to see what is missing, a few files by hand in steps 3 and 4, and the script for real only in step 5, **after** every existing file has its fixed name. Never `--starter` on an existing app.

```bash
kit/new-project.sh <project> --modules <modules> --stacks <stacks> --no-git --dry-run
```

| From the kit | When | What you do with what already exists |
|------------|---------|--------------------------------|
| `reorganise` (module) | step 1, by hand | `docs/work/specs/reorganise.md`: the move table |
| `stacks/<s>/apps/<app>/app.mk` | step 3, by hand | existing targets to the fixed names, the project's commands; see [step 3](3-feedbacklus.md) |
| `Makefile`, `scripts/check-links.sh` | step 3, by hand | own Makefile: rename it, use the kit version as the base, move the targets over |
| `.gitignore`, `.editorconfig`, `.pre-commit-config.yaml` | step 4, by hand | `.gitignore`: the kit block on top, project rules at the bottom until the data has moved |
| `docs/`, `data/`, `apps/<app>/AGENTS.md` | step 5, with the script | move to the fixed name first, then the script only fills the gaps |
| `AGENTS.md`, `docs/INDEX.md` | step 6 | the old router is the source, the kit version the shape |
| `.cursorrules` (solo) | step 6 | becomes the thin personal layer; the content moves to `AGENTS.md` |

If you do not want to go through this yourself, let an agent do it: [bootstrap package](../BOOTSTRAP.md).

## Steps

| Step | Time | Done when |
|------|------|-----------|
| [1. Baseline and inventory](1-baseline-and-inventory.md) | 1 hour | measurement C1 run; list of all docs and agent files; dry run reviewed |
| [2. Classify](2-classificeren.md) | 1 hour | every file has a kind and a purpose in the move table |
| [3. Feedback loop](3-feedbacklus.md) | 1 hour | `make check` exists and is green |
| [4. Clean up](4-opruimen.md) | 30 min | distractions, status and build output gone; `.gitignore` from the kit |
| [5. Move](5-move.md) | 1–3 hours | every file in its fixed place; links updated |
| [6. Router and map](6-router-and-map.md) | 1 hour | one `AGENTS.md`, one `docs/INDEX.md`; no second router |
| [7. Measure and record](7-measure-and-record.md) | 1 hour | measurement C2, comparison, ADR with the results |

## Order when you have little time

What pays off most per hour:

1. `make check` (P13) — [step 3](3-feedbacklus.md)
2. `AGENTS.md` with "Never" and commands (P6, P17) — [step 6](6-router-and-map.md)
3. Remove distractions and parallel tracks (P7, P16) — [step 4](4-opruimen.md)
4. Seams and deep modules before AI volume (P23) — architecture + tests on the seams, only then large agent refactors
5. Delete folder trees and lists (P5) — [step 5](5-move.md)
6. Rewrite the map (`INDEX.md`) (P2) — [step 6](6-router-and-map.md)
7. Glossary (P10)
8. Split decisions into ADRs (P9), only if the measurement asks for it

## Examples

| Project | Kind | Worked out |
|---------|-------|------------|
| GymFreak | solo, Next + Nest + Python, health data | [examples/gymfreak](examples/gymfreak.md): every file placed, steps G-0 to G-8 |
| Data_Engineering_Project_2 | team of five, Python ETL to MSSQL, sprints | [examples/dep2](examples/dep2.md): findings D1–D10, steps D-1 to D-7 |
