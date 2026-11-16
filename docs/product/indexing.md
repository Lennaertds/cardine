# Indexing / Project-Understanding

> **Rol:** Bijhouden van domein **indexing** — snelle, gerichte projectcontext voor de agent.
> **Niet hier:** werkplan X1–X7 ([onderdeel-indexing](../work/specs/onderdeel-indexing.md)); FS-bus ([fs-events.md](fs-events.md)); samenhang ([totaalproduct.md](totaalproduct.md)); ADRs.

**Stand:** beslist, alleen agent-pad · **ADR:** [0006](../decisions/0006-de-agent-zoekt-via-jarvis-als-mcp-zed-zoeken-en-lsp-blijven-van-de-editor.md) · **Spec:** [onderdeel-indexing](../work/specs/onderdeel-indexing.md)

## Wat de gebruiker kan

- Als solo-dev wil ik dat de agent **snel de juiste bestanden/symbolen** vindt in *mijn* repo’s (AE + lab), lokaal, lexical/symbol-first — beter *op mijn workflow* dan Cursor, niet feature-pariteit.

## Jouw use-case (fit)

| Dimensie | Situatie | Gevolg |
|----------|----------|--------|
| Schaal | Enkele repo’s | Kleine index; agressieve ignore |
| Talen nu | Veel MD/docs + Make; code later | Docs-first + later SCIP per taal |
| Workflow | AGENTS / `make check` / slices | Structure-paden prioriteren |
| Host | Arch, lokaal; Zed als IDE-host | Index als **aparte** dienst (MCP/daemon) ↔ harness/ACP |
| Model | DeepSeek BYOK | Tools > embeddings-lock-in |

Hypothese (§69): **exact/lexical-first**; semantic later meten.

## Lagen (wat “indexing” is)

```text
1. Discovery   — paden + ignore + git
2. Lexical     — tekst/regex (Zoekt / Instant-Grep-achtig)
3. Structural  — defs/refs/symbols (SCIP / tree-sitter / LSP)
4. Map         — compacte repo-kaart (§16 Aider)
5. (Later) Semantic — embeddings alleen na baseline
```

---

## Open source — bouwstenen & producten

### A. Engines (forken zelden nodig — als binary gebruiken)

| Stuk | Licentie | Wat | URL / anker |
|------|----------|-----|-------------|
| **Zoekt** | Apache-2.0 | Trigram code-search (regex/substring, multi-repo) | [sourcegraph/zoekt](https://github.com/sourcegraph/zoekt) |
| **SCIP** (+ `scip` CLI) | Apache-2.0 | Protocol + tool voor defs/refs/implementations | [sourcegraph/scip](https://github.com/sourcegraph/scip) · [scip-code.org](https://scip-code.org) |
| **scip-typescript / -python / -java / …** | meestal Apache | Per-taal indexers → `.scip` | Sourcegraph indexer-docs |
| **tree-sitter** | MIT | Incrementele AST; highlight + lichte outline | tree-sitter.github.io |
| **ripgrep** | MIT/Unlicense | Baseline zonder index; altijd fallback | BurntSushi/ripgrep |

**Niet gebruiken als OSS-basis:** Sourcegraph *product* code-search (enterprise-license sinds ~2023). Zoekt + SCIP blijven open.

### B. Agent-facing lagen (MCP / CLI — compose-kandidaten)

| Stuk | Licentie | Wat | Fork? |
|------|----------|-----|-------|
| **jarvis** | MIT (claim) | Lokale SCIP-nav + Zoekt-search als **MCP-tools**; tree-sitter baseline; indexes op disk | Eerst **gebruiken**; fork alleen als tool-API/fit faalt |
| **Gortex** | Apache-2.0 | Zware code-graph + veel MCP-tools; single binary | Trial/Assess — breed; mogelijk overkill v1 |
| **polyglot-indexer-mcp** | checken | tree-sitter + SQLite ± SCIP | Leer/kleinere compose |
| **mcp-zoekt** | Apache | Dunne Zoekt↔MCP-brug | Goed als je Zoekt alleen wilt |
| **Aider** (repo map) | Apache-2.0 (Aider) | tree-sitter + dependency-graaf → tokenbudget-kaart | **Concept** stelen (§16); niet hele Aider forken |
| **DSH community** (code-intel / codegraph / rag) | wisselend | Indexing als harness-plugin | Observeren naast DSH-keuze |
| **Serena** | (complement) | Refactor/rename-half — **niet** retrieval | Pair met jarvis-achtig; niet indexing-kern |

### C. Leerbronnen (closed of deels open — mechanisme, geen code stelen)

| Bron | Type | Wat leren | Lab-anker |
|------|------|-----------|-----------|
| Cursor Instant Grep blog + docs | closed product + engineering | Lokale lexical index, versheid, waarom embeddings voor search afgebouwd | **§69** |
| Cursor semantic search / secure indexing | closed / historisch | Embeddings + Merkle — context, niet v1-pad | **§70–§71** |
| Aider Repository Map docs | open docs | Graaf + ranking binnen tokenbudget | **§16** |
| Zoekt README + query language | OSS docs | Indexeren, zoeken, ranking-signalen | wantlist |
| SCIP schema + indexer docs | OSS docs | Wat een “symbol index” is | wantlist |
| jarvis install/MCP docs | OSS docs | Tool-surface voor agents | wantlist |
| PKU Harness-Bench e.d. | papers | H×M meten — indexing is deel van H | §133 e.a. |

---

## Besluit

Alleen het agent-pad ([ADR 0006](../decisions/0006-de-agent-zoekt-via-jarvis-als-mcp-zed-zoeken-en-lsp-blijven-van-de-editor.md)). jarvis (Zoekt + SCIP) is de MCP die DSH mount. Zed Agent blijft uit. Project-zoeken en de LSP in Zed blijven voor de mens.

## Wat past het best? (keuze, gedragen door de smoke)

Zelfde logica als Zed: **niet Instant Grep zelf bouwen**; **composeren** en personaliseren op AE/lab.

| Optie | Fit voor jou | Oordeel |
|-------|--------------|---------|
| **jarvis (of gelijkwaardige MCP: Zoekt+SCIP)** als index-daemon | Agent-tools klaar; lokaal; past bij Zed/harness via MCP | **Primaire trial** |
| Zoekt alleen + eigen dunne MCP | Meer controle, minder symbol-nav | Fallback / tussenstap |
| Gortex | Krachtig, breed | Assess — pas als jarvis tekort + je graph wilt |
| Alleen `rg` + file reads | Te zwak als einddoel; OK als dag-0 baseline | Meetbaseline |
| Eigen engine van nul | Geen voorsprong vs Zoekt | **Nee** |
| Cursor-pariteit embeddings | Cloud/lock-in; §69 zegt lexical eerst | **Nee v1** |

### Personaliseren (jouw “beter dan Cursor”):

1. Ignore + **docs/MD/structure-paden** zwaarder wegen (AE).  
2. Multi-root AE + lab.  
3. Versheid via [fs-events](fs-events.md) (git-anker + dirty).  
4. Tool-namen/contract als MCP die DSH mount (`dsh --profile acp`). Pi alleen als die smoke faalt.  
5. Optioneel: dunne **repo-map** (§16) naast search-tools.

### Is een fork nodig?

| Laag | Fork? |
|------|-------|
| Zoekt / SCIP / tree-sitter | **Nee** — binaries/upstream |
| jarvis / MCP-wrapper | **Eerst niet** — draaien + meten; fork/wrapper alleen als API of Arch-packaging structureel knelt |
| Aider | **Nee** — idee overnemen in klein eigen stukje |
| “Één app” | Index = **aparte dienst** naast Zed (zoals harness) — zelfde model als IDE-shell |

```text
Zed (host, Agent Panel) ──ACP──► DSH ──MCP──► indexing (jarvis/Zoekt+…)
                                  │
                                  └── tools / LLM / structure
Zed Agent + grep: in de binary, niet starten.
```

---

## Regels (intentie)

| Regel | Waarom |
|-------|--------|
| Index lokaal; geen codebase-upload voor search | §69 / privacy |
| Default = lexical/symbol; embeddings expliciet | Geen stille semantic |
| `.gitignore` + project-ignore | Tokens/ruis |
| Vers op het zoekmoment | [fs-events](fs-events.md) — git-anker + vuile paden; geen eigen watcher |

## Arch-install (smoke 2026-11-16)

Machine: Arch Linux x86_64 (`arch-desktop`). Geen inhoud uit AE/`data/raw/` naar deze repo gekopieerd.

| Stuk | Pad / versie |
|------|----------------|
| CLI + MCP | `uv tool install --python 3.13 jarvis-mcp` → **jarvis-mcp 0.10.0** (`jarvis`, `jarvis-server` in `~/.local/bin`) |
| Zoekt + scip | `setup.sh --only zoekt` / `--only scip` → `~/.jarvis/bin` (Zoekt-pin `33f1f18af292`; scip fork `v0.9.0-dev` / `56791658a873`) |
| scip-python | `npm install -g --prefix ~/.jarvis @sourcegraph/scip-python` → **0.6.8** (globale npm faalde op EACCES) |
| PATH | `~/.local/bin` + `~/.jarvis/bin` (setup.sh appendt aan `~/.zshrc`) |
| Index roots | `jarvis index <lab>` en apart `jarvis index <AE>` — twee slugs, één MCP-server |

Eerste `searchCode` na koude start ~2 s (Zoekt-webserver op :6070); daarna ~7–10 ms.

## Smoke-resultaat (lab `cardine`)

Vaste vragen via MCP (`jarvis-server`). Warm Zoekt.

| # | Vraag | Tool | Eerste treffer | Klopt? |
|---|-------|------|----------------|--------|
| Q1 | Definitie `parse_items_xml` | `goToDefinition` | 3.2 ms → `scripts/digest-rss.py:38` (SCIP) | ja |
| Q2 | Refs `parse_items_xml` | `findReferences` | 1.9 ms → 2 locaties in `digest-rss.py` | ja |
| Q3 | MD-fragment `Project-Understanding` | `searchCode` | 7.6 ms → o.a. `docs/product/indexing.md` | ja |
| Q4 | Token in `data/runtime/` (gitignore) | `searchCode` | 7.3 ms → 0 hits | ja (ontbreekt) |
| Q5 | Net gewijzigd tracked bestand (niet geherindexeerd) | `searchCode` + `getIndexStatus` | 7.4 ms → 0 hits; `stale: false` / `freshness: fresh` | index mist dirty (verwacht); status liegt “fresh” — overlay blijft [fs-events](fs-events.md) |

Fallback Zoekt-only: **niet nodig**. SCIP-refs werkten na scip-python. Semantic extra niet geïnstalleerd (bewust buiten smoke).

**X5 (waarneming):** tweede root AE indexeert als aparte slug (`agent_engineering`); `searchCode` zonder `repo`-filter raakt beide (smoke: 140 hits / 2 repos). Geen AE-inhoud in deze repo.

## Stand van zaken

| Onderwerp | Status | Notitie |
|-----------|--------|---------|
| X1 Compose-set | beslist | jarvis (Zoekt+SCIP via MCP) — [ADR 0006](../decisions/0006-de-agent-zoekt-via-jarvis-als-mcp-zed-zoeken-en-lsp-blijven-van-de-editor.md) |
| X2 Process-model | beslist | MCP die DSH mount. Alleen agent-pad. Zed Agent uit. Editor-zoeken en LSP blijven |
| X3 Repo-map | open | later klein eigen (§16) |
| X4 Docs-weging | open | AE-fit |
| X5 Multi-root | **waarneming** | Twee `jarvis index`-aanroepen; cross-repo search werkt |
| X6 Embeddings | **nee v1** | semantic extra niet in smoke |
| X7 Fork | **nee default** | Arch-pad: uv + setup.sh + npm-prefix; geen fork-blocker |
| Smoke jarvis op Arch | **gedaan** | zie tabel hierboven |

## Raakvlakken

- [ide-shell.md](ide-shell.md) (Zed-host) · [harness.md](harness.md) · [fs-events.md](fs-events.md) · [tools.md](tools.md)

## Bewust niet

- Eigen search-engine / embedding-farm.
- Sourcegraph enterprise als dependency.
- Thesis-outline hier.