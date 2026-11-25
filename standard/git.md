# What lives in git

> **Role:** The git policy: what belongs in it, what never does, and how you enforce that.
> **Not here:** the `.gitignore` file itself ([kit/kern/.gitignore](../kit/kern/.gitignore)).

| In git | Never in git |
|--------|--------------|
| Code, configs, lockfiles of the chosen package manager | Secrets: `.env`, `.env.*`, keys |
| All docs, including `work/` (solo) | `data/raw/`, `external/`, `interim/`, `runtime/`, `models/` |
| `data/reference/`, `data/processed/demo/`, every `README.md` in `data/` | `data/processed/` outside `demo/` |
| `.env.example` | Build output and caches: `node_modules/`, `.pnpm-store/`, `.next/`, `dist/`, `.venv/`, `*.egg-info/` |
| Small, synthetic fixtures | `tmp/`, test reports, screenshots of test runs |
| Shared editor settings (`.vscode/extensions.json`) | Personal editor settings, `*.sync-conflict-*`, `.DS_Store` |

- The full `.gitignore` block sits in one place, in [kit/kern/.gitignore](../kit/kern/.gitignore). Put project-specific rules at the bottom, under their own heading.
- **`.gitignore` does not work retroactively.** Something already committed is removed from the index with `git rm -r --cached <path>`. The file then stays on disk.
- The pre-commit hooks from [kit/kern/.pre-commit-config.yaml](../kit/kern/.pre-commit-config.yaml) deterministically block what `.gitignore` only asks for: files above 1 MB, secrets, raw data that would slip in anyway via `git add -f`, and sync-conflict files (P14).

---
