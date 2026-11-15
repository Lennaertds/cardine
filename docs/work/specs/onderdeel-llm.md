# Spec — onderdeel-llm

> **Rol:** Open keuzes voor model-providers (BYOK).
> **Kaart:** [totaalproduct.md](../../product/totaalproduct.md)

- **Item:** [BACKLOG.md](../BACKLOG.md)
- **Status:** open
- **Product (bijhouden):** [../../product/llm.md](../../product/llm.md)
- **Hypothese (jij):** DeepSeek default — prijs/kwaliteit; keys in `.env`; geen eigen inference.

## Wat het is

Adapters + credentials + model-picker (of vast default). Enige **niet-lokale** pad in het totaalproduct: HTTPS naar provider-API.

## Stappenplan

Start als de harness een provider-configuratie kan dragen (na het H1-voorstel). Eén stap per sessie. Uitkomst in [llm.md](../../product/llm.md). Geen key in git, docs of de spec.

### Stap A — Default op papier

1. L1: DeepSeek is de default. De key hoort in `.env`. `.env.example` noemt de variabelenaam en laat de waarde leeg.
2. L2: minstens één andere provider blijft configureerbaar. Kimi is de peer uit het onderzoek (§142).
3. L3: het model-id blijft een notitie uit de upstream-docs van de harness, en wordt later via de radar herijkt. Deze stap vriest geen id vast.
4. L4: v1 heeft geen lokale inference.
5. L5: prompts in logs worden geredigeerd. Dat is de regel voor de latere implementatie.

### Stap B — ADR

Vraag ja op L1. De `.env.example` van een app komt pas na die ADR én na de runtime-keuze uit de harness-ADR.

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
