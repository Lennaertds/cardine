# How-to — deps-audit

> **Role:** Run `make deps-audit` and install the audit tools.
> **Not here:** ritual and ADR policy ([architecture/dependencies.md](../architecture/dependencies.md)).

## deps-audit

```bash
make deps-audit
```

Checks the fixed sections in `docs/architecture/dependencies.md` and runs audits for every stack it finds (JS, Python; Rust stub). It is part of `make check-full`, not `make check`.

## Tools

| Stack | Tool | Tip |
|-------|------|-----|
| JS/TS | `pnpm` or `npm` (bundled) | Keep a lockfile (`pnpm-lock.yaml` / `package-lock.json`) |
| Python | `pip-audit` or `uv` | `pipx install pip-audit` or a recent `uv` |
| Rust | `cargo-audit` | `cargo install cargo-audit` — the script reports a stub until it is wired up |

Without the tool: a warning + skip for that stack. Install the tool before a release / `check-full` in CI.

Extensions (licence gate, SBOM, `TARGET=`, …): see `## Deliberately later` (P28) in [dependencies.md](../architecture/dependencies.md) — ask for them when needed.

## CVE found

1. Upgrade or patch in the lockfile.
2. If that does not work: an ADR with why you keep the dependency + the mitigating measure.
3. `make deps-audit` again until green (or ADR + a deliberate ignore — document it, do not stay silent).
