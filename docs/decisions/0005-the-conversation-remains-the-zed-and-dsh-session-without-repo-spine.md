# 0005 — The conversation stays the Zed and DSH session, without a repo spine

- **Status:** accepted
- **Date:** 2026-11-16
- **Touches:** [session-spine.md](../product/session-spine.md), [totaalproduct.md](../product/totaalproduct.md), [PRODUCT.md](../product/PRODUCT.md), [BACKLOG.md](../work/BACKLOG.md). The `onderdeel-session-spine` spec was removed — the product doc suffices.

## Summary

In the context of a chat whose history hangs on the workspace path in Zed, Claude and Cursor, faced with a `.agent/` directory that couples it no better, we chose the existing Zed panel and DSH session over a repo spine, in order not to build a second memory, and we accept that a renamed directory leaves the conversation on the old path.

## Context

- Cursor, Claude Code and the DSH session behind Zed keep the transcript outside the repo, bound to the path you started from (§128, §132).
- Proposal C′ put `<cwd>/.agent/` (`status.md` + `ledger.jsonl`) as the source across a path change. That does not couple the chats any better; it is one more file beside the session.
- Durable notes already have a place: `make log` writes to `docs/work/logs/`.

## Decision

We build no repo spine. The conversation is the Zed Agent Panel and the DeepSeek Harness session. There will be no `.agent/` and no `ledger.jsonl` in the working directory. Whatever must outlive the slice goes through `make log`.

## Alternatives

| Option | Why not |
|-------|-------------|
| `.agent/` in the working directory | Does not solve the chat's path binding |
| `.planning/` instead of `.agent/` | The same extra memory under a different name |
| The IDE chat alone as the only source, discarding the DSH session | The harness session resumes the conversation; it stays |

## Consequences

- **Easier:** no second state beside the session Zed and DSH already keep.
- **Harder or risky:** renaming or moving a directory leaves the conversation on the old path. That is the same behaviour as Cursor and Claude.
- **To do:** nothing until someone has a coupling that does solve the path binding. That reopens this decision.
