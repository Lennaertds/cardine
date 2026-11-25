# Template: Keeping a status log

> **Guide for:** `logs/status-log.md` (from `kit/logging/`) and `logs/topics/T*.md`

## Filling in `logs/status-log.md`

### When
The file is created when a project is bootstrapped. It is updated at the user's request ("summarise and update") or via `make finish MSG="..."`.

### Filling in

1. **Header** — replace `{{DATE}}` with the date of creation
2. **🔴 In progress** — topics actively being worked on right now, with a short note
3. **🟡 Open** — topics that still have to happen
4. **✅ Done (reference)** — finished topics, moved out of the active tables
5. **Log** — `make finish` writes lines here (| date | what |)

### Example

```markdown
# Status log

> **Role:** the single source of truth on what has been done and what is still open.
> **Updated:** 2025-11-19
> **See also:** `logs/topics/` for details per topic

## 🔴 In progress

| ID | Topic | Last update | Notes |
|----|-------|-------------|-------|
| T01 | Build the token logger | 2025-11-19 | Investigate DSH hooks |

## 🟡 Open

| ID | Topic | Last update | Notes |
|----|-------|-------------|-------|
| T02 | Turn the structure plan into kit | 2025-11-19 | Three-place rule |

## ✅ Done (reference)

| ID | Topic | Last update | Notes |
|----|-------|-------------|-------|
| T04 | Set up make finish | 2025-11-19 | Status log works |

---

## Log

| Date | What |
|------|------|
| 2025-11-19 | Project started, status log created |
```

### Quick check

- [ ] Are all open topics in there (no gaps)?
- [ ] Have finished topics been moved to ✅ (not duplicated)?
- [ ] Is the date in the header correct?

## Filling in `logs/topics/TX-name.md`

### When
A detail page is created for a new topic that needs extensive notes. Light topics can make do with the notes column in `status-log.md`.

### Filling in

1. **ID** — use the next free number (T01, T02, …); do not reuse gaps
2. **Status** — 🔴 In progress / 🟡 Open / ✅ Done
3. **What** — concrete description of what needs to happen
4. **Why** — the goal or the motivation
5. **Approach** — how it will be tackled (e.g. which tracks, steps, methods)
6. **Log** — date + action, grows with every update
7. **Next step** — what the next action is

### Example

```markdown
# T01: Token logger for DeepSeekHarness

**Created:** 2025-11-19
**Status:** 🔴 In progress
**Priority:** High

## What
A post-request hook in DeepSeekHarness that parses every API response
(prompt_tokens, completion_tokens, model, timestamp) and writes it to
a local file (CSV/JSONL).

## Why
Deeper insight than the DeepInfra dashboard; own measurements + aggregation.

## Approach
- Track A: check DSH plugins/hooks
- Track B: search the Zed assistant logs
- Track C: build a proxy logger

## Log
| Date | What was done |
|------|---------------|
| 2025-11-19 | Read the environment variables, discovered the sandbox limit |

## Next step
Investigate track A further (plugins directory)
```

### Quick check

- [ ] Is the ID in the table of `status-log.md`?
- [ ] Is the status the same as in the table?
- [ ] Is the next step in there (so an agent can continue)?

## Finishing a topic

1. Set the status to ✅ in the detail file
2. Move the row in `status-log.md` from 🔴/🟡 to ✅
3. The detail file stays (reference for agents that ask for it)

## Adding a topic

1. Pick the next free ID (check the existing IDs in `logs/topics/`)
2. Create `logs/topics/T<ID>-<slug>.md` from the template
3. Add a row in the right section of `status-log.md`

See [standard/logging.md](../standard/logging.md) for the full rules.
