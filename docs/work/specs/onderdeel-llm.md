# Spec — onderdeel-llm

> **Rol:** Open keuzes voor model-providers (BYOK). Eigenaar is de harness, niet Zed.
> **Kaart:** [totaalproduct.md](../../product/totaalproduct.md)

- **Item:** [BACKLOG.md](../BACKLOG.md)
- **Status:** open — sluit mee met het ja op de harness; geen aparte “Zed-af”
- **Product (bijhouden):** [../../product/llm.md](../../product/llm.md)
- **Hypothese (jij):** DeepSeek default — prijs/kwaliteit; keys in `.env`; geen eigen inference. Route leeft in DSH (ACP `model`), niet in Zed’s modelkiezer.

## Wat het is

Adapters + credentials + modelkeuze van de geïmporteerde harness. Enige **niet-lokale** pad in het totaalproduct: HTTPS naar provider-API.

Zed Agent heeft een eigen provider-config. Die gebruik je niet op dit pad ([totaalproduct](../../product/totaalproduct.md)).

## Stappenplan

Start samen met het ja op H1 (DSH). Eén stap per sessie. Uitkomst in [llm.md](../../product/llm.md). Geen key in git, docs of de spec. Geen eigen LLM-ADR vóór die harness-ja.

### Stap A — Default op papier

1. L1: DeepSeek is de default in de DSH-config. De key hoort in `.env`. `.env.example` noemt de variabelenaam en laat de waarde leeg.
2. L2: minstens één andere provider blijft configureerbaar in de harness. Kimi is de peer uit het onderzoek (§142).
3. L3: het model-id blijft een notitie uit de upstream-docs van DSH, en wordt later via de radar herijkt. Deze stap vriest geen id vast.
4. L4: v1 heeft geen lokale inference.
5. L5: prompts in logs worden geredigeerd. Dat is de regel voor de latere implementatie.

### Stap B — Meenemen in de harness-ADR

L1 gaat mee in de ADR van H1/H2. De `.env.example` van een app komt pas na die ADR.

## Open beslissingen

| # | Vraag | Opties | Blokkeert |
|---|-------|--------|-----------|
| L1 | Default provider? | DeepSeek / … | cost |
| L2 | Fallback-providers? | Kimi peer (§142) / Claude / geen | harness config |
| L3 | Welk DeepSeek-model-id voor coding? | periodiek herijken via AA/radar | kwaliteit |
| L4 | Local models later? | nee v1 / Ollama later | scope |
| L5 | Logging: prompts redacteren? | verplicht (RULES) | security |

## Acceptatie (later)

- [ ] L1 meegenomen in harness-ADR + `.env.example` (geen secrets)
- [ ] Harness kan ≥1 non-DeepSeek provider (anti-lock smoke)
