# 0000 — Voorbeeld: native module na budget-breuk op hot path

- **Status:** voorbeeld (niet aanvaard — kopieer naar een nieuw nummer via `make adr` en pas aan)
- **Datum:** {{DATE}}
- **Raakt:** `docs/architecture/polyglot.md`, `docs/architecture/performance.md`, `<pad naar hot path>`

## Samenvatting

In de context van een gemeten p95-overschrijding op `<endpoint of job>`, geconfronteerd met CPU-gebonden werk dat in-stack optimalisatie niet onder het budget bracht, kozen we voor een **native module (Rust/C) via FFI** en tegen “meer hardware / pure Python-rewrite”, om het budget te halen, en we aanvaarden extra build-tooling en een seam die getest moet worden.

## Context

- Budget: zie `docs/architecture/performance.md` (rij `<metric>`).
- Meting: `make bench-<app>` / obs op `<datum>` — p95 was `<X>` (budget `<Y>`).
- In-stack pogingen: `<korte opsomming wat niet genoeg hielp>`.
- Polyglot-afspraak: [polyglot.md](../architecture/polyglot.md).

## Besluit

We introduceren een native module voor `<afgebakende pure functie>`, aangeroepen vanuit `<Nest/Next/Python>`, met integratievorm **FFI** (of: sidecar / apart proces — kies er één). Geen sync CPU-werk meer op het HTTP-request-pad buiten die call. ADR is verplicht vóór de map/crate landt.

## Alternatieven

| Optie | Waarom niet |
|-------|-------------|
| Alleen meer caching / batch in TS/Python | Al geprobeerd; budget blijft gebroken |
| Sidecar i.p.v. FFI | Onnodige netwerkhop voor deze pure functie |
| Niets doen / budget oprekken | Geen productkeuze zonder expliciete ADR “budget wijzigen” |

## Gevolgen

- **Makkelijker:** hot path haalt budget; grens is één geteste seam.
- **Moeilijker of risico:** CI/toolchain, debug over taalgrenzen, `deps-audit`/cargo later.
- **Te doen:** seam in `ARCHITECTURE.md`; bench groen; eventueel rij in `polyglot.md` projectnotities schrappen als die er waren.
