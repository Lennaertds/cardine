# Step 1 — Copy the kit

> **Role:** Lay the foundation: every fixed folder, every entry file, the Makefile and the guardrails.
> **Not here:** the apps themselves ([step 3](3-apps-and-feedback-loop.md)), what each layer holds ([kit](../kit/README.md#layers)).

## Do

1. **Pick the layers** from the table in [INDEX](INDEX.md#what-you-copy). Leave the stacks out for now: their generators come in step 3.

   ```bash
   kit/new-project.sh ~/code/<project> --modules product,design,compose
   ```

   The script creates the folder, copies kern + solo (or team) + modules, fills in `{{PROJECT}}` and `{{DATE}}`, keeps the `<!-- als: … -->` blocks that apply, and runs `git init`.

2. **Check:**

   ```bash
   cd ~/code/<project>
   make            # lists all targets, grouped
   make check      # fails: "make check does not check any app yet" (that is right)
   make doctor     # which tools are missing
   ```

3. **First commit** with only the kit, so you can see later what you added:

   ```bash
   git add -A && git commit -m "chore: project skeleton from the kit"
   ```

## What you have now

- `README.md`, `AGENTS.md`, `docs/INDEX.md`: the three entry points, with `<…>` where you fill in.
- `Makefile` with the fixed targets ([makefile](../standard/makefile.md)), `.gitignore`, `.editorconfig`, `.pre-commit-config.yaml`, `scripts/check-links.sh`.
- `docs/` with the kern files and the `_template.md` templates for ADR, spec and log.
- `data/` with the five fixed layers and a catalogue. Raw data never goes into git.
- Empty fixed folders with a `.gitkeep`: `apps/`, `docs/how-to/`, the data layers.

## Pitfalls

- **Do not move or rename anything.** A name you do not like, you change in the standard ([standard](../standard/INDEX.md#changing-the-standard)), not in one project.
- **No extra folders "for later".** The place is fixed, even if the folder does not exist yet.
- The script refuses a target folder inside the kit itself, and never overwrites anything. Running it again with extra modules is safe.
