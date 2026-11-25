# Dependencies

> **Role:** the agreement on dependency hygiene: CVE audits, the ritual, and when to consider a faster/safer alternative.
> **Not here:** how to run the audit ([how-to/deps-audit.md](../how-to/deps-audit.md)); latency budgets ([performance.md](performance.md)); threats/auth ([security.md](security.md)).

Supply chain and package maintenance are part of engineering discipline, not just "security later".

## Relation to other docs

| Here | Elsewhere |
|------|-----------|
| Which audits, the ritual, deliberate exceptions (ADR) | `security.md` — auth, secrets, Strix |
| "Slow / does this package drag?" | `performance.md` — budgets; then possibly another dependency |
| `make deps-audit` (in `check-full`) | How-to for tools and flags |

## Audits per stack

| Ecosystem | Detection | Command (via script) | Fails on |
|-----------|-----------|----------------------|----------|
| JS/TS | `package.json` (apps or root) | `pnpm audit` / `npm audit` (`--audit-level=high`) | high / critical |
| Python | `pyproject.toml` / `requirements*.txt` | `pip-audit` or `uv pip audit` | known CVEs |
| Rust | `Cargo.toml` | stub: `cargo audit` (install `cargo-audit`) | wired up later |

Rows without those files in the project: the script skips that stack. Missing the tool: a warning, not a silent "green" as if you had scanned — see the how-to. Deliberate omissions: [Deliberately later](#deliberately-later) (P28).

## Ritual

1. **On release / nightly CI:** `make check-full` (includes `deps-audit`).
2. **Monthly (or after a big bump):** `make deps-audit` plus a short review:
   - Which high/critical are open? Patch, pin, or an ADR "deliberately keep".
   - Is a package slow or dragging? Measure (`bench` / obs) → a faster/safer alternative, or drop it.
3. **New dependency:** through the stack command in `AGENTS.md` by default; not "just a quick pip install" outside the lockfile.

## Faster / safer alternatives

No always-on radar in AGENTS. Instead:

- A periodic question in this ritual or in `docs/research/wantlist.md` / `docs/research/radar.md` (module `research`).
- A deliberate choice for a weaker or slower dependency → ADR (license/CVE/perf trade-off).
- Tech radar (Adopt/Trial/…): module `research` → `docs/research/radar.md`; scrapers → Deliberately later there.

## Commands

```bash
make deps-audit     # docs structure + audits for each stack present
make check-full     # check + deps-audit + CHECK_FULL (e2e, …)
```

Not in `make check` (network/registry; can produce noise). See [how-to/deps-audit.md](../how-to/deps-audit.md).

## Deliberately later

Fixed heading (P28): what the kit **deliberately** does not ship. Ask about it or file a project BACKLOG item when this becomes needed — do not guess, and do not silently assume it "is not allowed".

| Extension | Why later | Ask when |
|-----------|-----------|----------|
| License allowed-list in `deps-audit` | v1 = CVE hygiene | Compliance/school requires a license scan |
| SBOM (CycloneDX etc.) | Extra tooling/format | Customer or supply-chain audit |
| `cargo audit` permanent (not just a stub message) | No Rust stack in the core | First production `Cargo.toml` |
| `TARGET=` / limit the scan to one path | Rarely needed in a typical monorepo | Audit noise or CI time too high |
| Auto-Adopt of digest proposals in the dependency choice | The digest proposes; a human chooses (P5) | A feed may change a dependency default |
