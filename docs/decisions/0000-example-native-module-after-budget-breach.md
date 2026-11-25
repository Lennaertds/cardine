# 0000 — Example: a native module after a budget breach on a hot path

- **Status:** example (not accepted — copy it to a new number via `make adr` and adjust)
- **Date:** 2026-10-26
- **Touches:** `docs/architecture/polyglot.md`, `docs/architecture/performance.md`, `<path to the hot path>`

## Summary

In the context of a measured p95 overrun on `<endpoint or job>`, faced with CPU-bound work that in-stack optimisation did not bring under budget, we chose a **native module (Rust/C) via FFI** over "more hardware / a pure Python rewrite", in order to meet the budget, and we accept extra build tooling and a seam that must be tested.

## Context

- Budget: see `docs/architecture/performance.md` (row `<metric>`).
- Measurement: `make bench-<app>` / obs on `<date>` — p95 was `<X>` (budget `<Y>`).
- In-stack attempts: `<a brief list of what did not help enough>`.
- The polyglot agreement: [polyglot.md](../architecture/polyglot.md).

## Decision

We introduce a native module for `<a well-scoped pure function>`, called from `<Nest/Next/Python>`, with integration form **FFI** (or: sidecar / separate process — pick one). No synchronous CPU work on the HTTP request path outside that call. An ADR is mandatory before the directory or crate lands.

## Alternatives

| Option | Why not |
|-------|-------------|
| More caching or batching in TS/Python only | Already tried; the budget stays broken |
| A sidecar instead of FFI | An unnecessary network hop for this pure function |
| Do nothing / widen the budget | Not a product choice without an explicit "change the budget" ADR |

## Consequences

- **Easier:** the hot path meets its budget; the boundary is one tested seam.
- **Harder or risky:** CI and toolchain, debugging across language boundaries, `deps-audit` and cargo later.
- **To do:** the seam in `ARCHITECTURE.md`; a green bench; remove the row in the `polyglot.md` project notes if there was one.
