# Tech-radar

> **Role:** periodic re-weighing of languages, frameworks, dependencies and tooling — what we Adopt/Trial/Assess/Hold.
> **Not here:** acquiring sources ([wantlist.md](wantlist.md)); domain literature (`research/<topic>.md`); the CVE scan ([dependencies.md](../architecture/dependencies.md)); raw feeds as truth (P5).

Inbound feeds: [digest/](digest/README.md) (`digest-fetch` / `digest-propose`) — curate proposals before adding a row here (P5). Horizon: `bron/fundament/ecosysteem/kit-dekking-en-horizon.md`.

## Ritual

1. **Monthly** (or after a large bump): `make radar-reminder` → review this file.
2. Change a ring only with a short note; **Adopt** or **Hold** with impact → an ADR.
3. Faster or safer dependencies: also the [dependencies.md](../architecture/dependencies.md) ritual; the radar holds the *state of the choice*.
4. `make radar-check` after structural edits (not in `make check`).

## Last reviewed

Last reviewed: 2026-10-26

(Update the date on every substantive change. `make radar-reminder` reads this line.)

## Rings

| Ring | Meaning |
|------|-----------|
| **Adopt** | The default choice for new stubs; the team or solo developer knows it |
| **Trial** | Actively tried in one slice or app; not yet a default |
| **Assess** | On the radar; no time or experiment yet |
| **Hold** | Deliberately not (again) for new work; existing code may stay until an ADR |

## Radar

Replace the example rows with project choices. Example rows are **illustrative**, not a fact about your stack.

| Ring | Category | Item | Note / ADR |
|------|-----------|------|---------------|
| Adopt | languages | TypeScript (Nest/Next) | kit default; see ARCHITECTURE |
| Adopt | frameworks | Postgres 17 | the only writer of user data → ADR |
| Trial | deps | `<a faster JSON lib>` | example — measure before Adopt |
| Assess | tooling | `<bundler X>` | example — no experiment yet |
| Assess | benchmarks | Artificial Analysis (models + coding agents + providers) | Watch §80/§95/§142; reload before citing; never Adopt |
| Assess | learning | Decode / Vercel Academy harness courses | §105/§109 — a learning path, not a product Adopt |
| Assess | models | Mistral Large 4 / Medium 3.5 / Small 4 | relevant for EU/internship §95–§101; weights and licence open; the lab default stays the DeepSeek hypothesis |
| Assess | models | Kimi K3 / K3.1 Pro (Moonshot) | Peer §134–§142; strong on cyber and coding; dearer than DeepSeek; H×M later |
| Hold | content | Vendor or agency "best IDE/vibe" listicles | §102–§104: names fine, rankings not; prefer AA and papers |
| Hold | deps | `<an outdated ORM>` | example — no new use; migration ADR |

Categories (keep them fixed): **languages** · **frameworks** · **deps** · **tooling**.

## Commands

```bash
make radar-check      # structure + Deliberately later; needs the research module
make radar-reminder   # hint + the Last reviewed date
```

How-to: [../how-to/radar.md](../how-to/radar.md).

## Deliberately later

Fixed heading (P28): ask about it or file a BACKLOG item when this becomes needed.

| Extension | Why later | Ask when |
|-------------|--------------|-----------|
| Auto-pasting digest proposals into this file | P5 — a proposal is not a fact | Zero-touch radar updates |
| Radar in **kern** (every project) | Opt-in through the `research` module suffices | A project without research still wants a radar |
| An always-on line in AGENTS | Harness tax (P25) | Every task must see the radar (usually not) |
| `radar-check` in `check-full` | Deliberately monthly, not on every PR | A release gate demands a fresh review |
| Visual or HTML export of the rings | Markdown is enough for agents | A stakeholder wants a picture |
