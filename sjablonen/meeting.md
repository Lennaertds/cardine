# docs/work/meetings/YYYY-MM-DD-&lt;met-wie&gt;.md

> **Rol:** Verslag van een overleg met klant, coach of team: wat besproken, wat beslist, wie doet wat.
> **Niet hier:** het besluit zelf als het over het systeem gaat ([adr](adr.md)).

**Kitbestand:** [kit/modules/meetings/docs/work/meetings/_template.md](../kit/modules/meetings/docs/work/meetings/_template.md) · module `meetings` (komt automatisch met `--team`)

## Wanneer

Na elk overleg waarin iets beslist of afgesproken werd. Een stand-up zonder besluiten: niet.

```bash
make meeting met=klant     # docs/work/meetings/2026-10-19-klant.md
```

## Invullen

1. **Aanwezig en doel:** rollen volstaan.
2. **Besproken:** kort, de punten.
3. **Besluiten:** wat vastligt. Raakt het het systeem, dan maak je meteen een ADR en link je die hier.
4. **Acties:** wie, wat, tegen wanneer. In een team gaan ze ook als issue in de tracker.

## Voorbeeld (DEP2)

```markdown
# 2026-10-14 — klant

- **Aanwezig:** klant (CADS), coach, team
- **Doel:** welke dronevluchten tellen voor case 2

## Besluiten

- Alleen vluchten met een orthomosaic van ≥ 1 cm/pixel tellen mee → ADR 0003.

## Acties

| Wie | Wat | Tegen |
|-----|-----|-------|
| Pieter | Lijst van geldige vluchten aan de klant bezorgen | 2026-10-21 |
```

## Snelle toets

- [ ] Elk besluit over het systeem heeft een ADR.
- [ ] Geen persoonsgegevens van de klant buiten naam en rol.
