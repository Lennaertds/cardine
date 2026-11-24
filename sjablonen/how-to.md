# docs/how-to/&lt;taak&gt;.md

> **Rol:** Eén taak stap voor stap: deploy, database resetten, data laden, release.
> **Niet hier:** waarom het zo werkt ([architecture](architecture.md)), het commando zelf als het één regel is (de Makefile).

**Kitbestand:** geen; de map [kit/kern/docs/how-to/](../kit/kern/docs/how-to/) staat klaar · laag kern

## Wanneer

Als een taak meer is dan één make-target, en je hem minder dan maandelijks doet (zodat je de stappen vergeet). Is het één commando, maak dan een make-target met `## uitleg` in plaats van een how-to.

## Invullen

Gebruik deze vorm:

```markdown
# <Taak als werkwoord, bv. "Databases resetten">

> **Rol:** <wanneer je dit nodig hebt>
> **Niet hier:** <waarom het zo werkt → architecture/…>

## Vooraf

- <Wat moet kloppen: .env, toegang, back-up.>

## Stappen

1. `<commando>` — <wat je ziet als het goed gaat>
2. …

## Als het misgaat

| Melding | Oorzaak | Oplossing |
|---------|---------|-----------|
```

## Voorbeeld (DEP2, `how-to/databases-resetten.md`)

```markdown
## Stappen

1. `make status` — de staging- en DWH-database draaien.
2. `bash scripts/reset_staging.sh` — **wist alle staging-tabellen**. Vraag eerst het team in het kanaal.
3. `bash scripts/reset_dwh.sh` — na een staging-reset altijd ook de DWH, anders verwijzen feiten naar niets.
4. `make data` — de volledige pipeline (± 25 min; de wortelmeting duurt ± 10 min).

## Als het misgaat

| Melding | Oorzaak | Oplossing |
|---------|---------|-----------|
| `Violation of PRIMARY KEY` in `FactWortelmeting` | DWH niet gereset na staging | stap 3, dan stap 4 |
```

## Snelle toets

- [ ] Elke stap is een commando dat je kan plakken, met wat je dan ziet.
- [ ] Destructieve stappen staan in vet, met wie je eerst vraagt.
- [ ] `docs/INDEX.md` § How-to heeft een regel voor dit bestand.
