# Spec — onderdeel-harness

> **Rol:** Open keuzes voor de agent-loop. H1/H2/H5 zijn een voorstel, nog geen ADR.
> **Kaart:** [totaalproduct.md](../../product/totaalproduct.md) · bronnen §76 Pi, §77 DSH

- **Item:** [BACKLOG.md](../BACKLOG.md)
- **Status:** open — voorstel klaar; wacht op ja
- **Product (bijhouden):** [../../product/harness.md](../../product/harness.md)
- **Voorstel:** DeepSeek Harness importeren (`dsh --profile acp`), upstream, geen fork. Zelfde patroon als [ADR 0002](../../decisions/0002-de-ide-shell-is-upstream-zed-opgehaald-als-pinned-release-zonder-fork.md). Pi alleen als ACP-smoke later faalt. Geen DeepInfer.

## Wat het is

Loop: model ↔ tools ↔ permissions ↔ session-log. Host voor indexing-tools (MCP) en structure-hooks. **≠** IDE; **≠** indexing. **≠** Zed Agent.

Upstream (niveau C, docs): `dsh --profile acp` is een ACP-server; de MCP-client hangt tools in de loop. Dat is genoeg om te kiezen in plaats van een nieuw literatuurprogramma. A2 (§77) is gedaan.

## Opties (kort)

| Kandidaat | Sterkte | Risico |
|-----------|---------|--------|
| **DSH** (§77) — voorstel | ACP + MCP + plugins + DeepSeek-fit, MIT | Preview/breaking; breder dan lab-minimum |
| **Pi** (§76) | Minimaal, TS, SDK/RPC | Alleen fallback als Zed DSH niet start of MCP niet mount |
| Eigen dunne loop | Max controle | Heruitvinden; niet het voorstel |

Of antwoorden beter zijn dan Zed Agent is geen feit tot een smoke (zelfde taak, beide paden). De hypothese staat in [totaalproduct](../../product/totaalproduct.md).

## Stappenplan

Eén stap per sessie. Uitkomst in [harness.md](../../product/harness.md). [ADR 0001](../../decisions/0001-runtime-stack-bewust-uitgesteld-tot-expliciete-pi-of-ts-keuze.md) blijft gelden tot een ja op H1 en H2: geen `apps/` en geen `--starter`.

### Stap A — Voorstel (papier, deze ronde)

1. H1: basis = DSH.
2. H2: apart process. Zed praat ACP. De harness gaat niet in de Zed-binary.
3. H3: profile `acp`.
4. H4: indexing blijft de externe MCP uit het indexing-contract.
5. H5: upstream volgen. Een fork vraagt een latere, eigen ja.

### Stap B — ADR

Vraag ja op H1 en H2 samen. Pas die ADR, samen met een expliciete runtime-keuze, mag code en een generator. LLM-default en tool-whitelist gaan mee in die ADR.

### Stap C — Smoke (na ja, niet nu)

Zed start `dsh --profile acp` en mount één MCP. Faalt dat, dan pas Pi opnieuw als voorstel.

## Open beslissingen

| # | Vraag | Stand | Blokkeert |
|---|-------|--------|-----------|
| H1 | Basis? | voorstel DSH | stack, tot ja |
| H2 | Embed vs apart + ACP? | voorstel apart + ACP | Agent-UI is al Zed-paneel |
| H3 | Profile? | voorstel `acp` | overhead |
| H4 | Indexing plugin vs MCP? | voorstel externe MCP | indexing-contract |
| H5 | Upstream vs fork? | voorstel upstream | onderhoud |

## Acceptatie (later)

- [ ] Ja op H1 + H2, daarna ADR
- [ ] Geen generators/`apps` vóór die ADR (0001)
- [ ] ACP-smoke: Zed start DSH en ziet één MCP-tool
