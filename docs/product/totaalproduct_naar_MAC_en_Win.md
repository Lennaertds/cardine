# Totaalproduct naar andere OS'en (Linux-distro's, macOS en Windows)

> **Rol:** Gedrag, regels, opties en randgevallen voor het porten en geautomatiseerd distribueren van de persoonlijke stack (`IDE_Agentic`) naar andere Linux-distro's, macOS en Windows na Arch Linux v1.
> **Niet hier:** de Arch-basisarchitectuur ([totaalproduct.md](totaalproduct.md)); tool-details ([tools.md](tools.md)); specifieke platform-specs (`docs/work/specs/`).

## Wat de gebruiker kan

- Als gebruiker op een andere Linux-distro (Debian/Ubuntu, Fedora), macOS of Windows wil ik via één commando in een gangbare package manager of installer dezelfde geversioneerde stack (Zed + `agentic-core`) installeren en updaten als op Arch Linux, zodat ik zonder handmatig bouwen direct kan werken.
- Als developer/beheerder wil ik bij elke nieuwe release-tag (`git tag`) automatisch binaries, SHA256-checksums en package-manifests voor alle ondersteunde platformen genereren, zodat multi-platform onderhoud geen handmatige controle per OS kost.

## Regels

Elke regel is **intentie**: een test die slaagt door de regel te omzeilen of af te zwakken, faalt op intentie.

| Regel | Waarom | Bewaakt door |
|-------|--------|--------------|
| OS-specifieke implementaties (`sandbox`, `fs-events`, paden) zitten achter een abstracte interface (`Trait`) in `agentic-core`. | Voorkomt dat macOS/Windows-ondersteuning de kernlogica (`indexing`, `harness`, `structure`, `llm`, `session-spine`) vervuilt of breekt. | Compiler-checks (`cargo check` op target triples `x86_64-unknown-linux-musl`, `aarch64-apple-darwin` & `x86_64-pc-windows-msvc`) |
| Geen verplichte zware container-runtime (Docker Desktop) om Zed of `agentic-core` zelf te starten op welk OS dan ook. | Behoudt het lage RAM/CPU-profiel en native gebruikservaring; containers/VMs (zoals Docker of Podman) zijn hooguit een optionele backend voor `4_tools` sandbox-exec. | Installatie- en opstarttest op schone omgeving zonder Docker |
| Eén centraal `release-manifest` + CI/CD-pipeline (`cargo-dist` / `GoReleaser`) stuurt alle OS-packages aan vanuit één versie-tag. | Voorkomt versie-drift tussen Arch (`PKGBUILD`), overige Linux, macOS en Windows en elimineert handmatig release-werk. | GitHub Actions release-matrix met geautomatiseerde SHA256-verificatie |
| Externe binaries (zoals Zed) worden op elk OS rechtstreeks van de officiële platform-release opgehaald, nooit geforkt of gehost. | Voorkomt licentieproblemen en houdt de meta-package transparant en onderhoudsarm op alle platformen. | Manifest-linter op toegestane upstream-domeinen |

## Opties per OS (later te kiezen)

| Platform | Opties voor Meta-Package / Distributie | Opties voor `agentic-core` Binary | Opties voor `4_tools` Sandbox-isolatie |
|----------|----------------------------------------|-----------------------------------|----------------------------------------|
| **Overige Linux** *(Ubuntu, Debian, Fedora, Nix)* | 1. Universeel install-script (`curl \| sh`) + tarball<br>2. Linuxbrew (Homebrew op Linux)<br>3. Native `.deb` & `.rpm` (auto-generated via CI)<br>4. Nix Flake | **Eén static `musl`-binary** (`x86_64-unknown-linux-musl`) — draait ongewijzigd op elke distro zonder `glibc`-conflicten. | 1. **`bwrap` (Bubblewrap)** — standaard (identiek aan Arch)<br>2. Rootless Podman / Docker (als fallback bij strenge AppArmor-regels) |
| **macOS** *(Apple Silicon & Intel)* | 1. **Homebrew Tap** (`brew install ...` via Formula/Cask — meest standaard)<br>2. Install-script (`curl \| sh`) naar `~/.local/bin` + `/Applications` | Cross-compiled native Mach-O binaries (`aarch64-apple-darwin` & `x86_64-apple-darwin`). | 1. **`sandbox-exec` (Apple Seatbelt)** — lichtgewicht, ingebouwd in macOS<br>2. **Docker / OrbStack / Colima** — universele Linux-container voor agent-exec<br>3. Strikte pad-allowlist in `4_tools` (zonder OS-sandbox) |
| **Windows** | 1. **Scoop** (JSON-manifest in eigen Git-bucket — makkelijkst te automatiseren)<br>2. **Winget** (officiële Windows Package Manager)<br>3. PowerShell install-script (`irm ... \| iex`) + `.msi`/`.zip` | Cross-compiled native PE-binary (`x86_64-pc-windows-msvc`). | 1. **WSL2** (delegeer agent-shell naar Linux `bwrap` in WSL)<br>2. **Docker Desktop / Podman** — container-isolatie voor agent-exec<br>3. **Windows AppContainer / Job Objects** of strikte pad-allowlist fallback |

## Randgevallen

- **Linux AppArmor op recente distro's (Ubuntu 24.04+):** Unprivileged user namespaces kunnen standaard geblokkeerd zijn voor `bwrap`; opvangen met een duidelijke foutmelding, AppArmor-profiel of fallback naar Podman/Docker.
- **Bestandspaden & regel-eindes op Windows:** Backslashes (`\`), drive-letters (`C:\`), symlinks en `CRLF` vs. `LF` mogen `2_fs_events`, `3_indexing` en `9_session_spine` niet breken (altijd `PathBuf` en genormaliseerde paden gebruiken).
- **Apple Silicon vs. Intel & Gatekeeper:** macOS-binaries uit GitHub Releases kunnen geblokkeerd worden door macOS Gatekeeper / quarantine-flags (`com.apple.quarantine`) als ze niet door Apple zijn genotariseerd; documenteer `xattr -d` of configureer code-signing in CI.
- **File-watching limieten (`2_fs_events`):** `FSEvents` (macOS) en `ReadDirectoryChangesW` (Windows) gedragen zich anders bij bulk-wijzigingen (zoals `git checkout`) dan Linux `inotify` (debouncing nodig per platform).

## Bewust niet

- Multi-platform support bouwen vóórdat Arch Linux + Hyprland v1 stabiel en dagelijks bruikbaar is.
- Electron-wrappers of web-apps bouwen om cross-platform UI-werk te ontwijken.
- Handmatig losse releases compileren, testen en uploaden bij elke update.