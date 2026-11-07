# Spec — onderdeel-ide-shell

> **Rol:** Open keuzes voor de IDE-shell (host). Geen ADR tot score + ja.
> **Kaart:** [totaalproduct.md](../../product/totaalproduct.md)

- **Item:** [BACKLOG.md](../BACKLOG.md) · volg **1**
- **Status:** in uitvoering
- **Product (bijhouden):** [ide-shell.md](../../product/ide-shell.md)
- **Eisen (vast):** GUI · agent-pad-**kwaliteit** als #1 keuzecriterium · perf/size Lapce↔Zed ondergeschikt · extensies niet urgent · VS Code-referentie
- **Hypothese:** **Zed als host + eigen harness via ACP** (beter agent-resultaat); Lapce = plan B / Apache-fork als shell-eigendom later nodig; Neovim/Helix af als primaire shell

## Slices

1. ~~Diepte kandidaten~~ → ~~herijk Lapce vs Zed op agent-pad~~ **gedaan**
2. Smoke Hyprland: **Zed** (incl. agent/ACP-oppervlak) + Lapce ter vergelijking
3. I1/I2 voorstel + ACP↔harness-schets; ADR alleen na ja

## Open beslissingen

| # | Vraag | Notitie |
|---|-------|---------|
| I1 | Fork vs koppelen? | **Koppelen** — fork niet nodig voor totaalproduct; zie ide-shell |
| I2 | Winnaar? | Neiging **Zed** als host (niet-fork) |
| I3 | TUI vs GUI? | **GUI** (beslist) |
| I4–I6 | LSP / terminal / smoke | Open tot slice 2 |

## Acceptatie

- [x] Diepte Lapce/Zed/Kate/Helix + nvim afgewezen in [ide-shell.md](../../product/ide-shell.md)
- [ ] Smoke-cijfers
- [ ] I1/I2 voorstel
- [ ] ADR vóór code
