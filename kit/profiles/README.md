# Profielen — voorgedefinieerde kit-combinaties

> **Rol:** Per profiel een `.profile`-bestand met variabelen die `new-project.sh` inleest.
> **Niet hier:** de profiel-definities zelf ([standaard/profielen.md](../../standaard/profielen.md)), hoe je een profiel maakt ([sjablonen/profielen.md](../../sjablonen/profielen.md)).

## Bestaande profielen

| Profiel | Gebruik | Modules | Stacks | Extra mappen |
|---------|---------|---------|--------|--------------|
| `app` | Applicatie bouwen | vision, assignment, product, design, research, business, agent, deliverables, meetings, compose, observability | kiest user | — |
| `research` | Onderzoek met software | assignment, research, agent, deliverables, meetings | python | — |
| `studie` | Studieplanning | assignment | — | werk/kalender.md, werk/deadlines.md, werk/studielog.md |
| `schoolwerk` | Oefeningen (DL/DB/Python/algo) | assignment, compose | python | containers/ |

## Hoe het werkt

```bash
kit/new-project.sh ~/code/nieuw --profile app --stacks next,python
```

Het script leest `kit/profiles/<naam>.profile`, vult de variabelen in en gedraagt zich alsof je `--modules ... --stacks ...` handmatig had meegegeven.

## Structuur

```
kit/profiles/
├── README.md
├── app.profile
├── research.profile
├── studie.profile
├── schoolwerk.profile
└── extra/
    ├── app/          # extra bestanden voor app-profiel (eventueel)
    ├── research/
    ├── studie/
    │   ├── werk/
    │   │   ├── kalender.md
    │   │   ├── deadlines.md
    │   │   └── studielog.md
    │   └── Makefile
    └── schoolwerk/
        ├── containers/
        │   └── docker-compose.yml
        └── Makefile
```