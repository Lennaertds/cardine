# docs/architecture/dependencies.md

> **Role:** Dependency hygiene: audits, ritual, faster/safer alternatives.
> **Not here:** Strix ([security](security.md)), budgets ([performance](performance.md)).

**Kit file:** [kit/kern/docs/architecture/dependencies.md](../kit/kern/docs/architecture/dependencies.md) · layer kern · P13, P17

## When

Day 0 with the kit text. At the first release: run `make deps-audit` once locally + in CI (`check-full`). Monthly: the ritual from the architecture doc. AGENTS: only via INDEX when the task names it.

## Filling in

1. Leave the audit table; the script skips stacks without those files.
2. For a deliberate CVE/licence compromise: an ADR, not silently in this file.
3. **`## Deliberately incomplete` (P28):** keep the kit rows or add project rows (P28). How-to: [deps-audit](../kit/kern/docs/how-to/deps-audit.md). No paths into Agent Engineering `bron/` in the project file.

## Quick check

- [ ] `make deps-audit` is green (or only the docs check + clear skips without the tool).
- [ ] `deps-audit` is in `make help` and in `check-full`, not in `CHECK` / `make check`.
- [ ] `## Deliberately incomplete` has at least one extension row (P28).
- [ ] The monthly ritual is known (or in the team calendar / BACKLOG reminder).
