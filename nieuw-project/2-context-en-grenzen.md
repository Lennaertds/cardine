# Stap 2 — Context en grenzen

> **Rol:** Vóór de eerste regel code vastleggen wat niet uit de code af te leiden is: voor wie, waarom, wat nooit, en de grote keuzes.
> **Niet hier:** hoe je elk bestand invult (de gidsen in [sjablonen](../sjablonen/INDEX.md)).

## Doen

| # | Bestand | Wat | Gids |
|---|---------|-----|------|
| 1 | `docs/context/CONTEXT.md` | gebruiker of klant, probleem, wat succes is, scope, bewust niet | [context](../sjablonen/context.md) |
| 2 | `docs/rules/RULES.md` | de drie à vijf inhoudelijke grenzen die je nu al kent | [rules](../sjablonen/rules.md) |
| 3 | `docs/context/GLOSSARY.md` | de eerste vijf termen en de domeinen, met de naam die ook in de code komt (P10) | [glossary](../sjablonen/glossary.md) |
| 4 | `docs/architecture/ARCHITECTURE.md` | containerdiagram: welke apps, welke databases, wie schrijft waar | [architecture](../sjablonen/architecture.md) |
| 5 | `docs/architecture/security.md` | persoonsgegevens, secrets, Strix-afspraken | [security](../sjablonen/security.md) |
| 6 | `docs/architecture/observability.md` | signalen + LGTM-stack (productie-hosting invullen) | [observability](../sjablonen/observability.md) |
| 7 | `docs/architecture/performance.md` | budgets (API→web→analytics) + anti-patronen | [performance](../sjablonen/performance.md) |
| 8 | `docs/decisions/` | één ADR per keuze die je nu maakt: stack, database, hosting, obs/security/perf | [adr](../sjablonen/adr.md) |
| 9 | modules | `assignment.md`, `vision.md`, `PRODUCT.md` als je ze koos | [assignment](../sjablonen/assignment.md), [vision](../sjablonen/vision.md), [product](../sjablonen/product.md) |

```bash
make adr t="Next.js en NestJS in een pnpm-workspace"
make adr t="Postgres is de enige writer van user-data"
make adr t="Eén Railway-project met twee domeinen"
make adr t="LGTM self-host (OTel Alloy Prometheus Loki Tempo Grafana) als observability-stack"
make adr t="Strix als actieve security-scan via make security-scan"
make adr t="Performance-budgets in performance.md; meten via obs en make bench"
```

## Ontwerp vóór code (P18, P22, P23; bron §2, §6, §7, §32)

- **Laat een agent je interviewen** over het idee tot de randgevallen helder zijn ("grill me", §1, §7). Het resultaat gaat naar CONTEXT, RULES en productintentie, niet in een chatlog (P22, P27).
- **Bepaal zelf de modules en hun interfaces** (diepe modules, gray box): jij bent de strategische programmeur; de agent vult tactisch in (§2, §7, §32 / P19, P23). De domeinnamen in het glossarium zijn meteen de mappen in `features/<domein>/` en `src/<domein>/`.
- **Teken het containerdiagram**, niet meer (P12), en vul **Seams** in: naden + wat een agent mag zonder akkoord (P23). Klassen en bestanden leest de agent uit de code.

## Klaar als

- Iemand die alleen deze vijf bestanden leest, kan zeggen voor wie het is, wat nooit mag en welke apps er komen.
- Elke regel in RULES heeft een waarom. Is hij afdwingbaar, dan staat bij "Bewaakt door" welke test of hook het wordt.
- `ARCHITECTURE.md` § Seams heeft minstens de naden die je nu al kent (of "nog te beveiligen").
- `make check` faalt nog steeds alleen op "geen app" (de links kloppen).

## Valkuilen

- **Lege kopjes laten staan.** Weet je iets nog niet, schrap dan de sectie. Ze komt terug als de vraag echt opduikt.
- **Techniek in CONTEXT.** Stack en hosting horen in ARCHITECTURE en de ADR's.
- **Status in een stabiel doc.** "Nu bezig met …" hoort in de backlog of de tracker (P8).
