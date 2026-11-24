# Extra voor teamprojecten (sprint 0)

> **Rol:** Wat er anders is als je met meerdere mensen aan één repo werkt.
> **Niet hier:** de verschillen in de structuur zelf ([solo-team](../standaard/solo-team.md)).

## Kit

```bash
kit/new-project.sh <map> --team --modules assignment,deliverables --stacks …
```

De team-laag zet `.github/` neer (CI met `make check`, PR-template, issue-templates) en voegt de module `meetings` toe. Er komt geen `docs/work/BACKLOG.md`, `specs/` of `logs/`: status staat in de issue tracker.

## Sprint 0

- [ ] Samen `AGENTS.md`, `RULES.md` en de eerste ADR's opstellen en via één PR mergen. Iedereen leest ze één keer.
- [ ] Afspreken: **docs bijwerken hoort bij de Definition of Done.** De PR-template vraagt ernaar.
- [ ] Eén **docs steward** per sprint, die roteert. Die doet [onderhoud](6-onderhoud.md) in de laatste sprintweek en brengt het in de retro.
- [ ] Status alleen in de tracker. Geen `TODO.md`, `STATUS.md` of `last_changes.md` in de repo.
- [ ] Een ADR veranderen = een PR met een nieuwe ADR. Geen stille wijzigingen.
- [ ] Gedeelde termen in `GLOSSARY.md`, zeker bij gemengd Nederlands en Engels.
- [ ] Afspreken welke tools iedereen gebruikt. `AGENTS.md` is de gemeenschappelijke basis; persoonlijke Cursor-rules horen in je eigen user rules, niet in de repo. Module `claude` als iemand Claude Code gebruikt.
- [ ] Branch protection op `main`: CI groen en één review.
- [ ] Verslagen van overleg met klant of coach: `make meeting met=<wie>`; wat er beslist werd, wordt een ADR.

## Voorbeeld

DEP2 (team van vijf, sprints van twee weken) is uitgewerkt in [bestaand-project/voorbeelden/dep2](../bestaand-project/voorbeelden/dep2.md). Voor een nieuw teamproject volg je hetzelfde, maar vanaf dag 0.
