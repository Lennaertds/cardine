# Harness

> **Rol:** Bijhouden van de agent-loop — runtime, permissions, sessions, routing naar tools/LLM/indexing.
> **Niet hier:** modelkeuze ([llm.md](llm.md)); samenhang ([totaalproduct.md](totaalproduct.md)).

**Stand:** beslist · **ADR:** [0003](../decisions/0003-de-agent-loop-is-upstream-deepseek-harness-gepind-als-dsh-profile-acp-zonder-fork.md) · **Spec weg** — besluit in ADR, vorm in product-doc · bronnen: §76 Pi, §77 DSH

## Wat de gebruiker kan

- Lokaal een agent-loop starten die tools aanroept, indexing bevraagt, structure respecteert, en via BYOK een model praat — meetbaar en herhaalbaar. Zed toont het gesprek; de loop is niet Zed Agent.

## Besluit

**DeepSeek Harness**, upstream, geen fork, apart proces ([ADR 0003](../decisions/0003-de-agent-loop-is-upstream-deepseek-harness-gepind-als-dsh-profile-acp-zonder-fork.md)). Zed start `dsh --profile acp`. Indexing komt binnen als MCP. [ADR 0001](../decisions/0001-runtime-stack-bewust-uitgesteld-tot-expliciete-pi-of-ts-keuze.md) blijft gelden voor eigen app-code: geen `apps/` en geen `--starter`.

Pi komt alleen terug als een latere ACP-smoke faalt (Zed start DSH niet, of MCP mount faalt). Deze ADR kiest Pi niet. Geen DeepInfer. Geen eigen loop.

| Kandidaat | Sterkte | Risico |
|-----------|---------|--------|
| DSH (gekozen) | ACP-profiel, MCP-client, plugins, DeepSeek-fit, MIT, upstream-updates | Preview/breaking; breder dan lab-minimum |
| Pi | Minimaal, TS, SDK/RPC | Alleen als ACP-smoke faalt |
| Eigen loop | Max controle | Traag / heruitvinden — niet gekozen |

## Stand van zaken

| Onderwerp | Status | Notitie |
|-----------|--------|---------|
| Basis H1 | beslist | DSH, geen fork — [ADR 0003](../decisions/0003-de-agent-loop-is-upstream-deepseek-harness-gepind-als-dsh-profile-acp-zonder-fork.md) |
| Embed vs apart process H2 | beslist | Apart proces; Zed praat ACP |
| Profile H3 | beslist | `acp` (niet web/headless als UI) |
| Indexing als plugin vs MCP H4 | beslist | Externe MCP uit het indexing-contract |
| Upstream vs fork H5 | beslist | Upstream volgen; fork vraagt een latere ja |
| ADR / apps-code | import beslist | [0001](../decisions/0001-runtime-stack-bewust-uitgesteld-tot-expliciete-pi-of-ts-keuze.md) blijft: geen `apps/` |
| Lab-install | staat | Pin `0.2.2-rc.1`, Zed-koppeling, key en jarvis-mount: [zed-dsh](../how-to/zed-dsh.md). Een al open Zed-thread ziet de tool nog niet |

## Raakvlakken

- Aan: [tools.md](tools.md), [indexing.md](indexing.md), [structure.md](structure.md), [llm.md](llm.md), [session-spine.md](session-spine.md)
- UI: [agent-ui.md](agent-ui.md) (Zed-panel, af)
- Host: [ide-shell.md](ide-shell.md)

## Bewust niet

- Inference-serving.
- Feature-pariteit met Cursor Cloud Agents.
- DSH in de Zed-binary stoppen, of Zed Agent ernaast aan laten staan.
