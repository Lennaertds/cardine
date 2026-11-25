# Solo or team

> **Role:** What differs between a solo project and a team project.
> **Not here:** the team extras to copy ([kit/team](../kit/README.md#layers)).

| Aspect | Solo (like GymFreak) | Team (like DEP2) |
|--------|----------------------|------------------|
| Context file | `AGENTS.md` for the project, plus `.cursorrules` as a thin personal layer: preferences and Cursor agreements, with a pointer to `AGENTS.md` and no overlap | **`AGENTS.md` mandatory**: everyone uses a different tool. No `.cursorrules`: personal preferences belong in your own user rules |
| Status | `docs/work/` in the repo | Issue tracker or board; no status files in the repo |
| Logs | Daily logs useful as memory | Leave them out: PR descriptions and commits are the log |
| Specs | `docs/work/specs/` | Issue description, or a spec in the PR |
| Consultation | `docs/work/meetings/` when there is a client or coach | `docs/work/meetings/`, or the tracker's wiki; pick one place |
| Decisions | ADRs | ADRs, **submitted via a PR** so the team sees them |
| Deliverables | `docs/deliverables/` | `docs/deliverables/`, with the version that was actually submitted |
| Ownership | You | One "docs steward" per sprint (rotating); docs are part of the Definition of Done |
| Check | `make check` locally + pre-commit | `make check` locally **and** in CI on every PR, branch protection on `main` |

---
