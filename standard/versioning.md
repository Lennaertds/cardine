# Kit versioning

> **Role:** How the kit (`kit/`) gets versions and how `cardine-structure` picks them up.
> **Not here:** SemVer for projects (lives in `kern/`), the CHANGELOG format.

## Why

`cardine-structure` (public npm package) contains a copy of `kit/`. Every
`cardine-structure` release pins one kit version, so users know which
structure they get. The source (`kit/`) and the distribution copy
(`packages/structure/kit/`) live in the same repo and are kept identical with
`make sync-kit`.

## Tags

Kit tags follow the pattern `kit-v<semver>`:

```
kit-v0.1.0       → first kit release
kit-v0.2.0       → kit with a new module or stack
kit-v0.2.1       → bugfix in the kit without new features
```

SemVer for the kit:

| Part | When to bump |
|------|--------------|
| **major** | Breaking change: layer renamed, generator behaves differently, existing projects break |
| **minor** | New module, new stack, new option in `new-project.sh` |
| **patch** | Bugfix, documentation update in the kit, small change to `new-project.sh` |

## Cutting a new kit version

```bash
# 1. Make sure everything is committed and make check is green
make check

# 2. Make sure the distribution copy matches the source
make sync-kit

# 3. Tag the current HEAD as kit-v0.2.0
make tag-kit TAG=v0.2.0

# 4. The tag script checks that the working directory is clean
#    and that the tag does not already exist on another commit.
```

The new version ships with the next `cardine-structure` release:

```bash
bash packages/structure/sync_kit.sh
```

## Pairing with cardine-structure

| cardine-structure version | kit tag | Particulars |
|---------------------------|---------|-------------|
| 0.5.0 | — | `kit/` becomes the source; no pin any more |
| 0.4.0 | — | `jarvis-check`/`env-status`/`index` in `kern/Makefile` |
| 0.1.0 | `kit-v0.1.0` | first release |

This table is updated in `packages/structure/docs/cardine-structure.md`.

## When to tag

- **Always** before a `cardine-structure` release
- **Optional** after a significant kit change (new module, stack, or generator option)
- **Not** for small ongoing changes — bundle those into the next tag

## Deliberately later

Extensions this repo deliberately leaves out (P28).

| Extension | Why later | Ask when |
|-----------|-----------|----------|
| Automatic tag on `make check` | Not every check is a release | Tags are set by hand |
| A kit CHANGELOG as a separate file | For now the pairing table above is enough | The kit changes weekly |

---
