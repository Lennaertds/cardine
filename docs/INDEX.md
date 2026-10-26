# IDE_Agentic — docs-kaart

> Eén ingang voor alle documentatie. Kies het bestand bij je vraag en open alleen dat.
> Werkwijze en commando's: [AGENTS.md](../AGENTS.md).

## Context — waarom en voor wie

- [CONTEXT.md](context/CONTEXT.md) — Domein, gebruiker of klant, doel, scope. Niet: techniek.
- [GLOSSARY.md](context/GLOSSARY.md) — Wat een term betekent en hoe hij in de code heet. Ook de lijst van domeinen.

## Regels — wat nooit mag

- [RULES.md](rules/RULES.md) — Inhoudelijke grenzen. Niet: codestijl of werkwijze.

## Product — wat het doet

- [PRODUCT.md](product/PRODUCT.md) — Domeinen en wat bewust niet. Per domein één bestand: `product/<domein>.md`.

## Architectuur — hoe het in elkaar zit

- [ARCHITECTURE.md](architecture/ARCHITECTURE.md) — Containers, stack, dataflow, invarianten, seams, hosting. Start hier voor "waar zit X". Niet: PWA/auth-catalogus → subsystemen.
- [security.md](architecture/security.md) — Persoonsgegevens, secrets, auth-principes, Strix. Uitbreidingen: `## Bewust later`.
- [observability.md](architecture/observability.md) — Signalen, LGTM, `make obs-*` (opt-in; AGENTS keyword-tabel).
- [performance.md](architecture/performance.md) — Budgets, anti-patronen, `make bench` / `perf-check` (opt-in).
- [dependencies.md](architecture/dependencies.md) — CVE-audits, ritueel, `make deps-audit` (opt-in).
- [polyglot.md](architecture/polyglot.md) — Extra talen na meting + ADR; native-map alleen met die stack (opt-in).
- (Subsystemen zoals `runtime-client.md` / auth volgen na runtime-keuze indien nodig.)

## Onderzoek — wat we weten over het domein

- [RESEARCH.md](research/RESEARCH.md) — Onderzoeksvragen, hoe bronnen beoordeeld worden, kaart van `research/`. Niet laden bij codewerk.
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
- [digest.md](how-to/digest.md) — Digest fetch/propose (`digest-check` / `digest-fetch` / `digest-propose`).
## Besluiten — waarom het zo is

- `decisions/` — Eén ADR per besluit. Nieuw: `make adr t="<besluit als zin>"`. Geldend:
  - [0000 — Voorbeeld native module](decisions/0000-voorbeeld-native-module-na-budget-breuk.md) — sjabloonvorm (status *voorbeeld*); kopieer via `make adr`, niet als feit gebruiken.
  - [0001 — Runtime-stack uitgesteld tot Pi/TS-keuze](decisions/0001-runtime-stack-bewust-uitgesteld-tot-expliciete-pi-of-ts-keuze.md)
## Werk — status (niet vooraf lezen)

- [BACKLOG.md](work/BACKLOG.md) — Open werk. De opdracht noemt het item.
- `work/specs/` — Eén plan per item; na merge weg.
- `work/logs/` — Dag-logs. Zoeken met `rg`, niet laden.

## Agent — alleen bij schrijven of meta-taken

- [write-rules.md](agent/write-rules.md) — Welke paden vrij, welke na toestemming.
- [doc-conventions.md](agent/doc-conventions.md) — Hoe je een doc schrijft.
- [lessons.md](agent/lessons.md) — Lessen na mislukkingen bij meta-taken.

## Data

- [data/README.md](../data/README.md) — Welke dataset waar staat, herkomst, licentie, wat in git mag.
