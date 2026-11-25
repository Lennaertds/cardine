# Changelog — Cardine meta

## [0.4.1] — 2026-11-24

| Package | Version | What |
|---------|---------|------|
| cardine (meta) | 0.4.1 | README and package docs in English; stale version table fixed |
| @lennaertds/cardine-lab | 0.5.2 | English package, CLI help and docs; pending npm-route catch-up shipped |
| @lennaertds/cardine-structure | 0.5.1 | English package docs; English `new-project.sh` help and output |

### Changed
- English is the only project language ([ADR 0018](docs/decisions/0018-english-is-the-only-project-language.md)).
  This entry covers the public-facing layer: READMEs, package docs and CLI help.
  The rest of the repo follows per [LANGUAGE-MIGRATION.md](LANGUAGE-MIGRATION.md).

## [0.4.0] — 2026-11-24

| Package | Versie | Wat |
|---------|--------|-----|
| cardine (meta) | 0.4.0 | Installeerbaar: `bin/cardine` + `files` + `LICENSE`; `npx cardine <map>` werkt in een gloednieuwe map |
| @lennaertds/cardine-lab | 0.5.0 | `bin/cardine-lab` (`install`/`status`), `files`-allowlist, `PACMAN_FAILED` werkt echt |

### Changed
- **Registry: GitHub Packages → publieke npm** (`registry.npmjs.org`,
  `access: public`) voor alle drie de packages. `publish.yml` publiceert met
  via trusted publishing (OIDC) — geen `NPM_TOKEN` — en heeft nu ook een job
  voor de meta.

### Fixed
- `kit/new-project.sh` resolvet eerst symlinks; via `cardine-structure` wees
  `KIT_DIR` naar `<prefix>/bin` en werden profielen/stacks niet gevonden.
- `cardine` was niet te installeren: `private: true`, geen `bin`, en de docs
  verboden install-code in de root. De meta bevat nu `bin/cardine` en levert
  `packages/structure/kit/` mee, zodat een verse map genoeg heeft.
- `publishConfig` had de ongeldige sleutel `"@Lennaertds:registry"`; wordt
  `registry`.
- README noemde `npx cardine-structure` — dat package is scoped, dus
  `npx @lennaertds/cardine-structure`.
- Binaries resolven eerst `readlink -f "${BASH_SOURCE[0]}"`. Via de npm-symlink
  wees `BASH_SOURCE[0]` naar `<prefix>/bin` en zat de kit/het lab niet op het
  afgeleide pad.
- `LICENSE` (MIT) toegevoegd; `"license": "MIT"` zonder licentietekst is een
  publicatiefout.

## [0.1.0] — 2026-11-20

| Package | Versie | Wat |
|---------|--------|-----|
| cardine (meta) | 0.1.0 | Eerste meta-release: README als uithangbord, package.json met meta-velden, CHANGELOG-overzicht |
| cardine-lab | 0.1.0 | Initiële publieke release: install-lab.sh, cardine-bwrap, cardine-slice-check |
| cardine-structure | 0.1.0 | Eerste pinned pull uit Agent_Engineering@c841cb9, pull_kit.sh, new-project.sh |

## [0.2.0] — 2026-11-20

| Package | Versie | Wat |
|---------|--------|-----|
| cardine (meta) | 0.2.0 | publicatie-klaar: publishConfig GitHub Packages, GitHub URLs naar Lennaertds, harde paden vervangen |
| @lennaertds/cardine-lab | 0.2.0 | Scoped name @lennaertds/cardine-lab, publishConfig, GitHub URLs bijgewerkt |
| @lennaertds/cardine-structure | 0.3.0 | Scoped name @lennaertds/cardine-structure, publishConfig, README/installatie bijgewerkt |

## [0.3.0] — 2026-11-22

| Package | Versie | Wat |
|---------|--------|-----|
| cardine (meta) | 0.3.0 | Versietabel en releaseprocedure bijgewerkt (README, VERSIONING), docs-check groen |
| @lennaertds/cardine-lab | 0.3.0 | Secrets-grens in de kooi + guard-plugin, `DeepSeek-V4.1-Flash-1017` als standaardmodel, `tool-web`/`tool-todo`/`tool-goal` uit, stale-lockcheck in `cardine-status.sh` |
| @lennaertds/cardine-structure | 0.4.0 | Kit gepind op Agent_Engineering `fca818f`, `jarvis-check`/`env-status`/`index`-targets in `kern/`, pull-procedure gedocumenteerd |

## Package-updates na 0.3.0 — 2026-11-23

De meta blijft 0.3.0. Alleen lab is opgehoogd.

| Package | Versie | Wat |
|---------|--------|-----|
| @lennaertds/cardine-lab | 0.4.0 | Bind-kooi als schrijfrechter, `approval: never`, fs-schrijftools uit, guard volgt de open sessie. Tag `lab-v0.4.0`. |

[0.3.0]: https://github.com/Lennaertds/cardine/releases/tag/v0.3.0
[0.2.0]: https://github.com/Lennaertds/cardine/releases/tag/v0.2.0
[0.1.0]: https://github.com/Lennaertds/cardine/releases/tag/v0.1.0