# docs/context/assignment.md

> **Role:** What the school or client asks for, how it is assessed, and by when.
> **Not here:** how you solve it ([architecture](architecture.md)), what you submitted (`docs/deliverables/`).

**Kit file:** [kit/modules/assignment/docs/context/assignment.md](../kit/modules/assignment/docs/context/assignment.md) · module `assignment`

## When

For every project with a client: a course, an internship, a customer. Day 0, as soon as you have the assignment.

## Filling in

1. **Client and contact:** course or client, name and channel. No private phone numbers in git.
2. **Assignment in your own words:** three to five sentences; quote literally where it matters. The source document itself goes to `deliverables/` or stays in the learning environment.
3. **Assessment criteria:** with the weight and **where you demonstrate it**. That last column is your checklist for the delivery.
4. **Deadlines:** date, what, status.
5. **Preconditions:** mandatory technology, what is not allowed.

## Example (DEP2)

```markdown
## Assessment criteria

| Criterion | Weight | Where we demonstrate it |
|-----------|--------|-------------------------|
| Star schema and ETL | 30 % | `docs/architecture/database.md`, demo step 2 |
| Data quality | 20 % | `make check-full` (checks on empty and duplicate measurements) |
| Collaboration | 20 % | PRs with review, sprint reports in `docs/work/meetings/` |

## Preconditions

- Database: the school's MSSQL; no cloud services outside the EU.
- Group of five; every member has PRs in the history.
```

## Quick check

- [ ] Every criterion has a place where you demonstrate it.
- [ ] The deadlines are in there with a date.
- [ ] No personal data of teachers or clients beyond name and work channel.
