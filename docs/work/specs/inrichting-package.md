### Heeft een meta-package ook een README enzo zoals een Git-repo?

Ja. Jouw meta-package is in de praktijk een publieke Git-repository (bijvoorbeeld lennaertds/cardine) die de installatie-bestanden bevat (PKGBUILD voor de Arch AUR, Formula/cardine.rb voor Homebrew, cardine.json voor Scoop, en de lockfile die de officiële Zed-versie koppelt aan jouw cardine-core binary).

Wat er standaard in die repo thuishoort:

- README.md: Je visitekaartje. Wat Cardine is, een architectuur-diagram (Mermaid), installatie-commando's per OS, en hoe de koppeling met Zed werkt.

- LICENSE: Bijvoorbeeld MIT of Apache-2.0 voor de meta-package en scripts, terwijl je daarin expliciet vermeldt dat de cardine-core binary onder een eigen licentie valt (source-available of proprietary).

- CHANGELOG.md & releases.toml / lockfile: Zodat gebruikers zien welke Zed-versie getest is met welke cardine-core-versie.

- docs/ (beknopt): Installatiegidsen, configuratie van BYOK-keys (DeepSeek/Anthropic), en troubleshooting (zoals bwrap-permissies).