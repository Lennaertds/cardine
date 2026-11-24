# Stap 6 — Onderhoud

> **Rol:** Maandelijks (solo) of in de laatste sprintweek (team) snoeien en bijwerken, zodat de docs de code blijven volgen.
> **Niet hier:** meten of een wijziging helpt ([meten](../meten/INDEX.md)).

Begin met:

```bash
make docs-health    # dode links, lengte van elke AGENTS.md, de docs die het langst niet wijzigden
```

## Snoeien (P20, P25; bron §3, §12, §21, §25)

- [ ] `AGENTS.md`: voor elke regel de deletion test. Zou de agent zonder deze regel een fout maken? Zo niet, schrappen. Langer dan nodig = harness tax.
- [ ] Dekking van de acht Coldtea-thema’s (bron §34): [snelle toets in agents-root](../sjablonen/agents-root.md#dekking-coldtea-bron-34). Gat = ontbreekt ergens in het systeem, of bewust elders.
- [ ] Is een regel intussen afdwingbaar met een linter, test of hook? Verhuis hem (P14). Harness-hacks die het model natively aankan: weg (P25).
- [ ] Dubbele feiten: `rg -n '<kernbegrip>' docs AGENTS.md` — staat het op meer dan één plek uitgelegd? (P7)
- [ ] Afleiders: oude configs, `_v2`-bestanden, docs over code die niet meer bestaat → weg of `docs/archive/` (P16).
- [ ] Ondiepe `utils/`/`helpers/` die AI heeft aangemaakt: samenvoegen tot deep modules of seams documenteren (P16, P23).

## Bijwerken

- [ ] `docs/INDEX.md` klopt met de bestanden die bestaan (`make links` is groen, en geen doc ontbreekt).
- [ ] `ARCHITECTURE.md` klopt met de containers, poorten en **seams** die echt draaien.
- [ ] Productregels hebben nog een bewaking die de intentie bewaart (P22).
- [ ] Vervangen ADR's staan op `vervangen door NNNN`.
- [ ] Afgewerkte specs zijn weg. De backlog bevat alleen open werk (spine, P27).
- [ ] `data/README.md` noemt elke dataset die er staat.
- [ ] Versies in `.pre-commit-config.yaml`: `pre-commit autoupdate`.

## Meten (P21)

- [ ] Na een grotere wijziging aan de structuur of `AGENTS.md`: de minimale meting uit [meten](../meten/INDEX.md#minimale-versie-een-namiddag).

## Klaar als

Een frisse agent slaagt nog steeds voor de toets uit [stap 4](4-agent.md#toets-met-een-frisse-agent), en `make docs-health` toont niets nieuws.
