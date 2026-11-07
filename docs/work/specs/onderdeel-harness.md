# Spec — onderdeel-harness

> **Rol:** Open keuzes voor de agent-loop.
> **Kaart:** [totaalproduct.md](../../product/totaalproduct.md) · bronnen §76 Pi, §77 DSH

- **Item:** [BACKLOG.md](../BACKLOG.md)
- **Status:** open
- **Product (bijhouden):** [../../product/harness.md](../../product/harness.md)
- **Hypothese (jij):** DeepSeek Harness (`dsh`) sterk kandidaat — plugin-model + DeepSeek-fit; Pi als leaner alternatief. Geen DeepInfer.

## Wat het is

Loop: model ↔ tools ↔ permissions ↔ session-log. Host voor indexing-tools en structure-hooks. **≠** IDE; **≠** indexing.

## Opties (kort)

| Kandidaat | Sterkte | Risico |
|-----------|---------|--------|
| **DSH** (§77) | Plugins, UI, DeepSeek-ecosysteem, MIT | Preview/breaking; breder dan lab-minimum |
| **Pi** (§76) | Minimaal, TS, SDK/RPC embed | Minder “product UI”; zelf meer lijmen |
| Eigen dunne loop | Max controle | Heruitvinden; traag |

Complexiteit “specifiek voor DeepSeek-model” leeft deels in **prompts/tools/harness-tuning**, deels in het model zelf — forken van DSH = die tuning meenemen; lock-in bewust houden (LLM-spec laat andere providers toe).

## Open beslissingen

| # | Vraag | Opties | Blokkeert |
|---|-------|--------|-----------|
| H1 | Basis? | DSH / Pi / ander / eigen | stack |
| H2 | Embed in IDE vs aparte process + ACP/RPC? | | I1, Agent-UI |
| H3 | Profile: headless vs web vs sdk-minimal? | DSH-templates | overhead |
| H4 | Indexing als plugin vs externe MCP? | | X2 |
| H5 | Upstream track vs fork? | observeren tot stabiel / fork nu | onderhoud |

## Acceptatie (later)

- [ ] H1 + H2 ADR
- [ ] Geen generators/`apps` vóór die ADR (0001)
