# Structure

> **Rol:** Bijhouden hoe de projectstandaard in de agent-loop meewegen en afgedwongen wordt (docs + checks + hooks).
> **Niet hier:** werkplan ([onderdeel-structure](../work/specs/onderdeel-structure.md)); kit-bron in Agent_Engineering; samenhang ([totaalproduct.md](totaalproduct.md)).

**Stand:** vorm (A6/A7 decision-candidates) · **Spec:** [onderdeel-structure](../work/specs/onderdeel-structure.md) · detailvorm: [ideeen A6–A7](../research/ideeen-en-vragen.md)

## Wat de gebruiker kan

- De agent (en jij) volgt **harde** projectregels: geen “klaar” bij rood `make check`, geen secrets, seams gerespecteerd — niet alleen prose in AGENTS.

## Hypothese

**Dual (A6):** dunne `AGENTS.md` (TOC/intent) + enforcement in `make check` / hooks. **Ladder (A7):** check verplicht einde slice; rood → fix of restore. Dit is een echte Cursor-voorsprong-hoek naast indexing.

## Stand van zaken

| Onderwerp | Status | Notitie |
|-----------|--------|---------|
| Dual → ADR S1 | open | vorm in ideeen |
| Stop/PreTool hooks S2 | open | hangt van harness |
| Write allowlist S3 | open | |
| Always-on vs JIT docs S4 | open | A8 |
| `product/structure` gedragstests | later | na stack |

## Raakvlakken

- Afgedwongen in: [harness.md](harness.md), [tools.md](tools.md)
- Geprioriteerd in retrieval: [indexing.md](indexing.md)
- Bronstandaard: Agent_Engineering (read-only)

## Bewust niet

- Alleen langere AGENTS als “oplossing”.
- Kit-edits vanuit dit lab zonder brug + ja.
