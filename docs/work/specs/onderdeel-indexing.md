# Spec — onderdeel-indexing

> **Rol:** Open keuzes voor Project-Understanding. Meeste tijd/aandacht.
> **Product:** [indexing.md](../../product/indexing.md) · **Kaart:** [totaalproduct.md](../../product/totaalproduct.md)

- **Item:** [BACKLOG.md](../BACKLOG.md) · volg **6**
- **Status:** in uitvoering — stap 2 gedaan; volgende = stap 3
- **Product (bijhouden):** [indexing.md](../../product/indexing.md)
- **Hypothese:** **Compose** (niet Instant Grep bouwen): trial **jarvis** = Zoekt+SCIP via MCP; personaliseren (ignore, docs/AE, versheid); **fork niet default**. Fallback: Zoekt + dunne eigen MCP. Embeddings niet v1. Smoke Arch (2026-11-16): jarvis droeg search + refs.

## Lagen

```text
Discovery → Lexical (Zoekt) → Structural (SCIP/tree-sitter) → Map (§16) → (later) Semantic
```

## Slices

1. ~~OSS-catalogus + leerbronnen + compose/fork-advies~~ **gedaan** → [indexing.md](../../product/indexing.md)
2. ~~Smoke: jarvis (of Zoekt-only) op AE/lab — search + refs latency; Arch-install-pad~~ **gedaan** → [indexing.md](../../product/indexing.md) (Arch-install + smoke-tabel)
3. X1/X2 vastleggen + tool-contract schets t.o.v. harness; ADR na ja
4. Baseline-meting vs `rg`-only

## Stappenplan

Eén stap per sessie. Cijfers en het gekozen pad komen in [indexing.md](../../product/indexing.md). Een ADR wacht op een expliciete ja. Tot die ja blijft [ADR 0001](../../decisions/0001-runtime-stack-bewust-uitgesteld-tot-expliciete-pi-of-ts-keuze.md) gelden: geen `apps/` en geen generator. Zed blijft de upstream-host uit [ADR 0002](../../decisions/0002-de-ide-shell-is-upstream-zed-opgehaald-als-pinned-release-zonder-fork.md).

### Stap 2 — Smoke op Arch

Doel: weten of jarvis (Zoekt + SCIP via MCP) op deze machine search én refs levert.

1. Werk op de Arch-machine waar dit lab en Agent Engineering naast elkaar staan. Neem geen inhoud uit Agent Engineering of `data/raw/` over naar deze repo.
2. Installeer jarvis volgens de upstream-docs. Noteer versie en het installatiepad (pakket, binary of build) in de productdoc.
3. Indexeer dit lab. Indexeer Agent Engineering alleen als de tool een tweede root aankan; noteer die uitkomst als waarneming bij X5.
4. Stel vijf vaste vragen. Noteer per vraag de toolnaam, de tijd tot de eerste treffer en of de treffer klopt:
   - een bekend symbool (definitie)
   - een referentie naar dat symbool
   - een tekstfragment in een markdown-bestand
   - een pad dat in `.gitignore` staat (hoort ontbreken)
   - een bestand dat je net hebt gewijzigd (blijft de index stale)
5. Faalt de installatie, de refs of de MCP-aanspreekbaarheid, herhaal 2–4 met Zoekt alleen en schrijf de blocker in één zin.

### Stap 3 — X1, X2 en het tool-contract

Doel: een voorstel dat de smoke draagt. Nog geen code.

1. X1 wordt de compose-set die stap 2 droeg: jarvis, of Zoekt plus wat er wél werkte.
2. X2 wordt een MCP/daemon die DSH mount (`dsh --profile acp`). Zed Agent blijft uit; zijn grep is niet dit contract.
3. Schets het contract op één blad: toolnaam, input (query, pad, root), output (pad, regel, symbool), en de fout als de index leeg of stale is.
4. X3 (repo-map), X4 (docs-weging) en X5 (multi-root) blijven open. Noteer alleen wat de smoke liet zien.
5. X6 blijft uit in v1. X7 blijft upstream, tenzij stap 2 een harde blocker noteerde.
6. Stop en vraag ja voor een ADR.

### Stap 4 — Baseline tegen ripgrep

1. Herhaal de vijf vragen met `rg` op dezelfde roots en dezelfde machine.
2. Zet een tabel in de productdoc: vraag, tijd `rg`, tijd index, klopt `rg`, klopt index.
3. Schrijf welke vragen de index wint (refs, docs) en welke `rg` wint (een net gewijzigd bestand, geen daemon).

## Open beslissingen

| # | Vraag | Neiging |
|---|-------|---------|
| X1 | Compose-set? | jarvis (smoke droeg) → Zoekt+SCIP MCP |
| X2 | Process-model? | MCP die DSH mount; Zed Agent uit |
| X3 | Repo-map? | later klein eigen |
| X4 | Docs-weging? | AE hoger |
| X5 | Multi-root? | twee `jarvis index`-roots; cross-search werkt |
| X6 | Embeddings? | nee v1 |
| X7 | Fork? | **nee** — geen Arch-blocker |

## Acceptatie

- [x] OSS + leerbronnen + fork/compose-advies in productdoc
- [x] Smoke / Arch-pad
- [ ] X1–X2 + ADR na ja
- [ ] Baseline vs rg
