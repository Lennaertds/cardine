# Harness

> **Role:** maintaining the agent loop — runtime, permissions, sessions, routing to tools/LLM/indexing.
> **Not here:** model choice ([llm.md](llm.md)); relations ([totaalproduct.md](totaalproduct.md)).

**State:** decided · **ADR:** [0003](../decisions/0003-the-agent-loop-is-upstream-deepseek-harness-pinned-as-a-dsh-profile-acp-without-fork.md) · **Spec gone** — decision in the ADR, shape in the product doc · sources: §76 Pi, §77 DSH

## What the user can do

- Start an agent loop locally that calls tools, queries indexing, respects structure, and talks to a model via BYOK — measurably and repeatably. Zed shows the conversation; the loop is not Zed Agent.

## Decision

**DeepSeek Harness**, upstream, no fork, a separate process ([ADR 0003](../decisions/0003-the-agent-loop-is-upstream-deepseek-harness-pinned-as-a-dsh-profile-acp-without-fork.md)). Zed starts `dsh --profile acp`. Indexing comes in as MCP. [ADR 0001](../decisions/0001-runtime-stack-deliberately-deferred-until-an-explicit-pi-or-ts-choice.md) still applies to our own app code: no `apps/` and no `--starter`.

Pi comes back only if a later ACP smoke test fails (Zed does not start DSH, or the MCP mount fails). This ADR does not choose Pi. No DeepInfra. No own loop.

| Candidate | Strength | Risk |
|-----------|----------|------|
| DSH (chosen) | ACP profile, MCP client, plugins, DeepSeek fit, MIT, upstream updates | Preview/breaking; broader than the lab minimum |
| Pi | Minimal, TS, SDK/RPC | Only if the ACP smoke test fails |
| Own loop | Maximum control | Slow / reinventing — not chosen |

## Current state

| Topic | Status | Note |
|-------|--------|------|
| Base H1 | decided | DSH, no fork — [ADR 0003](../decisions/0003-the-agent-loop-is-upstream-deepseek-harness-pinned-as-a-dsh-profile-acp-without-fork.md) |
| Embed vs separate process H2 | decided | Separate process; Zed talks ACP |
| Profile H3 | decided | `acp` (not web/headless as the UI) |
| Indexing as plugin vs MCP H4 | decided | External MCP from the indexing contract |
| Upstream vs fork H5 | decided | Follow upstream; a fork needs a later yes |
| ADR / apps code | import decided | [0001](../decisions/0001-runtime-stack-deliberately-deferred-until-an-explicit-pi-or-ts-choice.md) stays: no `apps/` |
| Lab install | stands | Pin `0.2.2-rc.1`, Zed coupling, key and jarvis mount: [zed-dsh](../how-to/zed-dsh.md). A Zed thread that is already open does not see the tool yet |

## Interfaces

- To: [tools.md](tools.md), [indexing.md](indexing.md), [structure.md](structure.md), [llm.md](llm.md), [session-spine.md](session-spine.md)
- UI: [agent-ui.md](agent-ui.md) (Zed panel, done)
- Host: [ide-shell.md](ide-shell.md)

## Deliberately not

- Inference serving.
- Feature parity with Cursor Cloud Agents.
- Putting DSH inside the Zed binary, or leaving Zed Agent running beside it.
