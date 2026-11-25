# docs/product/

> **Role:** What the product does, per domain, seen from the user: behaviour, rules, edge cases.
> **Not here:** screens ([design](design.md)), tables and endpoints ([architecture](architecture.md)).

**Kit files:** [PRODUCT.md](../kit/modules/product/docs/product/PRODUCT.md) and [_template.md](../kit/modules/product/docs/product/_template.md) · module `product` · P6, P11, P22

## When

As soon as there is more than one domain, or as soon as product rules (what counts as a workout, how a budget is calculated) no longer fit in a spec. A spec describes a change and disappears; `product/` describes the behaviour that stays.

## Filling in

1. **`PRODUCT.md`:** the table of the domains (the same names as in the glossary), with status and link, plus **Deliberately not**.
2. **Per domain** a copy of `_template.md` as `<domain>.md`. A code in front is fine (`H-gym.md`), as long as the topic is in the name.
3. **Rules** with the why and the test that guards them. That is **intent** (P22): a test that passes by weakening the rule fails on intent. The agent may not silently bypass RULES/product to get green.
4. **Edge cases:** empty data, duplicates, time zones, units. This is where what the agent cannot get from the code lives.

## Example (GymFreak, `S-sleep.md`)

```markdown
## Rules

| Rule | Why | Guarded by |
|------|-----|------------|
| A night counts from 18:00 to 18:00 the next day | naps and late nights land on the right day | `sleep-engine.spec.ts` |
| Two sources for the same night: Health beats manual | Health measures, manual is an estimate | `sleep-merge.spec.ts` |

## Edge cases

- Daylight saving time: a night of 23 or 25 hours is valid.
- Import without sleep stages: show total duration only, no stage chart.
```

## Quick check

- [ ] Every domain in `PRODUCT.md` has a file, and every file has a row.
- [ ] No screen descriptions and no table names.
- [ ] Every rule has a why and a guard; bypassing that guard would violate the rule.
