# Step 6 — Router and map

> **Role:** One `AGENTS.md` and one `docs/INDEX.md`, built from what made the old router file valuable.
> **Not here:** what belongs in a router ([agents-root](../sjablonen/agents-root.md)), the map ([docs-index](../sjablonen/docs-index.md)).

## Do

1. **The kit's `AGENTS.md` as the shape, the old router as the source.** Take over from the old file only what passes the test of P5 and P6:

   | In the old router | Goes to |
   |-------------------|---------|
   | "never", "may not", security, data | `AGENTS.md` § Never (brief) and `RULES.md` or `security.md` (explanation) |
   | commands, scripts | `AGENTS.md` § Commands, with the make targets from step 3 |
   | working method: plan first, follow patterns | `AGENTS.md` § Working |
   | Strix / obs / perf / deps / polyglot / radar | Keyword table in § Working + INDEX — **not** as always-on numbered steps or eight command rows |
   | what you do before you finish | `AGENTS.md` § Finishing |
   | write permissions per path | `docs/agent/write-rules.md` (module `agent`), one line in `AGENTS.md` |
   | "on UI read X" / read routes per kind of task | `AGENTS.md` § Working (one line); detail in `DESIGN.md` / `PRODUCT.md` — **not** in `write-rules.md` (the agent only opens that on write questions) |
   | lessons after failures | what applies to every task: `AGENTS.md`; the rest: `docs/agent/lessons.md` |
   | folder tree, list of docs | out (the map and `ls`) |
   | status, "currently working on" | `docs/work/` or the tracker |

2. **No second router.** A separate `CLAUDE.md` or `copilot-instructions.md` with its own content: delete it, or make it a symlink to `AGENTS.md` (module `claude`). Two routers with different content cause a context clash (§8).

   **Solo: `.cursorrules` stays, but goes thin.** Empty it first following the table above, then replace it with [kit/solo/.cursorrules](../kit/solo/.cursorrules): the reference to `AGENTS.md` plus your personal preferences, ≤ 15 lines, nothing duplicated ([guide](../sjablonen/cursorrules.md)). In a team project it goes away.

3. **A nested `apps/<app>/AGENTS.md` per app** from the stack: every tool reads it, and Cursor loads it as soon as you work in that folder. If `.cursor/rules/<app>.mdc` files with the same role exist, merge their content into the nested `AGENTS.md` and delete them. Keep a `.mdc` only for what `AGENTS.md` cannot do, such as loading on a file type (`**/*.sql`) across apps.

4. **`docs/INDEX.md` from the kit**, with per file the question it answers and when not. Links only to files that exist.

5. **Align rules outside the repo.** A workspace rule that says something different from the router makes the agent unsure. Let the workspace rule point at the router ("inside a project the router of that project wins").

## Done when

- There is exactly one router file with content (`AGENTS.md`); the others are symlinks or gone. Solo, next to it sits a `.cursorrules` of ≤ 15 lines that repeats nothing from `AGENTS.md`.
- `make docs-health`: root `AGENTS.md` under 70 lines (aim ~50), each nested one under 40.
- The fresh-agent test from [new-project step 4](../new-project/4-agent.md#test-with-a-fresh-agent) passes.
