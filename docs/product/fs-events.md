# FS/events

> **Role:** maintaining the filesystem/change seam — how indexing and harness see fresh file state.
> **Not here:** index algorithms ([indexing.md](indexing.md)); relations ([totaalproduct.md](totaalproduct.md)).

**State:** done (2026-11-15, no ADR) — direction fixed; spec gone

## What the user can do

- (Indirectly:) after a save or an agent edit the index is **not stale** — no wild goose chase on outdated content.

## Direction

No own bus and no second inotify tree. Zed's worktree is the only OS watch (`notify` on inotify, debounce inside Zed, rescan when the kernel queue overflows). Chokidar is out: it is a Node library, and on Linux every watcher talks to the same kernel anyway.

The index does not hook into that tree. Extensions and ACP do not export it, and a daemon beside Zed would double the watches. Freshness at search time:

| Layer | Source |
|-------|--------|
| Anchor | git commit (Zoekt already does this on commits) |
| Overlay | dirty paths via `git status`, read at the search |
| Unsaved text | stays in Zed; ACP `fs/read_text_file` when the harness needs that one buffer |

Zed closed or a headless harness: the git layer keeps working. The Zed tree exists only while the project is open.

## Current state

| Topic | Status | Note |
|-------|--------|------|
| Owner of the watch (F1) | chosen | Zed. No bus in the index daemon or the harness |
| Watch library (F2) | chosen | None. Chokidar out; no own `notify` |
| Unsaved buffers (F3) | chosen | Not in the index. ACP read from Zed |
| Git anchor + overlay (F4) | chosen | Commit + dirty paths at the search |
| Debounce (F5) | chosen | Stays in Zed. No milliseconds of ours |
| Own process + ADR | not needed | The bus does not become an own process |
| Smoke vs jarvis freshness (2026-11-16) | confirmed | Dirty tracked edit: Zoekt misses the token; `getIndexStatus` stays `stale: false` — the overlay stays with us (`git status`), not with jarvis |

## Interfaces

- From: [ide-shell.md](ide-shell.md), [tools.md](tools.md)
- To: [indexing.md](indexing.md), optionally [agent-ui.md](agent-ui.md)

## Deliberately not

- An own file-watcher framework.
- Chokidar or another npm watcher.
- A second inotify tree beside Zed.
- Unsaved keystrokes in the search index.
- Cloud file sync.

## Deliberately later

| Extension | Why later | Ask when |
|-----------|-----------|----------|
| OS watch in the index daemon | The git overlay covers the search moment | The indexing smoke test shows `git status` is too late or too expensive |
| Push of Zed events to the index | No such route exists (no worktree events via extension or ACP) | Upstream publishes such an event |
