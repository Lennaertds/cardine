# Onderzoek

> **Rol:** Wat we over het domein weten, op welke bronnen dat steunt, en welke productregel erop rust.
> **Niet hier:** de productregels zelf (`product/`), code van experimenten (`apps/<app>/experiments/`).

## Programma (agents: start hier)

Samenhang LLM ↔ AE ↔ dit lab (mens, één keer): [tour in Agent_Engineering](../../../Agent_Engineering/bron/tour.md).  
Volledig: [onderzoek-programma.md](onderzoek-programma.md) — A1→A2→A5→A4→A3, daarna A6–A9, dan B. Vorm + decision-candidates: [ideeen-en-vragen.md](ideeen-en-vragen.md).

## Stand (2026-10-26)

A6–A9 hebben **vorm** (dual structure, check-ladder, dual formats, folder-spine) — nog geen ADR. A1–A3/A5 deels met werkantwoorden (A3: DeepSeek §89–§94 + Kimi §134–§142 + Mistral §95–§101); A4 + A5-matrix open. B wacht op mens-ja.

## Onderzoeksvragen

1. Minimale harness-oppervlakte zodat de agent de standaard respecteert (meetbaar)? → hypothese: Pi-achtig + A6/A7/A9.
2. Structure (A6): **dual** — zie [ideeen A6](ideeen-en-vragen.md#a6--verduidelijkt--vorm).
3. Indexing: exact/regex-first (§69); semantic later meten.
4. (A1–A5) Peers/benches vóór stack-ADR — [werkantwoorden](ideeen-en-vragen.md#werkantwoorden-a1a5-nog-geen-adr).
5. (A7) Ladder + revert — [ideeen A7](ideeen-en-vragen.md#a7--verduidelijkt--vorm).
6. (A8)/(A9) Formaat + spine — [A8](ideeen-en-vragen.md#a8--verduidelijkt--vorm) / [A9](ideeen-en-vragen.md#a9--verduidelijkt--vorm).

## Hoe we bronnen beoordelen

| Niveau | Wat telt | Gebruik |
|--------|----------|---------|
| A | Meta-analyse of systematische review | Mag een productregel dragen |
| B | Gerandomiseerde studie | Mag een regel dragen, met vermelding |
| C | Observationeel, expert, blog | Alleen als hypothese of experiment |

## Kaart van `research/`

- [onderzoek-programma.md](onderzoek-programma.md) — Volgorde + bronsoorten + waar schrijven.
- [ideeen-en-vragen.md](ideeen-en-vragen.md) — Jouw vragen 1–9 + B; niet kwijtraken.
- [wantlist.md](wantlist.md) — Bronnen die we nog willen verwerven.
- (A5) `vergelijking-harness-ide.md` — nog te maken; cellen met §-links.
- [radar.md](radar.md) — Tech-radar (Adopt/Trial/Assess/Hold); maandelijks `make radar-reminder`.
- [digest/](digest/README.md) — Inbound feeds; `digest-fetch` / `digest-propose` / `digest-week` → AE `bron/weken/` (cureren vóór radar/§).
- `experiments/` — Eén verslag per experiment: `make experiment s=<slug>`.
