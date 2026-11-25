# docs/work/logs/YYYY-MM-DD.md

> **Role:** What happened that day, what went wrong, and where you start tomorrow.
> **Not here:** decisions ([adr](adr.md)), open work ([backlog](backlog.md)).

**Kit file:** [kit/solo/docs/work/logs/_template.md](../kit/solo/docs/work/logs/_template.md) · layer solo · P8, P20, P27. Team: the PRs are the log. Together with BACKLOG, the *spine* of ongoing work — not the chat history.

## When

Every turn with a repo change, when finishing — without the user asking for "log". `make log` creates today's file if it does not exist yet and shows the path; the agent then adds an entry at the top under `## Done`.

## Filling in

1. **Done:** with the backlog item or the commit. Short; the diff says the rest.
2. **Went wrong:** what did not work and what you learned from it. **This is the most valuable section**: a mistake that appears twice in the log becomes a line in `AGENTS.md` or a test.
3. **Next:** where you start tomorrow, so a new session knows straight away.

You do not read logs up front. Search: `rg -n 'clean-web' docs/work/logs`.

## Example (GymFreak)

```markdown
# 2026-10-19

## Done

- diet-budget slice 1: `diet-engine.ts` with 6 tests (feat/diet-budget).

## Went wrong

- The agent started `make dev-web` after a build and got `Cannot find module './812.js'`. Second time this month
  → pitfall added to `apps/web/AGENTS.md`.

## Next

- Slice 2: endpoint `GET /diet/budget`, integration test following the sleep example.
```

## Quick check

- [ ] "Went wrong" is filled in, or deliberately empty.
- [ ] No decision lives only here.
