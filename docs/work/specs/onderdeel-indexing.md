# Spec — onderdeel-indexing

> **Rol:** Open keuzes voor Project-Understanding. Meeste tijd/aandacht.
> **Product:** [indexing.md](../../product/indexing.md) · **Kaart:** [totaalproduct.md](../../product/totaalproduct.md)

- **Item:** [BACKLOG.md](../BACKLOG.md) · volg **2**
- **Status:** in uitvoering
- **Product (bijhouden):** [indexing.md](../../product/indexing.md)
- **Hypothese:** **Compose** (niet Instant Grep bouwen): trial **jarvis** = Zoekt+SCIP via MCP; personaliseren (ignore, docs/AE, versheid); **fork niet default**. Fallback: Zoekt + dunne eigen MCP. Embeddings niet v1.

## Lagen

```text
Discovery → Lexical (Zoekt) → Structural (SCIP/tree-sitter) → Map (§16) → (later) Semantic
```

## Slices

1. ~~OSS-catalogus + leerbronnen + compose/fork-advies~~ **gedaan** → [indexing.md](../../product/indexing.md)
2. Smoke: jarvis (of Zoekt-only) op AE/lab — search + refs latency; Arch-install-pad
3. X1/X2 vastleggen + tool-contract schets t.o.v. harness; ADR na ja
4. Baseline-meting vs `rg`-only

## Open beslissingen

| # | Vraag | Neiging |
|---|-------|---------|
| X1 | Compose-set? | jarvis-trial → Zoekt+SCIP MCP |
| X2 | Process-model? | MCP/daemon naast harness/Zed |
| X3 | Repo-map? | later klein eigen |
| X4 | Docs-weging? | AE hoger |
| X5 | Multi-root? | open |
| X6 | Embeddings? | nee v1 |
| X7 | Fork? | **nee** tenzij blocker |

## Acceptatie

- [x] OSS + leerbronnen + fork/compose-advies in productdoc
- [ ] Smoke / Arch-pad
- [ ] X1–X2 + ADR na ja
- [ ] Baseline vs rg
