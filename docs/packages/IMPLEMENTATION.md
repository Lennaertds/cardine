# Implementation plan — Cardine packages

> Phases and planning for setting up the public packages.
> **Status:** completed — the packages are published on npm.

## Phase 1 — Package structure

| Task | Duration |
|------|----------|
| Create the directory structure `packages/lab/`, `packages/structure/` | 1 day |
| Move `install-lab.sh` into `packages/lab/` and make it public | 1 day |
| Move all scripts into `packages/lab/scripts/` | 1 day |
| Create a CHANGELOG.md per package | 1 day |

## Phase 2 — Structure mirror

| Task | Duration |
|------|----------|
| Script `sync_kit.sh` that copies the kit from `kit/` | 1 day |
| First copy from `kit/` | 1 day |
| README.md for the structure package | 1 day |

## Phase 3 — Tidying the meta

| Task | Duration |
|------|----------|
| Rewrite the root README as the shop window | 1 day |
| Update `package.json` with references | 1 day |
| Clean up superfluous root files | 1 day |

## Timeline

```mermaid
gantt
    title Package implementation
    dateFormat  YYYY-MM-DD

    section Phase 1 — Package structure
    Create directory structure packages/lab/ packages/structure/      :p1a, 2026-11-21, 1d
    Move install-lab.sh into packages/lab/ and make it public         :p1b, after p1a, 1d
    Move all scripts into packages/lab/scripts/                       :p1c, after p1b, 1d
    Create a CHANGELOG.md per package                                 :p1d, after p1c, 1d

    section Phase 2 — Structure mirror
    Script sync_kit.sh that copies the kit from kit/                  :p2a, after p1d, 1d
    First copy from kit/                                              :p2b, after p2a, 1d
    README.md for the structure package                               :p2c, after p2b, 1d

    section Phase 3 — Tidying the meta
    Rewrite the root README as the shop window                        :p3a, after p2c, 1d
    Update package.json with references                               :p3b, after p3a, 1d
    Clean up superfluous root files                                   :p3c, after p3b, 1d
```
