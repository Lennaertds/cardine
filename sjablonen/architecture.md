# docs/architecture/ARCHITECTURE.md

> **Rol:** Hoe het systeem in elkaar zit op containerniveau: wat draait waar, wie schrijft waar, wat altijd waar moet zijn.
> **Niet hier:** de mappenboom (`ls`), codedetails (de code), het waarom ([adr](adr.md)), PWA/offline/push, auth-flows, feature-catalogus — die gaan naar `architecture/<subsysteem>.md`.

**Kitbestand:** [kit/kern/docs/architecture/ARCHITECTURE.md](../kit/kern/docs/architecture/ARCHITECTURE.md) · laag kern · P12, P23 (C4 niveau 1–2; seams vóór AI-volume)

## Wanneer

Dag 0 met het containerdiagram. Bij elke nieuwe container, dienst, poort, host of **seam** bijwerken. Diepte per subsysteem (import, pipeline, LLM, client-runtime, auth) komt in een eigen `architecture/<subsysteem>.md`. Zonder ingevulde seams: geen grote AI-refactors op legacy (P23).

## Invullen

1. **Systeemcontext:** één alinea, met de externe systemen.
2. **Containers:** Mermaid-diagram en de tabel met pad, taak, poort en host. De poorten komen uit de `app.mk`'s.
3. **Stack:** de keuze per laag met de ADR die haar onderbouwt. Native/extra taal: verwijs naar [polyglot](polyglot.md), niet stil in de tabel; native-mappen alleen als die stack bestaat.
4. **Dataflow en eigenaarschap:** wie schrijft waar. Dit is de sectie die de meeste fouten voorkomt.
5. **Hosting en poorten**, **Wat in git staat** (alleen wat afwijkt van de standaard), **Invarianten** met hun bewaking.
6. **Seams:** tabel met naden (web→api, api→db, …), welke test ze bewaakt, en wat een agent mag zonder akkoord vs. wat eerst ADR vraagt (P23).
7. **Subsystemen:** links, één zin per stuk. Kit levert al polyglot/security/obs/perf/deps. Project-dikte (PWA-chrome, JWT-details, onboarding) → eigen bestanden, niet hier dumpen.

## Voorbeeld (GymFreak)

```markdown
| Container | Pad | Taak | Poort lokaal | Host in productie |
|-----------|-----|------|--------------|-------------------|
| web | `apps/web` | PWA, server-side rendering | 3002 | Railway, gymfreak.be |
| api | `apps/api` | auth, user-data, import | 3003 | Railway, api.gymfreak.be |
| db | docker compose | Postgres 17 | 5433 | Railway Postgres |
| analytics | `apps/analytics` | batch: demo-data en evidence-index | — | lokaal |

## Dataflow en eigenaarschap

- Postgres is de enige writer van user-data; analytics leest alleen (ADR 0012).
- Uploads gaan naar `data/runtime/user/` lokaal en naar een Railway-volume in productie.
- `data/processed/demo/` staat in git en wordt door de web-app gelezen voor de demo zonder account.
```

Dun houden: PWA/offline/push → `architecture/runtime-client.md`; JWT/demo/onboarding-details → `architecture/auth.md` (of data-model + legal). ARCHITECTURE blijft “waar zit X / wie schrijft”.

## Snelle toets

- [ ] Geen klassen, geen bestandslijst, geen boom.
- [ ] Geen lange Runtime-/Auth-catalogus in dit bestand (P5, harness tax).
- [ ] Elke container in het diagram staat ook in de tabel, met poort en host.
- [ ] "Wie schrijft waar" is voor elke database of map met data beantwoord.
- [ ] Elke invariant verwijst naar de test of ADR die haar bewaakt.
- [ ] Elke seam heeft een bewaking (test) of staat expliciet als "nog te beveiligen".
- [ ] "Mag zonder akkoord" vs. "eerst ADR" is voor een agent begrijpelijk in één blik.
- [ ] Richtlengte: bij voorkeur ≤ ~100 regels; dikker = splits naar subsystemen.
