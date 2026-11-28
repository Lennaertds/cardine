# cardine-lab

> **A reproducible AI-agent workstation for Arch Linux / Hyprland.**

Installs the toolchain, sandbox, indexing and editor coupling in one idempotent
script. No manual steps, no stray configuration — run it and you have a working
agent workstation.

---

## What it installs

| Part | What | Why? (research) |
|------|------|-----------------|
| **DeepSeek Harness** | Agent loop: tool use, file editing, session management | Why DSH: [packages-context.md](../../docs/decisions/packages-context.md#why-deepseek-harness-and-not-an-own-loop) · ADR [0003](../../docs/decisions/0003-the-agent-loop-is-upstream-deepseek-harness-pinned-as-a-dsh-profile-acp-without-fork.md) |
| **Jarvis MCP server** | Code index for the agent — search, definition, references | Why Jarvis: [packages-context.md](../../docs/decisions/packages-context.md) · ADR [0006](../../docs/decisions/0006-the-agent-searches-via-jarvis-as-mcp-zed-search-and-lsp-stay-with-the-editor.md) |
| **bwrap sandbox** | Tight cage for the agent shell | Why a sandbox: [packages-context.md](../../docs/decisions/packages-context.md#why-a-sandbox-bwrap) · ADR [0007](../../docs/decisions/0007-tool-approval-is-a-workspace-allowlist-and-the-shell-runs-under-bwrap.md) |
| **Zed config** | ACP profile so DSH runs as the agent panel in Zed | Why Zed: [packages-context.md](../../docs/decisions/packages-context.md#why-is-zed-the-ide-on-the-lab-path) · ADR [0002](../../docs/decisions/0002-the-ide-shell-is-upstream-zed-pulled-as-a-pinned-release-without-fork.md) |

See [docs/cardine-lab.md](docs/cardine-lab.md) for the full explanation per part
and how they relate, and
[docs/decisions/packages-context.md](../../docs/decisions/packages-context.md)
for the context behind every choice.

---

## Install

### Requirements

- **Arch Linux** (or a derivative such as EndeavourOS)
- **Hyprland** (or another Wayland compositor)
- **Git** installed
- Optional: **Node.js** (for `cardine-slice-check`)

### Step 0 — A prefix your user can write to

On Arch npm installs into `/usr/lib/node_modules`, which belongs to root. Without
this, `npm i -g` fails with `EACCES: permission denied` and `sudo` only moves the
problem to the next update. Set your own prefix once:

```bash
npm config set prefix ~/.local
export PATH="$HOME/.local/bin:$PATH"   # add this line to ~/.zshrc or ~/.bashrc
```

The package's `postinstall` repeats this notice when it sees a prefix your user
cannot write — silent under `CARDINE_LAB_QUIET=1` or on CI.

### Step 1 — Install the toolchain

```bash
npm i -g @lennaertds/cardine-lab
cardine-lab install
```

`cardine-lab` stays available afterwards for `cardine-lab status` and
`cardine-lab status --fix`. The package publishes to the public npm registry —
no token needed. `cardine-lab install` runs from the directory you are in: that
directory (or its git root) becomes the `workspaceRoot` of the DSH profile.

The script is **idempotent**: you can run it several times without harm. It
installs what is missing and skips what is already there.

### Step 2 — Add the project structure

```bash
npm i -g cardine
cardine my-project --profile app
```

See [cardine](../structure/README.md) for every option.

### Step 3 — Check the status

```bash
cardine-lab status
```

or via make (if you have the repo):

```bash
make env-status
```

See [docs/how-to/status-jarvis-dsh.md](../../docs/how-to/status-jarvis-dsh.md)
for what the status check tells you and how to fix problems.

### Optional tooling

Besides the core, `install-lab.sh` also ships scripts for:

- **Security scanning** — [docs/how-to/security-scan.md](../../docs/how-to/security-scan.md)
- **Dependency audit** — [docs/how-to/deps-audit.md](../../docs/how-to/deps-audit.md)
- **Tech radar** — [docs/how-to/radar.md](../../docs/how-to/radar.md)
- **Digest (RSS/Atom feeds)** — [docs/how-to/digest.md](../../docs/how-to/digest.md)
- **Performance budgets** — [docs/architecture/performance.md](../../docs/architecture/performance.md)
- **Polyglot checks** — [docs/architecture/polyglot.md](../../docs/architecture/polyglot.md)

These scripts are **optional** — they are installed but you do not have to use
them.

---

## Contents of this package

```
packages/lab/
├── CHANGELOG.md              ← Version history
├── README.md                 ← This file
├── install-lab.sh            ← Main script — idempotent
├── cardine-bwrap             ← Tighter bwrap cage (ADR 0004)
├── cardine-status.sh         ← Status check for DSH, Jarvis, tools
├── cardine-slice-check/      ← Node module for make check after a turn
├── scripts/                  ← Optional tool scripts
│   ├── check-links.sh
│   ├── check-language.sh
│   ├── deps-audit.sh
│   ├── security-scan.sh
│   ├── perf-check.sh
│   ├── polyglot-check.sh
│   ├── radar-check.sh / radar-reminder.sh
│   ├── native-ffi.sh
│   ├── digest-*.sh / digest-rss.py
│   └── install-digest-timers.sh
└── systemd/                  ← Timer units (digest-fetch, digest-week)
    ├── digest-fetch.service / digest-fetch.timer
    └── digest-week.service / digest-week.timer
```

### Key files

| File | Role |
|------|------|
| `install-lab.sh` | Main script — idempotent, installs DSH + Jarvis + bwrap + Zed config |
| `cardine-move.sh` | The project moved: re-point the DSH profile, repair the jarvis client, re-index. `make move` / `make move-fix`. See [sandbox-troubleshoot](../../docs/how-to/sandbox-troubleshoot.md#1b-you-moved-or-renamed-the-repo) |
| `cardine-bwrap` | Tighter bwrap cage for the agent shell. See [ADR 0007](../../docs/decisions/0007-tool-approval-is-a-workspace-allowlist-and-the-shell-runs-under-bwrap.md) |
| `cardine-status.sh` | Status check for DSH, Jarvis and tools. See [docs/how-to/status-jarvis-dsh.md](../../docs/how-to/status-jarvis-dsh.md) |
| `cardine-slice-check/` | Node module for `make check` after a turn — verifies a slice is complete |
| `scripts/` | Extra tool scripts (security, radar, audit, digest, …) — optional |
| `systemd/` | Timer units for digest-fetch — optional |

---

## How it works

1. **`install-lab.sh`** downloads and installs DSH, Jarvis, bwrap and the Zed
   config. It generates an ACP profile in `~/.dsh/profiles/` that couples DSH as
   the agent panel in Zed.
2. **`cardine-bwrap`** replaces the default bwrap config with a tighter cage that
   isolates the agent shell to the workspace. The network stays open. No
   unauthorised file access.
3. **`cardine-status.sh`** checks whether every part works: DSH version, Jarvis
   index, sandbox, environment variables. Useful after installation and when
   something breaks.
4. **`cardine-slice-check`** is a Node module that `make check` uses to verify
   after every turn that links resolve, that no secrets leaked, and that the docs
   are consistent.

See [docs/product/totaalproduct.md](../../docs/product/totaalproduct.md) for how
these parts relate to the rest of the product.

---

## Behind the scenes — why these choices?

| Question | Answer | Read more |
|----------|--------|-----------|
| Why DSH and no own loop? | Upstream DeepSeek Harness is stable and active. A fork is maintenance without benefit. | Context: [packages-context.md](../../docs/decisions/packages-context.md#why-deepseek-harness-and-not-an-own-loop) · ADR: [0003](../../docs/decisions/0003-the-agent-loop-is-upstream-deepseek-harness-pinned-as-a-dsh-profile-acp-without-fork.md) |
| Why bwrap? | Lightweight, no root service, works on Arch without extra kernel modules. | Context: [packages-context.md](../../docs/decisions/packages-context.md#why-a-sandbox-bwrap) · ADR: [0007](../../docs/decisions/0007-tool-approval-is-a-workspace-allowlist-and-the-shell-runs-under-bwrap.md) |
| Why Zed? | Upstream, no fork. The lab path uses Zed, but the product imposes no editor. | Context: [packages-context.md](../../docs/decisions/packages-context.md#why-is-zed-the-ide-on-the-lab-path) · ADR: [0002](../../docs/decisions/0002-the-ide-shell-is-upstream-zed-pulled-as-a-pinned-release-without-fork.md) |
| Why deepseek-flash? | Cheap and fast for the lab. Claude is the second provider for anyone with their own key. | Context: [packages-context.md](../../docs/decisions/packages-context.md#why-deepseek-flash-as-the-model) · ADR: [0008](../../docs/decisions/0008-the-coding-model-is-deepseek-flash-and-claude-is-the-second-provider.md) |
| Why no own editor? | The editor is upstream Zed. An own IDE is work without benefit. | Context: [packages-context.md](../../docs/decisions/packages-context.md#why-a-free-product) · ADR: [0009](../../docs/decisions/0009-the-product-is-the-free-project-structure-and-a-guide-to-the-agent-paths.md) |

See [docs/decisions/packages-context.md](../../docs/decisions/packages-context.md)
for an overview of all the context and its sources.

---

## Versioning

This package has its **own version**, independent of `cardine`. SemVer — `major.minor.patch`.

| Item | Value |
|------|-------|
| Current version | 0.5.4 ([CHANGELOG](CHANGELOG.md)) |
| Git tag | `lab-v<semver>` |
| CHANGELOG | [CHANGELOG.md](CHANGELOG.md) |

See [docs/packages/VERSIONING.md](../../docs/packages/VERSIONING.md) for the full
scheme.

---

## Read more

| Where | What |
|-------|------|
| [docs/cardine-lab.md](docs/cardine-lab.md) | Full documentation of this package |
| [docs/how-to/zed-dsh.md](../../docs/how-to/zed-dsh.md) | Configure Zed + DSH |
| [docs/how-to/status-jarvis-dsh.md](../../docs/how-to/status-jarvis-dsh.md) | Read the status check |
| [docs/how-to/sandbox-troubleshoot.md](../../docs/how-to/sandbox-troubleshoot.md) | Solving bwrap problems |
| [docs/product/totaalproduct.md](../../docs/product/totaalproduct.md) | How the 9 parts relate |
| [docs/architecture/ARCHITECTURE.md](../../docs/architecture/ARCHITECTURE.md) | Containers, stack, dataflow |
| [README.md](../../README.md) | Repo overview and breakdown of the product |
