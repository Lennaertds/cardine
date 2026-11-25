# 0008 — The coding model is deepseek-flash and Claude is the second provider

- **Status:** accepted
- **Date:** 2026-11-16
- **Touches:** [llm.md](../product/llm.md), [totaalproduct.md](../product/totaalproduct.md), [PRODUCT.md](../product/PRODUCT.md), [BACKLOG.md](../work/BACKLOG.md). The `onderdeel-llm` spec was removed — the product doc suffices. Closes L2 and L3 from [0003](0003-the-agent-loop-is-upstream-deepseek-harness-pinned-as-a-dsh-profile-acp-without-fork.md). Applies to the API-key path; the subscription paths choose their own model ([0010](0010-the-meta-package-points-to-separate-packages-for-structure-and-three-zed-paths.md)).

## Summary

In the context of a coding agent on DeepSeek, faced with a frontier id whose price and behaviour drift on their own, we chose `deepseek-flash` as the model id and Claude as the second provider over "the newest frontier" and over Kimi as that second, in order to run the cheaper model daily and reach for Claude only when quality falls short, and we accept that a newer id arrives later through the radar.

## Context

- L1 and L4 are in [0003](0003-the-agent-loop-is-upstream-deepseek-harness-pinned-as-a-dsh-profile-acp-without-fork.md): DeepSeek is the default, no local inference. The key lives only in `.env`.
- §93 names the API id `deepseek-flash`. The older `deepseek-v4-pro` was routed there. Kimi (§142) was the comparison in the research, not the quality escape hatch.
- The overall product names DeepSeek for price and quality and Claude for higher quality.

## Decision

- **L3.** The coding model is `deepseek-flash`, chosen in DeepSeek Harness, not in Zed's model picker. No "latest" alias.
- **L2.** Claude is the second provider, with its own key. Kimi stays a research peer and is not a product fallback.

A newer DeepSeek id replaces `deepseek-flash` only after a radar note, not because the API quietly picks the dearest model.

## Alternatives

| Option | Why not |
|-------|-------------|
| The newest frontier as default | That is the expensive model; DeepSeek is the default precisely for its price |
| No second provider | Then you are locked to one vendor with no way out |
| Kimi as the second | A peer from the benches, not the quality escape hatch the product already names |

## Consequences

- **Easier:** one id to start with. Claude stands ready without being the daily bill.
- **Harder or risky:** `deepseek-flash` may go stale until the radar replaces it. Two keys, both only in `.env`.
- **To do:** `.env.example` only with the application. [0001](0001-runtime-stack-deliberately-deferred-until-an-explicit-pi-or-ts-choice.md) stays. No `apps/`.
