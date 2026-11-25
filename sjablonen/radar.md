# docs/research/radar.md

> **Role:** Tech radar (Adopt/Trial/Assess/Hold); re-assessed monthly.
> **Not here:** wantlist ([research](research.md)), CVE audits ([dependencies](dependencies.md)).

**Kit file:** [kit/modules/research/docs/research/radar.md](../kit/modules/research/docs/research/radar.md) · module `research` · P5, P8, P25, P28
**How-to:** [kit/modules/research/docs/how-to/radar.md](../kit/modules/research/docs/how-to/radar.md)

## When

With module `research`. Day 0: replace or mark the example rows. After that, monthly (`make radar-reminder`).

## Filling in

1. **Last reviewed:** a real `YYYY-MM-DD` after every substantive pass.
2. **Rows:** project choices; remove or rewrite the example rows (do not leave an illustration standing as fact).
3. **Adopt/Hold with impact:** an ADR.
4. **`## Deliberately incomplete` (P28):** keep the kit rows or extend them (P28). No scrapers in v1.

## Quick check

- [ ] `make radar-check` is green.
- [ ] `radar-check` / `radar-reminder` in `make help`; not in `CHECK` / `check-full`.
- [ ] `## Deliberately incomplete` has at least one extension row (P28).
- [ ] No feed dump in this file (P5).
