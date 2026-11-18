### Heeft een meta-package ook een README enzo zoals een Git-repo?

Distributie (2026-11-17): één meta-package wijst naar losse packages. De structuur is het product; Zed en DeepSeek Harness zijn optionele paden. Zie [ADR 0009](../../decisions/0009-het-product-is-de-gratis-projectstructuur-en-een-gids-naar-de-agent-paden.md) en [ADR 0010](../../decisions/0010-de-meta-package-wijst-naar-losse-packages-voor-structuur-en-drie-zed-paden.md). De publieke repo is het uithangbord en pullt de structure uit Agent_Engineering ([ADR 0013](../../decisions/0013-cardine-is-het-publieke-uithangbord-en-pullt-de-structure-uit-agent-engineering.md)), pas nadat de persoonlijke stapel werkt ([ADR 0012](../../decisions/0012-de-eerstvolgende-voltooiing-is-de-persoonlijke-stack-op-arch-linux-hyprland.md)). De alinea hieronder is de oudere vorm (`cardine-core`).

Ja. Jouw meta-package is in de praktijk een publieke Git-repository (bijvoorbeeld lennaertds/cardine) die de installatie-bestanden bevat (PKGBUILD voor de Arch AUR, Formula/cardine.rb voor Homebrew, cardine.json voor Scoop, en de lockfile die de officiële Zed-versie koppelt aan jouw cardine-core binary).

Wat er standaard in die repo thuishoort:

- README.md: Je visitekaartje. Wat Cardine is, een architectuur-diagram (Mermaid), installatie-commando's per OS, en hoe de koppeling met Zed werkt.

- LICENSE: Bijvoorbeeld MIT of Apache-2.0 voor de meta-package en scripts, terwijl je daarin expliciet vermeldt dat de cardine-core binary onder een eigen licentie valt (source-available of proprietary).

- CHANGELOG.md & releases.toml / lockfile: Zodat gebruikers zien welke Zed-versie getest is met welke cardine-core-versie.

- docs/ (beknopt): Installatiegidsen, configuratie van BYOK-keys (DeepSeek/Anthropic), en troubleshooting (zoals bwrap-permissies).