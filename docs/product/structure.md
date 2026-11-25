# Structure

> **Role:** maintaining how the project standard counts in the agent loop and is enforced (docs + checks + hooks).
> **Not here:** the kit source in `kit/`; relations ([totaalproduct.md](totaalproduct.md)).

**State:** decided · **ADR:** [0004](../decisions/0004-the-project-standard-is-dual-a-thin-agents-md-and-a-hard-make-check.md) · **Spec gone** — decision in the ADRs, shape in the product doc · shape: [ideas A6–A7](../research/ideas-and-questions.md)

## What the user can do

- The agent (and you) follow **hard** project rules: no "done" on a red `make check`, no secrets, seams respected — not just prose in AGENTS.

## Decision

The harness is DeepSeek Harness ([ADR 0003](../decisions/0003-the-agent-loop-is-upstream-deepseek-harness-pinned-as-a-dsh-profile-acp-without-fork.md)). The shape stays A6–A7. No hook code.

- **S1 — dual.** `AGENTS.md` stays the map: short, intent, and where the rest lives. Hard boundaries stay in `make check` and [RULES.md](../rules/RULES.md). A prohibition a check can enforce does not live in prose alone.
- **S2 — two hooks.** Before a write tool the path allowlist applies, on the DSH waterfall `tools/pre-execute` (§77). At the end of a slice `make check` runs. §77 names no Stop event; the second hook is the slice end, not every model step.
- **S3 — write boundary.** Writing stays inside the workspace. Inside that directory it goes through; outside, the agent asks ([ADR 0007](../decisions/0007-tool-approval-is-a-workspace-allowlist-and-the-shell-runs-under-bwrap.md)).
- **S4 — always on.** Always loaded: `AGENTS.md`, `RULES.md`, and the product doc of the part the slice is about. The rest is read when the slice touches that file.

**Ladder (A7), as a sentence:** a red `make check` does not close the slice. Fix it, or revert the slice. Measurable only once there is an application; until then `make check` stays red because there is no app ([ADR 0001](../decisions/0001-runtime-stack-deliberately-deferred-until-an-explicit-pi-or-ts-choice.md)).

## Current state

| Topic | Status | Note |
|-------|--------|------|
| Dual → ADR S1 | decided | [ADR 0004](../decisions/0004-the-project-standard-is-dual-a-thin-agents-md-and-a-hard-make-check.md) |
| Write hooks + slice end S2 | stands | `agent/turn-stopping` runs `make check`. An empty CHECK does not send back. How-to: [zed-dsh](../how-to/zed-dsh.md) |
| Write allowlist S3 | stands | workspace allowlist — [ADR 0007](../decisions/0007-tool-approval-is-a-workspace-allowlist-and-the-shell-runs-under-bwrap.md) |
| Always-on vs JIT docs S4 | decided | three always-on, the rest JIT |
| `product/structure` behaviour tests | later | after an application |

## Interfaces

- Enforced in: [harness.md](harness.md), [tools.md](tools.md)
- Prioritised in retrieval: [indexing.md](indexing.md)
- Source standard: `kit/` in this repo. The structure is updated there; `make sync-kit` copies it into the npm package ([ADR 0013](../decisions/0013-cardine-is-the-public-shop-window-and-pulls-the-structure-from-agent-engineering.md))

## Deliberately not

- A longer AGENTS file as the "solution".
- Kit edits from this lab without a bridge + yes.
