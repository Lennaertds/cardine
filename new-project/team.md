# Extra for team projects (sprint 0)

> **Role:** What is different when several people work on one repo.
> **Not here:** the differences in the structure itself ([solo-team](../standard/solo-team.md)).

## Kit

```bash
kit/new-project.sh <dir> --team --modules assignment,deliverables --stacks …
```

The team layer installs `.github/` (CI with `make check`, PR template, issue templates) and adds the `meetings` module. There is no `docs/work/BACKLOG.md`, `specs/` or `logs/`: status lives in the issue tracker.

## Sprint 0

- [ ] Together write `AGENTS.md`, `RULES.md` and the first ADRs, and merge them in one PR. Everyone reads them once.
- [ ] Agree: **updating docs is part of the Definition of Done.** The PR template asks for it.
- [ ] One **docs steward** per sprint, rotating. They do [maintenance](6-maintenance.md) in the last sprint week and bring it to the retro.
- [ ] Status only in the tracker. No `TODO.md`, `STATUS.md` or `last_changes.md` in the repo.
- [ ] Changing an ADR = a PR with a new ADR. No silent changes.
- [ ] Shared terms in `GLOSSARY.md`, especially with mixed Dutch and English.
- [ ] Agree which tools everyone uses. `AGENTS.md` is the common base; personal Cursor rules belong in your own user rules, not in the repo. Module `claude` if someone uses Claude Code.
- [ ] Branch protection on `main`: CI green and one review.
- [ ] Minutes of meetings with client or coach: `make meeting with=<who>`; what was decided becomes an ADR.

## Example

DEP2 (team of five, two-week sprints) is worked out in [existing-project/examples/dep2](../existing-project/examples/dep2.md). For a new team project you follow the same, but from day 0.
