# Indexing / Project-Understanding

> **Rol:** Bijhouden van domein **indexing** — snelle, gerichte projectcontext voor de agent (gedrag, kandidaten, stand).
> **Niet hier:** werkplan/open keuzes X1–X7 ([onderdeel-indexing](../work/specs/onderdeel-indexing.md)); FS-bus ([fs-events.md](fs-events.md)); samenhang ([totaalproduct.md](totaalproduct.md)); ADRs.

**Stand:** vorm · **Spec:** [onderdeel-indexing](../work/specs/onderdeel-indexing.md)

## Wat de gebruiker kan

- Als solo-dev wil ik dat de agent **snel de juiste bestanden/symbolen** vindt in *mijn* repo’s, zonder Electron-bloat en zonder cloud-index — zodat ik lokaal productiever ben dan in Cursor op *deze* workflow.

## Jouw use-case (waar “beter dan Cursor” wél kan)

Cursor optimaliseert voor miljoenen gebruikers en elke denkbare stack. Jij wint door **smalle fit**:

| Dimensie | Jouw situatie | Gevolg voor indexing |
|----------|---------------|----------------------|
| Schaal | Enkele actieve repo’s (AE + lab + later apps), geen enterprise-monorepo-farm | Kleinere index; agressieve ignore OK |
| Talen nu | Zwaar Markdown/docs + Make; code later na runtime | Docs-first retrieval + later AST/SCIP |
| Workflow | Standaard-gedreven (`AGENTS`, `make check`, slices) | Index moet **structure-paden** en specs/prioriteren |
| Host | Arch/Hyprland, lokaal disk | Versheid > fancy embeddings; watch/git dirty |
| Model | DeepSeek BYOK (hypothese) | Lexical/symbol tools > cloud semantic lock-in |
| Mens | Wil code **zien** in IDE | Index voedt agent én navigatie, niet “alleen black box” |

Lab-hypothese (§69): **exact/lexical-first**; semantic/embeddings later *meten*, niet aannemen.

## Regels (intentie — tests later)

| Regel | Waarom | Bewaakt door |
|-------|--------|--------------|
| Index/build blijft op de machine; geen codebase-upload voor search | Privacy + Cursor Instant Grep-les (§69) | later config + test |
| Agent-search default = lexical/symbol; embeddings alleen met expliciete config | Geen stille “semantic” | later harness-tool contract |
| Ignore respecteert `.gitignore` + project-ignore | Ruis/tokens | later |
| Na edit: index ziet wijziging binnen afgesproken SLA (FS/events) | Geen stale goose chase | [fs-events.md](fs-events.md) |

## Stand van zaken

| Onderwerp | Status | Notitie |
|-----------|--------|---------|
| Compose-set X1 (Zoekt/SCIP/jarvis/…) | open | zie tabel hieronder |
| Process-model X2 | open | library / daemon / MCP |
| Repo-map vs tools X3 | open | §16 |
| Docs/MD-weging X4 | open | AE-fit |
| Multi-root X5 | open | AE + lab |
| Embeddings X6 | open | niet dag-0 |
| Fork-punt X7 | open | |

## Wat is het waard om te bekijken

Strategie: **niet** Instant Grep van nul nabootsen; **wel** sterke OSS composeren/forken en personaliseren op bovenstaande use-case.

| Prioriteit | Repo / stuk | Licentie-achtig | Rol | Actie |
|------------|-------------|-----------------|-----|-------|
| **1** | **Zoekt** | Apache | Lexical code-search engine | Analyseren; kandidaat-bouwsteen |
| **1** | **SCIP + scip-*-indexers** | Apache-lijn | Symbol defs/refs | Analyseren; compose met Zoekt |
| **1** | **jarvis** (SCIP+Zoekt → MCP) | MIT — verifiëren | Agent-facing index-product | Analyseren; fork/compose-kandidaat |
| **2** | **Aider repo map** (§16) | open (Aider) | tree-sitter + graaf → tokenbudget | **Concept** meenemen; niet per se hele Aider forken |
| **2** | **polyglot-indexer-mcp** | checken | tree-sitter + SQLite ± SCIP | Leerbaar kleiner vlak |
| **2** | **tree-sitter** | MIT | AST-grondstof | Bouwsteen |
| **3** | **Pi** (§76) | MIT | Minimale harness om indexing aan te hangen | Harness-seam, niet index-kern |
| **3** | **DSH** (§77) + community index-plugins | MIT + plugins | Hoe indexing als plugin zit | Observeren; preview-volatiel |
| Learn-only | Cursor §69–§71, Sourcegraph product | closed / deels | Mechanismes (lokaal lexical, versheid, Merkle) | Geen code overnemen |

**Lager prioriteit:** zware monolieten (graph-DB + multi-tenant), Electron-IDE-indexers, embedding-RAG als dag-0.

## Randgevallen

- Repo zonder git; enorme `node_modules` ondanks ignore-fout; binary files; symlink-loops; workspace met meerdere roots (AE + lab tegelijk).

## Raakvlakken

- In: [fs-events.md](fs-events.md), [ide-shell.md](ide-shell.md)
- Uit: [harness.md](harness.md) / [tools.md](tools.md); optioneel navigatie in IDE

## Bewust niet

- Eigen inference-/embedding-farm.
- Feature-pariteit met Cursor Cloud codebase index.
- Thesis-outline hier (andere chat).
