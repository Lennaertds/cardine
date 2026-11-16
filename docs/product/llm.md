# LLM

> **Rol:** Bijhouden van BYOK-modelproviders — default, fallbacks, wat wél de machine verlaat.
> **Niet hier:** werkplan ([onderdeel-llm](../work/specs/onderdeel-llm.md)); harness-routing ([harness.md](harness.md)); samenhang ([totaalproduct.md](totaalproduct.md)).

**Stand:** beslist · **ADR:** [0003](../decisions/0003-de-agent-loop-is-upstream-deepseek-harness-gepind-als-dsh-profile-acp-zonder-fork.md) (default) en [0008](../decisions/0008-het-coding-model-is-deepseek-flash-en-claude-is-de-tweede-provider.md) (`deepseek-flash` + Claude) · **Spec:** [onderdeel-llm](../work/specs/onderdeel-llm.md)

## Wat de gebruiker kan

- Coding-agent via **eigen API-key**; default richting DeepSeek (prijs/kwaliteit); andere providers mogelijk zonder product-lock.

## Eigenaar

Model, route en keys horen bij DeepSeek Harness ([ADR 0003](../decisions/0003-de-agent-loop-is-upstream-deepseek-harness-gepind-als-dsh-profile-acp-zonder-fork.md)), niet bij Zed. Zed’s modelkiezer geldt voor Zed Agent; dat pad staat uit ([totaalproduct](totaalproduct.md)). DSH kiest het model via ACP (`session/set_config_option`).

## Besluit

DeepSeek als default, model-id `deepseek-flash`, via de harness-config ([ADR 0008](../decisions/0008-het-coding-model-is-deepseek-flash-en-claude-is-de-tweede-provider.md)). Claude is de tweede provider. Enige niet-lokale pad = provider HTTPS. Geen eigen inference. Keys alleen in `.env` (nooit git). Kimi blijft een onderzoekspeer (§142), geen product-fallback. Een nieuwer id komt via de radar.

## Stand van zaken

| Onderwerp | Status | Notitie |
|-----------|--------|---------|
| Eigenaar | beslist | DSH, niet Zed Agent — [ADR 0003](../decisions/0003-de-agent-loop-is-upstream-deepseek-harness-gepind-als-dsh-profile-acp-zonder-fork.md) |
| Default provider L1 | beslist | DeepSeek; key in `.env` |
| Fallbacks L2 | beslist | Claude, eigen key — [ADR 0008](../decisions/0008-het-coding-model-is-deepseek-flash-en-claude-is-de-tweede-provider.md) |
| Model-id coding L3 | beslist | `deepseek-flash`; nieuwer id via radar |
| Local/Ollama L4 | beslist | niet in v1 |
| Prompt-redaction L5 | verplicht later | RULES |
| `.env.example` | later | pas met een applicatie (ADR 0001) |

## Raakvlakken

- Gebruikt door: [harness.md](harness.md)
- Beïnvloedt tool/prompt-vorm → [indexing.md](indexing.md)

## Bewust niet

- DeepInfer / zelf GPU-serving.
- Zed-hosted modellen als default (dat is het slapende Zed-Agent-pad).
- Vendor-lock ADR forceren vóór meting.
