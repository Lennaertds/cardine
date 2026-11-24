# Stap 7 — Meten en vastleggen

> **Rol:** Nagaan of de herordening iets opleverde, en het resultaat bewaren.
> **Niet hier:** de meetmethode ([meten](../meten/INDEX.md)).

## Doen

1. **Dezelfde taken opnieuw**, met hetzelfde model en dezelfde prompts, op de nieuwe stand: conditie **C2** ([condities](../meten/2-condities.md)). Zelfde aantal herhalingen als de nulmeting.
2. **Vergelijken per taak**, niet alleen gemiddelden ([analyse](../meten/4-review-en-analyse.md)). Bekijk de traces van de taken waar C1 en C2 verschillen: wat deed de agent anders?
3. **Vastleggen in een ADR:**

   ```bash
   make adr t="Docs en structuur volgen de standaard uit Agent_Engineering"
   ```

   Met in **Gevolgen** de tabel van C1 tegenover C2, en wat je eruit leerde.

4. **Lessen terug naar de standaard.** Paste iets nergens, of hielp een regel niet, pas dan de standaard of de kit aan ([standaard veranderen](../standaard/INDEX.md#de-standaard-veranderen)), niet alleen dit project.
5. **Verhuistabel weg** (`docs/work/specs/herordening.md`). De ADR en git bewaren wat er gebeurde.

## Klaar als

- De ADR staat erin met de cijfers.
- De verhuistabel is weg.
- Wat je over de standaard leerde, staat in de standaard.
