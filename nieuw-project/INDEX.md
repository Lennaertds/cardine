# Nieuw project — stappenplan

> **Rol:** Van een lege map tot een project waarin mens en agent meteen goed werken, en hoe je het daarna zo houdt.
> **Niet hier:** een lopend project herordenen ([bestaand-project](../bestaand-project/INDEX.md)), waarom het zo moet ([bron](../bron/principes.md)).

Vuistregel: **de kit legt het fundament, de inhoud groeit op echte vragen en echte fouten** (P20). Een sjabloon dat je niet invult, schrap je; een leeg bestand is een afleider.

## Wat je kopieert

Alles komt uit [kit](../kit/README.md), met één commando. Kies de lagen bij je situatie:

| Situatie | Commando (na de generators uit stap 3) |
|----------|----------------------------------------|
| Solo, web en API, met database | `kit/new-project.sh <map> --modules product,design,compose,observability --stacks next,nest --starter` |
| Solo, data of ML | `kit/new-project.sh <map> --modules research,runtime,models,observability --stacks python --starter` |
| Schoolproject in team, data-pipeline | `kit/new-project.sh <map> --team --modules assignment,deliverables,compose,observability,claude --stacks sql,python --starter` |
| Klantproject in team, web | `kit/new-project.sh <map> --team --modules assignment,product,design,compose,observability --stacks next,nest` |
| Prototype of hackathon | zie [minimaal](minimaal.md) |

Twijfel je over een module, laat hem dan weg. De plaats ligt toch vast ([skelet](../standaard/skelet.md)); je voegt hem later toe met hetzelfde commando, dat niets overschrijft.

## Stappen

| Stap | Wanneer | Tijd | Klaar als |
|------|---------|------|-----------|
| [1. Kit kopiëren](1-kit-kopieren.md) | dag 0 | 10 min | `make help` werkt; `make check` faalt met "controleert nog geen app" |
| [2. Context en grenzen](2-context-en-grenzen.md) | dag 0, vóór code | 1 uur | CONTEXT, RULES, GLOSSARY ingevuld; containerdiagram; eerste ADR's |
| [3. Apps en feedbacklus](3-apps-en-feedbacklus.md) | dag 1 | 1–2 uur | elke app gegenereerd, `make check` groen met één echte test |
| [4. Agent](4-agent.md) | dag 1 | 30 min | `AGENTS.md` en de kaart kloppen; frisse agent slaagt voor de toets |
| [5. Per feature](5-per-feature.md) | elke keer | — | spec of issue, slices, `make check` groen, docs bij |
| [6. Onderhoud](6-onderhoud.md) | maandelijks of per sprint | 30 min | gesnoeid, kaart klopt, eventueel gemeten |

In team doe je stap 1 tot 4 samen in sprint 0: zie [team](team.md).

## Afvinken

Kopieer de lijst hieronder in je eerste dag-log (`make log`) of in een issue.

```markdown
- [ ] 1 kit gekopieerd, `make help` werkt
- [ ] 2 CONTEXT · RULES · GLOSSARY · ARCHITECTURE (containers + seams) · ADR's stack/db/hosting
- [ ] 3 generators gedraaid · kit over de apps · `make setup` · `make check` groen
- [ ] 4 AGENTS.md ingevuld (intent, seams, één slice) · docs/INDEX.md zonder lege verwijzingen · toets met frisse agent
```
