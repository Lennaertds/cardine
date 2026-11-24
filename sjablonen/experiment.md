# docs/research/experiments/YYYY-MM-DD-&lt;slug&gt;.md

> **Rol:** Verslag van één experiment: vraag, opzet, data, resultaat, conclusie.
> **Niet hier:** de code (`apps/<app>/experiments/`), wat je algemeen weet ([research](research.md)).

**Kitbestand:** [kit/modules/research/docs/research/experiments/_template.md](../kit/modules/research/docs/research/experiments/_template.md) · module `research`

## Wanneer

Elke keer dat je iets uitprobeert waarvan de uitkomst een keuze bepaalt: een model, een drempel, een parameter. Het verslag blijft, ook als het experiment mislukt; vooral dan.

```bash
make experiment s=sleep-baseline     # docs/research/experiments/2026-10-19-sleep-baseline.md
```

## Invullen

1. **Vraag:** zo dat het antwoord ja, nee of een getal is.
2. **Code** en **data:** het pad naar de code, de dataset en versie uit `data/README.md`. Nooit ruwe persoonsgegevens in het verslag; tellingen en verdelingen wel.
3. **Opzet:** wat je vergelijkt, met welke parameters, hoe vaak.
4. **Resultaat:** een tabel met de metriek.
5. **Conclusie:** wat je ermee doet: een productregel, een ADR, of niets.

## Voorbeeld (GymFreak)

```markdown
# 2026-10-19 — sleep-baseline

- **Vraag:** Voorspelt de slaapduur van de vorige nacht het trainingsvolume beter dan het gemiddelde van 7 dagen?
- **Code:** `apps/analytics/experiments/2026-10-19-sleep-baseline.py`
- **Data:** `processed/day_features/` (eigen data, 412 dagen)

## Resultaat

| Variant | MAE (sets) |
|---------|------------|
| gemiddelde 7 dagen | 3,1 |
| vorige nacht | 3,4 |

## Conclusie

Nee. Insights blijven op het 7-daagse gemiddelde; geen productwijziging.
```

## Snelle toets

- [ ] De vraag heeft een antwoord in de conclusie.
- [ ] Code en data zijn terug te vinden met de paden in de kop.
