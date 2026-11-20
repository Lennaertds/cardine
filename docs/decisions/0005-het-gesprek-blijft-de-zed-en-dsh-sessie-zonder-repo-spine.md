# 0005 — Het gesprek blijft de Zed- en DSH-sessie, zonder repo-spine

- **Status:** aanvaard
- **Datum:** 2026-11-16
- **Raakt:** [session-spine.md](../product/session-spine.md), [totaalproduct.md](../product/totaalproduct.md), [PRODUCT.md](../product/PRODUCT.md), [BACKLOG.md](../work/BACKLOG.md). Spec `onderdeel-session-spine` verwijderd — product-doc volstaat.

## Samenvatting

In de context van een chat die bij Zed, Claude en Cursor aan het workspace-pad hangt, geconfronteerd met een `.agent/`-map die dat niet beter koppelt, kozen we voor de bestaande Zed-panel- en DSH-sessie en tegen een repo-spine, om geen tweede geheugen te bouwen, en we aanvaarden dat een hernoemde map het gesprek bij het oude pad laat.

## Context

- Cursor, Claude Code en de DSH-sessie achter Zed bewaren het transcript buiten de repo, gebonden aan het pad waarmee je startte (§128, §132).
- Het voorstel C′ zette `<cwd>/.agent/` (`status.md` + `ledger.jsonl`) als bron over een padwissel. Dat koppelt de chats niet beter; het is een extra bestand naast de sessie.
- Duurzame notities hebben al een plek: `make log` naar `docs/work/logs/`.

## Besluit

We bouwen geen repo-spine. Het gesprek is het Zed Agent Panel en de DeepSeek Harness-sessie. Er komt geen `.agent/` en geen `ledger.jsonl` in de werkmap. Wat blijvend de slice uit moet, gaat via `make log`.

## Alternatieven

| Optie | Waarom niet |
|-------|-------------|
| `.agent/` in de werkmap | Lost de pad-binding van de chat niet op |
| `.planning/` in plaats van `.agent/` | Zelfde extra geheugen, andere mapnaam |
| Alleen de IDE-chat als enige bron, en de DSH-sessie weggooien | De harness-sessie hervat het gesprek; die blijft |

## Gevolgen

- **Makkelijker:** geen tweede state naast de sessie die Zed en DSH al bijhouden.
- **Moeilijker of risico:** map hernoemen of verplaatsen laat het gesprek bij het oude pad. Dat is hetzelfde gedrag als Cursor en Claude.
- **Te doen:** niets tot iemand een koppeling heeft die de pad-binding wél oplost. Dan heropent dit besluit.
