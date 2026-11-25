# Step 4 — Agent

> **Role:** Fill in `AGENTS.md` and the map with only what is true now, and test with a fresh agent.
> **Not here:** what belongs in an `AGENTS.md` ([agents-root](../sjablonen/agents-root.md)), why it must be short ([bron P1–P3, P20](../bron/principes.md)).

## Do

1. **Fill in `AGENTS.md`** ([guide](../sjablonen/agents-root.md)):
   - **Never:** the boundaries for secrets, data and git are already there. Add what is specific to this project (e.g. "never change `apps/api/src/database/migrations/` after merge"). Obs/perf/deps not as always-on links.
   - **Commands:** the daily table is there; fill in "one test" per stack. Opt-in targets stay under `make help` + INDEX (no path catalogue in AGENTS).
   - **Working:** hard read routes; opt-in via a task → INDEX; a real example file (`apps/api/src/sleep/sleep.service.ts`). Keep **intent**, **seams** and **one slice** short (P22–P24); cut essays, not the core.
2. **Check the nested `apps/<app>/AGENTS.md`**: the kit installed them with stack rules. Delete what does not apply, add the pitfalls ([guide](../sjablonen/agents-app.md)).
3. **`docs/INDEX.md`**: links only to files that exist. Replace the `<…>` lines or delete them ([guide](../sjablonen/docs-index.md)).
4. **Solo: `.cursorrules`** from the kit, filled in with your personal preferences, ≤ 15 lines, repeating nothing from `AGENTS.md` — duplication = harness tax (P25) ([guide](../sjablonen/cursorrules.md)). Use the same rules in every project, so every project feels the same.
5. **Other tools:** module `claude` for `CLAUDE.md` → `AGENTS.md`; module `cursor` for path rules **and** subagents in `.cursor/agents/` ([cursor-rule](../sjablonen/cursor-rule.md), [cursor-agents](../sjablonen/cursor-agents.md), [agent-rollen](../standard/agent-rollen.md)). The `design` / `product` / `research` modules install their own role agent.
6. **Guardrails:** the pre-commit hooks from the kit run after `make setup`. Add an agent hook (e.g. lint after every edit) only once the agent really makes that mistake (P14, P20).

## Test with a fresh agent

Open a new session without history and give it:

> Add a small feature: <something of ten minutes>. Finish the way it should be done.

| Check whether the agent | If not |
|-------------------------|--------|
| runs `make check` on its own and shows the output | command at the top of `AGENTS.md`, as step 1 of Finishing |
| opens the map and picks one doc, not a whole folder | link to the map at the top; INDEX per question |
| on a UI fix (module `design`) opens `DESIGN.md` first, then one craft file — not just code/screenshots | hard read route in `AGENTS.md` § Working; map in `DESIGN.md` sharpened |
| on "use subagents" (module `cursor`) picks the fitting `.cursor/agents/` instead of doing everything in one window | rule in `AGENTS.md`; `description` in the agent files; [agent-rollen](../standard/agent-rollen.md) |
| after "implement" / "build" / "yes" writes code in the same turn, without replanning or asking again | "doing beats talking" rule in `AGENTS.md`; plan-first in `.cursorrules` gets a carve-out |
| follows the pattern of the example file | more concrete example in Working |
| breaks no "Never" rule | sharper rule, or better: a hook or test (P14) |
| does not weaken product intent to get green | intent rule in Working; product rule + test sharpened (P22) |
| adds no new `utils/` or module without asking | seam rule + ARCHITECTURE § Seams (P23) |
| finishes one slice instead of three at once | slices in the spec; "one slice per session" (P24) |
| writes a log or PR summary | step 4 of Finishing (spine, P27) |

## Done when

- `make docs-health` shows the root `AGENTS.md` under 70 lines (aim for ~50), each nested one under 40.
- The test passes. What went wrong has become a rule or a test.
