# Bestaand project — stappenplan

> **Rol:** Een lopend project naar de standaard brengen zonder werk of geschiedenis te verliezen.
> **Niet hier:** een nieuw project ([nieuw-project](../nieuw-project/INDEX.md)), de doelstructuur zelf ([skelet](../standaard/skelet.md)).

Twee regels vooraf:

1. **Meet vóór en na** (P21). Anders weet je niet of de herordening iets opleverde.
2. **Eén stap per commit**, verhuizen met `git mv`. Zo blijft elke stap apart terug te draaien en houdt elk bestand zijn geschiedenis.

## Wat je kopieert

Het script overschrijft nooit iets, maar het kijkt alleen naar de doelnaam. Daarom: in stap 1 een droge run om te zien wat ontbreekt, in stap 3 en 4 een paar bestanden met de hand, en het script pas echt in stap 5, **nadat** elk bestaand bestand zijn vaste naam heeft. Nooit `--starter` op een bestaande app.

```bash
kit/new-project.sh <project> --modules <modules> --stacks <stacks> --no-git --dry-run
```

| Uit de kit | Wanneer | Wat je doet met wat al bestaat |
|------------|---------|--------------------------------|
| `herordening` (module) | stap 1, met de hand | `docs/work/specs/herordening.md`: de verhuistabel |
| `stacks/<s>/apps/<app>/app.mk` | stap 3, met de hand | bestaande targets naar de vaste namen, commando's van het project; zie [stap 3](3-feedbacklus.md) |
| `Makefile`, `scripts/check-links.sh` | stap 3, met de hand | eigen Makefile: hernoemen, de kit-versie als basis, targets overzetten |
| `.gitignore`, `.editorconfig`, `.pre-commit-config.yaml` | stap 4, met de hand | `.gitignore`: het kit-blok bovenaan, projectregels onderaan tot de data verhuisd is |
| `docs/`, `data/`, `apps/<app>/AGENTS.md` | stap 5, met het script | eerst verhuizen naar de vaste naam, dan vult het script alleen de gaten |
| `AGENTS.md`, `docs/INDEX.md` | stap 6 | de oude router is de bron, de kit-versie de vorm |
| `.cursorrules` (solo) | stap 6 | wordt de dunne persoonlijke laag; de inhoud verhuist naar `AGENTS.md` |

Wil je dit niet zelf doorlopen, laat dan een agent het doen: [opstartpakket](../BOOTSTRAP.md).

## Stappen

| Stap | Tijd | Klaar als |
|------|------|-----------|
| [1. Nulmeting en inventaris](1-nulmeting-en-inventaris.md) | 1 uur | meting C1 gedraaid; lijst van alle docs en agentbestanden; droge run bekeken |
| [2. Classificeren](2-classificeren.md) | 1 uur | elk bestand heeft een soort en een doel in de verhuistabel |
| [3. Feedbacklus](3-feedbacklus.md) | 1 uur | `make check` bestaat en is groen |
| [4. Opruimen](4-opruimen.md) | 30 min | afleiders, status en build-output weg; `.gitignore` uit de kit |
| [5. Verhuizen](5-verhuizen.md) | 1–3 uur | elk bestand op zijn vaste plek; links bijgewerkt |
| [6. Router en kaart](6-router-en-kaart.md) | 1 uur | één `AGENTS.md`, één `docs/INDEX.md`; geen tweede router |
| [7. Meten en vastleggen](7-meten-en-vastleggen.md) | 1 uur | meting C2, vergelijking, ADR met de resultaten |

## Volgorde als je weinig tijd hebt

Wat het meest oplevert per uur:

1. `make check` (P13) — [stap 3](3-feedbacklus.md)
2. `AGENTS.md` met "Nooit" en commando's (P6, P17) — [stap 6](6-router-en-kaart.md)
3. Afleiders en parallelle lijnen opruimen (P7, P16) — [stap 4](4-opruimen.md)
4. Seams en deep modules vóór AI-volume (P23) — architectuur + tests op naden, daarna pas grote agent-refactors
5. Mappenbomen en lijsten schrappen (P5) — [stap 5](5-verhuizen.md)
6. Kaart (`INDEX.md`) herschrijven (P2) — [stap 6](6-router-en-kaart.md)
7. Glossarium (P10)
8. Besluiten opsplitsen in ADR's (P9), alleen als de meting erom vraagt

## Voorbeelden

| Project | Soort | Uitgewerkt |
|---------|-------|------------|
| GymFreak | solo, Next + Nest + Python, gezondheidsdata | [voorbeelden/gymfreak](voorbeelden/gymfreak.md): elk bestand geplaatst, stappen G-0 tot G-8 |
| Data_Engineering_Project_2 | team van vijf, Python-ETL naar MSSQL, sprints | [voorbeelden/dep2](voorbeelden/dep2.md): bevindingen D1–D10, stappen D-1 tot D-7 |
