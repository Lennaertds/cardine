# Spec — bootstrap-no-stack-until-adr

> **Role:** Plan for one work item. Temporary: delete after merge; the code and the tests are the truth then.

- **Item:** [BACKLOG.md](../BACKLOG.md)
- **Status:** open

## Goal

BOOTSTRAP step 2 stays finished; no step 3 / `--starter` / stack until an explicit Pi/TS choice + ADR (0001).

## Scope

- **In:** Make sure agents add no generators/stack; kit deltas (docs/AGENTS) stay fine.
- **Out of scope:** The runtime choice itself (separate Later/ADR); building apps.

## Touchpoints

- Modules and files: `AGENTS.md`, `docs/decisions/0001-…`, `README.md`
- Seams involved: none
- Example to follow: ADR 0001

## Slices (each separately testable, one session)

1. On every bootstrap/kit delta: confirm there is no stack; point to this spec + ADR 0001.
2. After the runtime ADR: tick this item off and open step 3.

## Acceptance

- [ ] No `apps/<stack>` without an ADR
- [ ] `make links` is green
