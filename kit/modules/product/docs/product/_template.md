# <Domain>

> **Role:** Behaviour, rules and edge cases of the <domain> domain.
> **Not here:** screens (`design/`), tables and endpoints (`architecture/`), the research it rests on (`research/`).

## What the user can do

- <As a user I want … so that …>

## Rules

Every rule is **intent**: a test that passes by bypassing or weakening the rule fails on intent.

| Rule | Why | Guarded by |
|------|-----|------------|
| <A workout only counts once it lasts ≥ 10 minutes> | <short sessions skew the volume> | <test `volume.spec.ts`> |

## Edge cases

- <Empty import, duplicate day, time zone, unit kg/lb.>

## Deliberately not

- <…>
