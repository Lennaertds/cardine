# Spec — <slug>

> **Role:** Plan for one work item. Temporary: delete after merge; the code and the tests are then the truth.

- **Item:** [BACKLOG.md](../BACKLOG.md) · branch `feat/<slug>`
- **Status:** open | in progress | done (→ delete)

## Goal

<What the user can do afterwards, and why. One or two sentences.>

## Scope

- **In:** <…>
- **Out of scope:** <explicitly what not, including what seems obvious>

## Touchpoints

- Modules and files: `<path>`, `<path>`
- Interface that changes: <signature, endpoint, schema>
- Seams involved: <web→api, api→db, … — see ARCHITECTURE.md § Seams>
- Example to follow: `<path/to/similar/feature>`

## Slices (each separately testable, one session, through the whole stack)

1. <Thinnest working version>
2. <Extension>
3. <Edge cases>

## Acceptance

- [ ] <Test or command that proves it works — intent, not just "green">
- [ ] Product rules / RULES this touches still hold (not weakened)
- [ ] `make check` is green
