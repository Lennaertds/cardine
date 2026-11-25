# README.md

> **Role:** The front page for humans: what it is, why, and how to run it in two minutes.
> **Not here:** working method for the agent ([agents-root](agents-root.md)), architecture ([architecture](architecture.md)).

**Kit file:** [kit/kern/README.md](../kit/kern/README.md) · layer kern

## When

Always. Day 0 with the quickstart from the kit; extend it once there is a demo or a first user.

## Filling in

1. **Title and one sentence:** what it is and for whom. No marketing.
2. **Why:** the problem in two or three sentences. The full context lives in `CONTEXT.md`; link to it.
3. **Demo:** a link and, if allowed, a test account without real data.
4. **Quickstart:** the three make commands from the kit. What else you need (Docker, uv) is shown by `make doctor`.
5. **More:** links to `docs/INDEX.md` and `AGENTS.md`. Do not repeat their content.

## Example (GymFreak)

```markdown
# GymFreak

Training planner as a PWA for people who build their own programmes: plan, log, and trends in strength, sleep and nutrition.

Demo: https://gymfreak.be · test account `test@gymfreak.be` (demo data only)

## Quickstart

    make setup   # .env, dependencies, git hooks
    make up      # Postgres on :5433
    make dev     # web :3002, api :3003

## More

Docs: [docs/INDEX.md](docs/INDEX.md) · Working with an agent: [AGENTS.md](AGENTS.md)
```

## Quick check

- [ ] Someone with no prior knowledge runs the project using only this file and `make doctor`.
- [ ] No folder tree, no list of features that belongs in `PRODUCT.md`, no status.
- [ ] Code private? Then the public explanation lives in a separate repo, not here.
