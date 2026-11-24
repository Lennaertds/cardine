# Glossarium

> **Rol:** Eén term per begrip, en hoe die in de code heet. Gebruik deze termen in code, docs en prompts.
> **Niet hier:** uitleg van algemene begrippen (REST, ETL, JWT).

## Domeinen

Dezelfde naam in `docs/product/`, en later in app-mappen zodra er een stack is (`features/<domein>/`, `src/<domein>/`, …).

| Domein | Eén zin | Code of afkorting |
|--------|---------|-------------------|
| harness | Agent-loop / runtime-experiment: hoe de agent draait en meetbaar wordt aangestuurd | H |
| structure | Projectstructuur-integratie: standaard lezen en afdwingen (docs, rules, seams) | S |
| indexing | Code-/context-index zodat de agent gericht context krijgt | I |

## Termen

| Term | Betekenis | In de code | Niet verwarren met |
|------|-----------|------------|--------------------|
| Spoor | Eén van de drie lagen: omgeving (kit), kennis (bron), lab (deze repo) | — (docs) | module (kit-module agent/research/product) |
| Harness | De minimale runtime die de agent-loop en metingen draagt | `harness` | Cursor zelf (externe IDE); indexing |
| Structure | Integratie met de projectstandaard (lezen/afdwingen) | `structure` | de standaard in `kit/` van deze repo |
| Indexing | Opbouw en gebruik van een code-/context-index (Project-Understanding) | `indexing` | digest; IDE-shell; harness |
| IDE-shell | Lichte editor-host (non-Electron) waaraan rest hangt | later | Cursor/VS Code-fork |
| FS/events | Seam: file-wijzigingen doorgeven aan indexing/harness | later | “een app forken” |
| Totaalproduct | Persoonlijke stack van 9 onderdelen — [totaalproduct.md](../product/totaalproduct.md) | — (docs) | SaaS-productisatie |
| Runtime-keuze | Expliciet besluit voor stack (bv. Pi, DSH of IDE-fork) vóór generators | ADR 0001 (uitstel); opvolger bij keuze | kit-modules zonder stack |
| Productisatie | Expliciet besluit lab → gratis release (portfolio; OS of closed) | BACKLOG Geparkeerd | stille “maak het publiek” zonder ADR |
| DeepSeek | Goedkope LLM-provider-richting via eigen API-key | env `DEEPSEEK_API_KEY` e.d. | DeepSeek Harness (§77); DeepInfer |

## Afkortingen en projectcodes

| Code | Betekent |
|------|----------|
| ADR | Architecture Decision Record, bestand in `docs/decisions/` |
| H / S / I | Domeincodes harness / structure / indexing |
| Pi | Kandidaat-runtime (pas na expliciete keuze) |
| TS | TypeScript als kandidaat-richting (pas na expliciete keuze) |
