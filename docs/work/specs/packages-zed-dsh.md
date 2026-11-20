# Spec — packages-zed-dsh

> **Rol:** cardine-zed-dsh publiek-ready maken — install.sh, DSH-profiel, package.json, CHANGELOG, README.

- **Item:** [BACKLOG.md](../BACKLOG.md) · fase 2 van Implementatieplan
- **Status:** open

## Doel

`cardine-zed-dsh` is bruikbaar als zelfstandig package voor wie al Zed en DSH heeft, maar de configuratie voor de ACP-koppeling nodig heeft. Dit is het API-key-pad (ADR 0010).

## Scope

- **In:** `packages/zed-dsh/` — install.sh, .env.example, DSH-profiel, package.json, README, CHANGELOG
- **Buiten scope:** DSH of Jarvis zelf installeren (dat doet cardine-lab), AUR-package

## Status (wat is er al)

- ✅ Mapstructuur: `packages/zed-dsh/{profile/acp,docs}/`
- ✅ `README.md` en `CHANGELOG.md` bestaan (template)
- ✅ `docs/cardine-zed-dsh.md` in `packages/zed-dsh/docs/`
- ❌ `install.sh` — nog niet geschreven
- ❌ `.env.example` — nog niet aangemaakt
- ❌ `profile/acp/cordis.patch.yml` — nog niet gekopieerd uit lab
- ❌ `package.json` — nog niet aangemaakt

## Nog te doen

### Slice 1 — Profiel en voorbeeldbestanden

- [ ] `profile/acp/cordis.patch.yml` kopiëren uit `packages/lab/install-lab.sh`-template (of aparte source of truth)
- [ ] `.env.example` aanmaken met `DEEPSEEK_API_KEY=` als template

### Slice 2 — install.sh

- [ ] `packages/zed-dsh/install.sh` schrijven dat:
  - DSH-profiel installeert naar `~/.dsh/profiles/acp/cordis.patch.yml`
  - `.env.example` kopieert naar `~/.dsh/.env` als die nog niet bestaat
  - Idempotent is
  - Geen harde paden bevat

### Slice 3 — Package.json en versioning

- [ ] `packages/zed-dsh/package.json` aanmaken met naam `cardine-zed-dsh`, versie `0.1.0`
- [ ] CHANGELOG.md vullen met `0.1.0` entry
- [ ] Git-tag `zed-dsh-v0.1.0` voorbereiden

### Slice 4 — README en docs

- [ ] README.md controleren
- [ ] `docs/cardine-zed-dsh.md` synchen met de werkelijkheid

## Raakvlakken

- `packages/lab/install-lab.sh` — template voor DSH-profiel (kan als bron dienen)
- `packages/zed-dsh/install.sh` — nog te schrijven
- `packages/zed-dsh/package.json` — nog aan te maken
- `docs/packages/VERSIONING.md` — versioning-schema

## Relatie tot cardine-lab

`cardine-lab` is de volledige installatie (alles-in-één). `cardine-zed-dsh` is alleen de configuratielaag. Na implementatie moet `cardine-lab` blijven werken — het mag niet afhankelijk zijn van `cardine-zed-dsh`.

## Acceptatie

- [ ] `bash packages/zed-dsh/install.sh` installeert het profiel zonder fouten
- [ ] `~/.dsh/profiles/acp/cordis.patch.yml` bevat correcte paden (geen `scripts/`, wel `packages/lab/`)
- [ ] Het profiel is identiek aan wat `packages/lab/install-lab.sh` genereert (voor de relevante secties)
- [ ] Git-tag `zed-dsh-v0.1.0` bestaat
- [ ] `make check` groen