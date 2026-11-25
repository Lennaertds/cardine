# apps/&lt;app&gt;/AGENTS.md (nested)

> **Role:** What applies only in this app or deviates: layout, running one test, pitfalls. The root still applies.
> **Not here:** what applies to the whole project ([agents-root](agents-root.md)).

**Kit files:** [next](../kit/stacks/next/apps/web/AGENTS.md) · [nest](../kit/stacks/nest/apps/api/AGENTS.md) · [python](../kit/stacks/python/apps/analytics/AGENTS.md) · [sql](../kit/stacks/sql/apps/pipeline/AGENTS.md) · layer stack · P15

## When

For every app. The kit installs a version with the stack's rules; you delete what does not apply and add the pitfalls. If you use a `.cursor/rules/<app>.mdc` instead, do not keep the same rules in both.

## Filling in

1. **Layout:** the rules from [stacks](../standard/stacks.md) the agent gets wrong most often. Not the whole tree.
2. **Tests:** the command for **one** test, with a real path.
3. **Pitfalls:** what has already gone wrong. Every pitfall you can catch with a test or script, you catch; then only the reference stays here.
4. **No copy of the root.** Do not repeat "Never" rules; link to them.

## Example (GymFreak, `apps/web/AGENTS.md`, pitfalls)

```markdown
## Pitfalls

- Error `Cannot find module './NNN.js'` after `make build-web`: `make clean-web` first, then `make dev-web`.
- 119 components still sit flat in `src/components/`. New components of a domain go to
  `src/features/<domain>/components/`; an existing one moves only when you are changing it anyway.
- Themes live in `public/themes/<theme>/`; new colours go in as a token in `src/styles/` first.
```

## Quick check

- [ ] Under 40 lines.
- [ ] Every line applies **only** to this app. If it applies to two apps, it belongs in the root.
- [ ] The one-test command works when you paste it literally.
