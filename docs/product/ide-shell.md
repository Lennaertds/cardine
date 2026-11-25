# IDE-shell

 > **Role:** maintaining what the IDE shell is — a GUI host for someone who knows VS Code/Cursor. The decision criterion is the quality of the agent path.
> **Not here:** the decision ([ADR 0002](../decisions/0002-the-ide-shell-is-upstream-zed-pulled-as-a-pinned-release-without-fork.md)); samenhang ([totaalproduct.md](totaalproduct.md)).

**State:** decided · **ADR:** [0002](../decisions/0002-the-ide-shell-is-upstream-zed-pulled-as-a-pinned-release-without-fork.md)

## What you want (recorded)

| Requirement | Consequence |
|-----|--------|
| **GUI** — no editing in the terminal | Neovim drops out; Helix is for understanding only, not a goal |
| Performance | Both Lapce and Zed are well ahead of Cursor/Electron; **Arch package size is not a decision criterion** |
| Extension marketplace | Not needed in the short term |
| **Decision criterion #1** | How **good** the **agent path** can become (final quality), not how little time the first fork costs |
| VS Code as the only reference | The "VS Code translation" per candidate below |

## VS Code → what you are actually using

Cursor/VS Code roughly consists of this (Electron = a browser engine around the UI):

| VS Code part | What it does |
|--------------|--------------|
| Workbench | Sidebar, tabs, panels, command palette |
| Monaco | The text editor |
| Extensions (JS) | Extend almost everything, often webviews |
| LSP / debug | Language servers + DAP (often via extensions) |
| Integrated terminal | A shell in a panel |
| Electron | Heavy runtime — your number one annoyance |

Native editors do the same *jobs* without Chromium: an own GUI toolkit + LSP as separate processes.

---

## 1. Lapce — the most attractive fork candidate

**For you:** GUI ✓ · performance-focused ✓ · **Apache-2.0** ✓ · Arch `extra` (~59 MiB) ✓

### Stack

| Layer | Technology |
|------|-------------|
| Language | Rust |
| GUI | **Floem** (own toolkit) + **wgpu** (GPU: Vulkan/Metal/…) + a Flexbox-like layout (Taffy) |
| Highlight | Tree-sitter |
| Intelligence | Built-in **LSP** client |
| Plugins | **WASI** (Wasm) — "Volts"; any language that compiles to WASI |
| Architecture | **`lapce-app` (GUI) ↔ `lapce-proxy`** — the proxy talks to disk, LSP, plugins, terminal |

That proxy is deliberate: **remote development** = GUI local, proxy on the remote (the same idea as VS Code Remote, implemented more lightly).

### Features (VS Code translation)

| VS Code habit | Lapce |
|------------------|-------|
| Open folder / explorer | Yes (glob hide, git colours in the tree) |
| Tabs, splits | Yes |
| Ctrl+P / command palette | Yes (searchable shortcuts) |
| IntelliSense / go-to-def / refs | Via LSP; panels for find refs, implementations, document symbols, call hierarchy |
| Terminal at the bottom | Built-in |
| Diff / SCM | Diff editor, git status in the explorer; no full VS Code Git UI |
| Extensions marketplace | `plugins.lapce.dev` — **small** compared with VS Code |
| Vim mode | Built-in (on/off) |
| Debug (DAP) | Present (since the 0.3 line) |
| AI | Had an experimental Copilot path — not your BYOK harness |

### Forkability

| | |
|--|--|
| Licence | **Apache-2.0** — forking, modifying and redistributing is relatively simple |
| Codebase | Smaller/clearer than Zed; Floem is an own UI stack though (learning curve) |
| Maturity | **Pre-1.0** (0.4.x); slower releases; thinner docs |
| Maintenance risk | The author/org shares attention with **Lapdev** (a remote environment product) |
| Lab fit | The best "real fork" on the GUI list: keep it thin + WASI/proxy seams for indexing/harness |

**Risk:** you fork a *young* editor — bugs and missing polish compared with VS Code are normal.

---

## 2. Zed — modern, fast, heavy to fork

**For you:** GUI ✓ · performance UI ✓ · interesting agent ecosystem · fork = **copyleft + monolith**

### Stack

| Layer | Technology |
|------|-------------|
| Language | Rust (a great many crates) |
| GUI | **GPUI** — own framework; Linux: Wayland/X11 + **wgpu**/Vulkan |
| Buffers | Sum-tree (fast edits in large files) |
| Highlighting | Tree-sitter (the Zed makers originated tree-sitter) |
| Extensions | **Wasm** extensions (sandboxed; no VS Code webview freedom) |
| Agents | Built-in agent UI + **ACP** (Agent Client Protocol) — external agents as a subprocess |

Linux has become "first class"; the rendering path is actively improved (Blade → wgpu).

### Features (VS Code translation)

| VS Code habit | Zed |
|------------------|-----|
| Workbench / panes | A full GUI IDE experience |
| Extensions | Wasm; limited UI extensions (visual extension API still in discussion/RFC) |
| LSP / diagnostics | Strong; many servers |
| Git | Built-in |
| Terminal | Built-in |
| AI / agent panel | **A strong product point** — own and external agents via ACP (useful later for *your* harness as an ACP client) |
| Collaboration | Multiplayer (not your v1 goal) |
| Marketplace | Growing, but not the VS Code extension universe |

### Forkability

| | |
|--|--|
| Licence | The editor is mostly **GPL-3.0-or-later**; GPUI etc. partly **Apache-2.0**. Redistributing a fork = copyleft duties |
| Codebase | Enormous (hundreds of crates) — syncing with upstream is a job in itself |
| Arch-pakket | ~298 MiB installed — zwaarste op de shortlist |
| Lab fit | **Coupling** (ACP / extensions) >> forking. Fork only if you must patch the core and accept GPL |

**Performance nuance:** the UI is fast; large TS monorepos can still pull a lot of RAM/CPU through LSP/index — as elsewhere. Shell ≠ indexing.

---

## 3. Kate — the "classic" desktop editor (KDE)

**For you:** GUI ✓ · closest to an "ordinary IDE without Electron" · Hyprland drags **KDE Frameworks** along

### Stack

| Layer | Technology |
|------|-------------|
| Language | C++ |
| GUI | **Qt** + **KDE Frameworks** |
| Editor core | **KTextEditor** (a reusable library: Document / View) |
| Scripting | JavaScript (Kate scripts) |
| Plugins | Bundled addons (LSP, terminal, git, …) — no VS Code marketplace |

### Features (VS Code translation)

| VS Code habit | Kate |
|------------------|------|
| Multi-tab / splits / MDI | Yes |
| Open folder as project | Lightweight project support |
| Explorer / search in folder | Yes |
| LSP (completion, def, refs, rename, format, diagnostics) | The **LSP Client** plugin |
| Debug | DAP support |
| Terminal | Integrated (Konsole-like) |
| Git | Integration (not as rich as VS Code Git Graph extensions) |
| Vi mode | Optional |
| Syntax | 300+ languages (classic and modern) |
| Third-party extensions | Limited — what KDE bundles |

### Forkability

| | |
|--|--|
| Licence | **LGPL-2.0-or-later** (KTextEditor/Kate contributions) — more library-friendly than a GPL app fork |
| Stack knowledge | Qt/KF — a different world from the Rust lab |
| Runtime on Hyprland | Works, but **many KF dependencies** = weight plus update coupling to KDE Gear |
| Lab fit | A good "familiar desktop IDE"; mediocre for *your* harness-fork story unless you want Qt |

---

## 4. Helix — for understanding (not a GUI goal)

Helix is a **terminal** editor (Rust). You want a GUI → **not your shell**. Still useful for understanding what "batteries included without Electron" means.

### How it fits together

- **Modal** (like Vim): Normal / Insert / Select.
- **Selection-first** (Kakoune): select first, then act — a cursor is a one-character selection; multi-cursor is normal.
- **Built in:** LSP, tree-sitter highlighting/textobjects, fuzzy pickers, file explorer — without a plugin manager.
- **No** (stable) plugin API in main; Steel/Scheme plugins via a separate branch/AUR — extending often means **forking the core**.

VS Code translation: put Monaco + workbench aside, keep LSP + tree-sitter, pack it all into a fast TUI with Vim keys that work "backwards". Very fast, steep learning curve, a poor fit for "I want a window with a mouse and panels".

---

## 5. Neovim — rejected for this product

RPC/Lua = a great harness seam and top performance, but **no GUI editing** per your requirement. Possibly later only as a *backend* behind a separate GUI — not as the primary shell.

---

## Comparison (your criteria)

| | Lapce | Zed | Kate | Helix | (nvim) |
|--|-------|-----|------|-------|--------|
| GUI window | ✓ | ✓ | ✓ | ✗ TUI | ✗ |
| Performance focus | Very high | High (UI) | Medium (Qt/KF) | Extreme | Extreme |
| Familiar from VS Code | Moderate | High | Medium-high | Low | Low |
| Extensions | WASI, small | Wasm + ACP | Bundled | Barely any | Rich Lua |
| Agent path later | Build it yourself | ACP ready | Yourself | — | RPC |
| Fork licence | **Apache** | GPL | LGPL | MPL | Apache |
| Fork maintenance | Medium | Very heavy | Medium (Qt) | Medium | Unnecessary |
| Arch size | ~59 MiB | ~298 MiB | ~36 MiB + KF | ~207 MiB | ~31 MiB |
| Maturity | Pre-1.0 | Productive | Mature | Mature TUI | Mature |

## Lapce vs Zed — re-weighed on the agent path

Your question is *not* "where do I get a fork fastest", but "where does the agent result become **better** when *I* steer (own harness/indexing)?"

| | **Zed as host (couple)** | **Fork Lapce + agent yourself** |
|--|-----------------------------|-------------------------------|
| What you inherit | Agent panel, multi-buffer review, permissions UI, **ACP** (JSON-RPC to an external agent) | Fast GUI + proxy; **no** mature agent protocol/UI |
| Own harness (DSH/Pi/…) | As an **ACP server** (or subprocess): Zed shows diffs/threads; you own loop/tools/LLM | You build chat + apply/reject + streaming **and** the loop |
| Final agent UX quality | Probably **higher**: years of editor↔agent UX already in Zed | Depends on how much agent UI you rebuild — often **thinner** than Zed |
| Final quality of *your* indexing/structure | A level playing field: own tools behind ACP or in-process | A level playing field: WASI/proxy hooks |
| What you give up | Not rewriting a GPL core; following upstream Zed UI | Apache freedom in the shell; agent UX is on you |
| What a Lapce fork does **not** win you | Better Instant Grep — that is indexing, not the editor | — |

**Conclusion:** [ADR 0002](../decisions/0002-the-ide-shell-is-upstream-zed-pulled-as-a-pinned-release-without-fork.md). Zed is the GUI host; the own harness couples via ACP. Lapce stays plan B in case the editor core must later be ours under Apache.

### Do I need to fork Zed for "one big app"?

**No.** We pull a pinned upstream release. Reason and limit: [ADR 0002](../decisions/0002-the-ide-shell-is-upstream-zed-pulled-as-a-pinned-release-without-fork.md).

"One working application" = **one workflow for you**, not necessarily one git repo or one binary:

```text
┌─────────────────────────────────────────────┐
│  Zed (upstream, not forked)                 │
│  editor + panels + ACP-client + diffs       │
└───────────────┬─────────────────────────────┘
                │ ACP / tools / MCP
┌───────────────▼─────────────────────────────┐
│  Your stack (separate processes/repos OK)   │
│  harness (DSH/Pi) + indexing + structure    │
│  + BYOK LLM                                 │
└─────────────────────────────────────────────┘
```

| Approach | When |
|--------|---------|
| **Couple (default)** | Agent, indexing, structure, LLM as **external** services that Zed drives or that run beside Zed — you experience one product |
| **Wasm extension** | Thin UI/commands in Zed without forking the core |
| **Fork Zed** | Only if you must change the **core** in ways ACP/extensions cannot reach (renderer, a hard product limit) — rare; then GPL + sync burden |

Our own work lives in harness/indexing/structure — that does **not** belong in a Zed fork. Forking does not fix "bad Instant Grep"; indexing does.

### Disk footprint (your Arch, 2026-11-07)

| Editor | Installed size (package) | Note |
|--------|-------------------------|---------|
| Lapce (`extra`) | **~59 MiB** | not installed; pacman `-Si` |
| Zed (`extra`) | **~298 MiB** | idem |
| Cursor (`cursor-bin`) | **~508 MiB** | on your system; `/usr/share/cursor` ~544 M |
| VS Code (`visual-studio-code-bin`) | **~1051 MiB** | on your system; `/usr/share/code` ~1.1 G |
| VSCodium/OSS `code` (`extra`) | ~768 MiB + aparte Electron | andere build dan Microsoft-bin |

Lapce↔Zed stays small compared with Cursor/VS Code; **RAM in use** is often dominated by **LSP** (Zed community: editor under 350 MB with many tabs, LSPs over 1 GB). We ignore the size difference between Lapce and Zed for the shell choice.

### Decision

Zed is the GUI host. The meta package pulls a pinned upstream release. Our own work (harness, indexing, structure, LLM) stays outside Zed and couples via ACP. Lapce is plan B. Kate is a backup without an agent story. Helix and Neovim are not the primary shell.

The decision is in [ADR 0002](../decisions/0002-the-ide-shell-is-upstream-zed-pulled-as-a-pinned-release-without-fork.md). The Hyprland smoke test (start, agent panel, idle RAM) was not measured.

## Current state

| Topic | Status |
|-----------|--------|
| Neovim rejected (no GUI) | done |
| Depth on Lapce / Zed / Kate / Helix | done |
| Decision criterion = agent path quality | done |
| Zed as a pinned upstream release, no fork | done — [ADR 0002](../decisions/0002-the-ide-shell-is-upstream-zed-pulled-as-a-pinned-release-without-fork.md) |
| Hyprland smoke test | not measured; item closed anyway |

## Raakvlakken

- [fs-events.md](fs-events.md) · [agent-ui.md](agent-ui.md) · [indexing.md](indexing.md) · [harness.md](harness.md)

## Reported pain points (Reddit, 2026-11-16)

Forum, level C. Not a work list and not a reason to fork. Four threads: [hype vs VS Code](https://www.reddit.com/r/vscode/comments/1thib4i/i_still_dont_understand_the_hype_around_zed_over/), [point of Zed](https://www.reddit.com/r/ZedEditor/comments/1kj1ih5/what_is_the_point_of_zed/), [subscription](https://www.reddit.com/r/ZedEditor/comments/1szb0nq/benefits_of_zed_subscription/), [disappointing](https://www.reddit.com/r/ZedEditor/comments/1u38eu4/zed_is_good_but_its_also_dissapointing/).

- Large text files (a gigabyte log) freeze all of Zed; in VS Code only that tab freezes.
- The UI for complex work: more panels and filters for something that is one action in VS Code.
- Workspace search opens a tab and shows nothing until you press Enter.
- Git panel without staged/unstaged.
- You cannot undo a deleted file (a discussion since 2024, [9143](https://github.com/zed-industries/zed/discussions/9143)).
- No multi-root: one project is one directory, and the language server then runs per directory.
- Customising keybindings feels cumbersome.
- No built-in TODO/FIXME highlighting.
- AI features and releases move faster than base editor PRs; the subscription adds little over your own Claude or Codex sub. Someone notes that Zed's own ACP has less quality of life than their harness.
- Memory: reports of several GB on a larger project. Replies attribute that mostly to the language server (JS/TS), not the editor binary.

## Deliberately not

- Electron / a VS Code fork.
- A terminal as the only edit UI.
- Forking Zed without accepting GPL + maintenance.
