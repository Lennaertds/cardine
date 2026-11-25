# Spec — <slug>

> **Role:** a plan for one work item. Temporary: delete it after the merge; the code and the tests are then the truth.

- **Item:** [BACKLOG.md](../BACKLOG.md) · branch `feat/<slug>`
- **Status:** open | in progress | done (→ remove)

## Goal

<What the user will be able to do shortly, and why. One or two sentences.>

## Scope

- **In:** <…>
- **Out of scope:** <explicitly what not, including what seems obvious>

## Interfaces

- Modules and files: `<path>`, `<path>`
- Interface that changes: <signature, endpoint, schema>
- Seams touched: <web→api, api→db, … — see ARCHITECTURE.md § Seams>
- Example to follow: `<path/to/similar/feature>`

## Slices (each testable on its own, one session, through the whole stack)

1. <Thinnest working version>
2. <Extension>
3. <Edge cases>

## Acceptance

- [ ] <Test or command that proves it works — intent, not only "green">
- [ ] The product rules / RULES this touches still apply (not weakened)
- [ ] `make check` green
