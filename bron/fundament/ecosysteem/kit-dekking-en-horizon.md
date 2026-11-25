# Kit-dekking en horizon — wat een project nodig kan hebben

> **Rol:** Inventaris: wat de kit/standaard nú dekt vs. open behoeften en losse ideeën om later uit te werken. Geen kit-wijziging vanuit dit bestand alleen — eerst §/brug + akkoord.
> **Niet hier:** operationele Make-tabel ([standaard/makefile](../../../standard/makefile.md)); modulelijst ([kit/README](../../../kit/README.md)).

Stand: oktober 2026 (na Strix + observability in kern/module). Herzien wanneer de kit groeit of na een bootstrap-ronde op GymFreak/Caddie.

## Legende

| Status | Betekenis |
|--------|-----------|
| **In kit** | Docs en/of Make/module/stack bestaan |
| **Deels** | Plaats of principe er, tooling/afspraak nog dun |
| **Niet** | Nog geen vaste plek in kit — hier of in BACKLOG parkeren |
| **Horizon** | Idee om later uit te werken; geen actie nu |

---

## A. Wat we wél hebben (kort)

### Lagen

| Laag | Dekking |
|------|---------|
| `kern` | README, AGENTS, Makefile, pre-commit, docs-kaart, CONTEXT/RULES/GLOSSARY, ARCHITECTURE, **security** (+ Strix), **observability** (docs), **performance**, **dependencies** (+ `deps-audit`), **polyglot** (+ voorbeeld-ADR), how-to’s, data-lagen, check-links |
| `solo` / `team` | BACKLOG/specs/logs vs issues + CI |
| Modules | vision, assignment, product, design, research, business, agent, deliverables, meetings, archive, herordening, compose, **observability** (LGTM), packages, infra, runtime, models, cursor, claude |
| Stacks | next, nest, python, sql (+ starter) |

### Make (vaste namen)

`help`, `setup`, `env`, `doctor`, `dev`, `up`/`down`/`logs`, `status`, `check`, `check-full` (incl. **`deps-audit`** + **`native-bindings-strict`**), `links`, `smoke`, `fmt`, `build`, **`security-scan*`**, **`obs-*`**, **`perf-check`** / **`bench`**, **`polyglot-check`**, **`radar-*`** / **`digest-*`** (module research), `data`, `seed`, `db-reset`, docs-targets (`adr`, `spec`, `log`, …), `docs-health`, `clean`.

### Agent / kwaliteit (principes, niet altijd tooling)

P2/P5 JIT-docs · P13 verify · P14 deterministisch · P17 security · P22 intent · P23 seams/deep modules · P25 harness tax · P26 modelkeuze · anti-slop via §2/§32.

---

## B. Wat een project nog kan nodig hebben — gesorteerd

### 1. Runtime-kwaliteit & risico

| Behoefte | Status | Nu / gat |
|----------|--------|----------|
| Security (dreigingen, secrets, auth) | **In kit** | `security.md` |
| Actieve pentest | **In kit** | Strix + `make security-scan*` (runtime vaak BACKLOG) |
| Observability (logs/metrics/traces/SLO) | **In kit** | `observability.md` + module LGTM |
| **Performance — waarnemen** | **Deels** | Via obs (latency, RED); koppeling in `performance.md` |
| **Performance — bouwen (vanaf dag 1)** | **In kit** | `performance.md`, `make perf-check` / `bench`, stubs per stack; echte `scripts/bench.sh` per app nog in te vullen |
| Load / stress / chaos | **Niet** | Geen k6/Locust/… target |
| Accessibility (product-UI) | **Deels** | design-module `shared/a11y`; geen enforce in `check` |
| Privacy / AVG operationeel | **Deels** | security + business-module; geen DPA-checklist in kern |
| Backup / restore / DR | **Niet** | — |
| Feature flags / kill switches | **Niet** | — |

### 2. Codekwaliteit & maintainability

| Behoefte | Status | Nu / gat |
|----------|--------|----------|
| Lint/types/unit in `make check` | **In kit** | per stack |
| Integratie/e2e in `check-full` | **In kit** | deels per stack |
| Seams / deep modules / geen spekulatieve `utils/` | **In kit** | AGENTS + P23 |
| Dependency-audit (CVE, license) | **In kit** (CVE) | `dependencies.md` + `make deps-audit` (in `check-full`); license-gate → BACKLOG |
| **Package-compromissen / snellere alternatieven** | **Deels** | Ritueel in `dependencies.md`; radar + digest-propose in module research |
| SBOM / supply chain | **Niet** | — |
| API-/contract-tests tussen apps | **Deels** | `tests/` over apps heen ○ in skelet; weinig standaard-inhoud |
| Migratie-discipline | **Deels** | nest/sql stacks; geen generieke “expand-contract” how-to |

### 3. Talen, runtimes, polyglot

| Behoefte | Status | Nu / gat |
|----------|--------|----------|
| JS/TS (Next), Nest, Python, SQL, Rust, C (native) | **In kit** | stacks; Rust/C opt-in + FFI-starters |
| **Rust / C / andere systemstalen** | **In kit** (opt-in) | `rust` + `c` stacks; FFI-scaffolds Node/Python |
| Polyglot-grenzen (FFI, sidecar) | **In kit** | Docs + scaffolds; soft/`NATIVE_STRICT` + `native.yml`; sidecar → Bewust later |
| Runtime-versies vastzetten | **Deels** | `.tool-versions` ○ in skelet; niet overal afgedwongen |
| Welke taal voor welk hot path | **Horizon** | Beslisboom + meting (obs/bench), niet “Python default forever” |

### 4. Data, ML, AI-in-product

| Behoefte | Status | Nu / gat |
|----------|--------|----------|
| Datalagen raw→processed | **In kit** | |
| Models-map | **In kit** | module `models` |
| Evaluatie agent/docs | **In kit** | `meten/` (naast project) |
| LLM-cost/latency in product | **Deels** | P25/P26; geen standaard cost-dashboard |
| Prompt/skill-supply-chain | **Deels** | fundament skills-veiligheid; geen kit-hook |

### 5. Leveren & operatie

| Behoefte | Status | Nu / gat |
|----------|--------|----------|
| Lokale compose (DB) | **In kit** | |
| CI `make check` | **In kit** | team |
| Deploy-pipeline | **Deels** | how-to ○; geen vaste `deploy.yml` |
| Environments (staging/prod) | **Deels** | smoke URL=; geen env-matrix-doc |
| Secrets management (prod) | **Deels** | security.md; geen Vault/… module |
| Runbooks / on-call | **Niet** | deels via how-to + obs alerts |

### 6. Mens & proces

| Behoefte | Status | Nu / gat |
|----------|--------|----------|
| Solo spine BACKLOG | **In kit** | |
| ADR’s | **In kit** | |
| Research/wantlist | **In kit** | module |
| **Tech-radar / periodieke herijking** | **In kit** (module research) | `radar.md` + `make radar-check` / `radar-reminder`; geen scrapers |
| **Inbound nieuws/papers-digest** | **In kit** | `digest-fetch` / `digest-propose` + team draft-PR; geen auto-radar (P5) |

---

## C. Horizon-ideeën (uit gesprek — uitwerken later)

Niet implementeren nu. Wel bewaren zodat we kunnen terugvallen.

### C1. Performance: waarnemen vs. vanaf dag 1 goed bouwen

- **Waarnemen:** observability (latency p95, saturatie, profiles) — pad bestaat deels.
- **Bouwen:** aparte afspraak nodig, bv. `docs/architecture/performance.md` of sectie in ARCHITECTURE: budgets (p95 &lt; X), verboden patronen (N+1, sync in request path), wanneer Rust/C voor hot path, `make bench` smoke.
- Vraag om later te beantwoorden: wat moet in AGENTS (kort) vs. alleen in architecture (JIT)?

### C2. Maintainability + dependency hygiene

- ~~Ritueel + `make deps-audit`~~ → **in kit** (okt 2026): `dependencies.md`, how-to, in `check-full`.
- Track “snellere alternatieven” via `docs/research/radar.md` / wantlist (module research) — niet always-on in AGENTS.
- Compromissen (license, maintenance, CVE) vastleggen als ADR als je bewust een zwakkere dep houdt.
- License-allowed-list / SBOM: nog niet.

### C3. Taalkeuze (Python vs Rust/C, …)

- ~~ADR/AGENTS-patroon + beslisboom~~ → **in kit** (okt 2026).
- ~~Rust-stack + napi-starter~~ → **in kit** (okt 2026).
- ~~PyO3-scaffold naast napi~~ → **in kit** (okt 2026).
- ~~C-stack + N-API/ctypes~~ → **in kit** (okt 2026).
- ~~Harde native CI (`NATIVE_STRICT` / `check-full` / `native.yml`)~~ → **in kit** (okt 2026); volledige kit-`build.rs`/node-gyp-starter → Bewust later.
- Beslisboom: meet eerst (obs/bench), dan taal — niet hype.

### C4. Up-to-date blijven (radar / digest)

1. **Mens + internet:** jij volgt bronnen; interessante hits → eerst `bron/bronnen.md` (§), dan brug. *(ongewijzigd)*
2. ~~Tech-radar Markdown + maandelijks ritueel~~ → **in kit** (okt 2026).
3. ~~Digest-scaffold + fetch-stub~~ → **in kit** (okt 2026).
4. ~~Live HTTP/RSS + propose + draft-PR~~ → **in kit** (okt 2026); auto-merge naar radar / LLM-samenvatting → Bewust later (P5).

### C5. Meta-les (Strix/obs laat)

Belangrijke dingen (security-scan, observability) hoorden eigenlijk vroeg in de standaard. Gebruik deze inventaris om **bewust** te prioriteren wat nog “mega belangrijk maar nog niet in kit” is — performance-first en polyglot staan hoog op die lijst om te onderzoeken, niet meteen te bouwen.

### C6. Spoor 3 — IDE-/harness-lab (sibling-repo)

- **Repo:** `cardine` (sibling-repo, niet nested in deze tree). Workspace: `Student_Zelfstandige/Agent+Cardine.code-workspace`.
- **Doel:** experimentele coding-agent/IDE met sterkere projectstructuur-integratie (indexing, structurele retrieval, …) — leerproject / mogelijk bachelor.
- **Niet in kit:** Pi, DeepSeek Harness, eigen indexer — eerst § in `bron/`, dan brug. Lessen uit spoor 3 → spoor 2 → eventueel spoor 1.
- **Meten:** zie [meten/INDEX — TODO sporen](../../../measurement/INDEX.md#todo--sporen-vergelijken-okt-2026).

---

## D. Mogelijke volgende uitwerk-slices (alleen na brug)

1. ~~Performance-doc + bench/perf-check~~ → **gedaan** (okt 2026); echte `bench.sh` per app + heuristische scan nog open.
2. ~~`deps-audit`~~ → **gedaan** (okt 2026); license-gate / SBOM nog open.
3. ~~polyglot-ADR-patroon~~ → **gedaan** (okt 2026).
4. ~~Tech-radar MVP~~ → **gedaan** (okt 2026).
5. ~~Rust-stack (napi)~~ → **gedaan** (okt 2026).
6. ~~Digest-scaffold + stub~~ → **gedaan** (okt 2026).
7. ~~PyO3 naast napi~~ → **gedaan** (okt 2026).
8. ~~C-stack (N-API + ctypes)~~ → **gedaan** (okt 2026).
9. ~~Harde native CI~~ → **gedaan** (okt 2026).
10. ~~Live digest A3 (fetch/propose/draft-PR)~~ → **gedaan** (okt 2026); license-gate/SBOM, load/chaos, … nog open.

**Geen actie** tot jij een slice kiest en de brug-checklist invult. Uitwerken = interview-first (zie root-`AGENTS.md` § Soort opdracht).
