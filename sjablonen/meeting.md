# docs/work/meetings/YYYY-MM-DD-&lt;with-whom&gt;.md

> **Role:** Minutes of a meeting with client, coach or team: what was discussed, what was decided, who does what.
> **Not here:** the decision itself when it is about the system ([adr](adr.md)).

**Kit file:** [kit/modules/meetings/docs/work/meetings/_template.md](../kit/modules/meetings/docs/work/meetings/_template.md) · module `meetings` (comes automatically with `--team`)

## When

After every meeting in which something was decided or agreed. A stand-up without decisions: no.

```bash
make meeting met=client     # docs/work/meetings/2026-10-19-client.md
```

## Filling in

1. **Present and goal:** roles are enough.
2. **Discussed:** briefly, the points.
3. **Decisions:** what is fixed. If it touches the system, write an ADR straight away and link it here.
4. **Actions:** who, what, by when. In a team they also go into the tracker as issues.

## Example (DEP2)

```markdown
# 2026-10-14 — client

- **Present:** client (CADS), coach, team
- **Goal:** which drone flights count for case 2

## Decisions

- Only flights with an orthomosaic of ≥ 1 cm/pixel count → ADR 0003.

## Actions

| Who | What | By |
|-----|------|----|
| Pieter | Send the client the list of valid flights | 2026-10-21 |
```

## Quick check

- [ ] Every decision about the system has an ADR.
- [ ] No personal data of the client beyond name and role.
