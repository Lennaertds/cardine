# Context

> **Rol:** Waarom dit project bestaat (**Cardine**), voor wie, en wat succes is.
> **Niet hier:** techniek ([ARCHITECTURE.md](../architecture/ARCHITECTURE.md)), inhoudelijke grenzen ([RULES.md](../rules/RULES.md)).

## Naam & Filosofie (Cardine)

- **Herkomst:** *Cardine* is de Latijnse ablatief van *cardo* (de spil, het scharnier, de hoofdas waar een stad of constructie omheen is gebouwd). De ablatief drukt het middel en uitgangspunt uit: *"waarmee en vanuit waar alles scharniert"*.
- **Filosofie:** Cardine probeert geen nieuwe alles-in-één editor te zijn, maar vormt het lichte, centrale scharnierpunt tussen een bestaande native editor (**Zed**), lokale project-indexing, strikte structuurregels (*Agent Engineering*) en externe LLM's (BYOK).
- **Ontwerpprincipe:** Minimale overhead, volledige lokale controle, geen eigen IDE-fork onderhouden, en een heldere scheiding tussen een transparante **open-source meta-package** (versiebeheer en koppeling) en een snelle, zelfgebouwde **closed-source core-binary** (`cardine-core`) met geïsoleerde tool-uitvoering (`bwrap`).

## Gebruiker of klant

**Nu:** solo-ontwikkelaar (Ventje) — lokaal lab, plus later een thesis-lezer die metingen en keuzes moet kunnen volgen.

**Later (als het lab echt goed is):** dezelfde tool als portfolio-stuk en als gratis applicatie voor vrienden en hobbyisten — gedistribueerd via een open meta-package + closed-source core-binary. Geen betalende SaaS of cloud-afhankelijkheid als uitgangspunt.

## Probleem

Bestaande IDE’s en agent-tools (bv. Cursor) koppelen slecht of niet-reproduceerbaar aan een strakke projectstandaard (spoor 1 kit + spoor 2 bron in Agent_Engineering). Cursor als VS Code-fork draagt bovendien Electron- en feature-overhead die jij niet nodig hebt. Er ontbreekt een *lichte*, lokaal meetbare stack (IDE-shell + indexing + harness + structure) die wél op *jouw* workflow past.

## Doel en wat succes is

- **Lab / persoonlijk product (nu):** lokaal (op Arch/Hyprland) een stack die *voor jou* productiever is dan Cursor — lage overhead, Zed als non-Electron host, BYOK-LLM (DeepSeek/Claude), indexing op jouw use-case, standaard afgedwongen. Kaart: [totaalproduct.md](../product/totaalproduct.md).
- **Thesis:** later toetsbaar doel op hetzelfde lab (diepte elders).
- **Product (toekomst, voorwaardelijk):** als kwaliteit het waard is → portfolio én release als gratis meta-package (open manifest + closed `cardine-core` binary) — pas na expliciete productisatie-keuze; tot die tijd mag het **alleen voor jou** werken.
- Geen stack/implementatie vastleggen tot expliciete ADR — tot die tijd docs + open keuzes in onderdeel-specs.

## Scope

- Domeinen: `harness`, `structure`, `indexing` (en hun scharnierwerking met `ide-shell` Zed, `fs-events`, `tools`, `llm`, `agent-ui` en `session-spine` — zie [GLOSSARY.md](GLOSSARY.md) en [PRODUCT.md](../product/PRODUCT.md)).
- Spoor 3 in het drie-sporenmodel: runtime/IDE/harness-experiment; kennis en standaard blijven in Agent_Engineering.
- **Talen:** stack-talen staan in [ARCHITECTURE.md](../architecture/ARCHITECTURE.md) — daar nog open tot ADR-keuze (met sterke voorkeur voor native compilation naar één static binary zoals Rust/Go). Extra systemstalen voor hot paths: toegestaan na meting + ADR — zie [polyglot.md](../architecture/polyglot.md).

## Bewust niet

Zie [PRODUCT.md](../product/PRODUCT.md) § Bewust niet en [RULES.md](../rules/RULES.md): nu geen productrelease/prod-hosting; geen feature-bloat; geen eigen Zed-fork onderhouden; geen zware Docker-vereiste voor de runtime zelf; geen duplicatie of overname van data/secrets uit andere projecten; lessen eerst als § in Agent_Engineering `bron/`.