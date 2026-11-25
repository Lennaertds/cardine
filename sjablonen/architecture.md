# docs/architecture/ARCHITECTURE.md

> **Role:** How the system fits together at container level: what runs where, who writes where, what must always be true.
> **Not here:** the folder tree (`ls`), code details (the code), the why ([adr](adr.md)), PWA/offline/push, auth flows, the feature catalogue — those go to `architecture/<subsystem>.md`.

**Kit file:** [kit/kern/docs/architecture/ARCHITECTURE.md](../kit/kern/docs/architecture/ARCHITECTURE.md) · layer kern · P12, P23 (C4 level 1–2; seams before AI volume)

## When

Day 0 with the container diagram. Update it with every new container, service, port, host or **seam**. Depth per subsystem (import, pipeline, LLM, client runtime, auth) goes into its own `architecture/<subsystem>.md`. Without filled-in seams: no large AI refactors on legacy (P23).

## Filling in

1. **System context:** one paragraph, with the external systems.
2. **Containers:** a Mermaid diagram and the table with path, job, port and host. The ports come from the `app.mk` files.
3. **Stack:** the choice per layer with the ADR that justifies it. Native/extra language: link to [polyglot](polyglot.md), do not slip it into the table silently; native folders only if that stack exists.
4. **Dataflow and ownership:** who writes where. This is the section that prevents most mistakes.
5. **Hosting and ports**, **What is in git** (only what deviates from the standard), **Invariants** with their guard.
6. **Seams:** a table with the seams (web→api, api→db, …), which test guards them, and what an agent may do without approval vs. what needs an ADR first (P23).
7. **Subsystems:** links, one sentence each. The kit already delivers polyglot/security/obs/perf/deps. Project depth (PWA chrome, JWT details, onboarding) → its own files, do not dump it here.

## Example (GymFreak)

```markdown
| Container | Path | Job | Local port | Host in production |
|-----------|------|-----|------------|--------------------|
| web | `apps/web` | PWA, server-side rendering | 3002 | Railway, gymfreak.be |
| api | `apps/api` | auth, user data, import | 3003 | Railway, api.gymfreak.be |
| db | docker compose | Postgres 17 | 5433 | Railway Postgres |
| analytics | `apps/analytics` | batch: demo data and evidence index | — | local |

## Dataflow and ownership

- Postgres is the only writer of user data; analytics only reads (ADR 0012).
- Uploads go to `data/runtime/user/` locally and to a Railway volume in production.
- `data/processed/demo/` is in git and is read by the web app for the demo without an account.
```

Keep it thin: PWA/offline/push → `architecture/runtime-client.md`; JWT/demo/onboarding details → `architecture/auth.md` (or data model + legal). ARCHITECTURE stays "where is X / who writes".

## Quick check

- [ ] No classes, no file list, no tree.
- [ ] No long runtime/auth catalogue in this file (P5, harness tax).
- [ ] Every container in the diagram is also in the table, with port and host.
- [ ] "Who writes where" is answered for every database or data folder.
- [ ] Every invariant links to the test or ADR that guards it.
- [ ] Every seam has a guard (test) or is explicitly listed as "still to be guarded".
- [ ] "Allowed without approval" vs. "ADR first" is clear to an agent at a glance.
- [ ] Target length: preferably ≤ ~100 lines; thicker = split into subsystems.
