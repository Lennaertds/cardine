# .pre-commit-config.yaml, .gitignore, .editorconfig

> **Rol:** De guardrails die vóór elke commit draaien, en wat nooit in git komt.
> **Niet hier:** het beleid over wat in git staat ([git](../standaard/git.md)), de lagen van `data/` ([data](../standaard/data.md)).

**Kitbestanden:** [.pre-commit-config.yaml](../kit/kern/.pre-commit-config.yaml), [.gitignore](../kit/kern/.gitignore), [.editorconfig](../kit/kern/.editorconfig) · laag kern · P14, P17

## Wanneer

Altijd, dag 0. `make setup` installeert de hooks. Een regel die je anders in `AGENTS.md` zou zetten ("geen ruwe data committen"), staat hier als hook: dan wordt hij niet vergeten.

## Invullen

1. **`.gitignore`:** het kit-blok niet aanpassen; regels van dit project onderaan onder `# --- Specifiek voor dit project`.
2. **Hooks:** de kit heeft secrets (gitleaks, private keys), grote bestanden (> 1 MB), merge-conflicten, YAML, witruimte, en twee eigen: geen ruwe of runtime-data en geen sync-conflicten.
3. **Eigen hook** voor een fout die twee keer gebeurde: een `language: fail`-hook op een padpatroon, of een `language: system`-hook die een script draait.
4. **Versies bijwerken** in het onderhoud: `pre-commit autoupdate`.

## Voorbeeld (eigen hook)

GymFreak wil nooit een Health-export in een testfixture:

```yaml
  - repo: local
    hooks:
      - id: no-health-export-in-fixtures
        name: geen echte Health-export in testfixtures
        language: fail
        entry: gebruik een synthetische export (tests/fixtures/README.md)
        files: 'tests/fixtures/.*export.*\.xml$'
```

## Snelle toets

- [ ] `pre-commit run --all-files` is groen.
- [ ] `git ls-files -ci --exclude-standard` geeft niets.
- [ ] Een test-commit van een bestand in `data/raw/` wordt geweigerd.
