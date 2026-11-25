# Step 7 — Measure and record

> **Role:** Check whether the reorganisation achieved anything, and keep the result.
> **Not here:** the measurement method ([meten](../measurement/INDEX.md)).

## Do

1. **The same tasks again**, with the same model and the same prompts, on the new state: condition **C2** ([conditions](../measurement/2-condities.md)). Same number of repetitions as the baseline.
2. **Compare per task**, not just averages ([analysis](../measurement/4-review-and-analysis.md)). Look at the traces of the tasks where C1 and C2 differ: what did the agent do differently?
3. **Record it in an ADR:**

   ```bash
   make adr t="Docs and structure follow the standard from `kit/`"
   ```

   With the C1-versus-C2 table in **Consequences**, and what you learned from it.

4. **Lessons back into the standard.** If something fits nowhere, or a rule did not help, change the standard or the kit ([changing the standard](../standard/INDEX.md#changing-the-standard)), not just this project.
5. **Move table out** (`docs/work/specs/reorganise.md`). The ADR and git keep what happened.

## Done when

- The ADR is there with the numbers.
- The move table is gone.
- What you learned about the standard is in the standard.
