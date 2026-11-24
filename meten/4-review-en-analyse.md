# Stap 4 — Review en analyse

> **Rol:** De diffs blind beoordelen en de condities eerlijk vergelijken.
> **Niet hier:** wat je meet ([INDEX](INDEX.md#wat-je-meet)), de valkuilen ([validiteit](5-validiteit.md)).

## Reviewrubriek (blind)

Laat een script de diffs anonimiseren (conditie weg, volgorde geschud) voor je ze beoordeelt. In een teamproject kan een teamgenoot meescoren. Dan kan je ook de overeenstemming tussen beoordelaars rapporteren.

| Score | Betekenis |
|-------|-----------|
| 5 | Zou ik zo mergen. Volgt de bestaande patronen, binnen de scope, met tests |
| 4 | Kleine opmerkingen (naamgeving, een overbodige regel) |
| 3 | Werkt, maar wijkt af van de patronen of doet meer dan gevraagd |
| 2 | Werkt deels, of is moeilijk te onderhouden (shotgun surgery, try/catch om tests te laten slagen, §6) |
| 1 | Fout, of breekt een regel |

## Analyse

- Slaagkans (aantal geslaagd / runs), met de spreiding over de herhalingen.
- Mediaan en interkwartielafstand van tokens, toolcalls, stappen tot het relevante bestand, en duur.
- Gemiddelde reviewscore.
- Aantal schendingen.

**Vergelijken:**

- Gepaard per taak: werkt dezelfde taak beter in C2 dan in C1? Toon een tabel per taak, niet alleen gemiddelden. Kleine aantallen verbergen veel in een gemiddelde.
- Voor de slaagkans (ja/nee, gepaard): de McNemar-test. Voor tokens en stappen: de Wilcoxon signed-rank test. Met 10 taken is dat indicatief, niet bewijzend. Zeg dat er ook bij.
- Kijk naar de **traces** van de taken waar de condities verschillen: wat deed de agent anders? Volgde hij een regel? Las hij een verkeerd document? Dat verklaart het *waarom*, en daar haal je de lessen uit.

**Rapporttabel** (ook in [kit/results.csv](kit/results.csv) als kolommen):

| Conditie | Slaagkans | Review (gem.) | Tokens (mediaan) | Toolcalls (mediaan) | Stappen tot relevant | Schendingen |
|----------|-----------|---------------|------------------|---------------------|----------------------|-------------|
| C0 | | | | | | |
| C1 | | | | | | |
| C2 | | | | | | |
