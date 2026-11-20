# Spec — packages-meta

> **Rol:** De meta-package `cardine` in de root van de repo afwerken — README als uithangbord, package.json met verwijzingen, overbodige bestanden opruimen.

- **Item:** [BACKLOG.md](../BACKLOG.md) · fase 3 van Implementatieplan
- **Status:** gereed

## Doel

De root van de GitHub-repo `ventje/cardine` is een helder uithangbord dat uitlegt wat Cardine is, naar de packages verwijst, en geen ruis bevat. De meta-package heeft een eigen versie.

## Scope

- **In:** Root README, package.json, CHANGELOG, LICENSE, .gitignore, docs/INDEX synchronisatie
- **Buiten scope:** CI/CD, GitHub Actions, npm publish, GitHub Pages

## Status (wat is er al)

- ✅ `README.md` bestaat maar is nog de oude ontwikkelaars-variant
- ✅ `package.json` heeft versie `0.1.0` en npm-scripts naar `packages/lab/`
- ✅ `LICENSE` (MIT) aanwezig
- ✅ `CHANGELOG.md` in root — moet nog gevuld
- ✅ `docs/INDEX.md` verwijst naar packages docs
- ✅ `AGENTS.md`, `Makefile`, `.gitignore`, `.editorconfig`, `.pre-commit-config.yaml`
- ❌ Root `README.md` is nog geen uithangbord

## Nog te doen

### Slice 1 — Root README herschrijven

- [x] README.md herschrijven als uithangbord:
  - Wat is Cardine? (kort, pakkend)
  - Architectuur-overzicht (Mermaid)
  - De twee packages met links
  - Installatie-paden (lab, structure-only)
  - Links naar docs
- [x] AGENTS.md behouden als ontwikkelaars-doc (apart van README)

### Slice 2 — package.json en versioning

- [x] `package.json` controleren op juiste meta-velden (repository, description, keywords)
- [x] CHANGELOG.md in root vullen met overzicht van package-versies
- [x] Git-tag `v0.1.0` voorbereiden (meta)

### Slice 3 — Opruimen

- [x] Controleren of er nog bestanden in root staan die weg kunnen
- [x] `.env.example` — laten staan (voorbeeld voor development)
- [x] `scripts/` — is al weg

## Raakvlakken

- `README.md` (root) — hoofddoel van deze spec
- `package.json` (root) — meta-package
- `CHANGELOG.md` (root) — overzicht alle package-versies
- `docs/INDEX.md` — moet verwijzen naar alle relevante docs
- `packages/lab/`, `packages/structure/` — de packages waar de meta naar verwijst
- `docs/packages/VERSIONING.md` — versioning-schema

## Acceptatie

- [x] README.md is een uithangbord: legt in 30 seconden uit wat Cardine is
- [x] README verwijst naar alle packages
- [x] `package.json` heeft correcte meta-data (description, repository, keywords)
- [x] `CHANGELOG.md` in root toont overzicht van package-versies
- [ ] Git-tag `v0.1.0` — voorbereid (taggen bij commit/acceptatie)
- [x] `make check` groen