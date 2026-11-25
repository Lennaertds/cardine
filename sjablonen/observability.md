# docs/architecture/observability.md

> **Role:** Signals, the kit-default LGTM stack and how to start observability locally.
> **Not here:** security threats ([security](security.md)), containers ([architecture](architecture.md)).

**Kit file:** [kit/kern/docs/architecture/observability.md](../kit/kern/docs/architecture/observability.md) · layer kern · runtime: module `observability` · P13 · source §48 (only in Agent Engineering `bron/`, do not repeat it in project docs)

## When

Day 0 with the stack table from the kit. With every new service: update signals + correlation fields. OTel in the apps can come later (BACKLOG) as long as this doc says *what* is mandatory. AGENTS does **not** load this always-on — only via INDEX when the task names it.

## Filling in

1. **Stack:** keep the kit default (OTel → Alloy → Prometheus/Loki/Tempo → Grafana), or write an ADR + change this file. Write "kit default", not "default for all projects as if everything were already live".
2. **Production:** where Grafana/OTel ingest runs.
3. **SLOs:** at least one user-facing target per productive service.
4. **Module:** `kit/new-project.sh … --modules …,observability` for compose + `make obs-up`. Without the module: compose is missing → Deliberately incomplete / BACKLOG.
5. **`## Deliberately incomplete` (P28):** keep the kit rows or extend them (P28). No paths into Agent Engineering `bron/` in the project file.

## Quick check

- [ ] No high-cardinality labels on metrics (`user_id`, raw URL, …).
- [ ] `make help` shows `obs-up` / `security-scan`; they are not in `make check`.
- [ ] Without the module, `obs-up` fails with "kit: --modules observability".
- [ ] `## Deliberately incomplete` has at least one extension row (P28).
- [ ] No "Agent Engineering source §…" in the project doc.
