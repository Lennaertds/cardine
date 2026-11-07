# Product

> **Rol:** Wat het product doet, per onderdeel/domein, gezien vanuit de gebruiker.
> **Niet hier:** hoe het gebouwd is ([ARCHITECTURE.md](../architecture/ARCHITECTURE.md)), hoe het eruitziet (`design/`).

## Fasen

| Fase | Wat | Status |
|------|-----|--------|
| Lab | Solo, lokaal, meetbaar; eigen LLM-keys (DeepSeek of andere) | nu |
| Thesis | Zelfde lab, leesbaar/toetsbaar voor beoordelaar | later |
| Product | Portfolio + gratis app voor anderen (OS of closed nader) | alleen als kwaliteit het waard is |

## Persoonlijk totaalproduct

**Samenhang:** [totaalproduct.md](totaalproduct.md) — hoe de 9 onderdelen samen één lokaal solo-product vormen.  
**Per onderdeel bijhouden:** één bestand hieronder (niet alleen in specs).

| # | Onderdeel | Productdoc | Spec |
|---|-----------|------------|------|
| 1 | IDE-shell | [ide-shell.md](ide-shell.md) | [onderdeel-ide-shell](../work/specs/onderdeel-ide-shell.md) |
| 2 | FS/events | [fs-events.md](fs-events.md) | [onderdeel-fs-events](../work/specs/onderdeel-fs-events.md) |
| 3 | Indexing | [indexing.md](indexing.md) | [onderdeel-indexing](../work/specs/onderdeel-indexing.md) |
| 4 | Tools | [tools.md](tools.md) | [onderdeel-tools](../work/specs/onderdeel-tools.md) |
| 5 | Harness | [harness.md](harness.md) | [onderdeel-harness](../work/specs/onderdeel-harness.md) |
| 6 | LLM | [llm.md](llm.md) | [onderdeel-llm](../work/specs/onderdeel-llm.md) |
| 7 | Structure | [structure.md](structure.md) | [onderdeel-structure](../work/specs/onderdeel-structure.md) |
| 8 | Agent-UI | [agent-ui.md](agent-ui.md) | [onderdeel-agent-ui](../work/specs/onderdeel-agent-ui.md) |
| 9 | Session/spine | [session-spine.md](session-spine.md) | [onderdeel-session-spine](../work/specs/onderdeel-session-spine.md) |

Kern-domeinen (GLOSSARY-waarde): `harness`, `structure`, `indexing`. Overige = host/seams.

## Bewust niet

- Geen productrelease of prod-hosting in de labfase (wel later mogelijk, gratis, OS of closed).
- Geen betalende SaaS als uitgangspunt; gebruiker brengt eigen API-keys mee.
- Geen feature-bloat “voor anderen”; IDE-shell is dunne host.
- Geen Pi-/DSH-/IDE-fork als vastgelegde stack tot expliciete ADR.
- Geen overname of duplicatie van data, secrets of broninhoud uit andere projecten / Agent_Engineering.
- Geen keuze “open vs closed” vastleggen tot productisatie.
- Geen eigen inference-serving.
