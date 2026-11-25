# Polyglot

> **Role:** when an extra language (Rust, C, …) is allowed, how to decide that, and what an agent may do without approval.
> **Not here:** latency budgets ([performance.md](performance.md)); container list ([ARCHITECTURE.md](ARCHITECTURE.md)); CVE audits ([dependencies.md](dependencies.md)).

Extra systems languages are **allowed** for hot paths after measuring + an ADR — not because it is "cooler", and not because the agent assumes Rust/C "is not allowed". Native app directories exist **only** if this project chose that stack (`--stacks rust` → `apps/native`, `--stacks c` → `apps/native-c`). Without those directories: do not assume FFI; measure first, ADR, then add the stack.

## Relation to other docs

| Here | Elsewhere |
|------|-----------|
| Decision tree for a language + FFI/sidecar boundaries | `performance.md` — budgets and anti-patterns |
| What may live in `apps/` / seams | `ARCHITECTURE.md` — containers, seams |
| Example ADR shape | `docs/decisions/0000-example-native-module-after-budget-breach.md` |
| Soft vs hard FFI in CI | [how-to/native-ci.md](../how-to/native-ci.md) |

## Decision tree

1. **Measure** the hot path (`make bench-*` and/or obs: p95, CPU, allocations).
2. **Budget broken?** If not: optimise within the existing stack (algorithm, I/O, caching). If so: continue.
3. **Consider native** (Rust/C or another systems language) only with a measurable problem.
4. **ADR first**, before a new language directory, crate, or FFI boundary (see the example ADR). Status `accepted` → only then code / stack.
5. **Choose the integration** (table below) and record it in the ADR + `ARCHITECTURE.md` (new container or seam).
6. **Bench again** against the same budget; if not met: back out or take another option.

```
budget OK? ──yes──► stay in the existing stack languages
     │
     no
     ▼
optimise in-stack ──helps──► done
     │
  does not help
     ▼
ADR + native (FFI / sidecar / process) → measure again
```

## Integration forms

| Form | When | Watch out for |
|------|------|---------------|
| **FFI / native module** in the existing app | Same process, low latency, a clear pure function | Build tooling, ABI, no secrets in native logs |
| **Sidecar** (a separate binary next to the app) | Its own lifecycle, different resource limits | Compose/ports in `ARCHITECTURE.md`; healthchecks |
| **Separate process / job** (batch, queue worker) | CPU-heavy, may be async | No synchronous wait on the HTTP request path |

SQL/analytics stays Python/SQL unless a mart is demonstrably CPU-bound (same tree + ADR).

## What the agent may do

| Without approval | Ask first or file an ADR |
|------------------|--------------------------|
| Optimise within the existing stack/language | A new `apps/<native-…>` directory, crate, or `.rs`/`.c` in the repo |
| Use bench/obs to support a suspicion | Adding an FFI binding or a sidecar |
| Refer to this doc + the example ADR | Assume Rust/C "is not allowed", "is always required", or that `apps/native` already exists |

### If native stacks are present

| Stack | App | Check | Starter FFI (with `--starter`) |
|-------|-----|-------|--------------------------------|
| `rust` | `apps/native` | `make check-native` | napi + PyO3 |
| `c` | `apps/native-c` | `make check-native-c` | N-API stub + ctypes |

The ADR picks the language + FFI path (or several seams). If the app directory is missing, that stack does not (yet) belong to this project.

## Commands

```bash
make polyglot-check            # fixed sections in this file; not in make check
make perf-check                # budgets present
make bench                     # measurement before a native choice
make check-native              # soft FFI (only with the rust stack)
make check-native-c            # soft FFI (only with the c stack)
NATIVE_STRICT=1 make check-native   # hard (or via check-full)
make check-full                # soft check + native-bindings-strict
```

Soft vs hard FFI: [how-to/native-ci.md](../how-to/native-ci.md). Team: `.github/workflows/native.yml` (if native stacks were included).

## Deliberately later

Fixed heading (P28): ask about it or file a BACKLOG item when this becomes needed.

| Extension | Why later | Ask when |
|-----------|-----------|----------|
| Full N-API/`#[napi]` build.rs in the kit starter | Soft check + STRICT via maturin/pnpm in project CI; the kit ships scaffolds | Day-1 `.node` without a project toolchain |
| Sidecar compose template | The FFI path covers the hot path; a sidecar is an ADR choice | Compose/healthchecks standard for native |
| `cargo`/`cc` in `TOOLS` without a native stack | No native in every project | Toolchains always needed on every machine |
