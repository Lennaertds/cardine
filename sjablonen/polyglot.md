# docs/architecture/polyglot.md

> **Role:** When extra/native languages are allowed; decision tree and agent boundaries.
> **Not here:** budgets ([performance](performance.md)), containers ([architecture](architecture.md)).

**Kit file:** [kit/kern/docs/architecture/polyglot.md](../kit/kern/docs/architecture/polyglot.md) · layer kern · P13, P23, P28
**Example ADR:** [0000-example-native-module-after-budget-breach.md](../kit/kern/docs/decisions/0000-example-native-module-after-budget-breach.md)

## When

Day 0 with the kit text. At the first budget breach that asks for native: a real ADR via `make adr` (do not leave the 0000 example there as if it were binding). AGENTS: no always-on polyglot link; the agent finds this via INDEX when the task names native/FFI. **No** assumption that `apps/native` exists without the stack.

## Filling in

1. Leave the decision tree and integration table; add project notes only where you deviate (ADR).
2. Write project paths (`apps/native`), not kit source paths (`kit/stacks/rust`) — those do not exist in the project.
3. **`## Deliberately incomplete` (P28):** keep the kit rows or extend them (P28).
4. CONTEXT/ARCHITECTURE: the kit already has references; do not remove them without an ADR.
5. Soft vs hard FFI: [how-to/native-ci.md](../kit/kern/docs/how-to/native-ci.md); team `native.yml` with `--team` + native stacks.

## Quick check

- [ ] `make polyglot-check` is green.
- [ ] `polyglot-check` is in `make help`, not in `CHECK` / `check-full`.
- [ ] `native-bindings-strict` / `NATIVE_STRICT` via `check-full` or the how-to.
- [ ] The doc says explicitly: a native folder only with that stack + an ADR.
- [ ] `## Deliberately incomplete` has at least one extension row (P28).
- [ ] AGENTS has no always-on polyglot path; INDEX + `polyglot.md` cover "no assumption, no Rust" / native after measurement + ADR.
