# docs/decisions/NNNN-&lt;slug&gt;.md (ADR)

> **Role:** One decision with its why, so nobody has to fight it out again later.
> **Not here:** how the system works now ([architecture](architecture.md)), what still has to happen ([backlog](backlog.md)).

**Kit file:** [kit/kern/docs/decisions/_template.md](../kit/kern/docs/decisions/_template.md) · layer kern · P9 (after Nygard and the Y-statement, §16, §17)

## When

Every choice with a why that someone might question later: stack, database, hosting, a pattern, a boundary. Also when you deliberately **do not** do something. A small choice that only plays in one file: a comment in that file is enough.

Native / extra language (Rust, C, …) after a budget breach: [polyglot.md](../kit/kern/docs/architecture/polyglot.md) first; for the shape see the kit example [`0000-example-native-module-after-budget-breach.md`](../kit/kern/docs/decisions/0000-example-native-module-after-budget-breach.md) — status *example*, do not leave it standing as a binding decision.

```bash
make adr t="Postgres is the only writer of user data"   # → docs/decisions/0007-postgres-is-the-only-writer-of-user-data.md
```

## Filling in

1. **Title = the decision as a sentence.** Not "Database", but "Postgres is the only writer of user data".
2. **Status:** `proposed` until it is merged or agreed, then `accepted`.
3. **Summary** as a Y-statement: one sentence with situation, problem, choice, alternative, goal and drawback.
4. **Context:** the forces, as facts.
5. **Alternatives:** each with why not. This is what helps an agent most later.
6. **Consequences:** what gets easier and harder, and which docs or code have to follow.

You never rewrite an ADR. If the decision changes, you write a new ADR and mark the old one `superseded by NNNN`.

## Example (DEP2)

```markdown
# 0002 — The pipeline is the source of truth for all cases

- **Status:** accepted
- **Date:** 2026-10-14
- **Touches:** `sql/`, `src/etl/`, `drone-imagery/`, `docs/architecture/`

## Summary

In the context of two parallel tracks for drone data, faced with agents and team members working on the
wrong track, we chose the pipeline's star schema and against schema `plantcount`, in order to have one
place for every measurement, accepting that case 2's group scripts have to be rewritten.

## Alternatives

| Option | Why not |
|--------|---------|
| Keep both tracks | every question has two answers; no test covers the second track |
| `plantcount` as the source | no link to `DimPlot`; not comparable with case 1 |
```

## Quick check

- [ ] The title is a decision, not a topic.
- [ ] There is at least one alternative with why not.
- [ ] A superseded ADR points to its successor.
- [ ] With more than ±15 ADRs: `decisions/DECISIONS.md` with the active ones, and the map points to it.
