# Versioning — Cardine packages

> How we keep versions for the meta package and each package.

## Principle

- **Each package has its own version**, independent of the others.
- **The meta package (`cardine`) has its own version too**, which changes only when the meta's own structure (docs, guides) changes.
- **No monorepo tools** (lerna, nx, turborepo) — too heavy at this stage. Manually, or with a small script.

## SemVer

[SemVer](https://semver.org/) — `major.minor.patch`:

| Part | When to bump |
|------|--------------|
| **major** | Breaking change: the installer no longer works on an old config, the kit structure changes incompatibly, the package is renamed |
| **minor** | New functionality: a new script, a new module in the kit, a new option in the installer |
| **patch** | Bugfix, documentation update, small adjustment |

## CHANGELOG per package

Each package has a `CHANGELOG.md` in the package directory. Format (inspired by
[Keep a Changelog](https://keepachangelog.com/)):

```markdown
# Changelog — cardine-lab

## [0.2.0] — 2026-11-20

### Added
- New --dry-run option for install-lab.sh
- Support for Podman alongside bwrap

### Changed
- DSH version bumped to 0.3.0

### Fixed
- Hardcoded path (`$HOME`-relative instead of an absolute user path)

## [0.1.0] — 2026-11-17

### Added
- Initial release: install-lab.sh, cardine-bwrap, cardine-slice-check

[0.2.0]: https://github.com/Lennaertds/cardine/compare/lab-v0.1.0...lab-v0.2.0
[0.1.0]: https://github.com/Lennaertds/cardine/releases/tag/lab-v0.1.0
```

## Meta version overview

The `CHANGELOG.md` in the repo root gives an **overview** of all packages:

```markdown
# Changelog — Cardine meta

## [0.3.0] — 2026-11-22

| Package | Version | What |
|---------|---------|------|
| cardine-lab | 0.3.0 | Secrets boundary in cage and guard, V4.1 model, plugin fix |
| cardine-structure | 0.4.0 | Kit `fca818f` with `jarvis-check` targets |
```

## Tags in git

```
lab-v<semver>          → packages/lab/ at version <semver>
structure-v<semver>    → packages/structure/ at version <semver>
v<semver>              → meta package version <semver>
```

Most recent: `lab-v0.4.0`, `structure-v0.4.0`, `v0.3.0`. The meta tag `v0.3.0`
came with `lab-v0.3.0` and `structure-v0.4.0`; `publish.yml` publishes each
package on its own tag.

## Packages and changelogs

| Package | CHANGELOG location |
|---------|--------------------|
| `cardine` (meta) | `CHANGELOG.md` (root) |
| `cardine-lab` | `packages/lab/CHANGELOG.md` |
| `cardine-structure` | `packages/structure/CHANGELOG.md` |

Current state (2026-11-28): meta 0.4.1, `@lennaertds/cardine-lab` 0.5.5,
`@lennaertds/cardine-structure` 0.5.1.

## Staged publishing

A release goes through `npm stage publish` and then `npm stage approve <id>`:

```bash
# 1. Bump package.json and add a CHANGELOG entry first — npm refuses to
#    publish over an existing version.
# 2. Stage it
npm stage publish --tag latest
# 3. Wait until `npm stage list` shows status "staged" (not "validating")
npm stage list
# 4. Approve with 2FA
npm stage approve <id> --tag latest
# 5. Verify — and install by exact version, because a stale npm cache can make
#    `pkg@latest` resolve to the previous release
npm view @lennaertds/cardine-lab dist-tags
npm i -g @lennaertds/cardine-lab@<version>
```
