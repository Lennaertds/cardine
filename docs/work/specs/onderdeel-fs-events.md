# Spec — onderdeel-fs-events

> **Rol:** FS/events-seam. Richting gekozen; geen watcher-code.
> **Kaart:** [totaalproduct.md](../../product/totaalproduct.md)

- **Item:** [BACKLOG.md](../BACKLOG.md)
- **Status:** richting gekozen (2026-11-15)
- **Product (bijhouden):** [../../product/fs-events.md](../../product/fs-events.md)

## Richting

Zed houdt de enige OS-watch. Geen eigen bus, geen Chokidar, geen tweede inotify-boom, geen ADR.

De index wordt vers op het zoekmoment: git-commit als anker, vuile paden als overlay. Ongeslagen tekst blijft in Zed en gaat via ACP-read. Detail en de tabel: [fs-events.md](../../product/fs-events.md).

## Wat nog open is

Niets in F1–F5. De indexing-smoke ([onderdeel-indexing](onderdeel-indexing.md) stap 2) laat zien of een net gewijzigd bestand stale blijft. Wijkt `git status` daar af, dan heropent [fs-events.md](../../product/fs-events.md) alleen die laag.

## Acceptatie

- [x] Richting in de productdoc; geen eigen process, dus geen ADR
- [x] Geen watcher-code
