# docs/work/logs/YYYY-MM-DD.md

> **Rol:** Wat er die dag gebeurde, wat misliep, en waar je morgen begint.
> **Niet hier:** besluiten ([adr](adr.md)), open werk ([backlog](backlog.md)).

**Kitbestand:** [kit/solo/docs/work/logs/_template.md](../kit/solo/docs/work/logs/_template.md) · laag solo · P8, P20, P27. Team: de PR's zijn de log. Samen met BACKLOG de *spine* van lopend werk — niet de chatgeschiedenis.

## Wanneer

Elke beurt met repo-wijziging, bij het afronden — zonder dat de gebruiker “log” vraagt. `make log` maakt het bestand van vandaag als het nog niet bestaat en toont het pad; de agent vult daarna een entry bovenaan onder `## Gedaan`.

## Invullen

1. **Gedaan:** met het backlog-item of de commit. Kort; de diff zegt de rest.
2. **Misliep:** wat niet werkte en wat je eruit leerde. **Dit is de waardevolste sectie**: een fout die twee keer in de log staat, wordt een regel in `AGENTS.md` of een test.
3. **Volgende:** waar je morgen begint, zodat een nieuwe sessie meteen weet waar.

Logs lees je niet vooraf. Zoeken: `rg -n 'clean-web' docs/work/logs`.

## Voorbeeld (GymFreak)

```markdown
# 2026-10-19

## Gedaan

- diet-budget slice 1: `diet-engine.ts` met 6 tests (feat/diet-budget).

## Misliep

- Agent startte `make dev-web` na een build en kreeg `Cannot find module './812.js'`. Tweede keer deze maand
  → valkuil toegevoegd aan `apps/web/AGENTS.md`.

## Volgende

- Slice 2: endpoint `GET /diet/budget`, integratietest naar het voorbeeld van sleep.
```

## Snelle toets

- [ ] "Misliep" is ingevuld, of bewust leeg.
- [ ] Geen besluit dat alleen hier staat.
