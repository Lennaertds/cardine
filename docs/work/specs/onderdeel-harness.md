# Spec — onderdeel-harness

> **Rol:** Open keuzes voor de agent-loop.
> **Kaart:** [totaalproduct.md](../../product/totaalproduct.md) · bronnen §76 Pi, §77 DSH

- **Item:** [BACKLOG.md](../BACKLOG.md)
- **Status:** open
- **Product (bijhouden):** [../../product/harness.md](../../product/harness.md)
- **Hypothese (jij):** DeepSeek Harness (`dsh`) sterk kandidaat — plugin-model + DeepSeek-fit; Pi als leaner alternatief. Geen DeepInfer.

## Wat het is

Loop: model ↔ tools ↔ permissions ↔ session-log. Host voor indexing-tools en structure-hooks. **≠** IDE; **≠** indexing.

## Opties (kort)

| Kandidaat | Sterkte | Risico |
|-----------|---------|--------|
| **DSH** (§77) | Plugins, UI, DeepSeek-ecosysteem, MIT | Preview/breaking; breder dan lab-minimum |
| **Pi** (§76) | Minimaal, TS, SDK/RPC embed | Minder “product UI”; zelf meer lijmen |
| Eigen dunne loop | Max controle | Heruitvinden; traag |

Complexiteit “specifiek voor DeepSeek-model” leeft deels in **prompts/tools/harness-tuning**, deels in het model zelf — forken van DSH = die tuning meenemen; lock-in bewust houden (LLM-spec laat andere providers toe).

## Stappenplan

Wacht op het X2-voorstel en het fs-events-contract. Eén stap per sessie. Uitkomst in [harness.md](../../product/harness.md). [ADR 0001](../../decisions/0001-runtime-stack-bewust-uitgesteld-tot-expliciete-pi-of-ts-keuze.md) blijft gelden tot een ja op H1 en H2: geen `apps/` en geen `--starter`.

### Stap A — DSH en Pi op papier

1. Lees de upstream-docs van DSH (§77) en Pi (§76). Per kandidaat: licentie, hoe een externe MCP-tool wordt aangeroepen, of er een ACP-server is die Zed kan starten, en of headless kan.
2. H1: voorstel voor de basis. De neiging is DSH. Pi wordt het voorstel als de MCP- of ACP-oppervlakte daar dunner is.
3. H2: apart process. Zed praat ACP, zoals [ADR 0002](../../decisions/0002-de-ide-shell-is-upstream-zed-opgehaald-als-pinned-release-zonder-fork.md). De harness gaat niet in de Zed-binary.
4. H4: indexing blijft de externe MCP uit X2.
5. H5: upstream volgen. Een fork vraagt een latere, eigen ja.
6. H3 (headless, web of sdk) volgt uit H1.

### Stap B — ADR

Vraag ja op H1 en H2 samen. Pas die ADR, samen met een expliciete runtime-keuze, mag code en een generator.

## Open beslissingen

| # | Vraag | Opties | Blokkeert |
|---|-------|--------|-----------|
| H1 | Basis? | DSH / Pi / ander / eigen | stack |
| H2 | Embed in IDE vs aparte process + ACP/RPC? | | I1, Agent-UI |
| H3 | Profile: headless vs web vs sdk-minimal? | DSH-templates | overhead |
| H4 | Indexing als plugin vs externe MCP? | | X2 |
| H5 | Upstream track vs fork? | observeren tot stabiel / fork nu | onderhoud |

## Acceptatie (later)

- [ ] H1 + H2 ADR
- [ ] Geen generators/`apps` vóór die ADR (0001)
