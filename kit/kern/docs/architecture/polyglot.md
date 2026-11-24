# Polyglot

> **Rol:** Wanneer een extra taal (Rust, C, …) mag, hoe je dat beslist, en wat een agent zonder akkoord mag doen.
> **Niet hier:** latency-budgets ([performance.md](performance.md)); containerlijst ([ARCHITECTURE.md](ARCHITECTURE.md)); CVE-audits ([dependencies.md](dependencies.md)).

Extra systemstalen zijn **toegestaan** voor hot paths na meting + ADR — niet omdat het “cooler” is, en niet omdat de agent aanneemt dat Rust/C “niet mag”. Native app-mappen bestaan **alleen** als dit project die stack koos (`--stacks rust` → `apps/native`, `--stacks c` → `apps/native-c`). Zonder die mappen: geen FFI aannemen; eerst meten, ADR, dan stack toevoegen.

## Relatie tot andere docs

| Hier | Elders |
|------|--------|
| Beslisboom taal + grenzen FFI/sidecar | `performance.md` — budgets en anti-patronen |
| Wat in `apps/` / seams mag | `ARCHITECTURE.md` — containers, seams |
| Voorbeeld-ADR-vorm | `docs/decisions/0000-voorbeeld-native-module-na-budget-breuk.md` |
| Soft vs hard FFI in CI | [how-to/native-ci.md](../how-to/native-ci.md) |

## Beslisboom

1. **Meet** het hot path (`make bench-*` en/of obs: p95, CPU, allocaties).
2. **Budget gebroken?** Zo nee: optimaliseer in de bestaande stack (algoritme, I/O, caching). Zo ja: ga door.
3. **Native overwegen** (Rust/C of andere systemstaal) alleen met meetbaar probleem.
4. **ADR vóór** nieuwe taalmap, crate, of FFI-grens (zie voorbeeld-ADR). Status `aanvaard` → pas code / stack.
5. **Kies integratie** (tabel hieronder) en leg die in de ADR + `ARCHITECTURE.md` (nieuwe container of seam).
6. **Bench opnieuw** tegen hetzelfde budget; zo niet: terug of andere optie.

```
budget OK? ──ja──► blijf in bestaande stack-talen
     │
    nee
     ▼
optimaliseer in-stack ──helpt──► klaar
     │
  helpt niet
     ▼
ADR + native (FFI / sidecar / proces) → opnieuw meten
```

## Integratievormen

| Vorm | Wanneer | Let op |
|------|---------|--------|
| **FFI / native module** in bestaande app | Zelfde proces, lage latency, duidelijke pure functie | Build-tooling, ABI, geen secrets in native logs |
| **Sidecar** (aparte binary naast de app) | Eigen lifecycle, andere resource-limits | Compose/poorten in `ARCHITECTURE.md`; healthchecks |
| **Apart proces / job** (batch, queue-worker) | CPU-zwaar, mag async | Geen sync-wacht op HTTP-request-pad |

SQL/analytics blijft Python/SQL tenzij een mart aantoonbaar CPU-gebonden is (zelfde boom + ADR).

## Wat de agent mag

| Zonder akkoord | Eerst vragen of ADR |
|----------------|---------------------|
| Optimaliseren binnen bestaande stack/taal | Nieuwe map `apps/<native-…>`, crate, of `.rs`/`.c` in de repo |
| Bench/obs gebruiken om een vermoeden te staven | FFI-binding of sidecar toevoegen |
| Verwijzen naar deze doc + voorbeeld-ADR | Aannemen dat Rust/C “niet mag”, “altijd moet”, of dat `apps/native` al bestaat |

### Als native-stacks aanwezig zijn

| Stack | App | Check | Starter-FFI (met `--starter`) |
|-------|-----|-------|-------------------------------|
| `rust` | `apps/native` | `make check-native` | napi + PyO3 |
| `c` | `apps/native-c` | `make check-native-c` | N-API stub + ctypes |

ADR kiest taal + FFI-pad (of meerdere seams). Ontbreekt de app-map: die stack hoort (nog) niet bij dit project.

## Commando's

```bash
make polyglot-check            # vaste secties in dit bestand; niet in make check
make perf-check                # budgets aanwezig
make bench                     # meting vóór native-keuze
make check-native              # soft FFI (alleen met rust-stack)
make check-native-c            # soft FFI (alleen met c-stack)
NATIVE_STRICT=1 make check-native   # hard (of via check-full)
make check-full                # soft check + native-bindings-strict
```

Soft vs hard FFI: [how-to/native-ci.md](../how-to/native-ci.md). Team: `.github/workflows/native.yml` (als native-stacks meekwamen).

## Bewust later

Vaste kop (P28): vraag ernaar of BACKLOG als dit nodig wordt.

| Uitbreiding | Waarom later | Vraag als |
|-------------|--------------|-----------|
| Volledige N-API/`#[napi]` build.rs in de kit-starter | Soft check + STRICT via maturin/pnpm in project-CI; kit levert scaffolds | Day-1 `.node` zonder project-toolchain |
| Sidecar-compose-sjabloon | FFI-pad dekt hot path; sidecar is ADR-keuze | Compose/healthchecks standaard voor native |
| `cargo`/`cc` in `TOOLS` zonder native-stack | Geen native in elk project | Altijd toolchains op elke machine |
