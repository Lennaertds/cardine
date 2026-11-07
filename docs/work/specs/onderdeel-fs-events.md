# Spec — onderdeel-fs-events

> **Rol:** Open keuzes voor de FS/events-seam (geen apart “product” om te forken).
> **Kaart:** [totaalproduct.md](../../product/totaalproduct.md)

- **Item:** [BACKLOG.md](../BACKLOG.md)
- **Status:** open
- **Product (bijhouden):** [../../product/fs-events.md](../../product/fs-events.md)

## Wat is dit?

**FS/events** = hoe het systeem merkt dat bestanden veranderd zijn, zodat indexing (en soms de harness) niet op een *stale* wereld werkt.

Geen fancy app. Wel een contract tussen:

| Bron van events | Voorbeeld |
|-----------------|-----------|
| OS watch | inotify (Linux), via bv. `notify` / Chokidar |
| IDE | buffer save, unsaved dirty, open files |
| Tools/harness | na `write`/`edit`/`apply_patch` |
| Git | commit hash als index-anker; unstaged als overlay (§69-les) |

Zonder dit: agent zoekt in oude index → “wild goose chase” + tokenverspilling (Cursor-argument voor lokale/verse search).

## Hoe ziet het eruit? (schets)

```text
save / tool-write / git-checkout
        │
        ▼
   FS event bus (pad + kind: create|modify|delete|rename)
        │
        ├─► indexing: mark dirty / incremental rebuild
        └─► optional: Agent-UI “index stale”
```

**Fork?** Nee als apart product. Keuze = library + waar de bus leeft (IDE-process vs indexing-daemon vs harness-plugin).

## Open beslissingen

| # | Vraag | Opties | Blokkeert |
|---|-------|--------|-----------|
| F1 | Eigenaar van de bus? | IDE / indexing-service / harness | architecture |
| F2 | Watch-library? | native inotify-wrapper vs Chokidar vs IDE-native | stack |
| F3 | Unsaved buffers indexeren? | ja (IDE push) / nee (alleen disk) | agent-kwaliteit |
| F4 | Git-anker + overlay zoals Instant Grep-model? | ja/nee | indexing v1 |
| F5 | Debounce / batch? | ms-waarden | CPU op grote trees |

## Acceptatie (later)

- [ ] Contract 1-pager in architecture of indexing
- [ ] Geen aparte ADR tenzij bus een eigen process wordt
