# Spec — packages-meta

> **Rol:** De meta-package `cardine` in de root van de repo afwerken — README als uithangbord, package.json met verwijzingen, overbodige bestanden opruimen.

- **Item:** [BACKLOG.md](../BACKLOG.md) · fase 3 van Implementatieplan
- **Status:** open
- **Blokkade:** Wacht op `packages-lab`, `packages-structure` en `packages-zed-dsh` — anders verwijzen we naar packages die nog niet bestaan

## Doel

De root van de GitHub-repo `ventje/cardine` is een helder uithangbord dat uitlegt wat Cardine is, naar de drie packages verwijst, en geen ruis bevat. De meta-package heeft een eigen versie.

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

- [ ] README.md herschrijven als uithangbord:
  - Wat is Cardine? (kort, pakkend)
  - Architectuur-overzicht (Mermaid)
  - De drie packages met links
  - Installatie-paden (lab, structure-only, zed-dsh-only)
  - Links naar docs
- [ ] AGENTS.md behouden als ontwikkelaars-doc (apart van README)

### Slice 2 — package.json en versioning

- [ ] `package.json` controleren op juiste meta-velden (repository, description)
- [ ] CHANGELOG.md in root vullen met overzicht van package-versies
- [ ] Git-tag `v0.1.0` voorbereiden (meta)

### Slice 3 — Opruimen

- [ ] Controleren of er nog bestanden in root staan die weg kunnen
- [ ] `.env.example` — laten staan (voorbeeld voor development)
- [ ] `scripts/` — is al weg

## Raakvlakken

- `README.md` (root) — hoofddoel van deze spec
- `package.json` (root) — meta-package
- `CHANGELOG.md` (root) — overzicht alle package-versies
- `docs/INDEX.md` — moet verwijzen naar alle relevante docs
- `packages/lab/`, `packages/structure/`, `packages/zed-dsh/` — de packages waar de meta naar verwijst
- `docs/packages/VERSIONING.md` — versioning-schema

## Acceptatie

- [ ] README.md is een uithangbord: legt in 30 seconden uit wat Cardine is
- [ ] README verwijst naar alle drie de packages
- [ ] `package.json` heeft correcte meta-data
- [ ] `CHANGELOG.md` in root toont overzicht van package-versies
- [ ] Git-tag `v0.1.0` bestaat
- [ ] `make check` groen