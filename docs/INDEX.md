# Cardine — docs-kaart

> Eén ingang voor alle documentatie. Kies het bestand bij je vraag en open alleen dat.
> Werkwijze en commando's: [AGENTS.md](../AGENTS.md).

## Context — waarom en voor wie

- [CONTEXT.md](context/CONTEXT.md) — Domein, gebruiker of klant, doel, scope. Niet: techniek.
- [GLOSSARY.md](context/GLOSSARY.md) — Wat een term betekent en hoe hij in de code heet. Ook de lijst van domeinen.

## Regels — wat nooit mag

- [RULES.md](rules/RULES.md) — Inhoudelijke grenzen. Niet: codestijl of werkwijze.

## Product — wat het doet

- [PRODUCT.md](product/PRODUCT.md) — Overzicht + wat bewust niet.
- [totaalproduct.md](product/totaalproduct.md) — Hoe de 9 onderdelen samenhangen.
- Per onderdeel (bijhouden): [ide-shell](product/ide-shell.md) · [fs-events](product/fs-events.md) · [indexing](product/indexing.md) · [tools](product/tools.md) · [harness](product/harness.md) · [llm](product/llm.md) · [structure](product/structure.md) · [agent-ui](product/agent-ui.md) · [session-spine](product/session-spine.md).

## Architectuur — hoe het in elkaar zit

- [ARCHITECTURE.md](architecture/ARCHITECTURE.md) — Containers, stack, dataflow, invarianten, seams, hosting. Start hier voor "waar zit X". Niet: PWA/auth-catalogus → subsystemen.
- [security.md](architecture/security.md) — Persoonsgegevens, secrets, auth-principes, Strix. Uitbreidingen: `## Bewust later`.
- [observability.md](architecture/observability.md) — Signalen, LGTM, `make obs-*` (opt-in; alleen als de opdracht het noemt).
- [performance.md](architecture/performance.md) — Budgets, anti-patronen, `make bench` / `perf-check` (opt-in).
- [dependencies.md](architecture/dependencies.md) — CVE-audits, ritueel, `make deps-audit` (opt-in).
- [polyglot.md](architecture/polyglot.md) — Extra talen na meting + ADR; native-map alleen met die stack (opt-in).
- (Subsystemen zoals `runtime-client.md` / auth volgen na runtime-keuze indien nodig.)

## Onderzoek — wat we weten over het domein

- [RESEARCH.md](research/RESEARCH.md) — Onderzoeksvragen, hoe bronnen beoordeeld worden, kaart van `research/`. Niet laden bij codewerk.
- [Tour LLM→AE→lab](../../Agent_Engineering/bron/tour.md) — Doorlopend verhaal (spoor 2+3); niet voor codewerk.
- [onderzoek-programma.md](research/onderzoek-programma.md) — Volgorde A1…B, bronsoorten, waar § vs ADR.
- [ideeen-en-vragen.md](research/ideeen-en-vragen.md) — Ruwe vragen/hypothesen (niet kwijtraken).
- [wantlist.md](research/wantlist.md) — Bronnen die we nog willen verwerven.
- [radar.md](research/radar.md) — Tech-radar (Adopt/Trial/Assess/Hold); `make radar-reminder` / `radar-check`.
- [digest/](research/digest/README.md) — Inbound digest; `digest-fetch` / `digest-propose` (geen auto-radar).
- `research/experiments/` — Eén verslag per experiment, met datum. Zoeken met `rg`.

## How-to — een taak uitvoeren

- [security-scan.md](how-to/security-scan.md) — Strix installeren en `make security-scan` draaien.
- [perf-bench.md](how-to/perf-bench.md) — `make perf-check` / `make bench` en app-scripts.
- [deps-audit.md](how-to/deps-audit.md) — `make deps-audit` en audit-tools.
- [native-ci.md](how-to/native-ci.md) — Soft vs `NATIVE_STRICT` / `check-full` / `native.yml`.
- [radar.md](how-to/radar.md) — Tech-radar herzien (`make radar-reminder` / `radar-check`).
- [zed-dsh.md](how-to/zed-dsh.md) — Zed + DeepSeek Harness + API-key op het lab-pad.
- [digest.md](how-to/digest.md) — Digest fetch/propose (`digest-check` / `digest-fetch` / `digest-propose`).
- [sandbox-troubleshoot.md](how-to/sandbox-troubleshoot.md) — bwrap/sandbox problemen oplossen.
## Besluiten — waarom het zo is

- `decisions/` — Eén ADR per besluit. Nieuw: `make adr t="<besluit als zin>"`. Geldend:
  - [0000 — Voorbeeld native module](decisions/0000-voorbeeld-native-module-na-budget-breuk.md) — sjabloonvorm (status *voorbeeld*); kopieer via `make adr`, niet als feit gebruiken.
  - [0001 — Runtime-stack uitgesteld tot Pi/TS-keuze](decisions/0001-runtime-stack-bewust-uitgesteld-tot-expliciete-pi-of-ts-keuze.md)
  - [0002 — IDE-shell is upstream Zed, geen fork](decisions/0002-de-ide-shell-is-upstream-zed-opgehaald-als-pinned-release-zonder-fork.md)
  - [0003 — Agent-loop is upstream DeepSeek Harness, geen fork](decisions/0003-de-agent-loop-is-upstream-deepseek-harness-gepind-als-dsh-profile-acp-zonder-fork.md)
  - [0004 — Projectstandaard is dual: dunne AGENTS.md en harde make check](decisions/0004-de-projectstandaard-is-dual-een-dunne-agents-md-en-een-harde-make-check.md)
  - [0005 — Gesprek blijft de Zed- en DSH-sessie, zonder repo-spine](decisions/0005-het-gesprek-blijft-de-zed-en-dsh-sessie-zonder-repo-spine.md)
  - [0006 — Agent zoekt via jarvis; Zed-zoeken en LSP blijven](decisions/0006-de-agent-zoekt-via-jarvis-als-mcp-zed-zoeken-en-lsp-blijven-van-de-editor.md)
  - [0007 — Workspace-allowlist, shell onder bwrap](decisions/0007-tool-goedkeuring-is-een-workspace-allowlist-en-de-shell-draait-onder-bwrap.md)
  - [0008 — Coding-model is deepseek-flash, Claude is de tweede](decisions/0008-het-coding-model-is-deepseek-flash-en-claude-is-de-tweede-provider.md) — geldt voor het API-key-pad
  - [0009 — Product is de gratis projectstructuur en een gids](decisions/0009-het-product-is-de-gratis-projectstructuur-en-een-gids-naar-de-agent-paden.md)
  - [0010 — Meta-package wijst naar losse packages en drie Zed-paden](decisions/0010-de-meta-package-wijst-naar-losse-packages-voor-structuur-en-drie-zed-paden.md)
  - [0011 — Stack volgt op beslissingsdocs en een catalogus](decisions/0011-de-stack-volgt-op-beslissingsdocs-en-een-goedkeuring-tegen-een-catalogus.md)
  - [0012 — Eerst de persoonlijke stack op Arch Linux Hyprland](decisions/0012-de-eerstvolgende-voltooiing-is-de-persoonlijke-stack-op-arch-linux-hyprland.md)
  - [0013 — Cardine is het publieke uithangbord en pullt de structure](decisions/0013-cardine-is-het-publieke-uithangbord-en-pullt-de-structure-uit-agent-engineering.md)
## Werk — status (niet vooraf lezen)

- [BACKLOG.md](work/BACKLOG.md) — Index van open werk (korte regel + link). Nieuw item: `make spec s=<slug>`.
- `work/specs/` — Plan per item; na merge weg.
- `work/logs/` — Dag-logs. Zoeken met `rg`, niet laden.

## Packages — ontwerpdocumentatie

- [packages/INDEX.md](packages/INDEX.md) — Overzicht van alle packages
- [packages/cardine-lab.md](packages/cardine-lab.md) — cardine-lab package
- [packages/cardine-structure.md](packages/cardine-structure.md) — cardine-structure package
- [packages/cardine-zed-dsh.md](packages/cardine-zed-dsh.md) — cardine-zed-dsh package
- [packages/cardine-meta.md](packages/cardine-meta.md) — Meta-package cardine
- [packages/VERSIONING.md](packages/VERSIONING.md) — Versiebeheer en changelogs

## Agent — alleen bij schrijven of meta-taken

- [write-rules.md](agent/write-rules.md) — Welke paden vrij, welke na toestemming.
- [doc-conventions.md](agent/doc-conventions.md) — Hoe je een doc schrijft.
- [lessons.md](agent/lessons.md) — Lessen na mislukkingen bij meta-taken.

## Data

- [data/README.md](../data/README.md) — Welke dataset waar staat, herkomst, licentie, wat in git mag.
