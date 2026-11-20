# 0003 — De agent-loop is upstream DeepSeek Harness, gepind, als dsh --profile acp, zonder fork

- **Status:** aanvaard
- **Datum:** 2026-11-16
- **Raakt:** [harness.md](../product/harness.md), [tools.md](../product/tools.md), [llm.md](../product/llm.md), [totaalproduct.md](../product/totaalproduct.md), [PRODUCT.md](../product/PRODUCT.md), [BACKLOG.md](../work/BACKLOG.md). Spec `onderdeel-harness` verwijderd — product-doc volstaat. [0001](0001-runtime-stack-bewust-uitgesteld-tot-expliciete-pi-of-ts-keuze.md) en [0002](0002-de-ide-shell-is-upstream-zed-opgehaald-als-pinned-release-zonder-fork.md) blijven gelden.

## Samenvatting

In de context van een agent-loop naast upstream Zed, geconfronteerd met een preview-harness die ACP en MCP al levert, kozen we voor upstream DeepSeek Harness als gepind proces (`dsh --profile acp`) en tegen een fork, een eigen loop of Pi als default, om de loop niet zelf te onderhouden, en we aanvaarden preview-breuken en dat de ACP-smoke nog niet is gedaan.

## Context

- Zed is de GUI-host ([0002](0002-de-ide-shell-is-upstream-zed-opgehaald-als-pinned-release-zonder-fork.md)). De loop, de index, structure en het model horen daarbuiten.
- DeepSeek Harness (`dsh`, MIT, §77) levert een ACP-server en een MCP-client. Profile `acp` stapelt op `dsh-base`. Dit is de harness, niet het DeepSeek-model.
- De harness is public preview; breaking changes zijn verwacht. Het officiële ACP-vlak is smaller dan de web-app (één workspace, MCP-tools, geen plannen of elicitation).
- [0001](0001-runtime-stack-bewust-uitgesteld-tot-expliciete-pi-of-ts-keuze.md) stelt een eigen app-stack uit. Een gepind npm-proces is die stack niet.

## Besluit

We gebruiken DeepSeek Harness als agent-loop. De meta-package pint een upstream-release. Zed start `dsh --profile acp`. We forken DSH niet en we stoppen het niet in de Zed-binary.

- **H1.** De basis is DSH.
- **H2.** Apart proces. Zed praat ACP.
- **H3.** Profile `acp`. De web-UI is niet het dagelijkse scherm.
- **H4.** De index is een externe MCP. Geen indexing-plugin en geen open MCP-markt.
- **H5.** Upstream volgen. Een fork vraagt een latere ja.

Meeliftend, omdat tools en LLM met dit ja meegaan:

- De toolset is die van DSH, ingekort tot read, edit en shell, plus de indexing-tools uit het latere MCP-contract. Zoeken op het agent-pad loopt via die index. `rg` blijft de meet-fallback. Zed-grep hoort bij Zed Agent en staat uit.
- Het default-model is DeepSeek, gekozen in DSH, niet in Zed’s modelkiezer. De key staat alleen in `.env`. Geen eigen inference in v1. Model-id en tweede provider staan in [0008](0008-het-coding-model-is-deepseek-flash-en-claude-is-de-tweede-provider.md): `deepseek-flash`, Claude als tweede.

De sandbox van de shell en de goedkeuring zijn gesloten in [0007](0007-tool-goedkeuring-is-een-workspace-allowlist-en-de-shell-draait-onder-bwrap.md): workspace-allowlist, shell onder `bwrap`.

[0001](0001-runtime-stack-bewust-uitgesteld-tot-expliciete-pi-of-ts-keuze.md) blijft gelden voor eigen app-code. Geen `apps/`, geen `--starter`, geen generator. DSH is geen TypeScript-keuze voor de index.

## Alternatieven

| Optie | Waarom niet |
|-------|-------------|
| Pi als basis | Alleen als de latere ACP-smoke faalt; dit besluit kiest Pi niet |
| Eigen dunne loop | Heruitvinden van de loop |
| DSH forken | Breaking rc’s zelf bijhouden; index en structure hangen erbuiten |
| DSH in de Zed-binary | Zed blijft de host ([0002](0002-de-ide-shell-is-upstream-zed-opgehaald-als-pinned-release-zonder-fork.md)) |
| Profile `web` als dagelijks scherm | Het gesprek zit in het Zed Agent Panel |

## Gevolgen

- **Makkelijker:** loop, sessie, tools en BYOK komen van upstream. Eigen werk blijft indexing, structure en spine.
- **Moeilijker of risico:** preview en breaking changes. Het ACP-vlak kan te smal zijn voor diffs en approvals in Zed. Een falende smoke heropent dit besluit.
- **Te doen:** de smoke (Zed start `dsh --profile acp` en ziet één MCP-tool) wacht tot er een volledige applicatie is. [0001](0001-runtime-stack-bewust-uitgesteld-tot-expliciete-pi-of-ts-keuze.md) blijft van kracht.
