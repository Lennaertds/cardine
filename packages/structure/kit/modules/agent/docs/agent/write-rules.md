# Schrijfregels voor de agent

> **Rol:** Welke paden een agent vrij mag wijzigen, welke na toestemming, en welke nooit.
> **Niet hier:** wat bij elke taak geldt ([AGENTS.md](../../AGENTS.md)); welke docs je bij een soort opdracht **leest** (dat staat in `AGENTS.md` § Werken en de kaart).

Open dit bestand alleen als je wilt weten of je ergens mag schrijven. Leesroutes (UI → DESIGN, feature → PRODUCT) staan in `AGENTS.md`, niet hier — anders worden ze alleen geraadpleegd bij schrijfvragen.

| Pad | Mag | Waarom |
|-----|-----|--------|
| `apps/*/src/`, `apps/*/tests/` | vrij | gewone code |
| `docs/work/` | vrij | status |
| `docs/` (rest) | na toestemming | één feit op één plek |
| `apps/*/src/database/migrations/` | na toestemming | schema-wijzigingen zijn onomkeerbaar |
| `AGENTS.md`, `.cursor/rules/` | na toestemming | elke regel kost context bij elke taak |
| `data/raw/`, `data/runtime/`, `.env*` | nooit | ruwe data, persoonsgegevens, secrets |
