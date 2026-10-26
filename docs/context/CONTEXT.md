# Context

> **Rol:** Waarom dit project bestaat, voor wie, en wat succes is.
> **Niet hier:** techniek ([ARCHITECTURE.md](../architecture/ARCHITECTURE.md)), inhoudelijke grenzen ([RULES.md](../rules/RULES.md)).

## Gebruiker of klant

**Nu:** solo-ontwikkelaar (Ventje) — lokaal lab, plus later een thesis-lezer die metingen en keuzes moet kunnen volgen.

**Later (als het lab echt goed is):** dezelfde tool als portfolio-stuk en als applicatie voor anderen — hoogstwaarschijnlijk volledig gratis; open source of closed source nog open. Geen betalende SaaS als uitgangspunt.

## Probleem

Bestaande IDE’s en agent-tools (bv. Cursor) koppelen slecht of niet-reproduceerbaar aan een strakke projectstandaard (spoor 1 kit + spoor 2 bron in Agent_Engineering). Er ontbreekt een *minimale*, lokaal meetbare harness om die koppeling wél te sturen en te experimenteren — en, als die werkt, eventueel breed beschikbaar te maken zonder dure lock-in.

## Doel en wat succes is

- **Lab (nu):** lokaal meetbaar lab dat de standaard respecteert (docs, rules, seams), met herhaalbare experimenten. LLM via eigen API-keys — voorkeur DeepSeek (goedkoop); andere providers (OpenAI e.d.) mogen als eigen key in `.env`.
- **Thesis:** later toetsbaar doel op hetzelfde lab.
- **Product (toekomst, voorwaardelijk):** als kwaliteit het waard is → portfolio én release als gratis app (OS of closed nader) — pas na expliciete productisatie-keuze, niet tijdens de labfase.
- Pi-fork of andere runtime alleen na expliciete runtime-keuze — tot die tijd geen stack vastleggen.

## Scope

- Domeinen: `harness`, `structure`, `indexing` (zie [GLOSSARY.md](GLOSSARY.md) en [PRODUCT.md](../product/PRODUCT.md)).
- Spoor 3 in het drie-sporenmodel: runtime/IDE/harness-experiment; kennis en standaard blijven in Agent_Engineering.
- **Talen:** stack-talen staan in [ARCHITECTURE.md](../architecture/ARCHITECTURE.md) — daar nog open tot Pi/TS-keuze. Extra systemstalen (Rust/C, …) voor hot paths: toegestaan na meting + ADR — zie [polyglot.md](../architecture/polyglot.md). Niet aannemen dat native “niet mag”.

## Bewust niet

Zie [PRODUCT.md](../product/PRODUCT.md) § Bewust niet en [RULES.md](../rules/RULES.md): nu geen productrelease/prod-hosting; geen feature-bloat; geen duplicatie of overname van data/secrets uit andere projecten; lessen eerst als § in Agent_Engineering `bron/`. Licentie (OS vs closed) en publieke deploy volgen pas bij productisatie.
