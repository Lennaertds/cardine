# docs/research/

> **Rol:** Wat je over het domein weet, op welke bronnen het steunt, en welke productregel erop rust.
> **Niet hier:** de productregels zelf ([product](product.md)), één experiment ([experiment](experiment.md)).

**Kitbestanden:** [RESEARCH.md](../kit/modules/research/docs/research/RESEARCH.md), [wantlist.md](../kit/modules/research/docs/research/wantlist.md), [radar.md](../kit/modules/research/docs/research/radar.md), [digest/](../kit/modules/research/docs/research/digest/README.md), [experiments/_template.md](../kit/modules/research/docs/research/experiments/_template.md), how-to radar/digest · module `research`

## Wanneer

Als productregels op literatuur steunen (trainingsvolume, slaap), als je experimenten draait, of bij een bachelorproef. Een agent die codewerk doet, laadt deze map niet; de kaart zegt dat.

## Invullen

1. **Onderzoeksvragen** in `RESEARCH.md`, genummerd. Elke `<onderwerp>.md` en elk experiment verwijst naar een nummer.
2. **Hoe je bronnen beoordeelt:** de niveaus en wat een niveau mag dragen. Zo kan je bij elke regel zeggen hoe sterk ze staat.
3. **Per onderwerp** een bestand: wat je weet, met bron, niveau en de productregel die erop steunt.
4. **Wantlist:** wat je nog wil lezen. De pdf's zelf staan in `data/external/`, nooit in git.
5. **Tech-radar:** [radar](radar.md) — ringen + maandelijks ritueel; niet always-on in AGENTS.
6. **Digest:** [digest](digest.md) — fetch/propose; cureren vóór radar (P5).

## Voorbeeld (GymFreak, `research/training-volume.md`)

```markdown
# Trainingsvolume

> **Rol:** Wat we weten over sets per spiergroep per week, en welke regel van de split-engine erop steunt.
> **Niet hier:** de regel zelf (`product/H-gym.md`).

| Bewering | Bron | Niveau | Productregel |
|----------|------|--------|--------------|
| 10+ sets per week geeft meer hypertrofie dan < 5 | Schoenfeld 2017 | A | standaard 10–20 sets per spiergroep |
| Boven 20 sets weinig extra winst bij beginners | Baz-Valle 2022 | B | waarschuwing boven 20 |
```

## Snelle toets

- [ ] Elke productregel die op onderzoek steunt, is hier terug te vinden.
- [ ] Geen pdf's of volledige teksten van derden in git.
- [ ] De kaart zegt "niet laden bij codewerk".
