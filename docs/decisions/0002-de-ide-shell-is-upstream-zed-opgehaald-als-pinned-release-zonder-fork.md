# 0002 — De IDE-shell is upstream Zed, opgehaald als pinned release, zonder fork

- **Status:** aanvaard
- **Datum:** 2026-11-15
- **Raakt:** [ide-shell.md](../product/ide-shell.md), [totaalproduct.md](../product/totaalproduct.md), [PRODUCT.md](../product/PRODUCT.md), [BACKLOG.md](../work/BACKLOG.md). [0001](0001-runtime-stack-bewust-uitgesteld-tot-expliciete-pi-of-ts-keuze.md) blijft gelden.

## Samenvatting

In de context van een GUI-host naast een eigen harness, geconfronteerd met een GPL-monoliet en een agent-pad dat al in Zed zit, kozen we voor upstream Zed als pinned release via de meta-package en tegen een eigen fork, om één workflow te hebben zonder de editor te onderhouden, en we aanvaarden dat core-gaten in Zed alleen via ACP, extensies of een latere heropening dichtgaan.

## Context

- Besliscriterium is de kwaliteit van het agent-pad, met een GUI. Neovim en Helix vallen af als primaire shell.
- Zed levert editor, panels, diffs en een ACP-client. De eigen loop, indexing, structure en LLM horen daar buiten.
- Een Zed-fork betekent GPL-plichten en een crate-monoliet bijhouden. Lapce is Apache en kleiner, en heeft geen rijp agent-protocol.
- De totaalkaart beschreef dit al als distributiemodel: officiële binary, niet zelf hosten, niet forken.

## Besluit

We gebruiken Zed als IDE-shell. De meta-package haalt een gepinde upstream-release rechtstreeks van Zed. We forken Zed niet en we hosten de binary niet zelf. Harness, indexing, structure en LLM blijven eigen processen en koppelen via ACP.

## Alternatieven

| Optie | Waarom niet |
|-------|-------------|
| Zed forken | GPL plus doorlopende sync met een monoliet; lost indexing niet op |
| Lapce forken en het agent-pad zelf bouwen | Apache-vrijheid in de shell, dunner agent-resultaat |
| Electron / VS Code-fork | Tegen de host-eis |
| Neovim of Helix als primaire shell | Geen GUI-edit |

## Gevolgen

- **Makkelijker:** geen editor-onderhoud; agent-UX en ACP komen van upstream; eigen werk blijft in harness, indexing en structure.
- **Moeilijker of risico:** Zed-UI en ACP volgen upstream. Een core-gat dat ACP en extensies niet dekken, heropent dit besluit. Hyprland-smoke (start, agentpaneel, idle RAM) is niet gemeten.
- **Te doen:** [0001](0001-runtime-stack-bewust-uitgesteld-tot-expliciete-pi-of-ts-keuze.md) blijft van kracht. Dit is geen runtime-keuze en maakt geen `apps/` of generators vrij.
