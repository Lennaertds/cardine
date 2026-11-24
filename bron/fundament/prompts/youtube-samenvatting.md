# Prompt — dichte YouTube-samenvatting

> **Rol:** Herbruikbare prompt om video’s om te zetten naar §-waardige naslag (maximale detail).
> **Niet hier:** de samenvattingen zelf ([bronnen.md](../../bronnen.md)).

## Gebruik

1. Haal bij voorkeur het **transcript** op (auto-subs / `yt-dlp --write-auto-sub`). Alleen een URL is onbetrouwbaar.
2. Video ≤ ~20 min → één call met de prompt hieronder.
3. Langer → per chapter of per 10–15 min een segment-call, daarna de **merge-pass**.
4. Plak output in `bronnen.md` als nieuw `§n` + rij in index/totaaloverzicht; diepte → `fundament/` indien nodig.

---

## Prompt (segment of hele korte video)

```markdown
# Taak
Maak een ZEER DETAILLERDE Nederlandse samenvatting van de YouTube-video(s) hieronder, geschikt als naslag in een technische kennisbank (Agent Engineering / LLMs / agents).

URL(s):
<plak hier 1 URL, of bij lange video: 1 segment-URL met &t=… plus tijdspanne>

Transcript (indien beschikbaar):
<plak transcript>

# Doel
Maximale informatiedichtheid. Dit is GEEN korte TL;DR. Ik wil later elk mechanisme, trade-off, cijfer, toolnaam en voorbeeld terugvinden zonder de video opnieuw te kijken.

# Hard verboden
- Geen vage marketingtaal zonder inhoud
- Geen weglaten van definities, architectuurstappen, benchmarks, of “waarom X i.p.v. Y”
- Geen verdichten tot 5 bullets als de video 20 onderwerpen behandelt
- Verzin niets. Staat het niet in de video/transcript → schrijf `[niet in bron]` of laat weg
- Geen Engelse hele alinea’s; termen (KV-cache, MoE, …) mogen Engels blijven

# Verplichte structuur (Markdown)

## §?. <Exacte videotitel> (<maker/kanaal>)
- **URL:** …
- **Duur / dit segment:** …
- **Kern in 2–3 zinnen:** wat de video claimt/uitlegt

Daarna genummerde of letter-secties (A, B, C…) per thema in **videovolgorde**.

Per sectie:
- Duidelijke kop
- Uitleg mechanisme (hoe werkt het), niet alleen de naam
- Lijsten met *Voordeel* / *Nadeel* / *Trade-off* waar relevant
- Concrete namen: tools, papers, modellen, APIs
- Cijfers en claims exact zoals gezegd (met eenheid); markeer als claim van de spreker
- Mini ASCII-diagram of bullet-flow als de spreker een pipeline/stack tekent
- Timestamps als clickable links waar mogelijk: `[[MM:SS](URL&t=seconden)]`

### Aan het eind
#### Wat ik meeneem
3–8 bullets voor (a) LLM/agent-begrip, (b) efficiëntie/tokens/kosten, (c) eventueel projectstructuur — alleen als de video dat raakt.

#### Open / onduidelijk
Wat de video openlaat of niet verifieerbaar was uit transcript.

# Detailniveau
College-dictaat: liever te lang dan te kort. Skip filler/sponsors. Wél elke technische digressie.

# Als je maar één segment krijgt
Vat ALLEEN dat tijdsbereik samen. Zeg: `Segment N van vermoedelijk M`.

# Outputtaal
Nederlands. Engelse vaktermijnen oké.
```

---

## Merge-pass (na segmenten)

```markdown
Hieronder staan dichte segmentsamenvattingen van ÉÉN video.
Voeg ze samen tot één § zonder informatie te schrappen.
Dedupliceer alleen letterlijke herhaling.
Behoud alle timestamps, cijfers, toolnamen en “Wat ik meeneem” (uniek maken).
Structuur: A/B/C-secties, ASCII waar nuttig.
Bovenaan: voorgesteld thema (Prompt/Context/Harness/Loop/Graph/Workflow/Inference/Reasoning/Model internals/Industrie).
```
