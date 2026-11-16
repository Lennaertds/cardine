# Structure

> **Rol:** Bijhouden hoe de projectstandaard in de agent-loop meewegen en afgedwongen wordt (docs + checks + hooks).
> **Niet hier:** werkplan ([onderdeel-structure](../work/specs/onderdeel-structure.md)); kit-bron in Agent_Engineering; samenhang ([totaalproduct.md](totaalproduct.md)).

**Stand:** beslist · **ADR:** [0004](../decisions/0004-de-projectstandaard-is-dual-een-dunne-agents-md-en-een-harde-make-check.md) · **Spec:** [onderdeel-structure](../work/specs/onderdeel-structure.md) · vorm: [ideeen A6–A7](../research/ideeen-en-vragen.md)

## Wat de gebruiker kan

- De agent (en jij) volgt **harde** projectregels: geen “klaar” bij rood `make check`, geen secrets, seams gerespecteerd — niet alleen prose in AGENTS.

## Besluit

De harness is DeepSeek Harness ([ADR 0003](../decisions/0003-de-agent-loop-is-upstream-deepseek-harness-gepind-als-dsh-profile-acp-zonder-fork.md)). Vorm blijft A6–A7. Geen hook-code.

- **S1 — dual.** `AGENTS.md` blijft de kaart: kort, intent en waar de rest staat. Harde grenzen blijven in `make check` en [RULES.md](../rules/RULES.md). Een verbod dat een check kan afdwingen, staat niet alleen in prose.
- **S2 — twee haken.** Vóór een schrijf-tool geldt de pad-allowlist, op de DSH-waterfall `tools/pre-execute` (§77). Aan het eind van een slice draait `make check`. §77 noemt geen Stop-event; de tweede haak is het slice-einde, niet elke modelstap.
- **S3 — schrijfgrens.** Schrijven blijft binnen de workspace-allowlist. Of de agent binnen die lijst eerst vraagt, blijft T2 in [tools](tools.md).
- **S4 — always-on.** Altijd mee: `AGENTS.md`, `RULES.md`, en de productdoc van het onderdeel waar de slice over gaat. De rest wordt gelezen wanneer de slice dat bestand raakt.

**Ladder (A7), als zin:** een rode `make check` sluit de slice niet. Fix, of zet de slice terug. Meetbaar pas als er een applicatie is; tot die tijd blijft `make check` rood omdat er geen app is ([ADR 0001](../decisions/0001-runtime-stack-bewust-uitgesteld-tot-expliciete-pi-of-ts-keuze.md)).

## Stand van zaken

| Onderwerp | Status | Notitie |
|-----------|--------|---------|
| Dual → ADR S1 | beslist | [ADR 0004](../decisions/0004-de-projectstandaard-is-dual-een-dunne-agents-md-en-een-harde-make-check.md) |
| Schrijfhaken + slice-einde S2 | beslist | `tools/pre-execute` en einde slice; geen code |
| Write allowlist S3 | beslist | workspace; T2 blijft open |
| Always-on vs JIT docs S4 | beslist | drie always-on, rest JIT |
| `product/structure` gedragstests | later | na een applicatie |

## Raakvlakken

- Afgedwongen in: [harness.md](harness.md), [tools.md](tools.md)
- Geprioriteerd in retrieval: [indexing.md](indexing.md)
- Bronstandaard: Agent_Engineering (read-only)

## Bewust niet

- Alleen langere AGENTS als “oplossing”.
- Kit-edits vanuit dit lab zonder brug + ja.
