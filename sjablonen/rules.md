# docs/rules/RULES.md

> **Rol:** De inhoudelijke grenzen van het project: wat het nooit doet, en wat altijd moet.
> **Niet hier:** codestijl (de linter), werkwijze van de agent ([agents-root](agents-root.md)), technische maatregelen ([security](security.md)).

**Kitbestand:** [kit/kern/docs/rules/RULES.md](../kit/kern/docs/rules/RULES.md) · laag kern · P6, P14, P22

## Wanneer

Dag 0 met de drie à vijf grenzen die je al kent. Elke nieuwe grens die een klant, docent of jijzelf stelt, komt er meteen bij.

## Invullen

1. **Eén zin per regel, met het waarom erbij.** Zonder waarom kan niemand een randgeval beslissen.
2. **Nooit** voor wat het product niet mag doen; **Altijd** voor wat in elke feature moet zitten.
3. **Afdwingbaar?** Schrijf de test, hook of CI-check, en verwijs ernaar. Een regel die alleen hier staat, wordt vroeg of laat gebroken. De test moet de **intentie** bewaren: groen door de regel af te zwakken telt niet (P22).
4. Werkwijze ("niet committen") hoort in `AGENTS.md`, niet hier. Hier staat wat het **product** mag.

## Voorbeeld (GymFreak)

```markdown
## Nooit

- Geen medisch advies: de app toont trends en bronnen, geen diagnoses of behandelingen.
- Geen gezondheidsdata naar een externe LLM zonder dat de gebruiker het per keer toestaat.
  Bewaakt door `apps/api/src/llm/consent.guard.spec.ts`.
- Geen dark patterns om de streak te houden.

## Altijd

- Elke aanbeveling toont haar bron (paper uit `data/reference/evidence/` of een eigen regel).
- Een gebruiker kan al zijn data exporteren en verwijderen.
```

## Snelle toets

- [ ] Elke regel heeft een waarom.
- [ ] Geen regel over code of tools; die horen in `AGENTS.md` of de linter.
- [ ] Wat afdwingbaar is, verwijst naar zijn test of hook — en die test omzeilt de regel niet.
