# Agent UI

> **Role:** maintaining the human agent surface — chat, diffs, apply/reject.
> **Not here:** the IDE shell ([ide-shell.md](ide-shell.md)); relations ([totaalproduct.md](totaalproduct.md)).

**State:** decided · no separate ADR (follows [ADR 0002](../decisions/0002-the-ide-shell-is-upstream-zed-pulled-as-a-pinned-release-without-fork.md): ACP, no fork)

## What the user can do

- Talk to the agent, see streaming, review diffs and accept/reject changes — in the Zed Agent Panel. The loop behind it is the External Agent, not Zed Agent.

## Decision

| Topic | Choice |
|-------|--------|
| U1 Surface | Zed Agent Panel via ACP. No own chat UI and no extra TUI in v1. |
| U2 Diffs | Zed's review (multi-buffer diff, apply/reject). |
| U3 Streaming | What Zed and the ACP server already do. |
| U4 Multi-agent | No in v1. One conversation. |

## Interfaces

- Host: [ide-shell.md](ide-shell.md)
- Loop: [harness.md](harness.md) (`dsh --profile acp`)
- Shows results from: [tools.md](tools.md)

## Deliberately not

- An own composer or chat app.
- A marketplace of chat themes.
- Parallel Cloud Agent dashboards.
- Turning Zed Agent on beside the External Agent (two loops, two search paths — see [totaalproduct](totaalproduct.md)).
