# How-to — tech-radar

> **Rol:** Maandelijks de tech-radar herzien en `make radar-check` / `radar-reminder` gebruiken.
> **Niet hier:** ring-inhoud zelf ([radar.md](../research/radar.md)).

## Vereiste

Module `research` (`docs/research/radar.md`). Zonder: `make radar-check` zegt hoe je de module toevoegt.

## Reminder

```bash
make radar-reminder
```

Toont de `Laatst herzien:`-datum en tip om te herzien als die ouder is dan ~30 dagen (of ontbreekt).

## Check

```bash
make radar-check
```

Controleert vaste secties, ringen/categorieën, `## Bewust later` (P28). Niet in `make check`.

## Herzien (maandelijks)

1. `make radar-reminder` — beslis of je nu herziet.
2. Loop rijen: nog terecht in Adopt/Trial/Assess/Hold?
3. Nieuwe hit → eerst Trial/Assess of wantlist; Adopt/Hold met impact → `make adr`.
4. Zet `Laatst herzien:` op vandaag.
5. `make radar-check`.

Geen scrapers: handmatig of via je eigen §/brug-proces (Agent Engineering). Dump van feeds hoort niet in deze file (P5).
