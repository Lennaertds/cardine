# Measuring — does it really work?

> **Role:** A repeatable way to test whether a change to structure or docs makes agents work better. Also the pilot for a bachelor thesis.
> **Not here:** what you change ([nieuw-project](../new-project/INDEX.md), [bestaand-project](../existing-project/INDEX.md)), why measure ([P21](../bron/principes.md)).

Method following the example of SWE-agent (source §19) and ETH's AGENTS.md evaluation (source §20).

## What you copy

[kit/tasks.yaml](kit/tasks.yaml) and [kit/results.csv](kit/results.csv) into a folder `eval/` **next to** the project, never inside it: the agent must not see the oracles.

```bash
mkdir -p ~/code/eval-<project> && cp measurement/kit/* ~/code/eval-<project>/
```

## What you measure

**Question:** does variant B of the structure and docs make an agent better, faster or cheaper than variant A, on tasks from your own project?

| Measure | How | Why |
|--------|-----|--------|
| **Pass rate** (main measure) | Does the task's acceptance test pass, and is `make check` green? Yes or no | Objective, like SWE-bench (§19, §20) |
| **Review score** | Your score from 1 to 5 with the [rubric](4-review-and-analysis.md#review-rubric-blind), given **blind** | Tests do not catch bad architecture (§6) |
| **Cost** | Input and output tokens, or the price per run | The ETH study found +20% cost from context files (§20) |
| **Steps** | Number of tool calls | More exploration is not always better (§20) |
| **First relevant file** | After how many steps does the agent first open a file that the real solution also changed? | Measures whether the map and structure help navigation (§20) |
| **Rule violations** | Number of violations of "Never" rules, ASK files or scope | Measures whether the guardrails work (P17) |
| **Time** | Wall-clock time per run | Practical |

## Steps

| Step | Done when |
|------|-----------|
| [1. Compose the tasks](1-taken.md) | 10 tasks in `tasks.yaml`, with oracle, chosen before you build the new structure |
| [2. Choose the conditions](2-condities.md) | at least C0, C1, C2 |
| [3. Protocol](3-protocol.md) | every task × condition combination run at least 3 times, in random order; everything in `results.csv` |
| [4. Review and analysis](4-review-and-analysis.md) | blind scores; table per task and per condition; traces reviewed where conditions differ |
| [5. Validity](5-validiteit.md) | every risk from the table checked and mentioned in the report |

Further: [from this set to a bachelor thesis](bachelorproef.md).

## Minimal version (one afternoon)

1. Five tasks from the git history of one project.
2. Two conditions: C1 (current) and C2 (new).
3. Two runs per combination: 20 runs.
4. Measure: passed yes or no, tokens, and a quick review score.
5. Write down in one paragraph what you saw. That is enough to know whether the reorganisation is heading the right way.

## TODO — comparing tracks (Oct 2026)

Not started yet; agreed though:

- [ ] After the bootstrap/reorganise of GymFreak (or Caddie): minimal eval — does the standard help navigation (first relevant file, pass rate)?
- [ ] Later: condition **Cursor + kit** vs **Cardine (track 3)** on the same tasks (`eval-` next to the target project). Knowledge stays in `bron/`; this lab is not a second SSOT.
