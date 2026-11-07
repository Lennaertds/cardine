# Spec — onderdeel-llm

> **Rol:** Open keuzes voor model-providers (BYOK).
> **Kaart:** [totaalproduct.md](../../product/totaalproduct.md)

- **Item:** [BACKLOG.md](../BACKLOG.md)
- **Status:** open
- **Product (bijhouden):** [../../product/llm.md](../../product/llm.md)
- **Hypothese (jij):** DeepSeek default — prijs/kwaliteit; keys in `.env`; geen eigen inference.

## Wat het is

Adapters + credentials + model-picker (of vast default). Enige **niet-lokale** pad in het totaalproduct: HTTPS naar provider-API.

## Open beslissingen

| # | Vraag | Opties | Blokkeert |
|---|-------|--------|-----------|
| L1 | Default provider? | DeepSeek / … | cost |
| L2 | Fallback-providers? | Kimi peer (§142) / Claude / geen | harness config |
| L3 | Welk DeepSeek-model-id voor coding? | periodiek herijken via AA/radar | kwaliteit |
| L4 | Local models later? | nee v1 / Ollama later | scope |
| L5 | Logging: prompts redacteren? | verplicht (RULES) | security |

## Acceptatie (later)

- [ ] L1 ADR + `.env.example` (geen secrets)
- [ ] Harness kan ≥1 non-DeepSeek provider (anti-lock smoke)
