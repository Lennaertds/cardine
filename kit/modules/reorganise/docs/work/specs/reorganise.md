# Spec — reorganise

> **Role:** The move table for reorganising this project to the standard. Temporary: delete once everything is done.

- **Status:** inventory | in progress | done (→ delete)
- **Baseline:** <date and result of the tasks before the reorganisation>

## Move table

One row per file or folder. Order of execution: top to bottom; every row is one commit.

| Now | Becomes | Why | Done |
|-----|---------|-----|------|
| <`notes.md`> | <`docs/work/logs/2026-10-01.md`> | <daily log> | [ ] |
| <`docs/old-arch.md`> | <removed> | <derived from the code> | [ ] |

## After every step

- [ ] `make check` is green
- [ ] Links to the old path updated (`rg -n '<old path>'`)
