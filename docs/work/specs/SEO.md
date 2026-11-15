### Hoe verbeter je de vindbaarheid (SEO) van je package?

GitHub, Google en package managers (AUR, Homebrew, crates.io) indexeren op specifieke plekken. Zo zorg je dat mensen die zoeken op lichtgewicht Zed/Cursor-alternatieven bij jou uitkomen:

- GitHub Repository Topics & Description: Vul in de rechterzijbalk van je GitHub-repo de About-beschrijving in met exacte zoektermen (bijv. "Lightweight native AI coding harness & project structure engine for Zed on Linux/Arch (BYOK, bwrap sandbox)") en voeg 8–12 Topics toe: zed-editor, ai-coding-assistant, agent-harness, rust, arch-linux, byok, mcp, bubblewrap, developer-tools.

- De eerste 150 woorden van je README.md: Google weegt de <h1> titel, de eerste alinea en de <h2> koppen het zwaarst. Gebruik daarin natuurlijke termen waarop mensen zoeken ("Cursor alternative without Electron", "Zed agent harness", "local-first codebase indexing").

- Cross-linking via ecosysteem-lijsten: Zodra v1 stabiel draait, kun je een Pull Request indienen bij relevante awesome-* lijsten op GitHub (zoals awesome-zed, awesome-mcp, awesome-ai-coding) en een korte technische post plaatsen op Reddit (r/archlinux, r/rust, r/LocalLLaMA) of Hacker News (Show HN). Eén link vanaf een populaire awesome-lijst geeft je repo direct autoriteit in Google.

- Package Manager Metadata: Zorg dat in je Arch PKGBUILD (pkgdesc=...) en Homebrew Formula (desc "...") dezelfde heldere kernwoorden staan, zodat yay -Ss agent of brew search zed jouw package direct tonen.