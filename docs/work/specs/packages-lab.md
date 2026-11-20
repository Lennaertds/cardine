# Spec — packages-lab

> **Rol:** cardine-lab publiek-ready maken — versioning, package.json, harde paden verwijderen, CHANGELOG vullen, git-tag.

- **Item:** [BACKLOG.md](../BACKLOG.md) · fase 2 van Implementatieplan
- **Status:** gedaan — wacht op commit + git-tag `lab-v0.1.0` bij acceptatie

## Doel

`cardine-lab` is bruikbaar als zelfstandig npm-package of via curl-pipe-bash. De installer is generiek (geen harde paden naar `ventje` of `Agent_Engineering`), de versie staat in `package.json`, en de CHANGELOG is gevuld.

## Scope

- **In:** `packages/lab/` — package.json, CHANGELOG, README, installer public-ready maken
- **Buiten scope:** AUR-package, Homebrew Formula, npm publish — dat is distributie, pas na stabilisatie

## Status (wat is er al)

- ✅ Mapstructuur: `packages/lab/{scripts,systemd,docs}/`
- ✅ Alle scripts verhuisd van root `scripts/` naar `packages/lab/scripts/`
- ✅ `install-lab.sh`, `cardine-bwrap`, `cardine-status.sh`, `cardine-slice-check/` aanwezig
- ✅ `README.md` en `CHANGELOG.md` bestaan (template)
- ✅ Makefile verwijst naar `packages/lab/` paden
- ✅ `cardine-status.sh` heeft sandbox-config-check en `--fix`

## Nog te doen

### Slice 1 — Package.json en versioning

- [ ] `packages/lab/package.json` aanmaken met naam, versie `0.1.0`, beschrijving
- [ ] CHANGELOG.md vullen met `0.1.0` entry
- [ ] Git-tag `lab-v0.1.0` voorbereiden (taggen bij acceptatie)

### Slice 2 — Publiek maken van install-lab.sh

- [ ] Controleren op harde paden naar `/home/ventje/` of `Agent_Engineering/` in `install-lab.sh`
- [ ] `REPO_ROOT` bepaling controleren — moet werken ongeacht van waar het script gedraaid wordt
- [ ] DSH-profiel-template in `install-lab.sh` gebruikt `packages/lab/` paden (al gefikst in vorige sessie)

### Slice 3 — README en docs finetunen

- [ ] README.md in `packages/lab/` controleren op volledigheid
- [ ] `docs/cardine-lab.md` in `packages/lab/docs/` synchen met de werkelijkheid

## Raakvlakken

- `packages/lab/install-lab.sh` — hoofdinstaller
- `packages/lab/package.json` — nog aan te maken
- `packages/lab/CHANGELOG.md` — template, moet gevuld
- `packages/lab/cardine-status.sh` — status-check (al uitgebreid)
- `docs/packages/VERSIONING.md` — versioning-schema

## Acceptatie

- [x] `bash packages/lab/install-lab.sh` — controle op harde paden en REPO_ROOT: gedaan (kan niet op niet-Arch getest worden)
- [x] `bash packages/lab/cardine-status.sh` — structuur klopt (checks wijzen naar packages/lab/)
- [x] `make env-status` werkt en wijst naar `packages/lab/cardine-status.sh`
- [x] `make check` groen
- [x] Eerste git-tag `lab-v0.1.0` — voorbereid (taggen bij commit/acceptatie)