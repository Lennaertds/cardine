# Context

> **Rol:** Waarom dit project bestaat, voor wie, en wat succes is.
> **Niet hier:** techniek ([ARCHITECTURE.md](../architecture/ARCHITECTURE.md)), inhoudelijke grenzen ([RULES.md](../rules/RULES.md)).

## Gebruiker of klant

**Nu:** solo-ontwikkelaar (Ventje) — lokaal lab, plus later een thesis-lezer die metingen en keuzes moet kunnen volgen.

**Later (als het lab echt goed is):** dezelfde tool als portfolio-stuk en als applicatie voor anderen — hoogstwaarschijnlijk volledig gratis; open source of closed source nog open. Geen betalende SaaS als uitgangspunt.

## Probleem

Bestaande IDE’s en agent-tools (bv. Cursor) koppelen slecht of niet-reproduceerbaar aan een strakke projectstandaard (spoor 1 kit + spoor 2 bron in Agent_Engineering). Cursor als VS Code-fork draagt bovendien Electron- en feature-overhead die jij niet nodig hebt. Er ontbreekt een *lichte*, lokaal meetbare stack (IDE-shell + indexing + harness + structure) die wél op *jouw* workflow past.

## Doel en wat succes is

- **Lab / persoonlijk product (nu):** lokaal (op Arch/Hyprland) een stack die *voor jou* productiever is dan Cursor — lage overhead, BYOK-LLM (DeepSeek-richting), indexing op jouw use-case, standaard afgedwongen. Kaart: [totaalproduct.md](../product/totaalproduct.md).
- **Thesis:** later toetsbaar doel op hetzelfde lab (diepte elders).
- **Product (toekomst, voorwaardelijk):** als kwaliteit het waard is → portfolio én release als gratis app (OS of closed nader) — pas na expliciete productisatie-keuze; tot die tijd mag het **alleen voor jou** werken.
- Geen stack/fork vastleggen tot expliciete ADR — tot die tijd docs + open keuzes in onderdeel-specs.

## Scope

- Domeinen: `harness`, `structure`, `indexing` (zie [GLOSSARY.md](GLOSSARY.md) en [PRODUCT.md](../product/PRODUCT.md)).
- Spoor 3 in het drie-sporenmodel: runtime/IDE/harness-experiment; kennis en standaard blijven in Agent_Engineering.
- **Talen:** stack-talen staan in [ARCHITECTURE.md](../architecture/ARCHITECTURE.md) — daar nog open tot Pi/TS-keuze. Extra systemstalen (Rust/C, …) voor hot paths: toegestaan na meting + ADR — zie [polyglot.md](../architecture/polyglot.md). Niet aannemen dat native “niet mag”.

## Bewust niet

Zie [PRODUCT.md](../product/PRODUCT.md) § Bewust niet en [RULES.md](../rules/RULES.md): nu geen productrelease/prod-hosting; geen feature-bloat; geen duplicatie of overname van data/secrets uit andere projecten; lessen eerst als § in Agent_Engineering `bron/`. Licentie (OS vs closed) en publieke deploy volgen pas bij productisatie.
