# docs/product/

> **Rol:** Wat het product doet, per domein, gezien vanuit de gebruiker: gedrag, regels, randgevallen.
> **Niet hier:** schermen ([design](design.md)), tabellen en endpoints ([architecture](architecture.md)).

**Kitbestanden:** [PRODUCT.md](../kit/modules/product/docs/product/PRODUCT.md) en [_template.md](../kit/modules/product/docs/product/_template.md) · module `product` · P6, P11, P22

## Wanneer

Zodra er meer dan één domein is, of zodra productregels (wat telt als een training, hoe een budget rekent) niet meer in een spec passen. Een spec beschrijft een wijziging en verdwijnt; `product/` beschrijft het gedrag dat blijft.

## Invullen

1. **`PRODUCT.md`:** de tabel van de domeinen (dezelfde namen als in het glossarium), met status en link, plus **Bewust niet**.
2. **Per domein** een kopie van `_template.md` als `<domein>.md`. Een code vooraan mag (`H-gym.md`), zolang het onderwerp in de naam staat.
3. **Regels** met het waarom en de test die ze bewaakt. Dat is **intentie** (P22): een test die slaagt door de regel af te zwakken, faalt op intentie. De agent mag RULES/product niet stil omzeilen om groen te worden.
4. **Randgevallen:** lege data, dubbels, tijdzones, eenheden. Hier zit wat de agent niet uit de code haalt.

## Voorbeeld (GymFreak, `S-sleep.md`)

```markdown
## Regels

| Regel | Waarom | Bewaakt door |
|-------|--------|--------------|
| Een nacht telt vanaf 18:00 tot 18:00 de dag erna | dutjes en late nachten bij de juiste dag | `sleep-engine.spec.ts` |
| Twee bronnen voor dezelfde nacht: Health wint van handmatig | Health meet, handmatig is een schatting | `sleep-merge.spec.ts` |

## Randgevallen

- Zomertijd: een nacht van 23 of 25 uur is geldig.
- Import zonder slaapfases: alleen totale duur tonen, geen fasegrafiek.
```

## Snelle toets

- [ ] Elk domein in `PRODUCT.md` heeft een bestand, en elk bestand een rij.
- [ ] Geen schermbeschrijvingen en geen tabelnamen.
- [ ] Elke regel heeft een waarom en een bewaking; die bewaking omzeilen zou de regel schenden.
