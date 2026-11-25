# Step 2 — Context and boundaries

> **Role:** Before the first line of code, record what cannot be derived from the code: for whom, why, what never, and the big choices.
> **Not here:** how to fill in each file (the guides in [sjablonen](../sjablonen/INDEX.md)).

## Do

| # | File | What | Guide |
|---|------|------|-------|
| 1 | `docs/context/CONTEXT.md` | user or client, problem, what success is, scope, deliberately not | [context](../sjablonen/context.md) |
| 2 | `docs/rules/RULES.md` | the three to five content boundaries you already know | [rules](../sjablonen/rules.md) |
| 3 | `docs/context/GLOSSARY.md` | the first five terms and the domains, with the name that also goes into the code (P10) | [glossary](../sjablonen/glossary.md) |
| 4 | `docs/architecture/ARCHITECTURE.md` | container diagram: which apps, which databases, who writes where | [architecture](../sjablonen/architecture.md) |
| 5 | `docs/architecture/security.md` | personal data, secrets, Strix agreements | [security](../sjablonen/security.md) |
| 6 | `docs/architecture/observability.md` | signals + LGTM stack (fill in production hosting) | [observability](../sjablonen/observability.md) |
| 7 | `docs/architecture/performance.md` | budgets (API→web→analytics) + anti-patterns | [performance](../sjablonen/performance.md) |
| 8 | `docs/decisions/` | one ADR per choice you make now: stack, database, hosting, obs/security/perf | [adr](../sjablonen/adr.md) |
| 9 | modules | `assignment.md`, `vision.md`, `PRODUCT.md` if you chose them | [assignment](../sjablonen/assignment.md), [vision](../sjablonen/vision.md), [product](../sjablonen/product.md) |

```bash
make adr t="Next.js and NestJS in a pnpm workspace"
make adr t="Postgres is the only writer of user data"
make adr t="One Railway project with two domains"
make adr t="LGTM self-hosted (OTel Alloy Prometheus Loki Tempo Grafana) as the observability stack"
make adr t="Strix as the active security scan via make security-scan"
make adr t="Performance budgets in performance.md; measured via obs and make bench"
```

## Design before code (P18, P22, P23; source §2, §6, §7, §32)

- **Let an agent interview you** about the idea until the edge cases are clear ("grill me", §1, §7). The result goes into CONTEXT, RULES and product intent, not into a chat log (P22, P27).
- **Decide the modules and their interfaces yourself** (deep modules, grey box): you are the strategic programmer; the agent fills in tactically (§2, §7, §32 / P19, P23). The domain names in the glossary are immediately the folders in `features/<domain>/` and `src/<domain>/`.
- **Draw the container diagram**, nothing more (P12), and fill in **Seams**: the seams + what an agent may do without approval (P23). Classes and files the agent reads from the code.

## Done when

- Someone who reads only these five files can say who it is for, what is never allowed and which apps are coming.
- Every rule in RULES has a why. If it can be enforced, "Guarded by" says which test or hook it becomes.
- `ARCHITECTURE.md` § Seams has at least the seams you already know (or "still to be secured").
- `make check` still fails only on "no app" (the links are right).

## Pitfalls

- **Leaving empty headings behind.** If you do not know something yet, delete the section. It comes back when the question really appears.
- **Technical detail in CONTEXT.** Stack and hosting belong in ARCHITECTURE and the ADRs.
- **Status in a stable doc.** "Currently working on …" belongs in the backlog or the tracker (P8).
