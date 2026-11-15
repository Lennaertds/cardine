# IDE-shell

> **Rol:** Bijhouden wat de IDE-shell is — GUI-host voor iemand die VS Code/Cursor kent. Besliscriterium is de kwaliteit van het agent-pad.
> **Niet hier:** besluit ([ADR 0002](../decisions/0002-de-ide-shell-is-upstream-zed-opgehaald-als-pinned-release-zonder-fork.md)); criteria ([cursor-vervang-lagen](../work/specs/cursor-vervang-lagen.md)); samenhang ([totaalproduct.md](totaalproduct.md)).

**Stand:** beslist · **ADR:** [0002](../decisions/0002-de-ide-shell-is-upstream-zed-opgehaald-als-pinned-release-zonder-fork.md)

## Wat jij wilt (vastgelegd)

| Eis | Gevolg |
|-----|--------|
| **GUI** — niet in de terminal editen | Neovim valt af; Helix alleen ter begrip / niet als doel |
| Performance | Beide Lapce/Zed ruim OK t.o.v. Cursor/Electron; **Arch-pakketgrootte is geen besliscriterium** |
| Extensie-marktplaats | Niet nodig op korte termijn |
| **Besliscriterium #1** | Hoe **goed** het **agent-pad** kan worden (eindkwaliteit), niet hoe weinig tijd de eerste fork kost |
| VS Code als enige referentie | Onderstaande “VS Code-vertaling” per kandidaat |

## VS Code → wat je eigenlijk gebruikt

In Cursor/VS Code zit ongeveer dit (Electron = browser-engine om de UI):

| VS Code-stuk | Wat het doet |
|--------------|--------------|
| Workbench | Zijbalk, tabs, panels, command palette |
| Monaco | De teksteditor |
| Extensions (JS) | Bijna alles uitbreiden, vaak webviews |
| LSP / debug | Taalservers + DAP (vaak via extensions) |
| Integrated terminal | Shell in een paneel |
| Electron | Zware runtime — jouw #1 ergernis |

Native editors doen dezelfde *jobs* zonder Chromium: eigen GUI-toolkit + LSP als aparte processen.

---

## 1. Lapce — aantrekkelijkste fork-kandidaat

**Voor jou:** GUI ✓ · performance-gericht ✓ · **Apache-2.0** ✓ · Arch `extra` (~59 MiB) ✓

### Stack

| Laag | Technologie |
|------|-------------|
| Taal | Rust |
| GUI | **Floem** (eigen toolkit) + **wgpu** (GPU: Vulkan/Metal/…) + layout à la Flexbox (Taffy) |
| Highlight | Tree-sitter |
| Intelligentie | Built-in **LSP**-client |
| Plugins | **WASI** (Wasm) — “Volts”; elke taal die naar WASI compileert |
| Architectuur | **`lapce-app` (GUI) ↔ `lapce-proxy`** — proxy praat met disk, LSP, plugins, terminal |

Die proxy is bewust: **remote development** = GUI lokaal, proxy op de remote (zelfde idee als VS Code Remote, lichter uitgevoerd).

### Features (VS Code-vertaling)

| VS Code-gewoonte | Lapce |
|------------------|-------|
| Open folder / explorer | Ja (glob hide, git-kleuren in tree) |
| Tabs, splits | Ja |
| Ctrl+P / command palette | Ja (shortcuts searchable) |
| IntelliSense / go-to-def / refs | Via LSP; panels o.a. find refs, implementations, document symbols, call hierarchy |
| Terminal onderaan | Built-in |
| Diff / SCM | Diff-editor, git status in explorer; geen volledige VS Code Git-UI |
| Extensions marketplace | `plugins.lapce.dev` — **klein** t.o.v. VS Code |
| Vim-modus | Built-in (aan/uit) |
| Debug (DAP) | Aanwezig (sinds 0.3-lijn) |
| AI | Experimenteel Copilot-pad geweest — niet jouw BYOK-harness |

### Forkbaarheid

| | |
|--|--|
| Licentie | **Apache-2.0** — forken, aanpassen, heruitgeven relatief eenvoudig |
| Codebase | Kleiner/overzichtelijker dan Zed; Floem is wel eigen UI-stack (leercurve) |
| Rijpheid | **Pre-1.0** (0.4.x); releases trager; docs dunner |
| Onderhoudsrisico | Auteur/org deelt aandacht met **Lapdev** (remote env-product) |
| Lab-fit | Beste “echte fork” op de GUI-lijst: dun houden + WASI/proxy-seams voor indexing/harness |

**Risico:** je forkt een *jonge* editor — bugs en missing polish t.o.v. VS Code zijn normaal.

---

## 2. Zed — modern, snel, zwaar om te forken

**Voor jou:** GUI ✓ · performance-UI ✓ · agent-ecosysteem interessant · fork = **copyleft + monoliet**

### Stack

| Laag | Technologie |
|------|-------------|
| Taal | Rust (zeer veel crates) |
| GUI | **GPUI** — eigen framework; Linux: Wayland/X11 + **wgpu**/Vulkan |
| Buffers | Sum-tree (snelle edits in grote files) |
| Highlight | Tree-sitter (Zed-makers = tree-sitter-origine) |
| Extensies | **Wasm**-extensions (gezandboxed; géén VS Code-webview-vrijheid) |
| Agents | Ingebouwde agent-UI + **ACP** (Agent Client Protocol) — externe agents als subprocess |

Linux is “first class” geworden; rendering-pad is actief verbeterd (Blade → wgpu).

### Features (VS Code-vertaling)

| VS Code-gewoonte | Zed |
|------------------|-----|
| Workbench / panes | Volwaardige GUI-IDE-ervaring |
| Extensions | Wasm; UI-extensies beperkt (visuele extension API nog in discussie/RFC) |
| LSP / diagnostics | Sterk; veel servers |
| Git | Ingebouwd |
| Terminal | Ingebouwd |
| AI / agent panel | **Sterk productpunt** — eigen + externe agents via ACP (handig later voor *jouw* harness als ACP-client) |
| Collaboration | Multiplayer (niet jouw v1-doel) |
| Marketplace | Groeit, maar ≠ VS Code-extensie-universum |

### Forkbaarheid

| | |
|--|--|
| Licentie | Editor vooral **GPL-3.0-or-later**; GPUI e.d. deels **Apache-2.0**. Fork herdistribueren = copyleft-plichten |
| Codebase | Enorm (~honderden crates) — sync met upstream is een baan |
| Arch-pakket | ~298 MiB installed — zwaarste op de shortlist |
| Lab-fit | **Koppelen** (ACP / extensions) >> forken. Fork alleen als je core moet patchen én GPL accepteert |

**Performance-nuance:** UI is snel; grote TS-monorepo’s kunnen alsnog veel RAM/CPU trekken via LSP/index — net als elders. Shell ≠ indexing.

---

## 3. Kate — “klassieke” desktop-editor (KDE)

**Voor jou:** GUI ✓ · dichtst bij “gewone IDE zonder Electron” · Hyprland sleept **KDE Frameworks** mee

### Stack

| Laag | Technologie |
|------|-------------|
| Taal | C++ |
| GUI | **Qt** + **KDE Frameworks** |
| Editor-core | **KTextEditor** (herbruikbare library: Document / View) |
| Scripting | JavaScript (Kate-scripts) |
| Plugins | Bundled addons (LSP, terminal, git, …) — geen VS Code-marktplaats |

### Features (VS Code-vertaling)

| VS Code-gewoonte | Kate |
|------------------|------|
| Multi-tab / splits / MDI | Ja |
| Open folder as project | Lichtgewicht project-support |
| Explorer / search in folder | Ja |
| LSP (completion, def, refs, rename, format, diagnostics) | Plugin **LSP Client** |
| Debug | DAP-support |
| Terminal | Geïntegreerd (Konsole-achtig) |
| Git | Integratie (niet zo rijk als VS Code Git Graph-extensies) |
| Vi-modus | Optioneel |
| Syntax | 300+ languages (klassiek + modern) |
| Extensies van derden | Beperkt — wat KDE bundelt |

### Forkbaarheid

| | |
|--|--|
| Licentie | **LGPL-2.0-or-later** (KTextEditor/Kate-bijdragen) — library-vriendelijker dan GPL-app-fork |
| Stack-kennis | Qt/KF — andere wereld dan Rust-lab |
| Runtime op Hyprland | Werkt, maar **veel KF-deps** = gewicht + update-koppeling aan KDE Gear |
| Lab-fit | Goede “bekende desktop-IDE”; matig voor *jouw* harness-fork-verhaal tenzij je Qt wilt |

---

## 4. Helix — ter begrip (geen GUI-doel)

Helix is een **terminal**-editor (Rust). Jij wilt GUI → **niet jouw shell**. Wel nuttig om te weten wat “batteries included zonder Electron” betekent.

### Hoe het in elkaar zit

- **Modal** (zoals Vim): Normal / Insert / Select.
- **Selection-first** (Kakoune): eerst selecteren, dan actie — een cursor = selectie van 1 teken; multi-cursor is normaal.
- **Ingebouwd:** LSP, tree-sitter highlighting/textobjects, fuzzy pickers, file explorer — zonder plugin-manager.
- **Geen** (stabiele) plugin-API in main; Steel/Scheme-plugins via aparte branch/AUR — uitbreiden = vaak **core forken**.

VS Code-vertaling: stel Monaco + werkblad weg, houd LSP + tree-sitter, stop alles in een snelle TUI met Vim-toetsen die “andersom” werken. Razendsnel, steile leercurve, slechte fit voor “ik wil een window met muis/panels”.

---

## 5. Neovim — afgewezen voor dit product

RPC/Lua = geweldige harness-seam en top-performance, maar **geen GUI-edit** volgens jouw eis. Eventueel later alleen als *backend* achter een aparte GUI — niet als primaire shell.

---

## Vergelijking (jouw criteria)

| | Lapce | Zed | Kate | Helix | (nvim) |
|--|-------|-----|------|-------|--------|
| GUI-window | ✓ | ✓ | ✓ | ✗ TUI | ✗ |
| Perf-focus | Zeer hoog | Hoog (UI) | Mid (Qt/KF) | Extreem | Extreem |
| VS Code-herkenbaar | Matig | Hoog | Mid-hoog | Laag | Laag |
| Extensies | WASI, klein | Wasm + ACP | Bundled | Nauwelijks | Lua-rijk |
| Agent-pad later | Zelf bouwen | ACP klaar | Zelf | — | RPC |
| Fork-licentie | **Apache** | GPL | LGPL | MPL | Apache |
| Fork-onderhoud | Middel | Zeer zwaar | Middel (Qt) | Middel | Onnodig |
| Arch size | ~59 MiB | ~298 MiB | ~36 MiB + KF | ~207 MiB | ~31 MiB |
| Rijpheid | Pre-1.0 | Productief | Volwassen | Volwassen TUI | Volwassen |

## Keuze Lapce vs Zed — herijkt op agent-pad

Jouw vraag: *niet* “waar heb ik het snelst een fork”, maar “waar wordt het agent-resultaat **beter** als *ik* het stuur (eigen harness/indexing)?”

| | **Zed als host (koppelen)** | **Lapce forken + agent zelf** |
|--|-----------------------------|-------------------------------|
| Wat je erft | Agent panel, multi-buffer review, permissions-UI, **ACP** (JSON-RPC naar externe agent) | Snelle GUI + proxy; **geen** rijp agent-protocol/UI |
| Eigen harness (DSH/Pi/…) | Als **ACP-server** (of subprocess): Zed toont diffs/threads; jij bezit loop/tools/LLM | Jij bouwt chat + apply/reject + streaming **én** de loop |
| Eindkwaliteit agent-UX | Waarschijnlijk **hoger**: years of editor↔agent UX al in Zed | Afhankelijk van hoeveel Agent-UI jij nabouwt — vaak **dunner** dan Zed |
| Eindkwaliteit *jouw* indexing/structure | Gelijk speelveld: eigen tools achter ACP of in-process | Gelijk speelveld: WASI/proxy hooks |
| Wat je opgeeft | GPL-core niet herschrijven; upstream Zed-UI volgen | Apache-vrijheid in de shell; agent-UX is jouw schuld |
| Wat je níet wint door Lapce-fork | Betere Instant Grep — dat is indexing, niet de editor | — |

**Conclusie:** [ADR 0002](../decisions/0002-de-ide-shell-is-upstream-zed-opgehaald-als-pinned-release-zonder-fork.md). Zed is de GUI-host; de eigen harness koppelt via ACP. Lapce blijft plan B voor het geval de editor-core later onder Apache eigendom moet zijn.

### Moet ik Zed forken voor “één grote app”?

**Nee.** We halen een pinned upstream-release op. Reden en grens: [ADR 0002](../decisions/0002-de-ide-shell-is-upstream-zed-opgehaald-als-pinned-release-zonder-fork.md).

“Eén werkende applicatie” = **één workflow voor jou**, niet per se één git-repo of één binary:

```text
┌─────────────────────────────────────────────┐
│  Zed (upstream, niet-fork)                  │
│  editor + panels + ACP-client + diffs       │
└───────────────┬─────────────────────────────┘
                │ ACP / tools / MCP
┌───────────────▼─────────────────────────────┐
│  Jouw stack (aparte processen/repos OK)     │
│  harness (DSH/Pi) + indexing + structure    │
│  + BYOK LLM                                 │
└─────────────────────────────────────────────┘
```

| Aanpak | Wanneer |
|--------|---------|
| **Koppelen (default)** | Agent, indexing, structure, LLM als **externe** diensten die Zed aanstuurt of die naast Zed draaien — jij ervaart één product |
| **Wasm-extension** | Dunne UI/commands in Zed zonder core-fork |
| **Fork Zed** | Alleen als je **core** moet wijzigen die ACP/extensions niet aankunnen (renderer, harde productlimiet) — zeldzaam; dan GPL + sync-last |

Eigen werk zit in harness/indexing/structure — dat hoort **niet** in een Zed-fork. Forken lost “slechte Instant Grep” niet op; indexing wel.

### Disk-footprint (jouw Arch, 2026-11-07)

| Editor | Installed size (pakket) | Notitie |
|--------|-------------------------|---------|
| Lapce (`extra`) | **~59 MiB** | niet geïnstalleerd; pacman `-Si` |
| Zed (`extra`) | **~298 MiB** | idem |
| Cursor (`cursor-bin`) | **~508 MiB** | op jouw systeem; `/usr/share/cursor` ~544 M |
| VS Code (`visual-studio-code-bin`) | **~1051 MiB** | op jouw systeem; `/usr/share/code` ~1.1 G |
| VSCodium/OSS `code` (`extra`) | ~768 MiB + aparte Electron | andere build dan Microsoft-bin |

Lapce↔Zed blijft klein t.o.v. Cursor/VS Code; **RAM in gebruik** wordt vaak door **LSP** gedomineerd (Zed-community: editor &lt;350 MB met veel tabs, LSPs &gt;1 GB). Size Lapce vs Zed negeren we voor de shell-keuze.

### Besluit

Zed is de GUI-host. De meta-package haalt een pinned upstream-release op. Eigen werk (harness, indexing, structure, LLM) blijft buiten Zed en koppelt via ACP. Lapce is plan B. Kate is backup zonder agent-verhaal. Helix en Neovim zijn geen primaire shell.

Het besluit staat in [ADR 0002](../decisions/0002-de-ide-shell-is-upstream-zed-opgehaald-als-pinned-release-zonder-fork.md). De Hyprland-smoke (start, agentpaneel, idle RAM) is niet gemeten.

## Stand van zaken

| Onderwerp | Status |
|-----------|--------|
| Neovim afgewezen (geen GUI) | gedaan |
| Diepte Lapce / Zed / Kate / Helix | gedaan |
| Besliscriterium = agent-pad-kwaliteit | gedaan |
| Zed als pinned upstream-release, geen fork | gedaan — [ADR 0002](../decisions/0002-de-ide-shell-is-upstream-zed-opgehaald-als-pinned-release-zonder-fork.md) |
| Hyprland-smoke | niet gemeten; item toch gesloten |

## Raakvlakken

- [fs-events.md](fs-events.md) · [agent-ui.md](agent-ui.md) · [indexing.md](indexing.md) · [harness.md](harness.md)

## Bewust niet

- Electron / VS Code-fork.
- Terminal als enige edit-UI.
- Zed forken zonder GPL + onderhoud te accepteren.
