# Step 2 — Choose the conditions

> **Role:** Which variants of structure and docs you measure against each other, each time with one change.
> **Not here:** how you run them ([protocol](3-protocol.md)).

Compare **one** change at a time (ablation, §19). Possible conditions:

| Code | Condition | What you remove or add |
|------|----------|-------------------------------|
| **C0** | No agent context | `AGENTS.md`, `.cursorrules` and `.cursor/rules/` gone; `docs/` stays |
| **C1** | Current state | Nothing changed |
| **C2** | New skeleton | After the reorganisation from [bestaand-project](../existing-project/INDEX.md), or the kit for a new project |
| C3 | C2 without the map | Only `docs/INDEX.md` removed |
| C4 | C2 without `make check` | the check command removed from `AGENTS.md` and `Makefile` |
| C5 | C2 with a folder tree | A full tree added to `AGENTS.md` |
| C6 | No docs | `docs/` and every `.md` removed (as in §20: shows whether docs add anything) |

For a first measurement **C0, C1 and C2** are enough. C3 to C6 are ablations that show *which* part makes the difference. That is where a bachelor thesis contributes.
