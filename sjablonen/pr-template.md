# .github/pull_request_template.md en ISSUE_TEMPLATE/

> **Rol:** Elke PR en elk issue vraagt naar dezelfde dingen: wat, waarom, hoe getest, welke docs.
> **Niet hier:** het plan van een groot item solo ([spec](spec.md)).

**Kitbestanden:** [pull_request_template.md](../kit/team/.github/pull_request_template.md), [bug.md](../kit/team/.github/ISSUE_TEMPLATE/bug.md), [feature.md](../kit/team/.github/ISSUE_TEMPLATE/feature.md) · laag team · P8, P19, P22–P24

## Wanneer

Elk teamproject, vanaf sprint 0. De PR-template is de plek waar "docs bijwerken hoort bij de Definition of Done" zichtbaar wordt, plus review op intent en seams.

## Invullen

1. **PR:** wat en waarom in één à drie zinnen, met link naar het issue. Hoe getest. **Review:** mens of frisse agent-sessie; intent niet afgezwakt; geen nieuwe modulegrenzen zonder ADR (P19, P22, P23). Welke docs geraakt, of bewust geen.
2. **Feature-issue:** dezelfde velden als een [spec](spec.md): doel, buiten scope, raakvlakken (incl. seams), slices (één sessie), acceptatie op intent. Een agent kan er rechtstreeks mee werken.
3. **Bug-issue:** wat gebeurt, wat had moeten gebeuren, hoe reproduceren, en een test die faalt vóór de fix.
4. Schrap vakjes die in jullie team nooit gelden; een vakje dat iedereen blind aanvinkt, zegt niets.

## Voorbeeld (DEP2, ingevulde PR)

```markdown
## Wat en waarom

Loader voor dronevluchten zet `├п` om naar `ï` vóór de insert. Fixes #41.

## Hoe getest

- [x] `make check` groen (CI)
- [x] `make check-full` lokaal tegen de school-DB: 3 nieuwe vluchten geladen, geen dubbele plots

## Docs

- [x] Docs bijgewerkt: `docs/architecture/case2-drone.md` (valkuil encoding)
```

## Snelle toets

- [ ] Elke gemergede PR van de laatste sprint heeft "Docs" en "Review" ingevuld.
- [ ] Een feature-issue heeft iets onder "buiten scope" en noemt seams of "geen".
- [ ] Niemand vinkt "intent niet afgezwakt" blind aan: spotcheck één PR per sprint.
