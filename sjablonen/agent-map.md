# docs/agent/

> **Rol:** Agent-werkwijze die niet bij elke taak geladen moet worden: schrijfrechten, docconventies, lessen bij meta-taken, herbruikbare prompts.
> **Niet hier:** wat bij elke taak geldt ([agents-root](agents-root.md)).

**Kitbestanden:** [write-rules.md](../kit/modules/agent/docs/agent/write-rules.md), [doc-conventions.md](../kit/modules/agent/docs/agent/doc-conventions.md), [lessons.md](../kit/modules/agent/docs/agent/lessons.md), `prompts/` · module `agent`

## Wanneer

Als `AGENTS.md` te lang wordt door regels die alleen bij één soort taak gelden: schrijven in docs, refactors over het hele project, herbruikbare prompts. Zo blijft de root kort (P1) en staat de rest één link verder (P2).

## Invullen

| Bestand | Wat | Verwijzing in `AGENTS.md` |
|---------|-----|---------------------------|
| `write-rules.md` | per pad: vrij, na toestemming, nooit, met het waarom. Geen leesroutes per soort opdracht — die horen in `AGENTS.md` § Werken | "Mag ik dit bestand schrijven? → write-rules" |
| `doc-conventions.md` | kopregel, toon, tabellen of proza, lengte | "Een doc schrijven of herschrijven → doc-conventions" |
| `lessons.md` | datum, wat misliep, de les | geen; wat bij elke taak geldt, verhuist naar `AGENTS.md` |
| `prompts/<taak>.md` | een prompt die je vaker gebruikt (review, release-notes) | geen; je roept hem zelf op met `@` |

## Voorbeeld (GymFreak, `lessons.md`)

```markdown
| Datum | Wat misliep | Les |
|-------|-------------|-----|
| 2026-09-12 | De agent herschreef een oud besluit in DECISIONS.md in plaats van een nieuw toe te voegen | ADR's nooit wijzigen; staat nu in AGENTS.md § Nooit |
| 2026-10-02 | Bij "ruim de docs op" verwijderde de agent ook `archive/` | Meta-taken eerst als plan voorleggen; staat nu in write-rules (archive: na toestemming) |
```

## Snelle toets

- [ ] Elk bestand in deze map heeft precies één verwijzing in `AGENTS.md`, of geen als het alleen voor jou is.
- [ ] Geen regel staat zowel hier als in `AGENTS.md`.
