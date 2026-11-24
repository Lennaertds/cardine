# Sessie: Sessie afronden na alle aanpassingen

**Datum:** 2026-11-19 08:23

## Besluiten (punten uit de chat)

### 1. Lokale token-logger voor DeepSeekHarness — **GA IK ONDERZOEKEN**
   - **Wat:** post-request hook in DeepSeekHarness die elke API-response parsed (prompt_tokens, completion_tokens, model, timestamp) en wegschrijft naar een lokaal bestand (CSV/JSONL).
   - **Waarom:** Dieper inzicht dan DeepInfra dashboard; eigen metingen + aggregatie.
   - **Actie:** onderzoek hoe DeepSeekHarness hooks/callbacks ondersteunt. Bouw proof-of-concept.
   - **Bronnen:** §30 (harness tax), §74 (keep-rate/tool-error taxonomy), §5 (deterministische harness-laag).

### 2. Geen images in prompts — **GEEN PROBLEEM** (model is text-only, niet de harness)

### 3. Sessielog via `make finish` — **WERKT NU**
   - `make finish MSG="..."` schrijft naar `bron/sessies/<datum>-<slug>.md` + INDEX.md entry.
   - **Huidige beperking:** de `data/notities/Notities.md` die het oude target gebruikte bestaat niet in deze repo — die is voor projecten die de kit bootstrap'en. In deze repo schrijft het alleen naar `bron/sessies/`.
   - **Actie:** vul elk sessiebestand zelf in met wat gedaan + besluiten + volgende stap (anders heb je er niks aan).
   - **Bronnen:** §9 (Implementation_Plan als persistent geheugen), §10 (compaction + structured notes).

### 4. Vier papers toegevoegd (§193–§196) — **KLAAR**
   - §193 Efficient Transformers Survey (Tay et al.)
   - §194 LeanVec: Token Optimization (HF/Pinecone)
   - §195 Chain-of-Thought Prompting (Wei et al.)
   - §196 How Language Models Use Long Contexts (Liu et al.)

### 5. Structuurplan — **MOET IN DE KIT, NIET ALLEEN IN DEZE REPO**
   - **Correctie uit chat:** de 4-pijlersstructuur (§9) moet in `standaard/` + `kit/` + `sjablonen/` (drieplaats-regel) zodat elk project dat de kit bootstrap't ze meekrijgt.
   - **Nog te doen:** plan uitwerken in kit-vorm.

## Open punten / volgende stappen

| Prioriteit | Wat | Status |
|------------|-----|--------|
| 🔴 Hoog | Token-logger onderzoeken (DeepSeekHarness hooks) | Nog niet begonnen |
| 🟡 Hoog | Structuurplan omzetten naar kit (drieplaats-regel) | Nog niet begonnen |
| 🟡 Middel | DeepInfra checken op multimodale modellen | Nog niet begonnen |
| 🟢 Laag | Eigen token-logger bouwen (na onderzoek) | Volgt op 🔴 |

## Als deze chat weg is: hoe verder?

1. Open deze repo en start een nieuwe agent-prompt met:
   > "Ik wil verder met de token-logger voor DeepSeekHarness. Lees `bron/sessies/2026-11-19-sessie-afronden-na-alle-aanpassingen.md` en ga verder waar ik gebleven was."
2. Of als je het structuurplan in de kit wil gieten:
   > "Lees `bron/sessies/2026-11-19-sessie-afronden-na-alle-aanpassingen.md` en werk het 4-pijlers structuurplan uit in de kit via de drieplaats-regel."

---

