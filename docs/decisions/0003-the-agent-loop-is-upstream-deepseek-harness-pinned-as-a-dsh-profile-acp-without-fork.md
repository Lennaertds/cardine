# 0003 — The agent loop is upstream DeepSeek Harness, pinned, as dsh --profile acp, without a fork

- **Status:** accepted
- **Date:** 2026-11-16
- **Touches:** [harness.md](../product/harness.md), [tools.md](../product/tools.md), [llm.md](../product/llm.md), [totaalproduct.md](../product/totaalproduct.md), [PRODUCT.md](../product/PRODUCT.md), [BACKLOG.md](../work/BACKLOG.md). The `onderdeel-harness` spec was removed — the product doc suffices. [0001](0001-runtime-stack-deliberately-deferred-until-an-explicit-pi-or-ts-choice.md) and [0002](0002-the-ide-shell-is-upstream-zed-pulled-as-a-pinned-release-without-fork.md) still apply.

## Summary

In the context of an agent loop beside upstream Zed, faced with a preview harness that already provides ACP and MCP, we chose upstream DeepSeek Harness as a pinned process (`dsh --profile acp`) over a fork, an own loop or Pi as the default, in order not to maintain the loop ourselves, and we accept preview breakage and that the ACP smoke test has not been done yet.

## Context

- Zed is the GUI host ([0002](0002-the-ide-shell-is-upstream-zed-pulled-as-a-pinned-release-without-fork.md)). The loop, the index, structure and the model belong outside it.
- DeepSeek Harness (`dsh`, MIT, §77) provides an ACP server and an MCP client. The `acp` profile layers on `dsh-base`. This is the harness, not the DeepSeek model.
- The harness is a public preview; breaking changes are expected. The official ACP surface is smaller than the web app (one workspace, MCP tools, no plans or elicitation).
- [0001](0001-runtime-stack-deliberately-deferred-until-an-explicit-pi-or-ts-choice.md) defers an own app stack. A pinned npm process is not that stack.

## Decision

We use DeepSeek Harness as the agent loop. The meta package pins an upstream release. Zed starts `dsh --profile acp`. We do not fork DSH and we do not put it inside the Zed binary.

- **H1.** The base is DSH.
- **H2.** A separate process. Zed talks ACP.
- **H3.** Profile `acp`. The web UI is not the daily screen.
- **H4.** The index is an external MCP. No indexing plugin and no open MCP market.
- **H5.** Follow upstream. A fork needs a later yes.

Riding along, because tools and LLM come with this yes:

- The toolset is DSH's, trimmed to read, edit and shell, plus the indexing tools from the later MCP contract. Searching on the agent path goes through that index. `rg` stays the measurement fallback. Zed's grep belongs to Zed Agent and is off.
- The default model is DeepSeek, chosen in DSH, not in Zed's model picker. The key lives only in `.env`. No own inference in v1. The model id and second provider are in [0008](0008-the-coding-model-is-deepseek-flash-and-claude-is-the-second-provider.md): `deepseek-flash`, Claude as the second.

The shell sandbox and the approval model were settled in [0007](0007-tool-approval-is-a-workspace-allowlist-and-the-shell-runs-under-bwrap.md): workspace allowlist, shell under `bwrap`.

[0001](0001-runtime-stack-deliberately-deferred-until-an-explicit-pi-or-ts-choice.md) still applies to our own app code. No `apps/`, no `--starter`, no generator. DSH is not a TypeScript choice for the index.

## Alternatives

| Option | Why not |
|-------|-------------|
| Pi as the base | Only if the later ACP smoke test fails; this decision does not choose Pi |
| An own thin loop | Reinventing the loop |
| Fork DSH | Tracking breaking release candidates yourself; index and structure hang outside it |
| DSH inside the Zed binary | Zed stays the host ([0002](0002-the-ide-shell-is-upstream-zed-pulled-as-a-pinned-release-without-fork.md)) |
| The `web` profile as the daily screen | The conversation lives in the Zed Agent Panel |

## Consequences

- **Easier:** loop, session, tools and BYOK come from upstream. Our own work stays indexing, structure and spine.
- **Harder or risky:** preview and breaking changes. The ACP surface may be too narrow for diffs and approvals in Zed. A failing smoke test reopens this decision.
- **To do:** the smoke test (Zed starts `dsh --profile acp` and sees one MCP tool) waits until there is a complete application. [0001](0001-runtime-stack-deliberately-deferred-until-an-explicit-pi-or-ts-choice.md) remains in force.
