# Minimal version (prototype or hackathon)

> **Role:** What you do if you really only have an hour, without having to move anything later.
> **Not here:** the full step-by-step plan ([INDEX](INDEX.md)).

```bash
kit/new-project.sh <dir> --stacks <one stack>     # after the generator; no modules
```

Then fill in only this:

1. `README.md`: what and quickstart.
2. `AGENTS.md`: the commands are already there; add three "Never" rules specific to this project.
3. One test and a green `make check`.
4. Every choice with a why: `make adr t="…"`, and write only the summary.

The rest of the kit may stay empty: files with `<…>` only reach the agent when it opens them, and the map does not point at them as long as you do not fill in the line. If the project survives, you continue with [step 2](2-context-and-boundaries.md). Nothing has to move.
