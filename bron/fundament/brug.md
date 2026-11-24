# Brug — van fundament naar standaard

> **Rol:** Besluitlog: welke lessen uit spoor 2 wél/niet naar spoor 1 gaan.
> **Niet hier:** de les zelf (die staat in de leerstukken) of kitbestanden.

Stand: oktober 2026.

## Regel

Fundament wijzigt `kit/` / `standaard/` niet rechtstreeks. Alleen na brugkandidaat + (bij twijfel) deletion test of meting in `meten/`.

### Checklist vóór elke kit-wijziging uit bronnen

Elk voorstel dat van een § of fundament-stuk naar spoor 1 wil, beantwoordt dit (en stopt tot de mens **ja** zegt):

| Vraag | Antwoord (verplicht) |
|-------|----------------------|
| Bron | `§n` / fundament-pad |
| Wat verandert in standaard/kit/sjabloon? | concrete bestanden |
| Optimaliseert dit GymFreak/Caddie-achtige apps? | ja/nee + waarom |
| Bewijs | meting, deletion test, of expliciete productkeuze |
| Risico | harness tax, vendor-lock, traagheid in `make check`, … |
| Alternatief: alleen § houden? | ja/nee |
| Bewuste weglatingen (P28) | wat komt in `## Bewust later` van welk architecture-doc? |

Zonder die tabel + akkoord: geen kit-edit. Zie ook [README — twee doelen](../../README.md#twee-doelen-van-deze-repo).

## Besluiten nu

| Bron | Kandidaat | Besluit |
|------|-----------|---------|
| §35 / [hybrid-agents](redeneneren/hybrid-agents.md) | HybridAgent in bootstrap/kit | **Nee** |
| §35 / hybrid-agents | Nieuw principe P28 “latent vs text” | **Nee** — gedekt door P2, P25 + fundament |
| §35 / hybrid-agents | Always-on `.mdc` met Hybrid-jargon | **Nee** |
| §35 / hybrid-agents | Analogie denken/handelen in kenniskaart + docs | **Ja** (alleen spoor 2 / verwijzingen) |
| [drie-hefbomen](efficientie/drie-hefbomen.md) | “Drie hefbomen” als P28 | **Nee** — narratief in fundament; empirie blijft `meten/` |
| [cursor-rule](../../sjablonen/cursor-rule.md) | Audit-checklist mdc vs AGENTS | **Ja** — sjabloon + [waar-hoort-dit](../../standaard/waar-hoort-dit.md) + [bestanden](../../standaard/bestanden.md) |
| hybrid / hefbomen | Fase-splitting skills meten | **Later** — optionele `meten/`-slice, niet standaardiseren zonder data |
| §46 / [hrm-trm](redeneneren/hrm-trm.md) | HRM/TRM in kit of nieuw P | **Nee** — spoor 2 / kenniskaart alleen |
| §47 Strix | Docs + `make security-scan*` + AGENTS + skill-how-to in **kern** | **Ja** (okt 2026) — niet in `make check`; runtime ontbreekt → BACKLOG |
| §48 Observability | `observability.md` + Make in kern; LGTM-stack in module `observability` | **Ja** (okt 2026) — OTel→Alloy→Prom/Loki/Tempo→Grafana; instrumentatie apps → BACKLOG |
| §49 Colibrì | Colibrì als lokale default-runtime | **Nee** — te traag; wel les in §/fundament |
| §50 / §51 Ponytail | Ponytail-plugin of “one-liner”-KPI in AGENTS | **Nee** — plugin/LOC-KPI; micro-don’ts alleen na aparte analyse + akkoord |
| §52 MemPalace | MemPalace always-on in bootstrap | **Nee** — curated docs blijven SSOT; hybride search/scoped recall = les (zie toets hieronder) |
| §53 Byte models | Byte-tokenizer in projectstack | **Nee** — horizon/kenniskaart; geen kit |
| [kit-dekking-en-horizon](ecosysteem/kit-dekking-en-horizon.md) C1 Performance | `performance.md` + `make bench` / `perf-check` + per-stack stubs | **Ja** (okt 2026) — heuristische code-scan later (BACKLOG); niet in `make check` |
| [kit-dekking-en-horizon](ecosysteem/kit-dekking-en-horizon.md) C2 deps-audit | `dependencies.md` + how-to + `make deps-audit` in `check-full` | **Ja** (okt 2026) — license-gate later; cargo-audit stub; niet in `make check` |
| [kit-dekking-en-horizon](ecosysteem/kit-dekking-en-horizon.md) C3 polyglot | `polyglot.md` + voorbeeld-ADR + AGENTS/CONTEXT/ARCHITECTURE + `polyglot-check` | **Ja** (okt 2026) — geen volle Rust-stack; P28 in `## Bewust later` |
| [kit-dekking-en-horizon](ecosysteem/kit-dekking-en-horizon.md) C4 tech-radar | `research/radar.md` + how-to + `radar-check` / `radar-reminder` | **Ja** (okt 2026) — module research; geen scrapers; P28 |
| [kit-dekking-en-horizon](ecosysteem/kit-dekking-en-horizon.md) C4 digest-scaffold | `research/digest/` + stub-`digest-fetch` + `digest-check` / reminder | **Ja** (okt 2026) — opgevolgd door live fetch |
| [kit-dekking-en-horizon](ecosysteem/kit-dekking-en-horizon.md) C4 live digest A3 | `digest-fetch` + `digest-propose` + team `digest.yml` draft-PR | **Ja** (okt 2026) — geen auto-radar (P5); fixture offline |
| [kit-dekking-en-horizon](ecosysteem/kit-dekking-en-horizon.md) D5 Rust-stack | `kit/stacks/rust` → `apps/native`, napi-starter, `CHECK += check-native` | **Ja** (okt 2026) — eerste slice |
| [kit-dekking-en-horizon](ecosysteem/kit-dekking-en-horizon.md) PyO3 naast napi | zelfde starter: maturin/`pyo3-bridge` + analytics-AGENTS seam | **Ja** (okt 2026) — soft check; STRICT via check-full |
| [kit-dekking-en-horizon](ecosysteem/kit-dekking-en-horizon.md) C-stack | `kit/stacks/c` → `apps/native-c`, N-API+ctypes starter, `CHECK += check-native-c` | **Ja** (okt 2026) — soft check; STRICT via check-full |
| [kit-dekking-en-horizon](ecosysteem/kit-dekking-en-horizon.md) harde native CI | `NATIVE_STRICT` + `native-bindings-strict` in `check-full` + `native.yml` + how-to | **Ja** (okt 2026) — soft blijft `make check` |
| [kit-dekking-en-horizon](ecosysteem/kit-dekking-en-horizon.md) overig | license-gate/SBOM, load/chaos, … | **Later** — eerst prioriteren; niet alles tegelijk in kit |
| Harness tax / GymFreak-review (okt 2026) | AGENTS: keyword-tabel i.p.v. always-on kit-routes; dunne ARCHITECTURE; kit-docs zonder bron-paden / alsof-native | **Ja** — P2, P5, P25; BOOTSTRAP kit-delta + gymfreak G-9 |
| Harness tax / AGENTS-dun (okt 2026) | Keyword-catalogus + polyglot-Nooit weg; opt-in alleen INDEX/`make help`; Werken kort (~35–70 regels) | **Ja** — P2, P5, P25; snede B; BOOTSTRAP kit-delta + Cardine |
| BACKLOG-index (okt 2026) | BACKLOG = index; nieuw Nu-item alleen `make spec`; AGENTS-commando + Werken-regel (solo) | **Ja** — P8, P27; Cardine Nu → specs |

### Toets §52 MemPalace vs kit (fase 4)

| Kit / standaard nu | MemPalace (§52) |
|--------------------|-----------------|
| Curated docs, ADR, INDEX, JIT (P2, P5) | Verbatim chat-index als geheugen |
| Git + specs/BACKLOG als spine (P27) | Auto-save hooks vóór compaction |
| Geen always-on transcript-dump | Wings/rooms + BM25+vector |

**Conclusie:** geen kit. Wel herbruikbaar als *les*: scoped retrieval, verbatim voor audittrail (ADR), hooks vóór contextcompressie — zonder chat als SSOT.

### Ponytail-analyse (§50/§51) — voorstel, geen kit-edit tot apart akkoord

| Huidige kit | Uit §50/§51 | Voorstel |
|-------------|-------------|----------|
| Geen nieuwe modulegrenzen zonder vraag; deep modules (§2/§32) | YAGNI-ladder rung 1–2 | **Behouden** (dekt al) |
| Intent + tests (P13/P22) | “lazy ≠ negligent” (security/validatie niet knippen) | **Behouden** |
| Geen LOC-minimalisatie | One-liner-KPI / plugin | **Niet overnemen** |
| — | “stdlib/platform eerst” vóór custom code | **Kandidaat:** max. 1 zin in `AGENTS.md` § Werken of RULES — alleen na jouw ja |

## Volgende keer dat je brugt

1. Vul de checklist hierboven in.
2. Open het leerstuk → sectie **Wat kan naar de standaard**.
3. Voeg hier een rij toe met besluit.
4. Bij **Ja** op standaard/kit: drieplaats-regel (standaard + kit + sjabloon) of nieuw P-nummer in [principes.md](../principes.md).
5. `make check`.
