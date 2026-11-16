# 0004 — De projectstandaard is dual: een dunne AGENTS.md en een harde make check

- **Status:** aanvaard
- **Datum:** 2026-11-16
- **Raakt:** [structure.md](../product/structure.md), [onderdeel-structure](../work/specs/onderdeel-structure.md), [totaalproduct.md](../product/totaalproduct.md), [PRODUCT.md](../product/PRODUCT.md), [BACKLOG.md](../work/BACKLOG.md). [0001](0001-runtime-stack-bewust-uitgesteld-tot-expliciete-pi-of-ts-keuze.md) en [0003](0003-de-agent-loop-is-upstream-deepseek-harness-gepind-als-dsh-profile-acp-zonder-fork.md) blijven gelden.

## Samenvatting

In de context van een agent die projectregels anders negeert, geconfronteerd met instructiebestanden die alleen prose zijn, kozen we voor een dunne `AGENTS.md` plus harde `make check` en twee haken op DeepSeek Harness, en tegen een tweede instructielaag naast Zed Instructions, om een rode check de slice te laten blokkeren, en we aanvaarden dat die haken pas meetbaar zijn als er een applicatie is.

## Context

- Zed Instructions, Cursor-rules en `CLAUDE.md` zijn standing text. Het model kan ze meenemen en ze ook negeren (§107, §115).
- Claude Code beschrijft de juiste verdeling al: “altijd” en “nooit” horen in een hook, niet in het instructiebestand (§114). Codex houdt `AGENTS.md` op een korte inhoudsopgave en dwingt de rest met checks (§113).
- DeepSeek Harness leest ook `AGENTS.md` (§77). De waterfall `tools/pre-execute` is de plek vóór een tool. Een Stop-event noemt §77 niet.
- [0001](0001-runtime-stack-bewust-uitgesteld-tot-expliciete-pi-of-ts-keuze.md) laat `make check` rood zolang er geen app is.

## Besluit

De projectstandaard is dual.

- `AGENTS.md` blijft de kaart: kort, intent, en waar de rest staat. Een verbod dat een check kan afdwingen, staat niet alleen in prose. Er komt geen tweede prose-laag naast Zed Instructions.
- Harde grenzen blijven in `make check` en [RULES.md](../rules/RULES.md).
- Vóór een schrijf-tool geldt de workspace-allowlist, op `tools/pre-execute`. Aan het eind van een slice draait `make check`. Een rode check sluit de slice niet: fix, of zet de slice terug.
- Always-on zijn `AGENTS.md`, `RULES.md` en de productdoc van het onderdeel waar de slice over gaat. De rest wordt gelezen wanneer de slice dat bestand raakt.

Binnen de workspace vraagt de agent niet bij elke edit. Buiten de map stopt hij. Dat is [0007](0007-tool-goedkeuring-is-een-workspace-allowlist-en-de-shell-draait-onder-bwrap.md). Deze ADR schrijft geen hook-code.

## Alternatieven

| Optie | Waarom niet |
|-------|-------------|
| Alleen een langer instructiebestand | Zelfde kanaal als Zed, Cursor en Claude-prose; het model mag het negeren |
| Alleen checks, geen kaart | De intent is dan onleesbaar voor de mens |
| Hooks als optie die je zelf aanzet | Dan is de ladder geen productregel; een rode check kan de slice alsnog sluiten |
| Tweede rules-bestand naast Zed Instructions | Twee prose-lagen voor hetzelfde |

## Gevolgen

- **Makkelijker:** de slice heeft een stop die niet van het model afhangt. De kaart blijft dun.
- **Moeilijker of risico:** de haken zijn nog papier. Tot er een applicatie is, blijft `make check` rood door [0001](0001-runtime-stack-bewust-uitgesteld-tot-expliciete-pi-of-ts-keuze.md), niet door een falende slice.
- **Te doen:** hook-code pas met de applicatie. Goedkeuring en `bwrap` staan in [0007](0007-tool-goedkeuring-is-een-workspace-allowlist-en-de-shell-draait-onder-bwrap.md).
