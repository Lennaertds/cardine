# Package: `cardine-structure`

> **De projectstandaard voor ieder project, ongeacht editor of abonnement.**
> Dit is het gratis product uit ADR 0009 — pulled uit `Agent_Engineering/kit/` op een pinned commit.

| Veld | Waarde |
|------|--------|
| **Package** | `cardine-structure` |
| **Doelgroep** | Iedereen die een projectstandaard wil (elke editor) |
| **Bron** | `cardine/packages/structure/` (gepullt uit `Agent_Engineering/kit/`) |
| **Installatie** | `npx cardine-structure`, GitHub release zip/tarball, `new-project.sh` |
| **Afhankelijk van** | niets (zelfstandig) |

---

## Inhoud

De volledige `Agent_Engineering/kit/` op een pinned moment, letterlijk gekopieerd naar `packages/structure/kit/`.

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
└── kit/              ← letterlijke kopie op pinned versie
    ├── kern/
    ├── solo/
    ├── logging/
    ├── team/         (optioneel)
    ├── modules/      (optioneel)
    ├── stacks/       (optioneel)
    ├── profiles/     (optioneel)
    └── new-project.sh
```

## Hoe de pull werkt

```
Agent_Engineering/kit/  (SSOT, privé)
         │
         │  Bij elke release van cardine-structure:
         │  1. Pinned commit uit Agent_Engineering
         │  2. kit/ kopiëren naar packages/structure/kit/
         │  3. Versie ophogen, changelog bijwerken
         │
         ▼
cardine/packages/structure/  (publiek)
```

## Wat blijft in Agent_Engineering (privé)

| Onderdeel | Waarom privé |
|-----------|-------------|
| `standaard/` | Regels, principes, waarom de structuur zo is — logica achter de kit |
| `sjablonen/` | Invulgidsen per bestand — uitleg voor de maker |
| `nieuw-project/`, `bestaand-project/` | Gidsen — hoe gebruik je de kit |
| `bron/` | Kennis, principes, fundament — research en achtergrond |
| `meten/` | Meetprotocollen, taken, resultaten |
| `scripts/` | Interne tooling (test-kit, bootstrap, digest-triage, sessielogs) |

## Installatie

```bash
# Nieuw project starten
npx cardine-structure my-project --profile app --modules research,agent

# Of download van GitHub releases
# Of via: bash <(curl -fsSL ...)/packages/structure/kit/new-project.sh
```

## Relaties

- Maakt deel uit van de **cardine (meta)**-verwijzingen
- Wordt gepulled uit **Agent_Engineering** (privé, SSOT) — zie [ADR 0013](../../docs/decisions/0013-cardine-is-het-publieke-uithangbord-en-pullt-de-structure-uit-agent-engineering.md)
- Kan samen met `cardine-lab` gebruikt worden voor een volledig werkstation

## Versiebeheer

Zie [VERSIONING.md](VERSIONING.md) voor het algemene schema.
CHANGELOG: `packages/structure/CHANGELOG.md` (eigen versie, SemVer).
Git-tag: `structure-v<semver>`.