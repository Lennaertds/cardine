# docs/how-to/&lt;task&gt;.md

> **Role:** One task step by step: deploy, reset a database, load data, release.
> **Not here:** why it works that way ([architecture](architecture.md)), the command itself if it is one line (the Makefile).

**Kit file:** none; the folder [kit/kern/docs/how-to/](../kit/kern/docs/how-to/) is ready · layer kern

## When

When a task is more than one make target, and you do it less than monthly (so you forget the steps). If it is one command, make a make target with `## explanation` instead of a how-to.

## Filling in

Use this shape:

```markdown
# <Task as a verb, e.g. "Reset the databases">

> **Role:** <when you need this>
> **Not here:** <why it works that way → architecture/…>

## Before you start

- <What has to be right: .env, access, backup.>

## Steps

1. `<command>` — <what you see if it goes well>
2. …

## When it goes wrong

| Message | Cause | Fix |
|---------|-------|-----|
```

## Example (DEP2, `how-to/reset-databases.md`)

```markdown
## Steps

1. `make status` — the staging and DWH databases are running.
2. `bash scripts/reset_staging.sh` — **wipes all staging tables**. Ask the team in the channel first.
3. `bash scripts/reset_dwh.sh` — after a staging reset, always reset the DWH too, otherwise facts point at nothing.
4. `make data` — the full pipeline (± 25 min; the root measurement takes ± 10 min).

## When it goes wrong

| Message | Cause | Fix |
|---------|-------|-----|
| `Violation of PRIMARY KEY` in `FactRootMeasurement` | DWH not reset after staging | step 3, then step 4 |
```

## Quick check

- [ ] Every step is a command you can paste, with what you see afterwards.
- [ ] Destructive steps are in bold, with whom to ask first.
- [ ] `docs/INDEX.md` § How-to has a line for this file.
