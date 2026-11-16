# Harness

> **Rol:** Bijhouden van de agent-loop — runtime, permissions, sessions, routing naar tools/LLM/indexing.
> **Niet hier:** werkplan ([onderdeel-harness](../work/specs/onderdeel-harness.md)); modelkeuze ([llm.md](llm.md)); samenhang ([totaalproduct.md](totaalproduct.md)).

**Stand:** voorstel, nog geen ADR · **Spec:** [onderdeel-harness](../work/specs/onderdeel-harness.md) · bronnen: §76 Pi, §77 DSH

## Wat de gebruiker kan

- Lokaal een agent-loop starten die tools aanroept, indexing bevraagt, structure respecteert, en via BYOK een model praat — meetbaar en herhaalbaar. Zed toont het gesprek; de loop is niet Zed Agent.

## Voorstel (geen ADR)

**DeepSeek Harness** importeren zoals Zed: upstream, geen fork, apart proces. Zed start `dsh --profile acp`. Indexing komt binnen als MCP. [ADR 0001](../decisions/0001-runtime-stack-bewust-uitgesteld-tot-expliciete-pi-of-ts-keuze.md) blijft tot een ja op H1 en H2.

Pi blijft het alternatief alleen als een latere ACP-smoke (Zed start DSH niet, of MCP mount faalt) dat voorstel onderuit haalt. Geen DeepInfer. Geen eigen loop.

| Kandidaat | Sterkte | Risico |
|-----------|---------|--------|
| DSH (voorstel) | ACP-profiel, MCP-client, plugins, DeepSeek-fit, MIT, upstream-updates | Preview/breaking; breder dan lab-minimum |
| Pi | Minimaal, TS, SDK/RPC | Alleen als ACP-smoke faalt |
| Eigen loop | Max controle | Traag / heruitvinden — niet het voorstel |

## Stand van zaken

| Onderwerp | Status | Notitie |
|-----------|--------|---------|
| Basis H1 | voorstel | DSH, geen fork |
| Embed vs apart process H2 | voorstel | Apart proces; Zed praat ACP |
| Profile H3 | voorstel | `acp` (niet web/headless als UI) |
| Indexing als plugin vs MCP H4 | voorstel | Externe MCP uit het indexing-contract |
| Upstream vs fork H5 | voorstel | Upstream volgen; fork vraagt een latere ja |
| ADR / apps-code | geblokkeerd | ADR 0001 tot expliciete ja |

## Raakvlakken

- Aan: [tools.md](tools.md), [indexing.md](indexing.md), [structure.md](structure.md), [llm.md](llm.md), [session-spine.md](session-spine.md)
- UI: [agent-ui.md](agent-ui.md) (Zed-panel, af)
- Host: [ide-shell.md](ide-shell.md)

## Bewust niet

- Inference-serving.
- Feature-pariteit met Cursor Cloud Agents.
- DSH in de Zed-binary stoppen, of Zed Agent ernaast aan laten staan.
