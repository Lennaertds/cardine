# Step 6 — Maintenance

> **Role:** Monthly (solo) or in the last sprint week (team), prune and update so the docs keep following the code.
> **Not here:** measuring whether a change helps ([meten](../measurement/INDEX.md)).

Start with:

```bash
make docs-health    # dead links, length of every AGENTS.md, the docs that have not changed the longest
```

## Prune (P20, P25; source §3, §12, §21, §25)

- [ ] `AGENTS.md`: deletion test for every line. Would the agent make a mistake without this line? If not, cut it. Longer than needed = harness tax.
- [ ] Coverage of the eight Coldtea themes (source §34): [quick test in agents-root](../sjablonen/agents-root.md#coverage-coldtea-source-34). A gap = missing somewhere in the system, or deliberately elsewhere.
- [ ] Can a rule be enforced with a linter, test or hook by now? Move it (P14). Harness hacks the model handles natively: out (P25).
- [ ] Duplicated facts: `rg -n '<core concept>' docs AGENTS.md` — is it explained in more than one place? (P7)
- [ ] Distractions: old configs, `_v2` files, docs about code that no longer exists → out or `docs/archive/` (P16).
- [ ] Shallow `utils/`/`helpers/` created by AI: merge into deep modules or document the seams (P16, P23).

## Update

- [ ] `docs/INDEX.md` matches the files that exist (`make links` is green, and no doc is missing).
- [ ] `ARCHITECTURE.md` matches the containers, ports and **seams** that really run.
- [ ] Product rules still have a guard that preserves the intent (P22).
- [ ] Superseded ADRs are marked `superseded by NNNN`.
- [ ] Finished specs are gone. The backlog holds only open work (spine, P27).
- [ ] `data/README.md` lists every dataset that is there.
- [ ] Versions in `.pre-commit-config.yaml`: `pre-commit autoupdate`.

## Measure (P21)

- [ ] After a larger change to the structure or `AGENTS.md`: the minimal measurement from [meten](../measurement/INDEX.md#minimal-version-one-afternoon).

## Done when

A fresh agent still passes the test from [step 4](4-agent.md#test-with-a-fresh-agent), and `make docs-health` shows nothing new.
