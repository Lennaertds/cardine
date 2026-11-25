# .github/pull_request_template.md and ISSUE_TEMPLATE/

> **Role:** Every PR and every issue asks for the same things: what, why, how tested, which docs.
> **Not here:** the plan of a large item solo ([spec](spec.md)).

**Kit files:** [pull_request_template.md](../kit/team/.github/pull_request_template.md), [bug.md](../kit/team/.github/ISSUE_TEMPLATE/bug.md), [feature.md](../kit/team/.github/ISSUE_TEMPLATE/feature.md) · layer team · P8, P19, P22–P24

## When

Every team project, from sprint 0. The PR template is where "updating docs is part of the Definition of Done" becomes visible, plus review on intent and seams.

## Filling in

1. **PR:** what and why in one to three sentences, with a link to the issue. How tested. **Review:** a human or a fresh agent session; intent not weakened; no new module boundaries without an ADR (P19, P22, P23). Which docs were touched, or deliberately none.
2. **Feature issue:** the same fields as a [spec](spec.md): goal, out of scope, touchpoints (incl. seams), slices (one session), acceptance on intent. An agent can work from it directly.
3. **Bug issue:** what happens, what should happen, how to reproduce, and a test that fails before the fix.
4. Remove checkboxes that never apply in your team; a checkbox everyone ticks blindly says nothing.

## Example (DEP2, filled-in PR)

```markdown
## What and why

The drone flight loader converts `├п` to `ï` before the insert. Fixes #41.

## How tested

- [x] `make check` green (CI)
- [x] `make check-full` locally against the school DB: 3 new flights loaded, no duplicate plots

## Docs

- [x] Docs updated: `docs/architecture/case2-drone.md` (encoding pitfall)
```

## Quick check

- [ ] Every merged PR from the last sprint has "Docs" and "Review" filled in.
- [ ] A feature issue has something under "out of scope" and names the seams or "none".
- [ ] Nobody ticks "intent not weakened" blindly: spot-check one PR per sprint.
