# Session / spine

> **Role:** maintaining where the agent conversation lives.
> **Not here:** relations ([totaalproduct.md](totaalproduct.md)).

**State:** skipped · **ADR:** [0005](../decisions/0005-the-conversation-remains-the-zed-and-dsh-session-without-repo-spine.md) · **Spec gone** — decision in the ADR, shape in the product doc

## What the user can do

- Resume the conversation in the Zed Agent Panel, via the DeepSeek Harness session of this workspace.

## Decision

No repo spine. No `.agent/`, no `ledger.jsonl` in the working directory. The conversation is the panel and the DSH session. What a slice must record durably goes through `make log`.

A renamed or moved directory leaves the conversation on the old path. That is the same as with Cursor and Claude. A coupling that does solve it reopens [ADR 0005](../decisions/0005-the-conversation-remains-the-zed-and-dsh-session-without-repo-spine.md).

## Current state

| Topic | Status | Note |
|-------|--------|------|
| Repo spine P1–P4 | skipped | no better coupling mechanism than the path-bound session |
| `make log` | stays | durable note at the end of a slice |

## Interfaces

- Conversation: [agent-ui.md](agent-ui.md), [harness.md](harness.md)
- Durable: `docs/work/logs/`

## Deliberately not

- A second memory beside the harness session.
- Committing a spine with secrets.
