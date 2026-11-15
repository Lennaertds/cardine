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

## Stappenplan

Wacht op het X2-voorstel uit [onderdeel-indexing](onderdeel-indexing.md). Eén stap per sessie. Uitkomst in [fs-events.md](../../product/fs-events.md). Geen watcher-code en geen eigen framework.

### Stap A — Contract vanuit X2

1. F1: de bus hoort bij het indexing-proces uit X2. Wijkt de smoke af (alleen Zed ziet de saves), dan wordt dát het voorstel.
2. Schrijf één blad: een event is pad + soort (`create`, `modify`, `delete`, `rename`) + bron (`os`, `ide`, `tool`, `git`). Consumers: indexing markeert dirty; de UI mag later “stale” tonen.
3. F3: v1 leest de schijf. Ongeslagen buffers blijven een latere Zed-vraag.
4. F4: een git-commit is het anker, unstaged wijzigingen zijn de overlay. Doet jarvis of Zoekt dat al, dan neemt het voorstel die werking over.
5. F2 (library) en F5 (debounce) krijgen een naam pas als het proces vaststaat. Verzin geen milliseconden.

### Stap B — Vastleggen

Wordt de bus een eigen process naast de index-daemon, dan vraagt deze stap een ADR. Blijft de bus in die daemon, dan sluit de productdoc het voorstel en gaat deze spec weg zonder aparte ADR.

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
