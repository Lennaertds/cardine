# cardine-structure

> De projectstandaard voor ieder project, ongeacht editor of abonnement.

Dit is het gratis product — gepulled uit `Agent_Engineering/kit/` op een pinned commit.

## Installatie

```bash
npx cardine-structure my-project --profile app --modules research,agent
```

## Inhoud

| Laag | Beschrijving | Verplicht? |
|------|-------------|-----------|
| `kern/` | README, AGENTS.md, Makefile, .gitignore, .editorconfig, docs/ | altijd |
| `solo/` | .cursorrules, BACKLOG.md, specs/_template.md, logs/_template.md | standaard |
| `logging/` | logs/status-log.md, logs/onderwerpen/_template.md | altijd |
| `team/` | .github/ (CI, PR-template, issue-templates) | optioneel |
| `modules/<naam>/` | Per module | optioneel |
| `stacks/<stack>/` | Per stack | optioneel |
| `profiles/<naam>.profile` | Voorgedefinieerde combinaties | optioneel |
| `new-project.sh` | Generator-script | ja |

Zie [docs/cardine-structure.md](docs/cardine-structure.md) voor volledige documentatie.