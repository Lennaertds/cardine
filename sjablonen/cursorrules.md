# .cursorrules (solo)

> **Role:** Your personal layer for Cursor on top of `AGENTS.md`: preferences and Cursor agreements.
> **Not here:** anything about the project itself ([agents-root](agents-root.md)), rules for one app ([agents-app](agents-app.md)).

**Kit file:** [kit/solo/.cursorrules](../kit/solo/.cursorrules) · layer solo · rests on P2, P7

## When

Every solo project. Not in a team project: there personal preferences belong in your own user rules, not in the repo.

## Why not everything in `.cursorrules`

Cursor reads both `AGENTS.md` and `.cursorrules`. If the same rule is in both, you pay for it twice (harness tax, P25), and as soon as one version changes they contradict each other (P7). Hence:

| Belongs in `AGENTS.md` | Belongs in `.cursorrules` |
|------------------------|---------------------------|
| boundaries, commands, working method, finishing, the map | the reference to `AGENTS.md` |
| hard read routes (UI → `DESIGN.md`, feature → `PRODUCT.md`) | language of the answers (Dutch, …) |
| doing beats talking (*implement* → code this turn) | personal working method (plan first **unless** there is already an action word; browser check **after** the fix) |
| reporting style (extremely brief; applies to every tool) | what exists only in Cursor (which `.mdc` rules, `@` usage) |
| everything another tool or a fresh agent must also know | (nothing that is already linked) |

That keeps `AGENTS.md` the same standard in every project, and `.cursorrules` the only file that differs per person. Change project and the rules are in the same place.

## Filling in

1. Keep the first paragraph from the kit.
2. Two to four personal lines. If they apply in all your projects, they appear the same in every project.
3. An existing `.cursorrules` that served as a router: its content goes to `AGENTS.md`, `docs/agent/write-rules.md` and the nested `AGENTS.md` files ([step 6](../existing-project/6-router-and-map.md)). What remains is this thin layer.

## Example (GymFreak)

```markdown
# GymFreak — Cursor, personal

Follow [AGENTS.md](AGENTS.md): it holds the boundaries, the commands, the working method and the map. This file
contains only my personal preferences and what applies to Cursor alone. It repeats nothing from AGENTS.md.

- Answer in Dutch. Comments in the code in English.
- On a UI change: after the fix, check in the browser at iPhone and desktop widths, then finish. (Reading DESIGN belongs in AGENTS.md.)
- With more than three files: a short plan only if there is no *implement* / *build* / *yes* yet; then code straight away.
- Quality over token thrift: rather read one extra file than guess.
```

## Quick check

- [ ] ≤ 15 lines.
- [ ] No line that is also in `AGENTS.md` (`rg` on a key word).
- [ ] The first line refers to `AGENTS.md`.
