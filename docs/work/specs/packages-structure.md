# Spec — packages-structure

> **Rol:** cardine-structure publiek-ready maken — pull_kit.sh, eerste pinned pull uit Agent_Engineering, package.json, CHANGELOG, README.

- **Item:** [BACKLOG.md](../BACKLOG.md) · fase 2 van Implementatieplan
- **Status:** open
- **Blokkade:** Agent_Engineering repo moet bereikbaar zijn voor de eerste pull

## Doel

`cardine-structure` is bruikbaar als zelfstandig npm-package (`npx cardine-structure`) of via GitHub release. De kit is gepulled uit Agent_Engineering op een pinned commit, en de generator (`new-project.sh`) werkt.

## Scope

- **In:** `packages/structure/` — pull_kit.sh, eerste pull, package.json, README, CHANGELOG
- **Buiten scope:** Automatische GitHub Actions voor pullen, kit-content zelf wijzigen (SSOT is Agent_Engineering)

## Status (wat is er al)

- ✅ Mapstructuur: `packages/structure/{kit,docs}/`
- ✅ `README.md` en `CHANGELOG.md` bestaan (template)
- ✅ `docs/cardine-structure.md` in `packages/structure/docs/`
- ❌ `pull_kit.sh` — nog niet geschreven
- ❌ `kit/` is leeg — nog geen pull gedaan
- ❌ `package.json` — nog niet aangemaakt
- ❌ `new-project.sh` — zit in Agent_Engineering, moet meegepulled worden

## Nog te doen

### Slice 1 — pull_kit.sh script

- [ ] `packages/structure/pull_kit.sh` schrijven dat:
  - Een pinned commit uit `Agent_Engineering/kit/` kopieert naar `packages/structure/kit/`
  - De commit hash opslaat in `kit/COMMIT` (of in package.json)
  - Idempotent is
- [ ] Script uitvoerbaar maken (`chmod +x`)

### Slice 2 — Eerste pinned pull

- [ ] Bepalen welke commit uit Agent_Engineering gepulled wordt
- [ ] `pull_kit.sh` draaien
- [ ] Inhoud van `kit/` controleren (minstens: `kern/`, `solo/`, `logging/`, `new-project.sh`)

### Slice 3 — Package.json en versioning

- [ ] `packages/structure/package.json` aanmaken met naam `cardine-structure`, versie `0.1.0`
- [ ] CHANGELOG.md vullen met `0.1.0` entry
- [ ] Git-tag `structure-v0.1.0` voorbereiden

### Slice 4 — README en docs

- [ ] README.md in `packages/structure/` controleren
- [ ] `docs/cardine-structure.md` synchen met de werkelijkheid

## Raakvlakken

- `Agent_Engineering/kit/` — SSOT (privé), wordt gepulled
- `packages/structure/pull_kit.sh` — nog te schrijven
- `packages/structure/package.json` — nog aan te maken
- `packages/structure/kit/` — doel van de pull
- `docs/packages/VERSIONING.md` — versioning-schema

## Acceptatie

- [ ] `bash packages/structure/pull_kit.sh` draait idempotent
- [ ] `packages/structure/kit/` bevat `kern/`, `solo/`, `logging/`, `new-project.sh`
- [ ] Git-tag `structure-v0.1.0` bestaat
- [ ] `make check` groen