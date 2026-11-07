# IDE-shell

> **Rol:** Bijhouden wat de IDE-shell is, wat we willen, en waar we staan — editor-host voor het totaalproduct.
> **Niet hier:** open-keuze-werkplan ([onderdeel-ide-shell](../work/specs/onderdeel-ide-shell.md)); A4-shortlist-details ([cursor-vervang-lagen](../work/specs/cursor-vervang-lagen.md)); hoe alles samenhangt ([totaalproduct.md](totaalproduct.md)).

**Stand:** vorm · **Spec:** [onderdeel-ide-shell](../work/specs/onderdeel-ide-shell.md)

## Wat de gebruiker kan

- Als solo-dev wil ik een **lichte non-Electron** editor op Arch/Hyprland waarin ik code zie en edit, met haken voor indexing, harness en Agent-UI — zonder VS Code-bloat.

## Hypothese

Fork of koppeling van een shortlist-kandidaat (Zed / Lapce / Helix / Neovim / Kate); geen from-scratch; geen Electron. Basis om de rest aan te hangen.

## Wat overhead bepaalt

| Bron | Effect |
|------|--------|
| Electron/Chromium | RAM/CPU — must vermijden |
| Extensie-marktplaats + idle extensions | Startup, geheugen |
| GPU/animaties | Nice vs ballast op Hyprland |
| Ingebouwde git/debug/AI | Per feature: houden of weglaten |
| Grootte fork-boom | Onderhoudslast |

## Functies v1 (wel / niet)

**Wel:** snelle edit, splits, terminal (in of naast), LSP-host, workspace-root, haak Agent-UI, haak FS/events, Wayland-stabiel.

**Niet v1:** extensie-store, remote-SSH-IDE, cloud sync, theme-pariteit.

## Stand van zaken

| Onderwerp | Status | Notitie |
|-----------|--------|---------|
| Shortlist | open | zie cursor-vervang-lagen / spec I1–I6 |
| A4-bronnen / scorematrix | open | |
| ADR | nog niet | geen code tot ADR |

## Raakvlakken

- Levert aan: [fs-events.md](fs-events.md), [agent-ui.md](agent-ui.md), later LSP → [indexing.md](indexing.md)
- Ontvangt van: gebruiker (toetsenbord, files)

## Bewust niet

- Eigen editor-renderer bouwen zolang een kandidaat voldoet.
- Cursor/VS Code-fork als lab-shell.
