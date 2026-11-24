# docs/context/CONTEXT.md

> **Rol:** Waarom het project bestaat, voor wie, en wat succes is.
> **Niet hier:** techniek ([architecture](architecture.md)), grenzen ([rules](rules.md)), lange termijn ([vision](vision.md)).

**Kitbestand:** [kit/kern/docs/context/CONTEXT.md](../kit/kern/docs/context/CONTEXT.md) · laag kern · P6

## Wanneer

Dag 0, vóór de eerste code. Daarna alleen aanpassen als de doelgroep of de scope echt verandert.

## Invullen

1. **Gebruiker of klant:** één concrete persona of klant in een concrete situatie.
2. **Probleem:** wat nu misloopt, als feit. Nog geen oplossing.
3. **Doel en succes:** toetsbaar. Bij school of klant ook wat de opdrachtgever als geslaagd ziet.
4. **Scope:** op het niveau van domeinen of cases, niet van features. Kitregel over talen/polyglot laten staan of aanscherpen.
5. **Bewust niet:** met het waarom. Met een `product/`-map verwijs je naar `PRODUCT.md` § Bewust niet.

## Voorbeeld (DEP2)

```markdown
## Gebruiker of klant

CADS, proefhoeve Bottelare. Onderzoekers die kuilmaïsrassen vergelijken op wortelgroei,
plantaantal (drone) en bodemvocht (Kurosens), en dat nu in losse Excel-bestanden doen.

## Doel en wat succes is

- Eén datawarehouse waarin elke meting van de drie cases per plot en ras te vergelijken is.
- De klant draait de pipeline zelf opnieuw na een nieuwe meetcampagne, zonder ons.

## Bewust niet

- Geen eigen beeldherkenning op de wortelscans: we gebruiken de output van RootScan.
```

## Snelle toets

- [ ] Iemand die alleen dit leest, kan zeggen voor wie het is en wanneer het geslaagd is.
- [ ] Geen stack, geen hosting, geen planning.
- [ ] Elk "bewust niet" heeft een reden.
