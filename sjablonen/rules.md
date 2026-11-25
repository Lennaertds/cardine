# docs/rules/RULES.md

> **Role:** The content boundaries of the project: what it never does, and what always has to be true.
> **Not here:** code style (the linter), the agent's working method ([agents-root](agents-root.md)), technical measures ([security](security.md)).

**Kit file:** [kit/kern/docs/rules/RULES.md](../kit/kern/docs/rules/RULES.md) · layer kern · P6, P14, P22

## When

Day 0 with the three to five boundaries you already know. Every new boundary set by a client, a teacher or yourself goes in straight away.

## Filling in

1. **One sentence per rule, with the why.** Without the why, nobody can decide an edge case.
2. **Never** for what the product may not do; **Always** for what has to be in every feature.
3. **Enforceable?** Write the test, hook or CI check, and link to it. A rule that lives only here will be broken sooner or later. The test must preserve the **intent**: passing by weakening the rule does not count (P22).
4. Working method ("do not commit") belongs in `AGENTS.md`, not here. Here goes what the **product** may do.

## Example (GymFreak)

```markdown
## Never

- No medical advice: the app shows trends and sources, no diagnoses or treatments.
- No health data to an external LLM unless the user allows it each time.
  Enforced by `apps/api/src/llm/consent.guard.spec.ts`.
- No dark patterns to keep the streak.

## Always

- Every recommendation shows its source (a paper from `data/reference/evidence/` or one of our own rules).
- A user can export and delete all of their data.
```

## Quick check

- [ ] Every rule has a why.
- [ ] No rule about code or tools; those belong in `AGENTS.md` or the linter.
- [ ] What is enforceable links to its test or hook — and that test does not bypass the rule.
