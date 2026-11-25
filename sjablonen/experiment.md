# docs/research/experiments/YYYY-MM-DD-&lt;slug&gt;.md

> **Role:** Report of one experiment: question, setup, data, result, conclusion.
> **Not here:** the code (`apps/<app>/experiments/`), what you know in general ([research](research.md)).

**Kit file:** [kit/modules/research/docs/research/experiments/_template.md](../kit/modules/research/docs/research/experiments/_template.md) · module `research`

## When

Every time you try something whose outcome determines a choice: a model, a threshold, a parameter. The report stays, even if the experiment fails; especially then.

```bash
make experiment s=sleep-baseline     # docs/research/experiments/2026-10-19-sleep-baseline.md
```

## Filling in

1. **Question:** such that the answer is yes, no or a number.
2. **Code** and **data:** the path to the code, the dataset and version from `data/README.md`. Never raw personal data in the report; counts and distributions are fine.
3. **Setup:** what you compare, with which parameters, how often.
4. **Result:** a table with the metric.
5. **Conclusion:** what you do with it: a product rule, an ADR, or nothing.

## Example (GymFreak)

```markdown
# 2026-10-19 — sleep-baseline

- **Question:** Does last night's sleep duration predict training volume better than the 7-day average?
- **Code:** `apps/analytics/experiments/2026-10-19-sleep-baseline.py`
- **Data:** `processed/day_features/` (own data, 412 days)

## Result

| Variant | MAE (sets) |
|---------|------------|
| 7-day average | 3.1 |
| last night | 3.4 |

## Conclusion

No. Insights stay on the 7-day average; no product change.
```

## Quick check

- [ ] The question has an answer in the conclusion.
- [ ] Code and data can be found with the paths in the header.
