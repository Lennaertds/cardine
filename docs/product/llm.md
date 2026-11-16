# LLM

> **Rol:** Bijhouden van BYOK-modelproviders — default, fallbacks, wat wél de machine verlaat.
> **Niet hier:** werkplan ([onderdeel-llm](../work/specs/onderdeel-llm.md)); harness-routing ([harness.md](harness.md)); samenhang ([totaalproduct.md](totaalproduct.md)).

**Stand:** volgt harness-voorstel · **Spec:** [onderdeel-llm](../work/specs/onderdeel-llm.md)

## Wat de gebruiker kan

- Coding-agent via **eigen API-key**; default richting DeepSeek (prijs/kwaliteit); andere providers mogelijk zonder product-lock.

## Eigenaar

Model, route en keys horen bij de harness (voorstel: DeepSeek Harness), niet bij Zed. Zed’s modelkiezer geldt voor Zed Agent; dat pad staat uit ([totaalproduct](totaalproduct.md)). DSH kiest het model via ACP (`session/set_config_option`). De spec blijft open tot een ja op de harness — dit is geen “LLM = Zed, af”.

## Hypothese

DeepSeek als default, via de harness-config. Enige niet-lokale pad = provider HTTPS. Geen eigen inference. Keys alleen in `.env` (nooit git). Kimi als peer later (§142); frontier optioneel.

## Stand van zaken

| Onderwerp | Status | Notitie |
|-----------|--------|---------|
| Eigenaar | voorstel | DSH, niet Zed Agent |
| Default provider L1 | open | neiging DeepSeek; sluit mee met harness-ja |
| Fallbacks L2 | open | |
| Model-id coding L3 | open | periodiek via radar/AA; id komt uit upstream-docs van de harness |
| Local/Ollama L4 | open | neiging: niet v1 |
| Prompt-redaction L5 | verplicht later | RULES |
| `.env.example` | open | na harness-ADR |

## Raakvlakken

- Gebruikt door: [harness.md](harness.md)
- Beïnvloedt tool/prompt-vorm → [indexing.md](indexing.md)

## Bewust niet

- DeepInfer / zelf GPU-serving.
- Zed-hosted modellen als default (dat is het slapende Zed-Agent-pad).
- Vendor-lock ADR forceren vóór meting.
