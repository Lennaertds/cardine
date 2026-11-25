# Step 3 — Protocol

> **Role:** How you run each run, so that the results are comparable and repeatable.
> **Not here:** how you judge the results ([review and analysis](4-review-and-analysis.md)).

**Keep fixed:**

- The same model and model version, the same tool, the same settings (thinking, max mode).
- The same prompt per task, literally.
- Every run in a **clean session** and its **own git worktree** on the base commit.
- No human intervention during the run. If the agent asks a question, you answer with a fixed sentence ("Decide for yourself and carry on").
- A time and step limit per run (e.g. 20 minutes or 60 tool calls).

**Repeat:** models are not deterministic. Run every task × condition combination **at least 3 times**. For a bachelor thesis preferably 5 times.

**Order:** randomise the order of the runs, so that model updates or times of day do not coincide with one condition.

**Running** (sketch; adapt to your tool):

```bash
# per run
git worktree add ../eval-runs/$RUN_ID $BASE_COMMIT
cd ../eval-runs/$RUN_ID
./eval/apply-condition.sh $CONDITION          # removes or places files
claude -p "$PROMPT" --output-format json > ../logs/$RUN_ID.json   # headless; returns token usage
./eval/score.sh $TASK_ID                      # puts the oracle test back, runs the test + make check
git diff $BASE_COMMIT --stat > ../logs/$RUN_ID.diff.txt
```

Use the headless mode of the tool you are studying, so that token usage and tool calls land in a log file. Keep per run: the log, the diff, the test result and the duration.

**Results** in one CSV, `eval/results.csv` (header: [kit/results.csv](kit/results.csv)):

```
run_id,task_id,kind,condition,repetition,model,passed,check_green,review_score,input_tokens,output_tokens,toolcalls,steps_to_relevant,violations,duration_s
```
