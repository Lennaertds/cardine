# docs/work/specs/&lt;slug&gt;.md

> **Role:** The plan for one work item: goal, scope, touchpoints, slices, acceptance. Temporary.
> **Not here:** the behaviour that stays ([product](product.md)), the why of a choice ([adr](adr.md)).

**Kit file:** [kit/solo/docs/work/specs/_template.md](../kit/solo/docs/work/specs/_template.md) · layer solo · P1, P18, P22–P24, P27. Team: the [feature issue](pr-template.md).

## When

Every new item on **Now** (and Parked with a plan): always `make spec`. The BACKLOG is only the index; this file is the plan. A micro fix without a backlog line: no spec needed.

```bash
make spec s=diet-budget     # spec + an index line at the top of BACKLOG § Now
```

Then fill in the placeholders in the spec (goal, scope, slices). Never dump the plan into the BACKLOG table.

## Filling in

1. **Goal:** what the user can do afterwards, and why.
2. **Out of scope:** explicitly, including what seems obvious. This keeps the agent inside the lines.
3. **Touchpoints:** modules, the interface that changes, **seams involved** (P23), and an **example to follow**.
4. **Slices:** vertical, each separately testable and within **one session** (P1, P24). If a slice does not fit in one window: split further.
5. **Acceptance:** intent + tests/commands, always with `make check`. Passing by weakening a product rule does not count (P22).
6. After merge: delete the spec (`git rm`). The code and the tests are then the truth; what stays goes to `product/` or an ADR. Until then the spec (+ BACKLOG) is the *spine* of the task (P27).

## Example (GymFreak)

```markdown
# Spec — diet-budget

## Goal

Each day the user sees how many kcal and how much protein they have left, so in the evening they know what they can eat.

## Scope

- **In:** calculate the daily budget from the profile, show the remainder on the diet screen.
- **Out of scope:** meal suggestions, weekly budget, import from MyFitnessPal.

## Touchpoints

- `apps/api/src/diet/`, `apps/web/src/features/diet/`
- New endpoint `GET /diet/budget?date=YYYY-MM-DD`
- Example to follow: `apps/api/src/sleep/` (engine with pure functions + tests)

## Slices

1. `diet-engine.ts`: budget from the profile, with tests for the edge cases (no profile, negative remainder).
2. Endpoint + integration test.
3. Card on the diet screen.
```

## Quick check

- [ ] There is at least one thing under "out of scope".
- [ ] Each slice can be merged separately and fits in one clean session.
- [ ] The seams involved are named (or "none").
- [ ] The acceptance is executable and guards intent, not just "works fine".
