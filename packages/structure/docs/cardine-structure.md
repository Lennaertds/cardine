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
├── sync_kit.sh       ← kopieert de bron kit/ naar hier
└── kit/              ← letterlijke kopie op pinned versie
    ├── COMMIT        ← pinned commit hash
    ├── README.md
    ├── kern/
    ├── solo/
    ├── logging/
    ├── team/         (optioneel)
    ├── modules/      (optioneel)
    ├── stacks/       (optioneel)
    ├── profiles/     (optioneel)
    └── new-project.sh
```

## Hoe de kit bij het package komt

```
kit/                        (bron, in de repo-root)
  │
  │  bash packages/structure/sync_kit.sh
  │
  ▼
packages/structure/kit/     (publieke distributiekopie, gaat mee in het package)
  │
  ▼
@lennaertds/cardine-structure op npm
```

Er is **geen tweede repo en geen pin meer nodig**. Vroeger kwam `kit/` uit de
aparte repo `Agent_Engineering` en bewaarde `kit/COMMIT` de gepinde commit; dat
pin-bestand is weg. Sinds de samenvoeging is `kit/` de enige bron.

`sync_kit.sh` kopieert `kit/` letterlijk naar `packages/structure/kit/`.
Controleer met `bash packages/structure/sync_kit.sh --check` of de twee gelijk zijn
(`make check` doet dat ook).

## Versie-koppeling

Elke `cardine-structure`-release bevat een kopie van `kit/` op het moment van
uitbrengen.

| cardine-structure | Datum | Bijzonderheden |
|-------------------|-------|----------------|
| 0.5.0 | 2026-11-24 | `kit/` wordt de bron; `pull_kit.sh` en `kit/COMMIT` vervallen |
| 0.4.0 | 2026-11-22 | `jarvis-check`/`env-status`/`index` in `kern/Makefile` |
| 0.3.0 | 2026-11-20 | scoped name |
| 0.2.0 | 2026-11-18 | kit-tag `kit-v0.2.0` |
| 0.1.0 | 2026-11-17 | eerste release |

### Een nieuwe versie uitbrengen

```bash
# 1. Zorg dat de distributiekopie gelijk is aan de bron
bash packages/structure/sync_kit.sh

# 2. Versionering ophogen
#    - packages/structure/package.json: versie
#    - packages/structure/CHANGELOG.md: nieuwe entry
#    - deze tabel bijwerken
#    - git tag structure-v<versie>
```

## Aanpassingen voor publicatie

De kit wordt 1-op-1 uit Agent_Engineering gepulled, met twee uitzonderingen:

| Wijziging | Waarom |
|-----------|--------|
| `kit/README.md` wordt **vervangen** door een gebruikersversie | Het origineel bevat interne SSOT-links naar `../standaard/`, `../sjablonen/` etc. — die bestaan niet in de gepubliceerde package |
| `sync_kit.sh` staat niet in `files` van package.json | Interne tooling, niet relevant voor gebruikers |

Deze aanpassingen worden **elke pull opnieuw gedaan** (automatisch of handmatig). De SSOT blijft Agent_Engineering.

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
- Wordt gepulled uit **Agent_Engineering** (privé, SSOT) — zie [ADR 0013](../../../docs/decisions/0013-cardine-is-het-publieke-uithangbord-en-pullt-de-structure-uit-agent-engineering.md)
- Kan samen met `cardine-lab` gebruikt worden voor een volledig werkstation

## Versiebeheer

Zie [VERSIONING.md](VERSIONING.md) voor het algemene schema.
CHANGELOG: `packages/structure/CHANGELOG.md` (eigen versie, SemVer).
Git-tag: `structure-v<semver>`.