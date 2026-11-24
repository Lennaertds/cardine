# How-to — deps-audit

> **Rol:** `make deps-audit` draaien en audit-tools installeren.
> **Niet hier:** ritueel en ADR-beleid ([architecture/dependencies.md](../architecture/dependencies.md)).

## deps-audit

```bash
make deps-audit
```

Controleert vaste secties in `docs/architecture/dependencies.md` en runt audits voor elke gevonden stack (JS, Python; Rust stub). Zit in `make check-full`, niet in `make check`.

## Tools

| Stack | Tool | Tip |
|-------|------|-----|
| JS/TS | `pnpm` of `npm` (meegeleverd) | Lockfile aanwezig houden (`pnpm-lock.yaml` / `package-lock.json`) |
| Python | `pip-audit` of `uv` | `pipx install pip-audit` of recente `uv` |
| Rust | `cargo-audit` | `cargo install cargo-audit` — script meldt stub tot aangesloten |

Zonder tool: waarschuwing + skip voor die stack. Installeer de tool vóór release/`check-full` in CI.

Uitbreidingen (license-gate, SBOM, `TARGET=`, …): zie `## Bewust later` in [dependencies.md](../architecture/dependencies.md) (P28) — vraag ernaar als nodig.

## CVE gevonden

1. Upgrade of patch in de lockfile.
2. Lukt dat niet: ADR met waarom je de dep houdt + mitigerende maatregel.
3. Opnieuw `make deps-audit` tot groen (of ADR + bewuste ignore — documenteer, niet stil).
