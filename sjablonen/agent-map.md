# docs/agent/

> **Role:** Agent working method that should not be loaded on every task: write permissions, doc conventions, lessons on meta tasks, reusable prompts.
> **Not here:** what applies to every task ([agents-root](agents-root.md)).

**Kit files:** [write-rules.md](../kit/modules/agent/docs/agent/write-rules.md), [doc-conventions.md](../kit/modules/agent/docs/agent/doc-conventions.md), [lessons.md](../kit/modules/agent/docs/agent/lessons.md), `prompts/` · module `agent`

## When

When `AGENTS.md` gets too long because of rules that only apply to one kind of task: writing docs, refactors across the whole project, reusable prompts. That keeps the root short (P1) and puts the rest one link away (P2).

## Filling in

| File | What | Reference in `AGENTS.md` |
|------|------|-------------------------|
| `write-rules.md` | per path: free, after permission, never, with the why. No read routes per kind of task — those belong in `AGENTS.md` § Working | "May I write this file? → write-rules" |
| `doc-conventions.md` | header, tone, tables or prose, length | "Writing or rewriting a doc → doc-conventions" |
| `lessons.md` | date, what went wrong, the lesson | none; what applies to every task moves to `AGENTS.md` |
| `prompts/<task>.md` | a prompt you use regularly (review, release notes) | none; you call it yourself with `@` |

## Example (GymFreak, `lessons.md`)

```markdown
| Date | What went wrong | Lesson |
|------|-----------------|--------|
| 2026-09-12 | The agent rewrote an old decision in DECISIONS.md instead of adding a new one | Never modify ADRs; now in AGENTS.md § Never |
| 2026-10-02 | On "clean up the docs" the agent also deleted `archive/` | Present meta tasks as a plan first; now in write-rules (archive: after permission) |
```

## Quick check

- [ ] Every file in this folder has exactly one reference in `AGENTS.md`, or none if it is only for you.
- [ ] No rule appears both here and in `AGENTS.md`.
