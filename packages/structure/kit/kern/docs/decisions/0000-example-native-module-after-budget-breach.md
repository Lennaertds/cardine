# 0000 — Example: native module after a budget breach on a hot path

- **Status:** example (not accepted — copy it to a new number with `make adr` and adapt)
- **Date:** {{DATE}}
- **Touches:** `docs/architecture/polyglot.md`, `docs/architecture/performance.md`, `<path to hot path>`

## Summary

In the context of a measured p95 breach on `<endpoint or job>`, faced with CPU-bound work that in-stack optimisation did not bring under budget, we chose a **native module (Rust/C) via FFI** and against "more hardware / pure Python rewrite", in order to meet the budget, accepting extra build tooling and a seam that has to be tested.

## Context

- Budget: see `docs/architecture/performance.md` (row `<metric>`).
- Measurement: `make bench-<app>` / obs on `<date>` — p95 was `<X>` (budget `<Y>`).
- In-stack attempts: `<brief list of what did not help enough>`.
- Polyglot agreement: [polyglot.md](../architecture/polyglot.md).

## Decision

We introduce a native module for `<bounded pure function>`, called from `<Nest/Next/Python>`, with integration form **FFI** (or: sidecar / separate process — pick one). No more sync CPU work on the HTTP request path outside that call. An ADR is required before the folder/crate lands.

## Alternatives

| Option | Why not |
|--------|---------|
| More caching / batching in TS/Python only | Already tried; the budget stays breached |
| Sidecar instead of FFI | An unnecessary network hop for this pure function |
| Doing nothing / raising the budget | Not a product choice without an explicit "change the budget" ADR |

## Consequences

- **Easier:** the hot path meets budget; the boundary is one tested seam.
- **Harder or risky:** CI/toolchain, debugging across language boundaries, `deps-audit`/cargo later.
- **To do:** seam in `ARCHITECTURE.md`; bench green; remove any project-note row in `polyglot.md` if it was there.
