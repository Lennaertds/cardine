# FS/events

> **Rol:** Bijhouden van de filesystem-/change-seam — hoe indexing en harness verse file-state zien.
> **Niet hier:** werkplan ([onderdeel-fs-events](../work/specs/onderdeel-fs-events.md)); index-algoritmes ([indexing.md](indexing.md)); samenhang ([totaalproduct.md](totaalproduct.md)).

**Stand:** richting gekozen (2026-11-15, geen ADR) · **Spec:** [onderdeel-fs-events](../work/specs/onderdeel-fs-events.md)

## Wat de gebruiker kan

- (Indirect:) na save of agent-edit is de index **niet stale** — geen “wild goose chase” op oude inhoud.

## Richting

Geen eigen bus en geen tweede inotify-boom. De worktree van Zed is de enige OS-watch (`notify` op inotify, debounce in Zed, rescan als de kernel-wachtrij overloopt). Chokidar valt af: dat is een Node-bibliotheek, en op Linux praat elke watcher toch met dezelfde kernel.

De index haakt niet in die boom. Extensies en ACP exporteren hem niet, en een daemon naast Zed zou de watches verdubbelen. Versheid op het zoekmoment:

| Laag | Bron |
|------|------|
| Anker | git-commit (Zoekt doet dit al op commits) |
| Overlay | vuile paden via `git status`, gelezen bij de zoekactie |
| Ongeslagen tekst | blijft in Zed; ACP `fs/read_text_file` als de harness dat ene buffer nodig heeft |

Zed dicht of een headless harness: de git-laag blijft werken. De Zed-boom bestaat alleen zolang het project open is.

## Stand van zaken

| Onderwerp | Status | Notitie |
|-----------|--------|---------|
| Eigenaar van de watch (F1) | gekozen | Zed. Geen bus in de index-daemon of de harness |
| Watch-library (F2) | gekozen | Geen. Chokidar af; geen eigen `notify` |
| Ongeslagen buffers (F3) | gekozen | Niet in de index. ACP-read van Zed |
| Git-anker + overlay (F4) | gekozen | Commit + vuile paden bij de zoekactie |
| Debounce (F5) | gekozen | Blijft in Zed. Geen milliseconden van ons |
| Eigen process + ADR | niet nodig | De bus wordt geen eigen process |

## Raakvlakken

- Van: [ide-shell.md](ide-shell.md), [tools.md](tools.md)
- Naar: [indexing.md](indexing.md), optioneel [agent-ui.md](agent-ui.md)

## Bewust niet

- Eigen file-watcher-framework.
- Chokidar of een andere npm-watcher.
- Tweede inotify-boom naast Zed.
- Ongeslagen toetsaanslagen in de zoekindex.
- Cloud file-sync.

## Bewust later

| Uitbreiding | Waarom later | Vraag als |
|-------------|--------------|-----------|
| OS-watch in de index-daemon | De git-overlay dekt het zoekmoment | De indexing-smoke toont dat `git status` te laat of te duur is |
| Push van Zed-events naar de index | Die deur bestaat niet (geen worktree-events via extensie of ACP) | Upstream zo’n event publiceert |
