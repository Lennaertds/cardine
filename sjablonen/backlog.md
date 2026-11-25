# docs/work/BACKLOG.md

> **Role:** Index of open work: one short line + a link to the spec. No plan here.
> **Not here:** finished work (git and the logs), decisions ([adr](adr.md)), the plan of one item ([spec](spec.md)).

**Kit file:** [kit/solo/docs/work/BACKLOG.md](../kit/solo/docs/work/BACKLOG.md) · layer solo · P8, P27. Team: the issue tracker, no file. This is the persistent spine of open work (P27) — as an **index**, not as a notebook.

## When

Solo, from day 1. An agent does not read the backlog up front; the task names the item (or the link to the spec).

## Filling in

1. **Now:** only via `make spec s=<slug>` → an index line at the top of **Now** **plus** `specs/<slug>.md`. Never paste an essay or slices into the table.
2. **Later:** chosen, not started: one short line + why later. No spec until you promote it to Now (`make spec`).
3. **Parked:** idea/design that is waiting — with a plan: `make spec` + a line here; without: one short line + what it waits on. Parked is not `archive/`.
4. **The category is a column**, not a folder.
5. Finished: remove the line; `git rm` the spec after merge. Git and the log remember it.

## Example (GymFreak)

```markdown
## Now

| Item | Category | Status |
|------|----------|--------|
| [diet-budget](specs/diet-budget.md) | feature | slice 2 of 3 |
| [iphone-themes-slow](specs/iphone-themes-slow.md) | UI | open |

## Later

| Item | Category | Why later |
|------|----------|-----------|
| Weekly diet budget | feature | Daily budget live first |

## Parked

| Item | Category | Waiting on |
|------|----------|------------|
| [ai-vault](specs/ai-vault.md) | ML | consent flow for health data to the LLM |
```

## Quick check

- [ ] No finished items.
- [ ] Every **Now** row (and Parked-with-plan) is a markdown link to `specs/<slug>.md` — no loose essay cell.
- [ ] Every link works (`make links`).
- [ ] No item also sits as a TODO in a stable doc.
- [ ] An agent told to "put it on the backlog" runs `make spec`, it does not just edit BACKLOG.
