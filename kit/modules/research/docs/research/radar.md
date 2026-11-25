# Tech radar

> **Role:** Periodic re-assessment of languages, frameworks, dependencies and tooling — what we Adopt/Trial/Assess/Hold.
> **Not here:** acquiring sources ([wantlist.md](wantlist.md)); domain literature (`research/<topic>.md`); CVE scan ([dependencies.md](../architecture/dependencies.md)); raw feeds as truth (P5).

Inbound feeds: [digest/](digest/README.md) (`digest-fetch` / `digest-propose`) — curate proposals before you put a row here (P5). Source/horizon: Agent Engineering `bron/fundament/ecosysteem/kit-dekking-en-horizon.md` (C4).

## Ritual

1. **Monthly** (or after a big bump): `make radar-reminder` → revise this file.
2. Change a ring only with a short note; **Adopt** or **Hold** with impact → ADR.
3. Faster/safer deps: the [dependencies.md](../architecture/dependencies.md) ritual too; the radar keeps the *state of choices*.
4. `make radar-check` after structural edits (not in `make check`).

## Last reviewed

Last reviewed: {{DATE}}

(Set the date on every substantive update. `make radar-reminder` reads this line.)

## Rings

| Ring | Meaning |
|------|---------|
| **Adopt** | Default choice for new work; team/solo knows it |
| **Trial** | Actively trying it in one slice/app; not a default yet |
| **Assess** | On the radar; no time/experiment yet |
| **Hold** | Deliberately not (any more) for new work; existing code may stay until an ADR |

## Radar

Replace the example rows with project choices. The example rows are **illustrative**, not a fact about your stack.

| Ring | Category | Item | Note / ADR |
|------|----------|------|------------|
| Adopt | languages | TypeScript (Nest/Next) | kit default; see ARCHITECTURE |
| Adopt | frameworks | Postgres 17 | only writer of user data → ADR |
| Trial | deps | `<faster JSON lib>` | example — measure before Adopt |
| Assess | tooling | `<bundler X>` | example — no experiment yet |
| Hold | deps | `<outdated ORM>` | example — no new use; migration ADR |

Categories (keep fixed): **languages** · **frameworks** · **deps** · **tooling**.

## Commands

```bash
make radar-check      # structure + Deliberately later; needs the research module
make radar-reminder   # hint + Last reviewed date
```

How-to: [../how-to/radar.md](../how-to/radar.md).

## Deliberately later

Fixed heading (P28): ask for it or file it in BACKLOG when this becomes needed.

| Extension | Why later | Ask when |
|-----------|-----------|----------|
| Auto-pasting digest proposals into this file | P5 — proposal ≠ fact | Zero-touch radar updates |
| Radar in **kern** (every project) | Opt-in via module `research` is enough | A project without research still wants a radar |
| Always-on rule in AGENTS | Harness tax (P25) | Every task has to see the radar (usually not) |
| `radar-check` in `check-full` | Deliberately monthly, not on every PR | A release gate demands a fresh review |
| Visual / HTML export of the rings | Markdown is enough for agents | A stakeholder wants a picture |
