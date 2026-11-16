# Spec — onderdeel-llm

> **Rol:** Open keuzes voor model-providers (BYOK). Eigenaar is de harness, niet Zed.
> **Kaart:** [totaalproduct.md](../../product/totaalproduct.md)

- **Item:** [BACKLOG.md](../BACKLOG.md)
- **Status:** beslist — default in [ADR 0003](../../decisions/0003-de-agent-loop-is-upstream-deepseek-harness-gepind-als-dsh-profile-acp-zonder-fork.md). `deepseek-flash` en Claude in [ADR 0008](../../decisions/0008-het-coding-model-is-deepseek-flash-en-claude-is-de-tweede-provider.md).
- **Product (bijhouden):** [../../product/llm.md](../../product/llm.md)
- **Besluit:** DeepSeek default, id `deepseek-flash`. Claude is de tweede provider. Keys in `.env`. Geen eigen inference. Route leeft in DSH, niet in Zed’s modelkiezer.

## Wat het is

Adapters + credentials + modelkeuze van de geïmporteerde harness. Enige **niet-lokale** pad in het totaalproduct: HTTPS naar provider-API.

Zed Agent heeft een eigen provider-config. Die gebruik je niet op dit pad ([totaalproduct](../../product/totaalproduct.md)).

## Stappenplan

Gedaan. Uitkomst in [llm.md](../../product/llm.md) en [ADR 0008](../../decisions/0008-het-coding-model-is-deepseek-flash-en-claude-is-de-tweede-provider.md). Geen key in git, docs of de spec. `.env.example` pas met een applicatie. Prompt-redactie (L5) blijft een regel voor die implementatie.

## Open beslissingen

| # | Vraag | Opties | Blokkeert |
|---|-------|--------|-----------|
| L1 | Default provider? | beslist — DeepSeek, key in `.env` | — |
| L2 | Fallback-providers? | beslist — Claude | — |
| L3 | Welk DeepSeek-model-id voor coding? | beslist — `deepseek-flash`; nieuwer id via radar | — |
| L4 | Local models later? | beslist — nee in v1 | — |
| L5 | Logging: prompts redacteren? | verplicht (RULES) | security |

## Acceptatie (later)

- [x] L1 in [ADR 0003](../../decisions/0003-de-agent-loop-is-upstream-deepseek-harness-gepind-als-dsh-profile-acp-zonder-fork.md). L2 en L3 in [ADR 0008](../../decisions/0008-het-coding-model-is-deepseek-flash-en-claude-is-de-tweede-provider.md). `.env.example` pas na een app (0001)
- [ ] Harness kan ≥1 non-DeepSeek provider (anti-lock smoke)
