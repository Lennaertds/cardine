# Voorstel: Onderwerp-gecentreerd logsysteem

> **Rol:** Vervanger voor de huidige sessiebestanden in `bron/sessies/`.
> **Niet hier:** Technische implementatie (zie `scripts/`), ruwe chatdata (zie `data/`).

## Probleem

De huidige sessiebestanden in `bron/sessies/` hebben:

1. **Dubbele informatie** — dezelfde open punten (token-logger, structuurplan, DeepInfra check) staan in meerdere bestanden gekopieerd
2. **Geen opschoning** — een onderwerp dat afgerond is in sessie 5 staat nog steeds als "open" in sessiebestand 1, 2, 3
3. **Lege bestanden** — templates met "vul aan" die nooit gevuld zijn
4. **Conversatiedumps** — complete chatlogs die veel ruis bevatten
5. **Sessie ipv onderwerp** — de structuur is per chatsessie, niet per onderwerp. Een onderwerp dat 3 sessies duurt is lastig te volgen.

## Oplossing: Onderwerp-gecentreerd log + status-tracker

In plaats van per sessie te loggen, houden we **één gestructureerd statusbestand** bij met alle onderwerpen, hun status, en een beknopt log van wat er gedaan is.

### Centraal bestand: `bron/status-log.md`

```markdown
# Status-log

> **Rol:** Één bron van waarheid over wat er gedaan is en wat nog open staat.
> **Bijgewerkt:** 2026-11-19 (op verzoek van gebruiker)

## Onderwerpen

| ID | Onderwerp | Status | Laatste update | Notities |
|----|-----------|--------|---------------|----------|
| T01 | Token-logger DeepSeekHarness | 🔴 Bezig | 2026-11-19 | Hooks onderzoek: spoor A, B, C |
| T02 | 4-pijlers structuurplan in kit | 🟡 Open | 2026-11-19 | Drieplaats-regel wacht op uitwerking |
| T03 | DeepInfra multimodal check | 🟡 Open | 2026-11-19 | `curl` check nog doen |
| T04 | Kit-profielen (app/research/studie/schoolwerk) | ✅ Afgerond | 2026-11-19 | 4 profielen + --profile vlag + check groen |
| T05 | Papers §193–§196 toevoegen | ✅ Afgerond | 2026-11-19 | 4 papers toegevoegd aan bronnen.md |
| T06 | Make finish met sessielog | ✅ Afgerond | 2026-11-19 | Schrijft nu sessiebestand + INDEX.md entry |
| T07 | DSH sandbox onderzoek | ✅ Afgerond | 2026-11-19 | Beperking: sandbox blokkeert ~/.dsh/ |
```

### Detail per onderwerp: `bron/onderwerpen/T01-token-logger.md`

Voor onderwerpen die nog open zijn of uitgebreide notities nodig hebben:

```markdown
# T01: Token-logger voor DeepSeekHarness

**Gemaakt:** 2026-11-19
**Status:** 🔴 Bezig
**Prioriteit:** Hoog

## Wat
Een post-request hook in DeepSeekHarness die elke API-response parsed
(prompt_tokens, completion_tokens, model, timestamp) en wegschrijft naar
een lokaal bestand (CSV/JSONL).

## Waarom
Dieper inzicht dan DeepInfra dashboard; eigen metingen + aggregatie.

## Sporen
- **Spoor A:** DSH plugins/hooks — check `~/.dsh/plugins/`
- **Spoor B:** Zed assistent logs — `find ~ -name '*.json' -path '*zed*'`
- **Spoor C:** Proxy logger — mitmproxy tussen Zed en DeepInfra

## Bronnen
§30 (harness tax), §74 (keep-rate/tool-error taxonomy), §5 (deterministische harness-laag)

## Log
| Datum | Wat gedaan |
|-------|------------|
| 2026-11-19 | Onderzoek gestart: omgevingsvariabelen uitgelezen, sandbox-beperking ontdekt |

## Volgende stap
Onderzoek `~/.dsh/` directory buiten sandbox (termninal commando's)
```

### Afgeronde onderwerpen — blijven beschikbaar, niet in de weg

Onderwerpen met status `✅ Afgerond` blijven staan in `bron/onderwerpen/` maar verdwijnen uit de actieve tabel in `bron/status-log.md`. Ze krijgen een aparte sectie onderaan de status-log:

```markdown
## ✅ Afgerond (naslag)

| ID | Onderwerp | Laatste update |
|----|-----------|---------------|
| T04 | Kit-profielen | 2026-11-19 |
| T05 | Papers §193–§196 | 2026-11-19 |
```

Dit dient als **bibliotheek**: agents kunnen eruit lezen als het onderwerp relevant is voor de huidige taak. Het staat niet in het actieve overzicht, dus het dagelijkse werk blijft overzichtelijk.

## Hoe het werkt (flow)

1. **Standaard** — niets gebeurt; `make finish` schrijft alleen een kort logregel in `bron/status-log.md` onderaan, geen apart sessiebestand meer
2. **Op verzoek** — gebruiker zegt "vat samen en update" of "werk status-log bij" — dan:
   - De agent leest `bron/status-log.md`
   - Inventariseert wat er in de huidige chat gebeurd is
   - Voegt nieuwe onderwerpen toe of updatet bestaande
   - Zet afgeronde onderwerpen op ✅ en archiveert ze
   - Verwijdert dubbele entries
   - Schrijft detailbestanden voor open/blijvende onderwerpen

## Waarom dit beter is

| Aspect | Huidig (sessiebestanden) | Nieuw (status-log + onderwerpen) |
|--------|-------------------------|-----------------------------------|
| Overzicht | Per sessie, veel scrollen | Per onderwerp, één overzichtstabel |
| Dubbel | Open punten gekopieerd in elk bestand | Elk onderwerp één keer, automatisch opgeschoond |
| Opschoning | Gebeurt niet, afgerond blijft staan | ✅ → archief, verdwijnt uit actieve lijst |
| Detail | Conversatiedumps of lege templates | Alleen nuttige detailpagina's per onderwerp |
| Wanneer updaten | Elke make finish (sessiebestand) | Alleen op verzoek (samenvatten/updaten) |
| Herstart | Moet meerdere sessiebestanden lezen | Eén status-log + detail voor lopende zaken |

## Overgang

1. Huidige sessiebestanden blijven staan als historie
2. Nieuwe `bron/status-log.md` wordt de actuele bron
3. Bij eerste update: alle open punten uit alle sessiebestanden destilleren naar onderwerpen
4. Detailbestanden alleen voor onderwerpen die nog niet ✅ zijn

---

Zie ook: `bron/sessies/INDEX.md` (oude logs, historisch).