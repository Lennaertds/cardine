# Stap 3 — Protocol

> **Rol:** Hoe je elke run uitvoert, zodat de resultaten vergelijkbaar en herhaalbaar zijn.
> **Niet hier:** hoe je de resultaten beoordeelt ([review en analyse](4-review-en-analyse.md)).

**Vast houden:**

- Hetzelfde model en dezelfde modelversie, dezelfde tool, dezelfde instellingen (thinking, max mode).
- Dezelfde prompt per taak, letterlijk.
- Elke run in een **schone sessie** en een **eigen git worktree** op de base commit.
- Geen menselijke tussenkomst tijdens de run. Stelt de agent een vraag, dan antwoord je met een vaste zin ("Beslis zelf en ga verder").
- Een tijds- en stappenlimiet per run (bv. 20 minuten of 60 toolcalls).

**Herhalen:** modellen zijn niet deterministisch. Draai elke combinatie van taak en conditie **minstens 3 keer**. Voor een bachelorproef liefst 5 keer.

**Volgorde:** randomiseer de volgorde van de runs, zodat modelupdates of tijdstippen niet samenvallen met één conditie.

**Uitvoeren** (schets; pas aan op je tool):

```bash
# per run
git worktree add ../eval-runs/$RUN_ID $BASE_COMMIT
cd ../eval-runs/$RUN_ID
./eval/apply-condition.sh $CONDITIE          # verwijdert of plaatst bestanden
claude -p "$PROMPT" --output-format json > ../logs/$RUN_ID.json   # headless; geeft tokengebruik terug
./eval/score.sh $TASK_ID                      # zet orakeltest terug, draait test + make check
git diff $BASE_COMMIT --stat > ../logs/$RUN_ID.diff.txt
```

Gebruik de headless modus van de tool die je onderzoekt, zodat het tokengebruik en de toolcalls in een logbestand belanden. Bewaar per run: het log, de diff, de testuitkomst en de duur.

**Resultaten** in één CSV, `eval/results.csv` (kop: [kit/results.csv](kit/results.csv)):

```
run_id,task_id,soort,conditie,herhaling,model,geslaagd,check_groen,review_score,input_tokens,output_tokens,toolcalls,stappen_tot_relevant,schendingen,duur_s
```
