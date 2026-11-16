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
| 1 | IDE-shell | [ide-shell.md](ide-shell.md) | afgerond — [ADR 0002](../decisions/0002-de-ide-shell-is-upstream-zed-opgehaald-als-pinned-release-zonder-fork.md) |
| 2 | FS/events | [fs-events.md](fs-events.md) | afgerond — Zed-boom, geen eigen watcher (geen ADR) |
| 8 | Agent-UI | [agent-ui.md](agent-ui.md) | afgerond — Zed Agent Panel via ACP (geen ADR) |
| 5 | Harness | [harness.md](harness.md) | voorstel DSH-import — [onderdeel-harness](../work/specs/onderdeel-harness.md) |
| 4 | Tools | [tools.md](tools.md) | volgt harness — [onderdeel-tools](../work/specs/onderdeel-tools.md) |
| 6 | LLM | [llm.md](llm.md) | volgt harness (niet Zed) — [onderdeel-llm](../work/specs/onderdeel-llm.md) |
| 3 | Indexing | [indexing.md](indexing.md) | onderzoek — [onderdeel-indexing](../work/specs/onderdeel-indexing.md) |
| 7 | Structure | [structure.md](structure.md) | [onderdeel-structure](../work/specs/onderdeel-structure.md) |
| 9 | Session/spine | [session-spine.md](session-spine.md) | [onderdeel-session-spine](../work/specs/onderdeel-session-spine.md) |

Kern-domeinen (GLOSSARY-waarde): `indexing`, `structure`. Harness = geïmporteerde DSH (voorstel, nog geen ADR). Shell, FS en Agent-UI = Zed-host. LLM hoort bij die harness, niet bij Zed Agent. Overige = seams.

## Bewust niet

- Geen productrelease of prod-hosting in de labfase (wel later mogelijk, gratis, OS of closed).
- Geen betalende SaaS als uitgangspunt; gebruiker brengt eigen API-keys mee.
- Geen feature-bloat “voor anderen”; IDE-shell is dunne host.
- Geen IDE-fork: Zed blijft upstream ([ADR 0002](../decisions/0002-de-ide-shell-is-upstream-zed-opgehaald-als-pinned-release-zonder-fork.md)). Geen Pi-/DSH-fork als vastgelegde stack tot een eigen ADR.
- Geen overname of duplicatie van data, secrets of broninhoud uit andere projecten / Agent_Engineering.
- Geen keuze “open vs closed” vastleggen tot productisatie.
- Geen eigen inference-serving.
