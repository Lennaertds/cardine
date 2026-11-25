# Whole product on other OSes (Linux distros, macOS and Windows)

> **Role:** behaviour, rules, options and edge cases for porting and automatically distributing the personal stack (`Cardine`) to other Linux distros, macOS and Windows after Arch Linux v1.
> **Not here:** the Arch base architecture ([totaalproduct.md](totaalproduct.md)); tool details ([tools.md](tools.md)); platform-specific specs (`docs/work/specs/`).

The stack you port is upstream Zed + upstream DSH + your index process. An own `cardine-core` that contains the loop is no longer a current decision — see [totaalproduct](totaalproduct.md). The tables below that still say `cardine-core` are therefore outdated until a separate port slice. The agent shell on Linux runs under `bwrap` ([ADR 0007](../decisions/0007-tool-approval-is-a-workspace-allowlist-and-the-shell-runs-under-bwrap.md)), not in DSH's own sandbox.

## What the user can do

- As a user on another Linux distro (Debian/Ubuntu, Fedora), macOS or Windows I want, with one command in a common package manager or installer, to install and update the same versioned stack as on Arch Linux, so that I can start working immediately without building by hand.
- As a developer/administrator I want every new release tag (`git tag`) to generate binaries, SHA256 checksums and package manifests for all supported platforms automatically, so that multi-platform maintenance costs no manual check per OS.

## Rules

Every rule is **intent**: a test that passes by bypassing or weakening the rule fails on intent.

| Rule | Why | Guarded by |
|------|-----|------------|
| OS-specific implementations (`sandbox`, `fs-events`, paths) sit behind an abstract interface (a trait) in `cardine-core`. | Prevents macOS/Windows support from polluting or breaking the core logic (`indexing`, `harness`, `structure`, `llm`, `session-spine`). | Compiler checks (`cargo check` on the target triples `x86_64-unknown-linux-musl`, `aarch64-apple-darwin` and `x86_64-pc-windows-msvc`) |
| No mandatory heavy container runtime (Docker Desktop) to start Zed itself on any OS. | Preserves the low RAM/CPU profile and the native experience; containers/VMs (Docker or Podman) are at most an optional backend for `4_tools` sandbox exec. | Install and start test on a clean environment without Docker |
| One central release manifest + CI/CD pipeline (`cargo-dist` / `GoReleaser`) drives all OS packages from one version tag. | Prevents version drift between Arch (`PKGBUILD`), other Linux, macOS and Windows and removes manual release work. | GitHub Actions release matrix with automated SHA256 verification |
| External binaries (such as Zed) are pulled on each OS straight from the official platform release, never forked or hosted by us. | Avoids licence problems and keeps the meta package transparent and low-maintenance on every platform. | Manifest linter on allowed upstream domains |

## Options per OS (to be chosen later)

| Platform | Options for the meta package / distribution | Options for the index binary | Options for `4_tools` sandbox isolation |
|----------|---------------------------------------------|------------------------------|------------------------------------------|
| **Other Linux** *(Ubuntu, Debian, Fedora, Nix)* | 1. Universal install script (`curl \| sh`) + tarball<br>2. Linuxbrew (Homebrew on Linux)<br>3. Native `.deb` & `.rpm` (auto-generated via CI)<br>4. Nix flake | **One static `musl` binary** (`x86_64-unknown-linux-musl`) — runs unchanged on any distro without `glibc` conflicts. | 1. **`bwrap` (Bubblewrap)** — default (identical to Arch)<br>2. Rootless Podman / Docker (fallback under strict AppArmor rules) |
| **macOS** *(Apple Silicon & Intel)* | 1. **Homebrew tap** (`brew install ...` via formula/cask — most standard)<br>2. Install script (`curl \| sh`) into `~/.local/bin` + `/Applications` | Cross-compiled native Mach-O binaries (`aarch64-apple-darwin` & `x86_64-apple-darwin`). | 1. **`sandbox-exec` (Apple Seatbelt)** — lightweight, built into macOS<br>2. **Docker / OrbStack / Colima** — a universal Linux container for agent exec<br>3. Strict path allowlist in `4_tools` (without an OS sandbox) |
| **Windows** | 1. **Scoop** (JSON manifest in our own git bucket — easiest to automate)<br>2. **Winget** (the official Windows Package Manager)<br>3. PowerShell install script (`irm ... \| iex`) + `.msi`/`.zip` | Cross-compiled native PE binary (`x86_64-pc-windows-msvc`). | 1. **WSL2** (delegate the agent shell to Linux `bwrap` inside WSL)<br>2. **Docker Desktop / Podman** — container isolation for agent exec<br>3. **Windows AppContainer / Job Objects** or a strict path allowlist fallback |

## Edge cases

- **Linux AppArmor on recent distros (Ubuntu 24.04+):** unprivileged user namespaces may be blocked by default for `bwrap`; catch this with a clear error message, an AppArmor profile, or a fallback to Podman/Docker.
- **File paths and line endings on Windows:** backslashes (`\`), drive letters (`C:\`), symlinks and `CRLF` vs `LF` must not break `2_fs_events`, `3_indexing` and `9_session_spine` (always use normalised paths).
- **Apple Silicon vs Intel & Gatekeeper:** macOS binaries from GitHub Releases may be blocked by Gatekeeper / quarantine flags (`com.apple.quarantine`) unless notarised by Apple; document `xattr -d` or configure code signing in CI.
- **File-watching limits (`2_fs_events`):** `FSEvents` (macOS) and `ReadDirectoryChangesW` (Windows) behave differently on bulk changes (such as `git checkout`) than Linux `inotify` (debouncing per platform).

## Deliberately not

- Building multi-platform support before Arch Linux + Hyprland v1 is stable and usable day to day.
- Building Electron wrappers or web apps to dodge cross-platform UI work.
- Manually compiling, testing and uploading separate releases on every update.
