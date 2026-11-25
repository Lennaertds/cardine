# 0004 — The project standard is dual: a thin AGENTS.md and a hard make check

- **Status:** accepted
- **Date:** 2026-11-16
- **Touches:** [structure.md](../product/structure.md), [totaalproduct.md](../product/totaalproduct.md), [PRODUCT.md](../product/PRODUCT.md), [BACKLOG.md](../work/BACKLOG.md). The `onderdeel-structure` spec was removed — the product doc suffices. [0001](0001-runtime-stack-deliberately-deferred-until-an-explicit-pi-or-ts-choice.md) and [0003](0003-the-agent-loop-is-upstream-deepseek-harness-pinned-as-a-dsh-profile-acp-without-fork.md) still apply.

## Summary

In the context of an agent that would otherwise ignore project rules, faced with instruction files that are prose only, we chose a thin `AGENTS.md` plus a hard `make check` and two hooks on DeepSeek Harness over a second instruction layer beside Zed Instructions, in order to let a red check block the slice, and we accept that those hooks are only measurable once there is an application.

## Context

- Zed Instructions, Cursor rules and `CLAUDE.md` are standing text. The model can take them into account and ignore them just as easily (§107, §115).
- Claude Code already describes the right split: "always" and "never" belong in a hook, not in the instruction file (§114). Codex keeps `AGENTS.md` to a short table of contents and enforces the rest with checks (§113).
- DeepSeek Harness reads `AGENTS.md` too (§77). The `tools/pre-execute` waterfall is the place before a tool runs. §77 does not name a stop event.
- [0001](0001-runtime-stack-deliberately-deferred-until-an-explicit-pi-or-ts-choice.md) keeps `make check` red while there is no app.

## Decision

The project standard is dual.

- `AGENTS.md` stays the map: short, intent, and where the rest lives. A prohibition a check can enforce does not live in prose alone. There is no second prose layer beside Zed Instructions.
- Hard boundaries stay in `make check` and [RULES.md](../rules/RULES.md).
- Before a write tool the workspace allowlist applies, on `tools/pre-execute`. At the end of a slice `make check` runs. A red check does not close the slice: fix it, or revert the slice.
- Always on are `AGENTS.md`, `RULES.md` and the product doc of the part the slice is about. The rest is read when the slice touches that file.

Inside the workspace the agent does not ask on every edit. Outside the directory it stops. That is [0007](0007-tool-approval-is-a-workspace-allowlist-and-the-shell-runs-under-bwrap.md). This ADR writes no hook code.

## Alternatives

| Option | Why not |
|-------|-------------|
| A longer instruction file only | The same channel as Zed, Cursor and Claude prose; the model may ignore it |
| Checks only, no map | The intent then becomes unreadable for a human |
| Hooks as an option you switch on yourself | Then the ladder is not a product rule; a red check can still close the slice |
| A second rules file beside Zed Instructions | Two prose layers for the same thing |

## Consequences

- **Easier:** the slice has a stop that does not depend on the model. The map stays thin.
- **Harder or risky:** the hooks are still paper. Until there is an application, `make check` stays red because of [0001](0001-runtime-stack-deliberately-deferred-until-an-explicit-pi-or-ts-choice.md), not because of a failing slice.
- **To do:** hook code only with the application. Approval and `bwrap` are in [0007](0007-tool-approval-is-a-workspace-allowlist-and-the-shell-runs-under-bwrap.md).
