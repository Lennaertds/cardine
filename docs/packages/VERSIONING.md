# Versiebeheer — Cardine packages

> Hoe we versies bijhouden voor de meta en elk package.

## Principe

- **Elk package heeft een eigen versie** onafhankelijk van de andere packages.
- **De meta-package (`cardine`) heeft ook een eigen versie**, die alleen wijzigt als de structuur van de meta (docs, gidsen) verandert.
- **Geen monorepo-tools** (lerna, nx, turborepo) — te zwaar voor dit stadium. Handmatig of met een klein script.

## SemVer

[SemVer](https://semver.org/) — `major.minor.patch`:

| Deel | Wanneer ophogen |
|------|----------------|
| **major** | Breaking change: installer werkt niet meer op oude config, kit-structuur wijzigt incompatibel, package hernoemd |
| **minor** | Nieuwe functionaliteit: nieuw script, nieuwe module in kit, nieuwe optie in installer |
| **patch** | Bugfix, documentatie-update, kleine aanpassing |

## CHANGELOG per package

Elk package heeft een `CHANGELOG.md` in de package-map. Formaat (geïnspireerd op [Keep a Changelog](https://keepachangelog.com/)):

```markdown
# Changelog — cardine-lab

## [0.2.0] — 2026-11-20

### Added
- Nieuwe --dry-run optie voor install-lab.sh
- Ondersteuning voor Podman naast bwrap

### Changed
- DSH-versie opgehoogd naar 0.3.0

### Fixed
- Hardcoded pad naar /home/ventje vervangen door $HOME

## [0.1.0] — 2026-11-17

### Added
- Initiële release: install-lab.sh, cardine-bwrap, cardine-slice-check

[0.2.0]: https://github.com/Lennaertds/cardine/compare/lab-v0.1.0...lab-v0.2.0
[0.1.0]: https://github.com/Lennaertds/cardine/releases/tag/lab-v0.1.0
```

## Meta-versieoverzicht

De `CHANGELOG.md` in de repo-root geeft een **overzicht** van alle packages:

```markdown
# Changelog — Cardine meta

## [0.3.0] — 2026-11-20

| Package | Versie | Wat |
|---------|--------|-----|
| cardine-lab | 0.2.0 | Dry-run, Podman-support |
| cardine-structure | 0.1.0 | Eerste publieke pull uit Agent_Engineering@abc123 |
```

## Tags in git

```
lab-v0.1.0          → packages/lab/ op versie 0.1.0
structure-v0.1.0    → packages/structure/ op versie 0.1.0
v0.1.0              → meta-package versie 0.1.0
```

## Packages & changelogs

| Package | CHANGELOG locatie |
|---------|------------------|
| `cardine` (meta) | `CHANGELOG.md` (root) |
| `cardine-lab` | `packages/lab/CHANGELOG.md` |
| `cardine-structure` | `packages/structure/CHANGELOG.md` |