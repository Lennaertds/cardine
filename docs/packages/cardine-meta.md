# Meta-package: `cardine`

> **De GitHub-repo `ventje/cardine` is het uithangbord.**
> De README legt uit wat Cardine is en verwijst naar de packages. Er komt geen install-code in de root — alleen uitleg, gidsen en verwijzingen.

| Veld | Waarde |
|------|--------|
| **Package** | `cardine` (meta) |
| **Doelgroep** | Iedereen die op de GitHub-repo landt |
| **Bron** | `cardine/` (root) |
| **Installatie** | Niet van toepassing — verwijst naar 1, 2 |
| **Afhankelijk van** | verwijst naar `cardine-lab`, `cardine-structure` |

---

## Wat in de root van de repo

```
cardine/
├── README.md           ← Visitekaartje, uitleg, links naar packages
├── package.json        ← Meta: "cardine" met versie, verwijzingen
├── CHANGELOG.md        ← Overzicht van alle package-versies
├── LICENSE             ← MIT
├── docs/
│   ├── INDEX.md        ← Doc-kaart
│   ├── product/        ← Productdocs per onderdeel
│   ├── decisions/      ← ADR's (publiek — zonder privé-details)
│   ├── packages/
│   │   └── INDEX.md    ← Dit document
│   ├── guides/         ← Gidsen per pad
│   └── ...
├── packages/
│   ├── lab/            ← cardine-lab package
│   └── structure/      ← cardine-structure package (gepullt)
├── scripts/            ← Alleen wat voor de meta nodig is (status, etc.)
├── AGENTS.md           ← (publiek, maar gericht op ontwikkelaars)
├── Makefile            ← check, context, finish (voor ontwikkeling)
└── .gitignore
```

## Wat verdwijnt uit de root (naar packages/)

| Huidig bestand | Gaat naar |
|---------------|-----------|
| `scripts/install-lab.sh` | `packages/lab/install-lab.sh` |
| `scripts/cardine-bwrap` | `packages/lab/cardine-bwrap` |
| `scripts/cardine-slice-check/` | `packages/lab/cardine-slice-check/` |
| `scripts/cardine-status.sh` | `packages/lab/cardine-status.sh` |
| `scripts/digest-*` | `packages/lab/scripts/` |
| `scripts/security-scan.sh` etc. | `packages/lab/scripts/` |
| `scripts/systemd/` | `packages/lab/systemd/` |

## Wat blijft in de root

| Bestand | Waarom |
|---------|--------|
| `README.md` | Uithangbord — moet meteen duidelijk zijn |
| `package.json` | Meta-package |
| `CHANGELOG.md` | Overzicht alle versies |
| `LICENSE` | MIT |
| `docs/` | Productdocs, ADR's, gidsen, packages-ontwerp |
| `AGENTS.md` | Agent-instructies voor ontwikkeling |
| `Makefile` | `make check`, `make context` voor ontwikkeling |
| `.gitignore` | Standaard |
| `.editorconfig` | Code-stijl |
| `.pre-commit-config.yaml` | Pre-commit hooks |
| `.env.example` | Voorbeeld |

## Packages die de meta aanbiedt

| # | Package | Doc | Doelgroep |
|---|---------|------|-----------|
| 1 | **`cardine-lab`** | [cardine-lab.md](cardine-lab.md) | Arch/Hyprland AI-agent-werkstation |
| 2 | **`cardine-structure`** | [cardine-structure.md](cardine-structure.md) | Projectstandaard (elke editor) |

## Afhankelijkheden en samenhang

```
                    ┌──────────────────┐
                    │   cardine (meta) │  ← GitHub repo, README, gidsen
                    │   versie x.y.z   │
                    └────────┬─────────┘
                             │ verwijst naar
               ┌─────────────┴──────────────┐
               ▼                            ▼
     ┌─────────────────┐          ┌──────────────────┐
     │  cardine-lab    │          │ cardine-structure │
     │  Arch/Hyprland  │          │ projectstandaard  │
     │  toolchain      │          │ (elke editor)     │
     └─────────────────┘          └──────────────────┘
               │                        │
               │                        ├── gepullt uit ───► Agent_Engineering/kit/
               │                        │                   (privé, SSOT)
               │
               ├── bevat ──► scripts/
               ├── bevat ──► systemd/
               └── genereert ──► ~/.dsh/profiles/ (ACP-profiel)
```

### Installatie-volgordes

| Scenario | Packages | Volgorde |
|----------|----------|----------|
| Alleen projectstandaard | structure | 1. `npx cardine-structure` |
| Volledig agent-werkstation | lab + structure | 1. `cardine-lab` 2. `cardine-structure` |

## Versiebeheer

Zie [VERSIONING.md](VERSIONING.md) voor het algemene schema.
De meta-package heeft een eigen versie die alleen wijzigt als de structuur van de meta (docs, gidsen) verandert.
Git-tag: `v<semver>` (zonder prefix).

CHANGELOG in root: `CHANGELOG.md` — overzicht van alle package-versies in tabelvorm.