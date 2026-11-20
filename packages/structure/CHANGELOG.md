# Changelog — cardine-structure

## [0.2.0] — 2026-11-20

### Added

- `pull_kit.sh --tag` — ondersteuning voor kit-tags uit Agent_Engineering (`kit-v<semver>`)
- `kit/` — geüpdatet naar Agent_Engineering commit 46fb1ab (kit-v0.2.0)
- `kit/README.md` — gebruikersversie zonder SSOT-links

### Changed

- `package.json` — `private: true` verwijderd, `files` veld toegevoegd, versie 0.2.0
- `pull_kit.sh` — idempotentie-check extraheert hash uit `tag = hash` formaat
- `docs/cardine-structure.md` — versie-koppelingstabel en release-procedure

### Fixed

- `new-project.sh` — `readlink -f` voor symlink-resolutie (werkt nu via `npx`)

## [0.1.0] — 2026-11-20

### Added

- `pull_kit.sh` — idempotent script om Agent_Engineering/kit/ op pinned commit te pullen
- `kit/` — eerste pinned pull uit Agent_Engineering@c841cb9 met `kern/`, `solo/`, `logging/`, `new-project.sh`
- `package.json` — npm-package `cardine-structure` met bin-link naar `new-project.sh`
- `README.md` — package-overzicht met installatie-instructies
- `docs/cardine-structure.md` — volledige documentatie

[0.2.0]: https://github.com/ventje/cardine/compare/structure-v0.1.0...structure-v0.2.0
[0.1.0]: https://github.com/ventje/cardine/compare/structure-v0.0.0...structure-v0.1.0