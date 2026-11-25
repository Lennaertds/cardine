# LLM

> **Role:** maintaining the BYOK model providers — default, fallbacks, and what does leave the machine.
> **Not here:** harness routing ([harness.md](harness.md)); relations ([totaalproduct.md](totaalproduct.md)).

**State:** decided · **ADR:** [0003](../decisions/0003-the-agent-loop-is-upstream-deepseek-harness-pinned-as-a-dsh-profile-acp-without-fork.md) (default) and [0008](../decisions/0008-the-coding-model-is-deepseek-flash-and-claude-is-the-second-provider.md) (`deepseek-flash` + Claude) · **Spec gone** — decision in the ADRs, shape in the product doc

## What the user can do

- On the Zed + DeepSeek Harness path: a coding agent via **your own API key**; DeepSeek by default (price/quality). Claude-in-Zed and ChatGPT-in-Zed pick their own model ([ADR 0010](../decisions/0010-the-meta-package-points-to-separate-packages-for-structure-and-three-zed-paths.md)).

## Owner

The model, the route and the keys belong to DeepSeek Harness ([ADR 0003](../decisions/0003-the-agent-loop-is-upstream-deepseek-harness-pinned-as-a-dsh-profile-acp-without-fork.md)), not to Zed. Zed's model picker applies to Zed Agent; that path is off ([totaalproduct](totaalproduct.md)). DSH chooses the model via ACP (`session/set_config_option`).

## Decision

DeepSeek as the default, model id `deepseek-flash`, through the harness config ([ADR 0008](../decisions/0008-the-coding-model-is-deepseek-flash-and-claude-is-the-second-provider.md)). Claude is the second provider. The only non-local path is provider HTTPS. No own inference. Keys only in `.env` (never git). Kimi stays a research peer (§142), not a product fallback. A newer id arrives via the radar.

## Current state

| Topic | Status | Note |
|-------|--------|------|
| Owner | decided | DSH, not Zed Agent — [ADR 0003](../decisions/0003-the-agent-loop-is-upstream-deepseek-harness-pinned-as-a-dsh-profile-acp-without-fork.md) |
| Default provider L1 | decided | DeepSeek; key in `.env` |
| Fallbacks L2 | decided | Claude, own key — [ADR 0008](../decisions/0008-the-coding-model-is-deepseek-flash-and-claude-is-the-second-provider.md) |
| Model id for coding L3 | decided | `deepseek-flash`; a newer id via the radar |
| Local/Ollama L4 | decided | not in v1 |
| Prompt redaction L5 | required later | RULES |
| `.env.example` | name fixed | `DEEPSEEK_API_KEY` in the root example. The value belongs in `~/.dsh/.env` ([zed-dsh](../how-to/zed-dsh.md)) |

## Interfaces

- Used by: [harness.md](harness.md)
- Influences tool/prompt shape → [indexing.md](indexing.md)

## Deliberately not

- DeepInfra / serving on our own GPU.
- Zed-hosted models as the default (that is the dormant Zed Agent path).
- Forcing a vendor-lock ADR before measuring.
