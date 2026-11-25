# Step 4 — Review and analysis

> **Role:** Judge the diffs blind and compare the conditions fairly.
> **Not here:** what you measure ([INDEX](INDEX.md#what-you-measure)), the pitfalls ([validity](5-validiteit.md)).

## Review rubric (blind)

Have a script anonymise the diffs (condition removed, order shuffled) before you judge them. In a team project a teammate can score along. Then you can also report inter-rater agreement.

| Score | Meaning |
|-------|-----------|
| 5 | I would merge it as is. Follows the existing patterns, within scope, with tests |
| 4 | Minor comments (naming, one superfluous line) |
| 3 | Works, but deviates from the patterns or does more than asked |
| 2 | Works partly, or is hard to maintain (shotgun surgery, try/catch to make tests pass, §6) |
| 1 | Wrong, or breaks a rule |

## Analysis

- Pass rate (passed / runs), with the spread across repetitions.
- Median and interquartile range of tokens, tool calls, steps to the relevant file, and duration.
- Mean review score.
- Number of violations.

**Comparing:**

- Paired per task: does the same task work better in C2 than in C1? Show a table per task, not just averages. Small numbers hide a lot in an average.
- For the pass rate (yes/no, paired): the McNemar test. For tokens and steps: the Wilcoxon signed-rank test. With 10 tasks that is indicative, not conclusive. Say so too.
- Look at the **traces** of the tasks where the conditions differ: what did the agent do differently? Did it follow a rule? Did it read the wrong document? That explains the *why*, and that is where you draw the lessons.

**Report table** (also as columns in [kit/results.csv](kit/results.csv)):

| Condition | Pass rate | Review (mean) | Tokens (median) | Tool calls (median) | Steps to relevant | Violations |
|----------|-----------|---------------|------------------|---------------------|----------------------|-------------|
| C0 | | | | | | |
| C1 | | | | | | |
| C2 | | | | | | |
