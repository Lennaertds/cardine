# 0006 — De agent zoekt via jarvis als MCP; Zed-zoeken en LSP blijven van de editor

- **Status:** aanvaard
- **Datum:** 2026-11-16
- **Raakt:** [indexing.md](../product/indexing.md), [totaalproduct.md](../product/totaalproduct.md), [PRODUCT.md](../product/PRODUCT.md), [BACKLOG.md](../work/BACKLOG.md). Spec `onderdeel-indexing` verwijderd — product-doc volstaat. [0001](0001-runtime-stack-bewust-uitgesteld-tot-expliciete-pi-of-ts-keuze.md) en [0003](0003-de-agent-loop-is-upstream-deepseek-harness-gepind-als-dsh-profile-acp-zonder-fork.md) blijven gelden.

## Samenvatting

In de context van een agent die bestanden moet vinden, geconfronteerd met Zed-zoeken en een language server die bij de editor horen, kozen we voor jarvis (Zoekt + SCIP) als MCP op het agent-pad en tegen het vervangen van het editor-zoeken, om één index voor DeepSeek Harness te hebben, en we aanvaarden dat de code in de Zed-binary blijft en dat een vuile file nog een git-overlay nodig heeft.

## Context

- De Arch-smoke (2026-11-16) droeg jarvis 0.10.0: `searchCode`, `goToDefinition` en `findReferences` klopten. Een gitignore-pad gaf 0 hits. Een net gewijzigd bestand ontbrak, terwijl `getIndexStatus` `fresh` zei.
- Zed Agent heeft een eigen grep in dezelfde binary. Die draait niet mee zolang alleen de external agent aanstaat. Dat is nog niet in een draaiende Zed nagemeten.
- Project-zoeken en de LSP terwijl je typt horen bij de editor. Die vervangen stond niet in het voorstel.

## Besluit

Indexing geldt alleen op het agent-pad.

- De compose-set is jarvis: Zoekt voor tekst, SCIP voor symbolen, als MCP die `dsh --profile acp` mount. Geen eigen engine, geen fork, geen embeddings in v1.
- Zed Agent blijft uit. Zijn grep is niet dit contract.
- Project-zoeken en de LSP in Zed blijven aan voor de mens. Die zetten we niet uit en we halen ze niet uit de binary.

Contract, namen uit de smoke:

| Tool | Input | Output | Fout |
|------|-------|--------|------|
| `searchCode` | query, optioneel repo | paden | 0 hits, ook als de index leeg is of het pad in `.gitignore` staat |
| `goToDefinition` | symbool | pad en regel | geen locatie |
| `findReferences` | symbool | locaties | geen locatie |
| `getIndexStatus` | — | status | niet vertrouwen voor versheid |

Versheid van een vuile file komt uit `git status` ([fs-events](../product/fs-events.md)), niet uit `getIndexStatus`.

Repo-map (X3) en docs-weging (X4) blijven open. Twee roots (lab + Agent Engineering) werkten in de smoke; dat is een waarneming, geen extra eis.

## Alternatieven

| Optie | Waarom niet |
|-------|-------------|
| Ook Zed-zoeken en de LSP vervangen | Dat is de editor. Het voorstel was alleen het agent-pad |
| Zed Agent-grep als zoekpad | Dan twee indexen, en de grep is niet jouw contract |
| Eigen Instant Grep of embeddings | De smoke droeg compose al; embeddings zijn niet v1 |
| jarvis forken | Geen Arch-blocker |

## Gevolgen

- **Makkelijker:** één MCP voor de agent. De editor blijft upstream Zed.
- **Moeilijker of risico:** Zed Agent per ongeluk aan zetten geeft een tweede zoekpad. `getIndexStatus` liegt “fresh” op een vuile file tot de git-overlay erbij zit.
- **Te doen:** baseline tegen `rg` blijft stap 4, geen deel van deze ADR. Geen `apps/`. [0001](0001-runtime-stack-bewust-uitgesteld-tot-expliciete-pi-of-ts-keuze.md) blijft.
