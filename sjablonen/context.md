# docs/context/CONTEXT.md

> **Role:** Why the project exists, for whom, and what success is.
> **Not here:** technical detail ([architecture](architecture.md)), boundaries ([rules](rules.md)), long term ([vision](vision.md)).

**Kit file:** [kit/kern/docs/context/CONTEXT.md](../kit/kern/docs/context/CONTEXT.md) · layer kern · P6

## When

Day 0, before the first line of code. After that, only change it when the audience or the scope really changes.

## Filling in

1. **User or client:** one concrete persona or client in a concrete situation.
2. **Problem:** what goes wrong today, as a fact. No solution yet.
3. **Goal and success:** testable. For school or a client also what the client counts as success.
4. **Scope:** at the level of domains or cases, not features. Keep the kit line about languages/polyglot, or sharpen it.
5. **Deliberately not:** with the why. With a `product/` folder, link to `PRODUCT.md` § Deliberately not.

## Example (DEP2)

```markdown
## User or client

CADS, trial farm Bottelare. Researchers who compare silage maize varieties on root growth,
plant count (drone) and soil moisture (Kurosens), and currently do that in loose Excel files.

## Goal and what success is

- One data warehouse in which every measurement of the three cases can be compared per plot and variety.
- The client reruns the pipeline after a new measurement campaign, without us.

## Deliberately not

- No in-house image recognition on the root scans: we use the output of RootScan.
```

## Quick check

- [ ] Someone who reads only this can say who it is for and when it has succeeded.
- [ ] No stack, no hosting, no planning.
- [ ] Every "deliberately not" has a reason.
