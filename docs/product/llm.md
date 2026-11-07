# LLM

> **Rol:** Bijhouden van BYOK-modelproviders — default, fallbacks, wat wél de machine verlaat.
> **Niet hier:** werkplan ([onderdeel-llm](../work/specs/onderdeel-llm.md)); harness-routing ([harness.md](harness.md)); samenhang ([totaalproduct.md](totaalproduct.md)).

**Stand:** vorm · **Spec:** [onderdeel-llm](../work/specs/onderdeel-llm.md)

## Wat de gebruiker kan

- Coding-agent via **eigen API-key**; default richting DeepSeek (prijs/kwaliteit); andere providers mogelijk zonder product-lock.

## Hypothese

DeepSeek als default. Enige niet-lokale pad = provider HTTPS. Geen eigen inference. Keys alleen in `.env` (nooit git). Kimi als peer later (§142); frontier optioneel.

## Stand van zaken

| Onderwerp | Status | Notitie |
|-----------|--------|---------|
| Default provider L1 | open | neiging DeepSeek |
| Fallbacks L2 | open | |
| Model-id coding L3 | open | periodiek via radar/AA |
| Local/Ollama L4 | open | neiging: niet v1 |
| Prompt-redaction L5 | verplicht later | RULES |
| `.env.example` | open | na ADR |

## Raakvlakken

- Gebruikt door: [harness.md](harness.md)
- Beïnvloedt tool/prompt-vorm → [indexing.md](indexing.md)

## Bewust niet

- DeepInfer / zelf GPU-serving.
- Vendor-lock ADR forceren vóór meting.
