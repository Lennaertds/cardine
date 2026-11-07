# Harness

> **Rol:** Bijhouden van de agent-loop — runtime, permissions, sessions, routing naar tools/LLM/indexing.
> **Niet hier:** werkplan ([onderdeel-harness](../work/specs/onderdeel-harness.md)); modelkeuze ([llm.md](llm.md)); samenhang ([totaalproduct.md](totaalproduct.md)).

**Stand:** vorm · **Spec:** [onderdeel-harness](../work/specs/onderdeel-harness.md) · bronnen: §76 Pi, §77 DSH

## Wat de gebruiker kan

- Lokaal een agent-loop starten die tools aanroept, indexing bevraagt, structure respecteert, en via BYOK een model praat — meetbaar en herhaalbaar.

## Hypothese

**DeepSeek Harness (`dsh`)** als sterke kandidaat (plugins, DeepSeek-fit, MIT); **Pi** als leaner alternatief. Embed via RPC/ACP of process naast IDE. Geen DeepInfer. Geen Cursor-harness-pariteit.

| Kandidaat | Sterkte | Risico |
|-----------|---------|--------|
| DSH | Plugins, UI, ecosysteem | Preview/breaking; breed |
| Pi | Minimaal, TS, SDK/RPC | Meer zelf lijmen |
| Eigen loop | Max controle | Traag / heruitvinden |

## Stand van zaken

| Onderwerp | Status | Notitie |
|-----------|--------|---------|
| Basis H1 (DSH/Pi/…) | open | neiging DSH |
| Embed vs apart process H2 | open | hangt van IDE |
| Profile H3 | open | |
| Indexing als plugin vs MCP H4 | open | |
| Upstream vs fork H5 | open | observeren tot stabieler? |
| ADR / apps-code | geblokkeerd | ADR 0001 |

## Raakvlakken

- Aan: [tools.md](tools.md), [indexing.md](indexing.md), [structure.md](structure.md), [llm.md](llm.md), [session-spine.md](session-spine.md)
- UI: [agent-ui.md](agent-ui.md)
- Host-optie: [ide-shell.md](ide-shell.md)

## Bewust niet

- Inference-serving.
- Feature-pariteit met Cursor Cloud Agents.
