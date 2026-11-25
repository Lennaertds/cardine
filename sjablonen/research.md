# docs/research/

> **Role:** What you know about the domain, which sources it rests on, and which product rule builds on it.
> **Not here:** the product rules themselves ([product](product.md)), a single experiment ([experiment](experiment.md)).

**Kit files:** [RESEARCH.md](../kit/modules/research/docs/research/RESEARCH.md), [wantlist.md](../kit/modules/research/docs/research/wantlist.md), [radar.md](../kit/modules/research/docs/research/radar.md), [digest/](../kit/modules/research/docs/research/digest/README.md), [experiments/_template.md](../kit/modules/research/docs/research/experiments/_template.md), how-to radar/digest · module `research`

## When

When product rules rest on literature (training volume, sleep), when you run experiments, or for a bachelor thesis. An agent doing code work does not load this folder; the map says so.

## Filling in

1. **Research questions** in `RESEARCH.md`, numbered. Every `<topic>.md` and every experiment references a number.
2. **How you judge sources:** the levels and what a level may carry. That way you can say how strong every rule is.
3. **Per topic** a file: what you know, with source, level and the product rule that rests on it.
4. **Wantlist:** what you still want to read. The pdfs themselves live in `data/external/`, never in git.
5. **Tech radar:** [radar](radar.md) — rings + monthly ritual; not always-on in AGENTS.
6. **Digest:** [digest](digest.md) — fetch/propose; curate before the radar (P5).

## Example (GymFreak, `research/training-volume.md`)

```markdown
# Training volume

> **Role:** What we know about sets per muscle group per week, and which rule of the split engine rests on it.
> **Not here:** the rule itself (`product/H-gym.md`).

| Claim | Source | Level | Product rule |
|-------|--------|-------|--------------|
| 10+ sets per week gives more hypertrophy than < 5 | Schoenfeld 2017 | A | default 10–20 sets per muscle group |
| Above 20 sets little extra gain for beginners | Baz-Valle 2022 | B | warning above 20 |
```

## Quick check

- [ ] Every product rule that rests on research can be traced back here.
- [ ] No pdfs or full third-party texts in git.
- [ ] The map says "do not load on code work".
