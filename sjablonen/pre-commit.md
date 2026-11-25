# .pre-commit-config.yaml, .gitignore, .editorconfig

> **Role:** The guardrails that run before every commit, and what never goes into git.
> **Not here:** the policy on what is in git ([git](../standard/git.md)), the layers of `data/` ([data](../standard/data.md)).

**Kit files:** [.pre-commit-config.yaml](../kit/kern/.pre-commit-config.yaml), [.gitignore](../kit/kern/.gitignore), [.editorconfig](../kit/kern/.editorconfig) · layer kern · P14, P17

## When

Always, day 0. `make setup` installs the hooks. A rule you would otherwise put in `AGENTS.md` ("do not commit raw data") sits here as a hook: then it is not forgotten.

## Filling in

1. **`.gitignore`:** do not change the kit block; put this project's rules at the bottom under `# --- Specific to this project`.
2. **Hooks:** the kit has secrets (gitleaks, private keys), large files (> 1 MB), merge conflicts, YAML, whitespace, and two of its own: no raw or runtime data and no sync conflicts.
3. **Your own hook** for a mistake that happened twice: a `language: fail` hook on a path pattern, or a `language: system` hook that runs a script.
4. **Update versions** during maintenance: `pre-commit autoupdate`.

## Example (your own hook)

GymFreak never wants a Health export in a test fixture:

```yaml
  - repo: local
    hooks:
      - id: no-health-export-in-fixtures
        name: no real Health export in test fixtures
        language: fail
        entry: use a synthetic export (tests/fixtures/README.md)
        files: 'tests/fixtures/.*export.*\.xml$'
```

## Quick check

- [ ] `pre-commit run --all-files` is green.
- [ ] `git ls-files -ci --exclude-standard` returns nothing.
- [ ] A test commit of a file in `data/raw/` is refused.
