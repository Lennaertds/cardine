# apps/&lt;app&gt;/AGENTS.md (genest)

> **Rol:** Wat alleen in deze app geldt of afwijkt: indeling, één test draaien, valkuilen. De root blijft ook gelden.
> **Niet hier:** wat voor het hele project geldt ([agents-root](agents-root.md)).

**Kitbestanden:** [next](../kit/stacks/next/apps/web/AGENTS.md) · [nest](../kit/stacks/nest/apps/api/AGENTS.md) · [python](../kit/stacks/python/apps/analytics/AGENTS.md) · [sql](../kit/stacks/sql/apps/pipeline/AGENTS.md) · laag stack · P15

## Wanneer

Bij elke app. De kit zet een versie neer met de regels van de stack; jij schrapt wat niet geldt en vult de valkuilen aan. Gebruik je in plaats daarvan een `.cursor/rules/<app>.mdc`, dan niet allebei met dezelfde regels.

## Invullen

1. **Indeling:** de regels uit [stacks](../standaard/stacks.md) die de agent het vaakst fout doet. Niet de hele boom.
2. **Tests:** het commando voor **één** test, met een echt pad.
3. **Valkuilen:** wat al eens misliep. Elke valkuil die je kan afvangen met een test of script, vang je af; dan blijft hier alleen de verwijzing.
4. **Geen kopie van de root.** Herhaal geen "Nooit"-regels; verwijs.

## Voorbeeld (GymFreak, `apps/web/AGENTS.md`, valkuilen)

```markdown
## Valkuilen

- Fout `Cannot find module './NNN.js'` na `make build-web`: eerst `make clean-web`, dan `make dev-web`.
- 119 componenten staan nog plat in `src/components/`. Nieuwe componenten van een domein gaan naar
  `src/features/<domein>/components/`; een bestaande verhuist pas als je hem toch aanpast.
- Thema's zitten in `public/themes/<thema>/`; nieuwe kleuren eerst als token in `src/styles/`.
```

## Snelle toets

- [ ] Onder de 40 regels.
- [ ] Elke regel geldt **alleen** voor deze app. Geldt hij voor twee apps, dan hoort hij in de root.
- [ ] Het één-test-commando werkt als je het letterlijk plakt.
