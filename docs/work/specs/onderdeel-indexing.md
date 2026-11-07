# Spec — onderdeel-indexing

> **Rol:** Open keuzes voor Project-Understanding. Meeste tijd/aandacht.
> **Product:** [indexing.md](../../product/indexing.md) · **Kaart:** [totaalproduct.md](../../product/totaalproduct.md)

- **Item:** [BACKLOG.md](../BACKLOG.md)
- **Status:** open
- **Product (bijhouden):** [../../product/indexing.md](../../product/indexing.md)
- **Hypothese:** Compose/fork OSS (Zoekt + SCIP ± jarvis); lexical-first; personaliseren op solo Arch-use-case — niet Cursor-pariteit.

## Hoe zit dit in elkaar? (lagen)

```text
1. Discovery   — welke paden bestaan (ignore, git)
2. Lexical     — snelle tekst/regex search (Zoekt / Instant-Grep-achtig)
3. Structural  — symbols, defs/refs (SCIP / tree-sitter / LSP)
4. Map         — compacte repo-kaart voor prompt (Aider-les §16)
5. (Later) Semantic — embeddings alleen na meting
```

Agent praat hiertegen via **tools** (search, outline, refs) — harness roept aan; IDE mag dezelfde index voor navigatie gebruiken.

## Fork / verbeteren

Zie tabel **“Wat is het waard om te bekijken”** in [indexing.md](../../product/indexing.md).

Verbeterhoek vs “grote bedrijven”: niet betere embeddings, wel **betere fit** — ignore, docs/MD-prioriteit, AE-structuur, DeepSeek-tool-vorm, lokale versheid, geen cloud.

## Open beslissingen

| # | Vraag | Opties | Blokkeert |
|---|-------|--------|-----------|
| X1 | Compose-set v1? | Zoekt only / Zoekt+SCIP / jarvis-as-host / eigen dunne map | bouw |
| X2 | Process-model? | library-in-process / lokale daemon / MCP-server | IDE+harness |
| X3 | Repo-map in prompt vs pure tools? | Aider-stijl inject / alleen on-demand tools | tokens |
| X4 | Docs/MD weging t.o.v. code? | use-case AE | kwaliteit |
| X5 | Multi-root (AE + lab)? | één index / twee / workspace-graph | F1 |
| X6 | Wanneer embeddings? | nooit v1 / experiment na baseline | scope |
| X7 | Fork-punt? | upstream contribute vs eigen fork-repo | onderhoud |

## Acceptatie (later)

- [ ] X1–X2 gekozen + ADR
- [ ] Baseline-meting vs “alleen rg” op jouw repo’s
