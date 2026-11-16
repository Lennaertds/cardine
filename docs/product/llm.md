# LLM

> **Rol:** Bijhouden van BYOK-modelproviders — default, fallbacks, wat wél de machine verlaat.
> **Niet hier:** werkplan ([onderdeel-llm](../work/specs/onderdeel-llm.md)); harness-routing ([harness.md](harness.md)); samenhang ([totaalproduct.md](totaalproduct.md)).

**Stand:** default beslist in [ADR 0003](../decisions/0003-de-agent-loop-is-upstream-deepseek-harness-gepind-als-dsh-profile-acp-zonder-fork.md); L2 en L3 open · **Spec:** [onderdeel-llm](../work/specs/onderdeel-llm.md)

## Wat de gebruiker kan

- Coding-agent via **eigen API-key**; default richting DeepSeek (prijs/kwaliteit); andere providers mogelijk zonder product-lock.

## Eigenaar

Model, route en keys horen bij DeepSeek Harness ([ADR 0003](../decisions/0003-de-agent-loop-is-upstream-deepseek-harness-gepind-als-dsh-profile-acp-zonder-fork.md)), niet bij Zed. Zed’s modelkiezer geldt voor Zed Agent; dat pad staat uit ([totaalproduct](totaalproduct.md)). DSH kiest het model via ACP (`session/set_config_option`).

## Hypothese

DeepSeek als default, via de harness-config. Enige niet-lokale pad = provider HTTPS. Geen eigen inference. Keys alleen in `.env` (nooit git). Kimi als peer later (§142); frontier optioneel.

## Stand van zaken

| Onderwerp | Status | Notitie |
|-----------|--------|---------|
| Eigenaar | beslist | DSH, niet Zed Agent — [ADR 0003](../decisions/0003-de-agent-loop-is-upstream-deepseek-harness-gepind-als-dsh-profile-acp-zonder-fork.md) |
| Default provider L1 | beslist | DeepSeek; key in `.env` |
| Fallbacks L2 | open | Kimi is de peer, niet dichtgezet |
| Model-id coding L3 | open | periodiek via radar/AA; id komt uit upstream-docs van de harness |
| Local/Ollama L4 | beslist | niet in v1 |
| Prompt-redaction L5 | verplicht later | RULES |
| `.env.example` | open | na harness-ADR |

## Raakvlakken

- Gebruikt door: [harness.md](harness.md)
- Beïnvloedt tool/prompt-vorm → [indexing.md](indexing.md)

## Bewust niet

- DeepInfer / zelf GPU-serving.
- Zed-hosted modellen als default (dat is het slapende Zed-Agent-pad).
- Vendor-lock ADR forceren vóór meting.
