# Product

> **Rol:** Wat het product doet, per domein, gezien vanuit de gebruiker.
> **Niet hier:** hoe het gebouwd is ([ARCHITECTURE.md](../architecture/ARCHITECTURE.md)), hoe het eruitziet (`design/`).

## Fasen

| Fase | Wat | Status |
|------|-----|--------|
| Lab | Solo, lokaal, meetbaar; eigen LLM-keys (DeepSeek of andere) | nu |
| Thesis | Zelfde lab, leesbaar/toetsbaar voor beoordelaar | later |
| Product | Portfolio + gratis app voor anderen (OS of closed nader) | alleen als kwaliteit het waard is |

## Domeinen

Eén bestand per domein: `product/<domein>.md`, met hetzelfde sjabloon ([_template.md](_template.md)). De namen komen uit [GLOSSARY.md](../context/GLOSSARY.md).

| Domein | Wat de gebruiker kan | Status | Spec |
|--------|----------------------|--------|------|
| harness | Agent-loop lokaal starten, experimenten draaien en metingen zien; LLM via eigen API-key | gepland | — |
| structure | Standaard (docs/rules/seams) laten meewegen in die loop | gepland | — |
| indexing | Code-/context-index gebruiken zodat de agent gerichte context krijgt | gepland | — |

Domeinbestanden (`product/harness.md` e.d.) volgen wanneer gedrag concreet wordt (na runtime-keuze of eerste slice).

## Bewust niet

- Geen productrelease of prod-hosting in de labfase (wel later mogelijk, gratis, OS of closed).
- Geen betalende SaaS als uitgangspunt; gebruiker brengt eigen API-keys mee.
- Geen feature-bloat buiten harness / structure / indexing tot het lab bewezen is.
- Geen Pi-fork of andere runtime tot expliciete keuze.
- Geen overname of duplicatie van data, secrets of broninhoud uit andere projecten / Agent_Engineering.
- Geen keuze “open vs closed” vastleggen tot productisatie — tot die tijd geen licentie-ADR forceren.
