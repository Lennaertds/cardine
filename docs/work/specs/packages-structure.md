# Spec — packages-structure

> **Rol:** cardine-structure publiek-ready maken — pull_kit.sh, eerste pinned pull uit Agent_Engineering, package.json, CHANGELOG, README.

- **Item:** [BACKLOG.md](../BACKLOG.md) · fase 2 van Implementatieplan
- **Status:** gereed
- **Blokkade:** (opgelost) Agent_Engineering repo was bereikbaar
- **Afhankelijkheid:** Agent_Engineering moet kit-tags beheren (zie `standaard/versioning.md` aldaar)

## Doel

`cardine-structure` is bruikbaar als zelfstandig npm-package (`npx cardine-structure`) of via GitHub release. De kit is gepulled uit Agent_Engineering op een pinned commit, en de generator (`new-project.sh`) werkt.

## Scope

- **In:** `packages/structure/` — pull_kit.sh, eerste pull, package.json, README, CHANGELOG
- **Buiten scope:** Automatische GitHub Actions voor pullen, kit-content zelf wijzigen (SSOT is Agent_Engineering)

## Status (wat is er al)

- ✅ Mapstructuur: `packages/structure/{kit,docs}/`
- ✅ `README.md` en `CHANGELOG.md` bestaan (template)
- ✅ `docs/cardine-structure.md` in `packages/structure/docs/`
- ✅ `pull_kit.sh` — geschreven en uitvoerbaar
- ✅ `kit/` — eerste pull gedaan (commit c841cb9)
- ✅ `package.json` — aangemaakt
- ✅ `new-project.sh` — meegepulled in kit/

## Nog te doen

### Slice 1 — pull_kit.sh script

- [x] `packages/structure/pull_kit.sh` schrijven dat:
  - Een pinned commit uit `Agent_Engineering/kit/` kopieert naar `packages/structure/kit/`
  - De commit hash opslaat in `kit/COMMIT` (of in package.json)
  - Idempotent is
- [x] Script uitvoerbaar maken (`chmod +x`)

### Slice 2 — Eerste pinned pull

- [x] Bepalen welke commit uit Agent_Engineering gepulled wordt
- [x] `pull_kit.sh` draaien
- [x] Inhoud van `kit/` controleren (minstens: `kern/`, `solo/`, `logging/`, `new-project.sh`)

### Slice 3 — Package.json en versioning

- [x] `packages/structure/package.json` aanmaken met naam `cardine-structure`, versie `0.1.0`
- [x] CHANGELOG.md vullen met `0.1.0` entry
- [x] Git-tag `structure-v0.1.0` voorbereiden
- [x] `pull_kit.sh` ondersteunt `--tag` (resolveert kit-v<semver> naar commit)
- [x] Agent_Engineering: `scripts/tag-kit.sh`, `standaard/versioning.md`, `make tag-kit`

### Slice 4 — README en docs

- [x] README.md in `packages/structure/` controleren
- [x] `docs/cardine-structure.md` synchen met de werkelijkheid

## Raakvlakken

- `Agent_Engineering/kit/` — SSOT (privé), wordt gepulled
- `Agent_Engineering/standaard/versioning.md` — kit-tag beleid (nieuw) <!-- three-place: standaard/versioning.md, AGENTS.md, Makefile + scripts/tag-kit.sh -->
- `packages/structure/pull_kit.sh` — geschreven, ondersteunt `--tag`
- `packages/structure/package.json` — aangemaakt
- `packages/structure/kit/` — gevuld met pull op commit c841cb9 (tag `kit-v0.1.0`)
- `packages/structure/docs/cardine-structure.md` — versie-koppelingstabel
- `docs/packages/VERSIONING.md` — versioning-schema

## Acceptatie

- [x] `bash packages/structure/pull_kit.sh` draait idempotent
- [x] `packages/structure/kit/` bevat `kern/`, `solo/`, `logging/`, `new-project.sh`
- [x] Git-tag `structure-v0.1.0` bestaat
- [x] `make check` groen