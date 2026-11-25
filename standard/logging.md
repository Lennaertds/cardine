# Logging

> **Role:** How a project tracks what has been done and what is still open, without duplicating it or letting it go stale.
> **Not here:** the technical implementation (`kit/log/`), the Makefile targets ([makefile.md](makefile.md)).

## Principle

A project keeps **one structured status file** with all topics, their status, and a short log of what happened. The file is only updated when the user asks for it ("summarise and update") — not on every prompt or every commit.

This prevents:
- Duplicated information (the same open items in several files)
- Stale open items (finished topics that wrongly stay listed as "open")
- Empty or half-filled templates
- Conversation dumps that carry more noise than signal

## Structure

```
<project>/
├── logs/
│   ├── status-log.md       ← one overview table (active + done)
│   └── topics/
│       ├── T01-slug.md     ← detail pages for open topics
│       └── T02-slug.md
```

### `logs/status-log.md`

The central overview. It contains:

1. **A header** with the role and the date of the last update
2. **A 🔴 In progress section** — topics actively being worked on
3. **A 🟡 Open section** — topics that still have to happen
4. **A ✅ Done section** — finished topics, kept for reference (agents can read them when the topic is relevant, but they are out of the way)
5. **A Log table** at the bottom for short `make finish` lines

Every topic has a unique ID (T01, T02, …) and a detail file in `logs/topics/`.

### `logs/topics/T01-slug.md`

A detail page for a topic that is still open or needs extensive notes:

- **What** — what the topic is about
- **Why** — why it has to be done
- **Approach** — how it will be tackled
- **Log** — what has happened so far (date + action)
- **Next step** — what the next action is

Finished topics stay in `logs/topics/` (for reference), but no longer get a place in the active table of `status-log.md`.

## When to update

| Action | What happens |
|--------|--------------|
| `make finish MSG="..."` | Writes one log line at the bottom of `status-log.md` (in the Log table) |
| "Summarise and update" | The agent reads `status-log.md`, takes stock of the current chat, adds new topics / updates existing ones, and moves ✅ done topics to the reference section |
| A topic is ✅ | The agent moves it to the ✅ section in `status-log.md`; the detail file stays |

## ID management

- IDs are assigned on creation: T01, T02, T03, …
- A new topic gets the next free number
- Deleted or merged IDs are never reused (P5: do not hide gaps)

## See also

- [makefile.md](makefile.md) — the `make finish` target
- [kit/logging/](../kit/logging/README.md) — templates for the status log and topics
