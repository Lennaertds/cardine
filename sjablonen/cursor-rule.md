# .cursor/rules/&lt;app&gt;.mdc

> **Role:** Rules Cursor loads automatically based on a glob or a description.
> **Not here:** rules for every tool ([agents-app](agents-app.md)), subagents per role ([cursor-agents](cursor-agents.md)).

**Kit file:** [kit/modules/cursor/.cursor/rules/_template.mdc](../kit/modules/cursor/.cursor/rules/_template.mdc) · module `cursor` · P15

## When

Only if you want something `AGENTS.md` cannot do: load on a glob (`apps/web/**/*.tsx`), load on a description, or manually with `@`. Preferably not in a team project: not everyone uses Cursor. The standard per app is a nested `AGENTS.md`; a `.mdc` only for what that cannot do, such as a rule per file type across apps.

**More `.mdc` instead of human docs is usually worse** (P15, P25, §8): always-on or duplicated content = harness tax and context clash. Do not migrate `docs/` to `.mdc`. Agent-facing language = dense imperatives, domain terms and pointers — no separate artificial language and no paper jargon in always-on rules.

## Audit before you add a `.mdc`

1. Is this already in the root or nested `AGENTS.md`? → do **not** copy it; cut it or link to it (P7).
2. Does it apply to *every* task? → it belongs in `AGENTS.md`, not in `.mdc` with `alwaysApply: true`.
3. Is it only for humans (why, onboarding)? → `docs/`, not `.mdc`.
4. Do you only need a Cursor glob/description? → `.mdc` is fine; content as short as the nested AGENTS rules.
5. Deletion test: remove the file — does agent behaviour still change? If not → delete it (P20).

## Filling in

1. **`description`:** when the rule applies, in one sentence. The agent decides on this whether to load it.
2. **`globs`:** as narrow as possible. `apps/web/**` for an app, `**/*.sql` for a language.
3. **`alwaysApply: false`**, unless it really applies to every task (then it belongs in `AGENTS.md`).
4. **Content:** patterns with a real example file, pitfalls, the one-test command. The same rules as in [agents-app](agents-app.md).
5. Copy the template to `<app>.mdc` and delete `_template.mdc` once every app has one.

## Example (GymFreak, `.cursor/rules/api.mdc`)

```markdown
---
description: Work in the GymFreak NestJS API (endpoints, services, migrations).
globs: apps/api/**
alwaysApply: false
---

- A new endpoint follows `apps/api/src/sleep/`: module, controller, service, `dto/`, engine with tests.
- Migrations in `src/database/migrations/` are never changed after merge; ask first.
- One test: `pnpm --filter @gymfreak/api exec jest src/diet/diet-engine.spec.ts`.
```

## Quick check

- [ ] The audit above is done (no duplicate of AGENTS, no docs→mdc migration).
- [ ] The glob only touches the files the rule applies to.
- [ ] No rule that is also in `AGENTS.md` or `apps/<app>/AGENTS.md` (context clash, §8).
- [ ] `alwaysApply: false` unless it really belongs in AGENTS.
- [ ] A workspace rule outside the repo that points at this project points at an existing path.
