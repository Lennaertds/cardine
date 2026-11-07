# FS/events

> **Rol:** Bijhouden van de filesystem-/change-seam — hoe indexing en harness verse file-state zien.
> **Niet hier:** werkplan/keuzes ([onderdeel-fs-events](../work/specs/onderdeel-fs-events.md)); index-algoritmes ([indexing.md](indexing.md)); samenhang ([totaalproduct.md](totaalproduct.md)).

**Stand:** vorm · **Spec:** [onderdeel-fs-events](../work/specs/onderdeel-fs-events.md)

## Wat de gebruiker kan

- (Indirect:) na save of agent-edit is de index **niet stale** — geen “wild goose chase” op oude inhoud.

## Wat het is

Geen aparte app om te forken. Contract tussen event-bronnen en consumers:

| Bron | Voorbeeld |
|------|-----------|
| OS watch | inotify via notify/Chokidar/IDE-native |
| IDE | buffer save, unsaved dirty, open files |
| Tools/harness | na write/edit/apply_patch |
| Git | commit als anker; unstaged als overlay |

```text
save / tool-write / git-checkout
        │
        ▼
   FS event bus (pad + create|modify|delete|rename)
        │
        ├─► indexing: dirty / incremental
        └─► optioneel Agent-UI: “index stale”
```

## Hypothese

Bus leeft dicht bij indexing of IDE; harness emits na tool-writes. Geen apart “FS-product”.

## Stand van zaken

| Onderwerp | Status | Notitie |
|-----------|--------|---------|
| Eigenaar bus (F1) | open | IDE / indexing / harness |
| Watch-library (F2) | open | |
| Unsaved buffers (F3) | open | |
| Git-anker + overlay (F4) | open | §69-les |
| Contract 1-pager | open | |

## Raakvlakken

- Van: [ide-shell.md](ide-shell.md), [tools.md](tools.md)
- Naar: [indexing.md](indexing.md), optioneel [agent-ui.md](agent-ui.md)

## Bewust niet

- Eigen file-watcher-framework als research-hobby.
- Cloud file-sync.
