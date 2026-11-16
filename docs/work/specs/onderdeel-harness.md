# Spec — onderdeel-harness

> **Rol:** Keuzes voor de agent-loop. H1–H5 zijn beslist in [ADR 0003](../../decisions/0003-de-agent-loop-is-upstream-deepseek-harness-gepind-als-dsh-profile-acp-zonder-fork.md).
> **Kaart:** [totaalproduct.md](../../product/totaalproduct.md) · bronnen §76 Pi, §77 DSH

- **Item:** [BACKLOG.md](../BACKLOG.md)
- **Status:** beslist — [ADR 0003](../../decisions/0003-de-agent-loop-is-upstream-deepseek-harness-gepind-als-dsh-profile-acp-zonder-fork.md). Smoke nog open.
- **Product (bijhouden):** [../../product/harness.md](../../product/harness.md)
- **Besluit:** DeepSeek Harness (`dsh --profile acp`), upstream, geen fork. Zelfde patroon als [ADR 0002](../../decisions/0002-de-ide-shell-is-upstream-zed-opgehaald-als-pinned-release-zonder-fork.md). Pi alleen als ACP-smoke later faalt. Geen DeepInfer.

## Wat het is

Loop: model ↔ tools ↔ permissions ↔ session-log. Host voor indexing-tools (MCP) en structure-hooks. **≠** IDE; **≠** indexing. **≠** Zed Agent.

Upstream (niveau C, docs): `dsh --profile acp` is een ACP-server; de MCP-client hangt tools in de loop. Dat is genoeg om te kiezen in plaats van een nieuw literatuurprogramma. A2 (§77) is gedaan.

## Opties (kort)

| Kandidaat | Sterkte | Risico |
|-----------|---------|--------|
| **DSH** (§77) — gekozen | ACP + MCP + plugins + DeepSeek-fit, MIT | Preview/breaking; breder dan lab-minimum |
| **Pi** (§76) | Minimaal, TS, SDK/RPC | Alleen fallback als Zed DSH niet start of MCP niet mount |
| Eigen dunne loop | Max controle | Heruitvinden; niet gekozen |

Of antwoorden beter zijn dan Zed Agent is geen feit tot een smoke (zelfde taak, beide paden). De hypothese staat in [totaalproduct](../../product/totaalproduct.md).

## Stappenplan

Eén stap per sessie. Uitkomst in [harness.md](../../product/harness.md). [ADR 0001](../../decisions/0001-runtime-stack-bewust-uitgesteld-tot-expliciete-pi-of-ts-keuze.md) blijft gelden voor eigen app-code: geen `apps/` en geen `--starter`.

### Stap A — Voorstel (gedaan)

1. H1: basis = DSH.
2. H2: apart process. Zed praat ACP. De harness gaat niet in de Zed-binary.
3. H3: profile `acp`.
4. H4: indexing blijft de externe MCP uit het indexing-contract.
5. H5: upstream volgen. Een fork vraagt een latere, eigen ja.

### Stap B — ADR (gedaan)

Ja op H1–H5: [ADR 0003](../../decisions/0003-de-agent-loop-is-upstream-deepseek-harness-gepind-als-dsh-profile-acp-zonder-fork.md). LLM-default en tool-whitelist gaan mee. Die ADR is geen runtime-keuze voor eigen code en maakt geen generator vrij.

### Stap C — Smoke (pas bij een volledige applicatie)

Niet de volgende slice. Zodra er een applicatie is die getest kan worden: Zed start `dsh --profile acp` en mount één MCP. Faalt dat, dan pas Pi opnieuw als voorstel.

## Open beslissingen

| # | Vraag | Stand | Blokkeert |
|---|-------|--------|-----------|
| H1 | Basis? | beslist — DSH | — |
| H2 | Embed vs apart + ACP? | beslist — apart + ACP | — |
| H3 | Profile? | beslist — `acp` | — |
| H4 | Indexing plugin vs MCP? | beslist — externe MCP | indexing-contract nog uit te werken |
| H5 | Upstream vs fork? | beslist — upstream | — |

## Acceptatie (later)

- [x] Ja op H1 + H2, daarna ADR — [0003](../../decisions/0003-de-agent-loop-is-upstream-deepseek-harness-gepind-als-dsh-profile-acp-zonder-fork.md)
- [x] Geen generators/`apps` in deze ADR ([0001](../../decisions/0001-runtime-stack-bewust-uitgesteld-tot-expliciete-pi-of-ts-keuze.md) blijft)
- [ ] ACP-smoke, pas bij een volledige applicatie: Zed start DSH en ziet één MCP-tool
