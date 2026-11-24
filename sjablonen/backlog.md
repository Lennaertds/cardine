# docs/work/BACKLOG.md

> **Rol:** Index van open werk: één korte regel + link naar de spec. Geen plan hier.
> **Niet hier:** afgewerkt werk (git en de logs), besluiten ([adr](adr.md)), het plan van één item ([spec](spec.md)).

**Kitbestand:** [kit/solo/docs/work/BACKLOG.md](../kit/solo/docs/work/BACKLOG.md) · laag solo · P8, P27. Team: de issue tracker, geen bestand. Dit is de persistente spine van open werk (P27) — als **index**, niet als notitieblok.

## Wanneer

Solo, vanaf dag 1. Een agent leest de backlog niet vooraf; de opdracht noemt het item (of de link naar de spec).

## Invullen

1. **Nu:** alleen via `make spec s=<slug>` → indexregel bovenaan **plus** `specs/<slug>.md`. Nooit een essay of slices in de tabel plakken.
2. **Straks:** gekozen, nog niet gestart: één korte regel + waarom later. Nog geen spec tot je promoveert naar Nu (`make spec`).
3. **Geparkeerd:** idee/ontwerp dat wacht — met plan: `make spec` + regel hier; zonder plan: één korte regel + waarop. Geparkeerd is niet `archive/`.
4. **Categorie is een kolom**, geen map.
5. Afgewerkt: regel weg; spec na merge `git rm`. Git en de log onthouden het.

## Voorbeeld (GymFreak)

```markdown
## Nu

| Item | Categorie | Status |
|------|-----------|--------|
| [diet-budget](specs/diet-budget.md) | feature | slice 2 van 3 |
| [iphone-themas-traag](specs/iphone-themas-traag.md) | UI | open |

## Straks

| Item | Categorie | Waarom later |
|------|-----------|--------------|
| Weekbudget dieet | feature | Eerst dagbudget live |

## Geparkeerd

| Item | Categorie | Wacht op |
|------|-----------|----------|
| [ai-kluis](specs/ai-kluis.md) | ML | toestemmingsflow voor gezondheidsdata naar de LLM |
```

## Snelle toets

- [ ] Geen afgewerkte items.
- [ ] Elke **Nu**-rij (en Geparkeerd-met-plan) is een markdown-link naar `specs/<slug>.md` — geen losse essay-cel.
- [ ] Elke link werkt (`make links`).
- [ ] Geen item staat ook als TODO in een stabiel doc.
- [ ] Agent die “zet op de backlog” doet: `make spec`, niet alleen BACKLOG editen.
