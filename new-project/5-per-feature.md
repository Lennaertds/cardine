# Step 5 — Per feature

> **Role:** The fixed loop for every piece of work: plan, build in slices, check, update docs.
> **Not here:** the spec template ([spec](../sjablonen/spec.md)), how to review an agent ([bron P19](../bron/principes.md)).

## Before

| Task | Do |
|------|----|
| Small: the diff fits in one sentence | Do it straight away, no spec |
| Large or uncertain | `make spec s=<slug>` (solo) or an issue (team): goal, **out of scope**, touchpoints, slices, acceptance |
| Touches a choice with a why | `make adr t="…"` first, then build |

Split into **vertical slices** that each fit in one clean session and are each separately testable (P1, P18, P24). A slice goes through the whole stack: table, endpoint, screen. Name in the spec which **seams** you touch (P23).

## During

- **One task per session.** After two failed corrections: a new session with a better prompt (§12). Large tasks: sub-agents or parallel narrow contexts instead of one polluted window (P24).
- **Test first:** let the agent write a failing test, then the code (§2, §7). The test must preserve the **intent**, not weaken it (P22).
- **Point at an example:** "follow the pattern of `apps/api/src/sleep/`".
- **Model choice (P26):** routine tasks (renaming, formatting) with a small/fast model if the tool allows it; open design and tricky bugs with a frontier model.
- Branch `feat/<slug>`, the same slug as the spec. The task status lives in BACKLOG/issue, not only in the chat (P27).

## After

1. `make check` green, with the output as proof. Before a release: `make check-full`.
2. Review of the diff: yourself, or by an agent in a **new** session (P19). Check explicitly: intent intact, no new module boundaries without an ADR (P22, P23).
3. Docs the change touches: only those. New decision → ADR. New doc → a line in `docs/INDEX.md`. Seams changed → update `ARCHITECTURE.md`.
4. Solo: `make log`, tick the item off in `BACKLOG.md`, delete the spec. Team: fill in the PR template (Review + Docs).
5. **Did the agent repeat an earlier mistake?** One line in `AGENTS.md` or the nested version, or better a test or hook (P20). No extra rule "to be safe" (P25).

## Example (GymFreak, solo)

```bash
make spec s=diet-budget                 # docs/work/specs/diet-budget.md + a line in BACKLOG § Now
git switch -c feat/diet-budget
# session 1: slice 1 — column + migration + endpoint, with a test
# session 2: slice 2 — screen in features/diet/, with a test
make check
make log                                # docs/work/logs/2026-10-19.md
git rm docs/work/specs/diet-budget.md   # after merge; the code and tests are the truth now
```
