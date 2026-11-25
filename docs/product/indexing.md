# Indexing / Project-Understanding

> **Role:** maintaining the **indexing** domain — fast, targeted project context for the agent.
> **Not here:** the FS bus ([fs-events.md](fs-events.md)); relations ([totaalproduct.md](totaalproduct.md)); ADRs.

**State:** decided, agent path only · **ADR:** [0006](../decisions/0006-the-agent-searches-via-jarvis-as-mcp-zed-search-and-lsp-stay-with-the-editor.md) · **Spec gone** — decision in the ADR, shape in the product doc

## What the user can do

- As a solo dev I want the agent to quickly find **the right files/symbols** in *my* repos, locally, lexical/symbol-first — better *for my workflow* than Cursor, not feature parity.

## Your use case (fit)

| Dimension | Situation | Consequence |
|----------|----------|--------|
| Scale | A few repos | Small index; aggressive ignore |
| Languages now | Lots of MD/docs + Make; code later | Docs-first + SCIP per language later |
| Workflow | AGENTS / `make check` / slices | Prioritise structure paths |
| Host | Arch, local; Zed as IDE host | Index as a **separate** service (MCP/daemon) ↔ harness/ACP |
| Model | DeepSeek BYOK | Tools over embeddings lock-in |

Hypothesis (§69): **exact/lexical-first**; measure semantic later.

## Layers (what "indexing" is)

```text
1. Discovery   — paths + ignore + git
2. Lexical     — text/regex (Zoekt / Instant-Grep-like)
3. Structural  — defs/refs/symbols (SCIP / tree-sitter / LSP)
4. Map         — compact repo map (§16 Aider)
5. (Later) Semantic — embeddings only after a baseline
```

---

## Open source — building blocks and products

### A. Engines (forking is rarely needed — use as a binary)

| Piece | Licence | What | URL / anchor |
|------|----------|-----|-------------|
| **Zoekt** | Apache-2.0 | Trigram code search (regex/substring, multi-repo) | [sourcegraph/zoekt](https://github.com/sourcegraph/zoekt) |
| **SCIP** (+ `scip` CLI) | Apache-2.0 | Protocol and tool for defs/refs/implementations | [sourcegraph/scip](https://github.com/sourcegraph/scip) · [scip-code.org](https://scip-code.org) |
| **scip-typescript / -python / -java / …** | usually Apache | Per-language indexers → `.scip` | Sourcegraph indexer docs |
| **tree-sitter** | MIT | Incremental AST; highlighting plus a light outline | tree-sitter.github.io |
| **ripgrep** | MIT/Unlicense | Baseline without an index; always the fallback | BurntSushi/ripgrep |

**Not to be used as an OSS base:** Sourcegraph *product* code search (enterprise licence since ~2023). Zoekt + SCIP stay open.

### B. Agent-facing layers (MCP / CLI — composition candidates)

| Piece | Licence | What | Fork? |
|------|----------|-----|-------|
| **jarvis** | MIT (claimed) | Local SCIP navigation + Zoekt search as **MCP tools**; tree-sitter baseline; indexes on disk | **Use** it first; fork only if the tool API or fit fails |
| **Gortex** | Apache-2.0 | Heavy code graph plus many MCP tools; single binary | Trial/Assess — broad; possibly overkill for v1 |
| **polyglot-indexer-mcp** | check | tree-sitter + SQLite ± SCIP | Learn from / smaller composition |
| **mcp-zoekt** | Apache | Thin Zoekt↔MCP bridge | Good if you want Zoekt alone |
| **Aider** (repo map) | Apache-2.0 (Aider) | tree-sitter + dependency graph → token-budget map | **Borrow the concept** (§16); do not fork all of Aider |
| **DSH community** (code-intel / codegraph / rag) | varies | Indexing as a harness plugin | Observe alongside the DSH choice |
| **Serena** | (complement) | Refactor/rename side — **not** retrieval | Pair with something jarvis-like; not the indexing core |

### C. Learning sources (closed or partly open — the mechanism, not stolen code)

| Source | Type | What to learn | Lab anchor |
|------|------|-----------|-----------|
| Cursor Instant Grep blog + docs | closed product + engineering | Local lexical index, freshness, why embeddings were dropped for search | **§69** |
| Cursor semantic search / secure indexing | closed / historical | Embeddings + Merkle — context, not the v1 path | **§70–§71** |
| Aider Repository Map docs | open docs | Graph + ranking within a token budget | **§16** |
| Zoekt README + query language | OSS docs | Indexing, searching, ranking signals | wantlist |
| SCIP schema + indexer docs | OSS docs | What a "symbol index" is | wantlist |
| jarvis install/MCP docs | OSS docs | Tool surface for agents | wantlist |
| PKU Harness-Bench etc. | papers | Measuring H×M — indexing is part of H | §133 etc. |

---

## Decision

Agent path only ([ADR 0006](../decisions/0006-the-agent-searches-via-jarvis-as-mcp-zed-search-and-lsp-stay-with-the-editor.md)). jarvis (Zoekt + SCIP) is the MCP that DSH mounts. Zed Agent stays off. Project search and the LSP in Zed remain for the human.

## What fits best? (the choice, carried by the smoke test)

The same logic as for Zed: **do not build Instant Grep yourself**; **compose** and personalise for this repo.

| Option | Fit for you | Verdict |
|-------|--------------|---------|
| **jarvis (or an equivalent MCP: Zoekt+SCIP)** as the index daemon | Agent tools ready; local; fits Zed/harness via MCP | **Primary trial** |
| Zoekt alone + a thin MCP of our own | More control, less symbol navigation | Fallback / intermediate step |
| Gortex | Powerful, broad | Assess — only if jarvis falls short and you want a graph |
| `rg` alone + file reads | Too weak as an end goal; fine as a day-0 baseline | Measurement baseline |
| An own engine from scratch | No advantage over Zoekt | **No** |
| Cursor-parity embeddings | Cloud/lock-in; §69 says lexical first | **No v1** |

### Personalising (your "better than Cursor"):

1. Weight ignore + **docs/MD/structure paths** more heavily.  
2. Multi-root AE + lab.  
3. Freshness via [fs-events](fs-events.md) (git anchor + dirty).  
4. Tool names/contract as an MCP that DSH mounts (`dsh --profile acp`). Pi only if that smoke test fails.  
5. Optional: a thin **repo map** (§16) next to the search tools.

### Is a fork needed?

| Layer | Fork? |
|------|-------|
| Zoekt / SCIP / tree-sitter | **No** — binaries/upstream |
| jarvis / MCP wrapper | **Not yet** — run it and measure; fork or wrap only if the API or Arch packaging structurally chafes |
| Aider | **No** — take the idea into a small piece of our own |
| "One app" | Index = a **separate service** beside Zed (like the harness) — the same model as the IDE shell |

```text
Zed (host, Agent Panel) ──ACP──► DSH ──MCP──► indexing (jarvis/Zoekt+…)
                                  │
                                  └── tools / LLM / structure
Zed Agent + grep: in the binary, do not start it.
```

---

## Rules (intent)

| Rule | Why |
|-------|--------|
| Index locally; no codebase upload for search | §69 / privacy |
| Default = lexical/symbol; embeddings explicit | No silent semantic |
| `.gitignore` + project ignore | Tokens/noise |
| Fresh at the search moment | [fs-events](fs-events.md) — git anchor + dirty paths; no own watcher |

## Arch install (smoke test 2026-11-16)

Machine: Arch Linux x86_64 (`arch-desktop`). No content from `data/raw/` was copied into this repo.

| Piece | Path / version |
|------|----------------|
| CLI + MCP | `uv tool install --python 3.13 jarvis-mcp` → **jarvis-mcp 0.10.0** (`jarvis`, `jarvis-server` in `~/.local/bin`) |
| Zoekt + scip | `setup.sh --only zoekt` / `--only scip` → `~/.jarvis/bin` (Zoekt pin `33f1f18af292`; scip fork `v0.9.0-dev` / `56791658a873`) |
| scip-python | `npm install -g --prefix ~/.jarvis @sourcegraph/scip-python` → **0.6.8** (the global npm install failed on EACCES) |
| PATH | `~/.local/bin` + `~/.jarvis/bin` (setup.sh appends to `~/.zshrc`) |
| Index roots | `jarvis index <lab>` and separately `jarvis index <other-repo>` — two slugs, one MCP server |

The first `searchCode` after a cold start takes ~2 s (Zoekt web server on :6070); after that ~7–10 ms.

## Smoke result (lab `cardine`)

Fixed questions via MCP (`jarvis-server`). Warm Zoekt.

| # | Question | Tool | First hit | Correct? |
|---|-------|------|----------------|--------|
| Q1 | Definition of `parse_items_xml` | `goToDefinition` | 3.2 ms → `scripts/digest-rss.py:38` (SCIP) | yes |
| Q2 | References to `parse_items_xml` | `findReferences` | 1.9 ms → 2 locaties in `digest-rss.py` | yes |
| Q3 | MD fragment `Project-Understanding` | `searchCode` | 7.6 ms → o.a. `docs/product/indexing.md` | yes |
| Q4 | Token in `data/runtime/` (gitignored) | `searchCode` | 7.3 ms → 0 hits | yes (absent) |
| Q5 | Just-changed tracked file (not reindexed) | `searchCode` + `getIndexStatus` | 7.4 ms → 0 hits; `stale: false` / `freshness: fresh` | the index misses dirty paths (expected); the status claims "fresh" — the overlay stays with [fs-events](fs-events.md) |

Zoekt-only fallback: **not needed**. SCIP references worked after scip-python. The semantic extra is not installed (deliberately outside the smoke test).

**X5 (observation):** a second index root indexes as a separate slug; `searchCode` without a `repo` filter touches both (smoke: 140 hits / 2 repos). No foreign content in this repo.

## Current state

| Topic | Status | Note |
|-----------|--------|---------|
| X1 Composition set | decided | jarvis (Zoekt+SCIP via MCP) — [ADR 0006](../decisions/0006-the-agent-searches-via-jarvis-as-mcp-zed-search-and-lsp-stay-with-the-editor.md) |
| X2 Process model | decided | MCP that DSH mounts. Agent path only. Zed Agent off. Editor search and LSP stay |
| X3 Repo map | open | a small own one later (§16) |
| X4 Doc weighting | open | fit for this repo |
| X5 Multi-root | **observation** | Two `jarvis index` calls; cross-repo search works |
| X6 Embeddings | **no v1** | semantic extra not in the smoke test |
| X7 Fork | **no by default** | Arch path: uv + setup.sh + npm prefix; no fork blocker |
| Smoke test of jarvis on Arch | **done** | see the table above |
| Mount on `dsh --profile acp` | stands | `mcp__jarvis__*`. A fresh ACP start sees the tools. An already open Zed thread does not. How-to: [zed-dsh](../how-to/zed-dsh.md) |

## Interfaces

- [ide-shell.md](ide-shell.md) (Zed host) · [harness.md](harness.md) · [fs-events.md](fs-events.md) · [tools.md](tools.md)

## Deliberately not

- An own search engine / embedding farm.
- Sourcegraph enterprise as a dependency.
- Thesis outline here.