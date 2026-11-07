# Spec — onderdeel-ide-shell

> **Rol:** Open keuzes voor de IDE-shell (host). Geen ADR tot A4-score + ja.
> **Kaart:** [totaalproduct.md](../../product/totaalproduct.md) · shortlist-criteria ook in [cursor-vervang-lagen](cursor-vervang-lagen.md)

- **Item:** [BACKLOG.md](../BACKLOG.md)
- **Status:** open
- **Product (bijhouden):** [../../product/ide-shell.md](../../product/ide-shell.md)
- **Hypothese:** Non-Electron fork of koppeling; basis om indexing + harness + UI aan te hangen — niet from-scratch.

## Wat het is

Editor + file tree + terminal + LSP/DAP-host. Dit is de **basis** van het totaalproduct: zonder shell geen “ik zie mijn code”. Geen agent-logica hier — wel hooks voor FS/events en UI.

## Wat overhead bepaalt

| Bron | Effect |
|------|--------|
| Electron/Chromium | RAM/CPU — **must vermijden** |
| Extensie-marktplaats + idle extensions | Startup, geheugen |
| GPU-compositor / animaties | Nice vs ballast op Hyprland |
| Ingebouwde git/debug/AI | Handig of bloat — per feature kiezen |
| Grootte van de fork-boom | Onderhoudslast |

## Functies die wél belangrijk zijn (v1)

- Snelle buffer-edit; split panes; terminal in of naast editor
- LSP-host (diagnostics, go-to-def via language servers — niet zelf bouwen)
- Workspace-root + multi-folder later
- Haak voor Agent-UI (paneel of externe TUI)
- Haak voor FS-events / indexing refresh
- Wayland/Arch: stabiel op Hyprland

**Niet v1:** extensie-store, remote-SSH-IDE, cloud sync, theme-ecosysteem-pariteit.

## Open beslissingen

| # | Vraag | Opties / notitie | Blokkeert |
|---|-------|------------------|-----------|
| I1 | Fork vs koppelen? | Plugin/RPC genoeg → koppel; anders fork lichtste kandidaat | bijna alles |
| I2 | Welke shortlist-winnaar? | Zed / Lapce / Helix / Neovim / Kate | I1 |
| I3 | TUI-first vs native GUI? | Helix/nvim lichter; Zed/Lapce “IDE-er” | Agent-UI |
| I4 | LSP: bundled vs system servers? | Arch packages vs vendor | overhead |
| I5 | Terminal: embedded vs extern (`foot`/`kitty`)? | | workflow |
| I6 | Arch AUR/repo-friction per kandidaat? | Meet bij A4 | hosts |

## Acceptatie (later)

- [ ] A4-scorematrix + §-bronnen
- [ ] Expliciete keuze + ADR vóór code
