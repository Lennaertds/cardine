# docs/work/specs/&lt;slug&gt;.md

> **Rol:** Het plan voor één werkitem: doel, scope, raakvlakken, slices, acceptatie. Tijdelijk.
> **Niet hier:** het gedrag dat blijft ([product](product.md)), het waarom van een keuze ([adr](adr.md)).

**Kitbestand:** [kit/solo/docs/work/specs/_template.md](../kit/solo/docs/work/specs/_template.md) · laag solo · P1, P18, P22–P24, P27. Team: het [feature-issue](pr-template.md).

## Wanneer

Elk nieuw item op **Nu** (en Geparkeerd met een plan): altijd `make spec`. De BACKLOG is alleen de index; dit bestand is het plan. Micro-fix zonder backlog-regel: geen spec nodig.

```bash
make spec s=diet-budget     # spec + indexregel bovenaan BACKLOG § Nu
```

Daarna de placeholders in de spec invullen (doel, scope, slices). Nooit het plan in de BACKLOG-tabel dumpen.

## Invullen

1. **Doel:** wat de gebruiker straks kan, en waarom.
2. **Buiten scope:** expliciet, ook wat voor de hand ligt. Dit houdt de agent binnen de lijnen.
3. **Raakvlakken:** modules, de interface die verandert, **seams die raken** (P23), en een **voorbeeld om te volgen**.
4. **Slices:** verticaal, elk apart testbaar en in **één sessie** (P1, P24). Past een slice niet in één venster: verder splitsen.
5. **Acceptatie:** intent + tests/commando's, altijd met `make check`. Groen door een productregel af te zwakken telt niet (P22).
6. Na merge: spec weg (`git rm`). De code en de tests zijn dan de waarheid; wat blijft, gaat naar `product/` of een ADR. Tot die tijd is de spec (+ BACKLOG) de *spine* van de taak (P27).

## Voorbeeld (GymFreak)

```markdown
# Spec — diet-budget

## Doel

De gebruiker ziet per dag hoeveel kcal en eiwit hij nog over heeft, zodat hij 's avonds weet wat hij mag eten.

## Scope

- **In:** dagbudget berekenen uit het profiel, resterend tonen op het dieetscherm.
- **Buiten scope:** maaltijdsuggesties, weekbudget, import uit MyFitnessPal.

## Raakvlakken

- `apps/api/src/diet/`, `apps/web/src/features/diet/`
- Nieuw endpoint `GET /diet/budget?date=YYYY-MM-DD`
- Voorbeeld om te volgen: `apps/api/src/sleep/` (engine met pure functies + tests)

## Slices

1. `diet-engine.ts`: budget uit profiel, met tests voor de randgevallen (geen profiel, negatief resterend).
2. Endpoint + integratietest.
3. Kaart op het dieetscherm.
```

## Snelle toets

- [ ] Er staat minstens één ding onder "buiten scope".
- [ ] Elke slice is apart te mergen en past in één schone sessie.
- [ ] Seams die raken zijn genoemd (of "geen").
- [ ] De acceptatie is uitvoerbaar en bewaakt intent, niet alleen "werkt goed".
