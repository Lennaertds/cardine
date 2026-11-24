# Wat in git staat

> **Rol:** Het git-beleid: wat erin hoort, wat nooit, en hoe je dat afdwingt.
> **Niet hier:** het `.gitignore`-bestand zelf ([kit/kern/.gitignore](../kit/kern/.gitignore)).

| In git | Nooit in git |
|--------|--------------|
| Code, configs, lockfiles van de gekozen package manager | Secrets: `.env`, `.env.*`, keys |
| Alle docs, ook `work/` (solo) | `data/raw/`, `external/`, `interim/`, `runtime/`, `models/` |
| `data/reference/`, `data/processed/demo/`, elke `README.md` in `data/` | `data/processed/` buiten `demo/` |
| `.env.example` | Build-output en caches: `node_modules/`, `.pnpm-store/`, `.next/`, `dist/`, `.venv/`, `*.egg-info/` |
| Kleine, synthetische fixtures | `tmp/`, testrapporten, screenshots van testruns |
| Gedeelde editor-instellingen (`.vscode/extensions.json`) | Persoonlijke editor-instellingen, `*.sync-conflict-*`, `.DS_Store` |

- Het volledige `.gitignore`-blok staat één keer, in [kit/kern/.gitignore](../kit/kern/.gitignore). Projectspecifieke regels zet je onderaan, onder een eigen kopje.
- **`.gitignore` werkt niet met terugwerkende kracht.** Iets dat al gecommit is, haal je uit de index met `git rm -r --cached <pad>`. Het bestand blijft dan lokaal staan.
- De pre-commit-hooks uit [kit/kern/.pre-commit-config.yaml](../kit/kern/.pre-commit-config.yaml) blokkeren deterministisch wat `.gitignore` alleen vraagt: bestanden boven 1 MB, secrets, ruwe data die met `git add -f` toch binnen zou komen, en sync-conflictbestanden (P14).

---
