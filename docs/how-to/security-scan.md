# How-to — security scan (Strix)

> **Role:** install Strix and run a scan against a target you have permission for.
> **Not here:** this project's threats and measures ([security.md](../architecture/security.md)).

## Requirements

1. Docker is running.
2. `strix` on PATH (`curl -sSL https://strix.ai/install | bash` or `pipx install strix-agent`).
3. An LLM key set (`LLM_API_KEY` / the provider per the Strix docs; optionally `STRIX_LLM=…`).
4. The target is your own repo, staging, or a system you are explicitly allowed to scan — **never** someone else's production without a mandate.

## Commands

```bash
make security-scan-quick          # quick scan of .
make security-scan                # deeper scan of .
make security-scan TARGET=./apps/api
make security-scan-quick TARGET=https://localhost:3000
```

Agent skills (optional): `npx usestrix/strix`.

## Result

Outputs under `strix_runs/` (JSON/CSV/SARIF per Strix). Take findings with a working PoC seriously; triage false positives in a BACKLOG item or issue.

Missing Docker/strix/key: the Make target fails with a clear message — then add an item to `docs/work/BACKLOG.md` (§ Later) instead of ignoring the docs.
