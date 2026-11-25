# 0002 — The IDE shell is upstream Zed, pulled as a pinned release, without a fork

- **Status:** accepted
- **Date:** 2026-11-15
- **Touches:** [ide-shell.md](../product/ide-shell.md), [totaalproduct.md](../product/totaalproduct.md), [PRODUCT.md](../product/PRODUCT.md), [BACKLOG.md](../work/BACKLOG.md). [0001](0001-runtime-stack-deliberately-deferred-until-an-explicit-pi-or-ts-choice.md) still applies.

## Summary

In the context of a GUI host beside an own harness, faced with a GPL monolith and an agent path that Zed already has, we chose upstream Zed as a pinned release via the meta package over an own fork, in order to have one workflow without maintaining the editor, and we accept that gaps in Zed's core are closed only through ACP, extensions or a later reopening.

## Context

- The decision criterion is the quality of the agent path, with a GUI. Neovim and Helix drop out as the primary shell.
- Zed provides the editor, panels, diffs and an ACP client. Our own loop, indexing, structure and LLM belong outside it.
- A Zed fork means GPL duties and maintaining a crate monolith. Lapce is Apache licensed and smaller, and has no mature agent protocol.
- The overall map already described this as the distribution model: the official binary, not self-hosted, not forked.

## Decision

We use Zed as the IDE shell. The meta package pulls a pinned upstream release straight from Zed. We do not fork Zed and we do not host the binary ourselves. Harness, indexing, structure and LLM stay separate processes and couple via ACP.

## Alternatives

| Option | Why not |
|-------|-------------|
| Fork Zed | GPL plus ongoing syncing with a monolith; it does not solve indexing |
| Fork Lapce and build the agent path yourself | Apache freedom in the shell, a thinner agent result |
| Electron / a VS Code fork | Against the host requirement |
| Neovim or Helix as the primary shell | No GUI editing |

## Consequences

- **Easier:** no editor maintenance; agent UX and ACP come from upstream; our own work stays in harness, indexing and structure.
- **Harder or risky:** Zed's UI and ACP follow upstream. A gap in the core that ACP and extensions do not cover reopens this decision. The Hyprland smoke test (start, agent panel, idle RAM) was not measured.
- **To do:** [0001](0001-runtime-stack-deliberately-deferred-until-an-explicit-pi-or-ts-choice.md) remains in force. This is not a runtime choice and does not free up `apps/` or generators.
