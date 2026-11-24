# Dependencies

> **Rol:** Afspraak over dependency-hygiëne: CVE-audits, ritueel, en wanneer je een sneller/veiliger alternatief overweegt.
> **Niet hier:** hoe je de audit draait ([how-to/deps-audit.md](../how-to/deps-audit.md)); latency-budgets ([performance.md](performance.md)); dreigingen/auth ([security.md](security.md)).

Supply-chain en onderhoud van packages horen bij engineering-discipline, niet alleen bij “security later”.

## Relatie tot andere docs

| Hier | Elders |
|------|--------|
| Welke audits, ritueel, bewuste uitzonderingen (ADR) | `security.md` — auth, secrets, Strix |
| “Traag / sleept deze package?” | `performance.md` — budgets; daarna eventueel andere dep |
| `make deps-audit` (in `check-full`) | How-to voor tools en flags |

## Audits per stack

| Ecosysteem | Detectie | Commando (via script) | Faalt op |
|------------|----------|------------------------|----------|
| JS/TS | `package.json` (apps of root) | `pnpm audit` / `npm audit` (`--audit-level=high`) | high / critical |
| Python | `pyproject.toml` / `requirements*.txt` | `pip-audit` of `uv pip audit` | bekende CVE’s |
| Rust | `Cargo.toml` | stub: `cargo audit` (installeer `cargo-audit`) | later aangesloten |

Rijen zonder die bestanden in het project: het script slaat die stack over. Ontbreekt de tool: waarschuwing, geen stille “groen” alsof je gescand hebt — zie how-to. Bewuste weglatingen: [Bewust later](#bewust-later) (P28).

## Ritueel

1. **Bij release / nachtelijke CI:** `make check-full` (bevat `deps-audit`).
2. **Maandelijks (of na grote bump):** `make deps-audit` + korte review:
   - Welke high/critical open? Patch, pin, of ADR “bewust houden”.
   - Vertraagt of sleept een package? Meet (`bench` / obs) → sneller/veiliger alternatief of schrappen.
3. **Nieuwe dependency:** standaard via stack-commando in `AGENTS.md`; niet “even pip install” buiten de lockfile.

## Snellere / veiligere alternatieven

Geen always-on radar in AGENTS. Wel:

- Periodieke vraag in dit ritueel of in `docs/research/wantlist.md` / `docs/research/radar.md` (module `research`).
- Bewuste keuze voor een zwakkere of tragere dep → ADR (compromis license/CVE/perf).
- Tech-radar (Adopt/Trial/…): module `research` → `docs/research/radar.md`; scrapers → Bewust later daar.

## Commando's

```bash
make deps-audit     # docs-structuur + audits per aanwezige stack
make check-full     # check + deps-audit + CHECK_FULL (e2e, …)
```

Niet in `make check` (netwerk/registry; kan noise geven). Zie [how-to/deps-audit.md](../how-to/deps-audit.md).

## Bewust later

Vaste kop (P28): wat de kit **bewust** niet meelevert. Vraag ernaar of zet een project-BACKLOG-item als dit nodig wordt — niet gissen of stil aannemen dat het “niet mag”.

| Uitbreiding | Waarom later | Vraag als |
|-------------|--------------|-----------|
| License-allowed-list in `deps-audit` | v1 = CVE-hygiëne | Compliance/school eist license-scan |
| SBOM (CycloneDX e.d.) | Extra tooling/format | Klant of supply-chain-audit |
| `cargo audit` vast (niet alleen stub-melding) | Geen Rust-stack in kern | Eerste productie-`Cargo.toml` |
| `TARGET=` / scan beperken tot één pad | Zelden nodig in typische monorepo | Audit-noise of CI-tijd te hoog |
| Auto-Adopt van digest-voorstellen in deps-keuze | Digest stelt voor; mens kiest (P5) | Feed mag dependency-default wijzigen |
