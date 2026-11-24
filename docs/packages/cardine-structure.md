# Package: `cardine-structure`

> **De projectstandaard voor ieder project, ongeacht editor of abonnement.**
> Dit is het gratis product uit ADR 0009 — de inhoud komt uit `kit/` in deze repo.

| Veld | Waarde |
|------|--------|
| **Package** | `cardine-structure` |
| **Doelgroep** | Iedereen die een projectstandaard wil (elke editor) |
| **Bron** | `kit/` in deze repo, gekopieerd door `sync_kit.sh` |
| **Installatie** | `npx @lennaertds/cardine-structure <map>`, `npm i -g` + `cardine-structure`, of `new-project.sh` uit de repo |
| **Afhankelijk van** | niets (zelfstandig) |

---

## Inhoud

De volledige `kit/`, letterlijk gekopieerd naar `packages/structure/kit/`.

| Laag | Beschrijving | Verplicht? |
|------|-------------|-----------|
| `kern/` | README, AGENTS.md, Makefile, .gitignore, .editorconfig, docs/ (INDEX, context, rules, architecture, decisions, how-to), data/ (5 vaste lagen), apps/ | altijd |
| `solo/` | .cursorrules, docs/work/BACKLOG.md, specs/_template.md, logs/_template.md | standaard |
| `logging/` | logs/status-log.md, logs/onderwerpen/_template.md | altijd |
| `team/` | .github/ (CI, PR-template, issue-templates) | optioneel (--team) |
| `modules/<naam>/` | Per module (agent, research, design, compose, …) | optioneel (--modules) |
| `stacks/<stack>/` | Per stack (next, nest, python, sql, rust, c) | optioneel (--stacks) |
| `profiles/<naam>.profile` | Voorgedefinieerde combinaties | optioneel (--profile) |
| `new-project.sh` | Generator-script | ja |

### Mapstructuur

```
packages/structure/
├── CHANGELOG.md
├── README.md
├── package.json
└── kit/              ← letterlijke kopie van de bron
    ├── kern/
    ├── solo/
    ├── logging/
    ├── team/         (optioneel)
    ├── modules/      (optioneel)
    ├── stacks/       (optioneel)
    ├── profiles/     (optioneel)
    └── new-project.sh
```

## Hoe de distributie werkt

```
kit/  (SSOT)
         │
         │  Bij elke release van cardine-structure:
         │  1. Optioneel: make tag-kit TAG=v0.2.0
         │  2. kit/ kopiëren naar packages/structure/kit/
         │  3. Versie ophogen, changelog bijwerken
         │
         ▼
cardine/packages/structure/  (publiek)
```

## Wat niet in het package gaat

| Onderdeel | Waarom niet in het package |
|-----------|-------------|
| `standaard/` | Regels, principes, waarom de structuur zo is — logica achter de kit |
| `sjablonen/` | Invulgidsen per bestand — uitleg voor de maker |
| `nieuw-project/`, `bestaand-project/` | Gidsen — hoe gebruik je de kit |
| `bron/` | Kennis, principes, fundament — research en achtergrond |
| `meten/` | Meetprotocollen, taken, resultaten |
| `scripts/` | Interne tooling (test-kit, bootstrap, digest-triage, sessielogs) |

## Installatie

Het package staat op de publieke npm-registry als
`@lennaertds/cardine-structure`.

```bash
# Nieuw project starten (aanbevolen)
npx @lennaertds/cardine-structure mijn-project --profile app --modules research,agent

# Of globaal installeren; het bin heet cardine-structure
npm i -g @lennaertds/cardine-structure
cardine-structure mijn-project --profile app

# Of direct uit de repo (alleen Git + Bash nodig)
bash cardine/packages/structure/kit/new-project.sh mijn-project --profile app
```

## Relaties

- Maakt deel uit van de **cardine (meta)**-verwijzingen
- Komt uit **`kit/`** in deze repo (SSOT) — zie [ADR 0013](../../docs/decisions/0013-cardine-is-het-publieke-uithangbord-en-pullt-de-structure-uit-agent-engineering.md)
- Kan samen met `cardine-lab` gebruikt worden voor een volledig werkstation

## Versiebeheer

Zie [VERSIONING.md](VERSIONING.md) voor het algemene schema.
CHANGELOG: `packages/structure/CHANGELOG.md` (eigen versie, SemVer).
Git-tag: `structure-v<semver>`.