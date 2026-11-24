# Solo of team

> **Rol:** Wat verschilt tussen een soloproject en een teamproject.
> **Niet hier:** de team-extra's om te kopiëren ([kit/team](../kit/README.md#lagen)).

| Aspect | Solo (zoals GymFreak) | Team (zoals DEP2) |
|--------|-----------------------|-------------------|
| Contextbestand | `AGENTS.md` voor het project, plus `.cursorrules` als dunne persoonlijke laag: voorkeuren en Cursor-afspraken, met een verwijzing naar `AGENTS.md` en zonder overlap | **`AGENTS.md` verplicht**: iedereen gebruikt een andere tool. Geen `.cursorrules`: persoonlijke voorkeuren horen in je eigen user rules |
| Status | `docs/work/` in de repo | Issue tracker of bord; geen statusbestanden in de repo |
| Logs | Dag-logs nuttig als geheugen | Weglaten: PR-beschrijvingen en commits zijn de log |
| Specs | `docs/work/specs/` | Issue-beschrijving, of een spec in de PR |
| Overleg | `docs/work/meetings/` als er een klant of coach is | `docs/work/meetings/`, of de wiki van de tracker; kies één plek |
| Besluiten | ADR's | ADR's, **ingediend via een PR** zodat het team ze ziet |
| Opleveringen | `docs/deliverables/` | `docs/deliverables/`, met de versie die werkelijk ingediend is |
| Eigenaarschap | Jij | Eén "docs steward" per sprint (roteert); docs zijn deel van de Definition of Done |
| Controle | `make check` lokaal + pre-commit | `make check` lokaal **en** in CI op elke PR, branch protection op `main` |

---
