# Tools

> **Role:** maintaining the exec layer — what the agent may do (read/edit/shell/MCP) and under what approval.
> **Not here:** the harness loop ([harness.md](harness.md)); relations ([totaalproduct.md](totaalproduct.md)).

**State:** decided · **ADR:** [0003](../decisions/0003-the-agent-loop-is-upstream-deepseek-harness-pinned-as-a-dsh-profile-acp-without-fork.md) (whitelist) and [0007](../decisions/0007-tool-approval-is-a-workspace-allowlist-and-the-shell-runs-under-bwrap.md) (allowlist + `bwrap`) · **Spec gone** — decision in the ADRs, shape in the product doc

## What the user can do

- The agent reads inside the project and changes things through the shell in the cage. Outside the project there is no mount and no write tool. In the lab there is no approval prompt.

## Decision

No own tool runtime. The toolset is DeepSeek Harness's ([ADR 0003](../decisions/0003-the-agent-loop-is-upstream-deepseek-harness-pinned-as-a-dsh-profile-acp-without-fork.md)): `read`, `glob`/`grep`, shell, plus the indexing tools via MCP. Writing happens through the shell, in the cage ([ADR 0017](../decisions/0017-the-agent-writes-in-the-cage-and-the-fs-write-tools-are-off.md)). `write`, `edit` and `apply_patch` are off in the lab profile. Shell and `npm`/`pip` run under `bwrap` with only the workspace as a bind ([ADR 0007](../decisions/0007-tool-approval-is-a-workspace-allowlist-and-the-shell-runs-under-bwrap.md)). Searching on the agent path goes through [indexing.md](indexing.md); `rg` stays the measurement fallback. Zed's built-in grep belongs to Zed Agent and does not run along.

## Current state

| Topic | Status | Note |
|-------|--------|------|
| Whitelist / ownership (T1) | decided | DSH read/edit/shell + indexing MCP — [ADR 0003](../decisions/0003-the-agent-loop-is-upstream-deepseek-harness-pinned-as-a-dsh-profile-acp-without-fork.md) |
| Approval model (T2) | stands | Lab: `approval: never`, `workspace-write` on the repo. No dialogue. How-to: [zed-dsh](../how-to/zed-dsh.md). [ADR 0017](../decisions/0017-the-agent-writes-in-the-cage-and-the-fs-write-tools-are-off.md) |
| Sandbox (T3) | stands | `packages/lab/cardine-bwrap` binds the workspace; the shell is the write court. `~/.ssh` not visible. Zed and `dsh` stay native |
| MCP v1 (T4) | decided | On, for the indexing daemon only. No open MCP market. |
| Indexing vs generic search (T5) | decided | Search via the indexing tools; `rg` is the measurement fallback |

## Interfaces

- Host: [harness.md](harness.md)
- Freshness of the tree: [fs-events.md](fs-events.md)
- Uses: [indexing.md](indexing.md) (search tools)

## Deliberately not

- An own tool framework or MCP marketplace.
- An unrestricted shell without path policy.
- A Docker/container requirement to run Zed or `dsh` itself (only for untrusted agent exec).
