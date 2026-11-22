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
├── pull_kit.sh       ← idempotent pull-script
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

## Hoe de pull werkt

```
Agent_Engineering/kit/  (SSOT, privé)
  │  Git tags: kit-v0.1.0, kit-v0.2.0, ...
  │
  │  bash pull_kit.sh --tag v0.1.0   ← idempotent
  │  1. Resolve kit-v0.1.0 naar commit in Agent_Engineering
  │  2. kit/ kopiëren naar packages/structure/kit/
  │  3. Commit hash + tag opslaan in kit/COMMIT
  │
  ▼
cardine/packages/structure/  (publiek)
  Git tags: structure-v0.1.0, structure-v0.2.0, ...
```

Zie [`pull_kit.sh`](../pull_kit.sh) voor het idempotente script. Het script:
- Accepteert een commit hash (`<commit>`) of een kit-tag (`--tag v0.1.0`)
- Resolved `--tag v0.1.0` naar `kit-v0.1.0` in Agent_Engineering
- Slaat commit hash + tag op in `kit/COMMIT`
- Is idempotent: bij dezelfde commit gebeurt er niets

## Versie-koppeling

Elke `cardine-structure`-release wijst naar één specifiek moment in Agent_Engineering.
De kit-tags worden beheerd in Agent_Engineering (zie `standaard/versioning.md`).

| cardine-structure | Agent_Engineering kit-tag | Commit |
|------------------|---------------------------|--------|
| 0.4.0 | geen tag (pullt HEAD) | fca818f (volledige hash in `kit/COMMIT`) |
| 0.3.0 | geen tag (scoped name) | 46fb1ab |
| 0.2.0 | `kit-v0.2.0` | 46fb1ab |
| 0.1.0 | `kit-v0.1.0` | c841cb9 |

`kit-v0.2.0` staat op `46fb1ab`; tussen dat commit en `fca818f` wijzigde in
Agent_Engineering alleen de root `AGENTS.md` (buiten `kit/`). `structure/kit/` wijkt
daarnaast op één punt bewust af: de `jarvis-check`-, `env-status`- en `index`-targets
staan in `kern/Makefile` van de gepubliceerde kit, niet in Agent_Engineering (ADR 0015).
`pull_kit.sh` kopieert de map letterlijk, dus controleer na elke pull de `git diff` van
`packages/structure/kit/` en herstel die afwijking als de pull ze wegneemt. Bewezen bij de
pull naar `fca818f`: de `jarvis-check`/`env-status`/`index`-targets én de
`jarvis__indexRepo`-regel in `kern/AGENTS.md` gingen verloren en zijn handmatig teruggezet.
Die commit wijzigt zelf alleen de root `AGENTS.md`, dus de inhoud van `kit/` hóórt na de
pull gelijk te blijven.

### Een nieuwe versie uitbrengen

```bash
# 1. Tag de kit in Agent_Engineering
cd ../Agent_Engineering
make tag-kit TAG=v0.2.0

# 2. Pull de nieuwe kit in cardine
cd ../cardine
bash packages/structure/pull_kit.sh --tag v0.2.0

# 3. Versionering ophogen
#    - package.json: versie naar 0.2.0
#    - CHANGELOG.md: nieuwe entry
#    - Deze tabel hierboven bijwerken
#    - git tag structure-v0.2.0
```

## Aanpassingen voor publicatie

De kit wordt 1-op-1 uit Agent_Engineering gepulled, met twee uitzonderingen:

| Wijziging | Waarom |
|-----------|--------|
| `kit/README.md` wordt **vervangen** door een gebruikersversie | Het origineel bevat interne SSOT-links naar `../standaard/`, `../sjablonen/` etc. — die bestaan niet in de gepubliceerde package |
| `pull_kit.sh` wordt uitgesloten van npm publish (`files` in package.json) | Interne tooling, niet relevant voor gebruikers |

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