# Changelog — cardine-structure

## [0.5.1] — 2026-11-24

### Changed
- The package is in English now (ADR 0018): README, package docs and the
  `new-project.sh` help text and output. Profile names (`app`, `research`,
  `studie`, `schoolwerk`) are unchanged — they are data, not prose.
- `kit/new-project.sh` is mirrored from `kit/` via `sync_kit.sh`.

## [0.5.0] — 2026-11-24

### Changed
- Registry: GitHub Packages → publieke npm (`registry.npmjs.org`, `access: public`).
- `private: false` expliciet.

### Fixed
- `kit/new-project.sh` resolvet eerst symlinks. Via het npm-`bin`-commando wees
  `KIT_DIR` naar `<prefix>/bin`, zodat profielen en stacks niet gevonden werden.

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

## [0.3.0] — 2026-11-20

### Changed
- Scoped name: `cardine-structure` → `@lennaertds/cardine-structure`
- `publishConfig` toegevoegd voor GitHub Packages
- GitHub URLs: `ventje` → `Lennaertds`
- Installatie-instructies: `npx @lennaertds/cardine-structure`
- README bijgewerkt met nieuwe GitHub URLs

## [0.4.0] — 2026-11-22

### Added

- `AGENTS.md` in de kit — expliciet verbod op `mcp__jarvis__indexRepo` vanuit de agent (breekt in `bwrap`, laat stale locks achter); bij een ontbrekende index vraagt de agent om `make index` vanaf de host
- `Makefile` in de kit — `make env-status`, `make index` en `make jarvis-check` (stale locks + is deze repo geïndexeerd), gekoppeld aan `context` en `env-status`

### Changed

- `kit/` — gepind op Agent_Engineering `fca818f`; `COMMIT` gebruikt weer het formaat `<tag> = <hash>` met `kit-v0.2.0 = 46fb1ab…`, zodat `pull_kit.sh` de idempotentiecheck blijft herkennen
- `docs/cardine-structure.md` — releaseprocedure: na een pull handmatig de `kern/`-afwijking controleren, want `pull_kit.sh` kopieert `kit/` letterlijk

### Fixed

- `kit/kern/` — bij de pull naar `fca818f` verdwenen de `jarvis-check`/`env-status`/`index`-targets en de `jarvis__indexRepo`-regel, terwijl die commit alleen de root `AGENTS.md` wijzigt; hersteld. **Bekend gedrag:** `pull_kit.sh` kopieert `kit/` letterlijk, dus elke pull kan deze afwijkingen wegzetten — controleer daarna `git diff packages/structure/kit/`
- Geen tag op `fca818f`: die commit wijzigt alleen de root `AGENTS.md` buiten `kit/`

[0.4.0]: https://github.com/Lennaertds/cardine/compare/structure-v0.3.0...structure-v0.4.0
[0.3.0]: https://github.com/Lennaertds/cardine/compare/structure-v0.2.0...structure-v0.3.0
[0.2.0]: https://github.com/Lennaertds/cardine/compare/structure-v0.1.0...structure-v0.2.0
[0.1.0]: https://github.com/Lennaertds/cardine/compare/structure-v0.0.0...structure-v0.1.0