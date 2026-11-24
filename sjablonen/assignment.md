# docs/context/assignment.md

> **Rol:** Wat de school of klant vraagt, hoe het beoordeeld wordt, en tegen wanneer.
> **Niet hier:** hoe je het oplost ([architecture](architecture.md)), wat je indiende (`docs/deliverables/`).

**Kitbestand:** [kit/modules/assignment/docs/context/assignment.md](../kit/modules/assignment/docs/context/assignment.md) · module `assignment`

## Wanneer

Bij elk project met een opdrachtgever: een vak, een stage, een klant. Dag 0, zodra je de opdracht hebt.

## Invullen

1. **Opdrachtgever en contact:** vak of klant, naam en kanaal. Geen privénummers in git.
2. **Opdracht in eigen woorden:** drie à vijf zinnen; citeer letterlijk waar het ertoe doet. Het brondocument zelf gaat naar `deliverables/` of blijft in de leeromgeving.
3. **Beoordelingscriteria:** met het gewicht en **waar je het aantoont**. Die laatste kolom is je checklist voor de oplevering.
4. **Deadlines:** datum, wat, status.
5. **Randvoorwaarden:** verplichte technologie, wat niet mag.

## Voorbeeld (DEP2)

```markdown
## Beoordelingscriteria

| Criterium | Gewicht | Waar we het aantonen |
|-----------|---------|----------------------|
| Sterschema en ETL | 30 % | `docs/architecture/database.md`, demo stap 2 |
| Datakwaliteit | 20 % | `make check-full` (checks op lege en dubbele metingen) |
| Samenwerking | 20 % | PR's met review, sprintverslagen in `docs/work/meetings/` |

## Randvoorwaarden

- Database: MSSQL van de school; geen cloud-diensten buiten de EU.
- Groep van vijf; elk lid heeft PR's in de geschiedenis.
```

## Snelle toets

- [ ] Elk criterium heeft een plek waar je het aantoont.
- [ ] De deadlines staan er met datum.
- [ ] Geen persoonsgegevens van docenten of klanten buiten naam en werkkanaal.
