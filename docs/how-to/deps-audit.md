# How-to — deps-audit

> **Role:** run `make deps-audit` and install the audit tools.
> **Not here:** the ritual and ADR policy ([architecture/dependencies.md](../architecture/dependencies.md)).

## deps-audit

```bash
make deps-audit
```

Checks the fixed sections in `docs/architecture/dependencies.md` and runs audits for each stack it finds (JS, Python; Rust stub). Part of `make check-full`, not of `make check`.

## Tools

| Stack | Tool | Tip |
|-------|------|-----|
| JS/TS | `pnpm` or `npm` (already present) | Keep the lockfile (`pnpm-lock.yaml` / `package-lock.json`) |
| Python | `pip-audit` or `uv` | `pipx install pip-audit` or a recent `uv` |
| Rust | `cargo-audit` | `cargo install cargo-audit` — the script reports a stub until it is wired up |

Without the tool: a warning and a skip for that stack. Install the tool before release / `check-full` in CI.

Extensions (licence gate, SBOM, `TARGET=`, …): see `## Deliberately later` in [dependencies.md](../architecture/dependencies.md) (P28) — ask about them when needed.

## CVE found

1. Upgrade or patch in the lockfile.
2. If that does not work: an ADR explaining why you keep the dependency, plus the mitigating measure.
3. Run `make deps-audit` again until green (or an ADR plus a deliberate ignore — document it, do not do it silently).
