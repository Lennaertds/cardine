# Step 5 — Validity

> **Role:** Where a measurement can mislead, and what you do about it.
> **Not here:** the method itself ([INDEX](INDEX.md)).

| Risk | Consequence | Measure |
|--------|--------|-----------|
| **Your own bias** as a reviewer | You see what you hope to see | Blind review, a second reviewer |
| **Leaking the solution** | The agent knows the answer from the docs, logs or git | Remove docs, logs and ADRs from after the base commit; truncate the git history (`git clone --depth 1` on the base) |
| **Model drift** | The model changes during your measurement | Record the model version, run everything in a short period, randomise the order |
| **Too few tasks** | Chance dominates | Repetitions; show results per task; word it carefully |
| **Tasks suit one variant** | You measure the task choice instead of the structure | Choose the tasks before you build the new structure |
| **Your own projects** | Hard to generalise | Two different projects (solo and team); possibly an open-source repo as a third case |
