# Research

> **Role:** What we know about the domain, which sources it rests on, and which product rule builds on it.
> **Not here:** the product rules themselves (`product/`), experiment code (`apps/<app>/experiments/`).

## Research questions

1. <e.g. "How many sets per muscle group per week give the most growth in beginners?">

## How we judge sources

| Level | What counts | Use |
|-------|-------------|-----|
| A | Meta-analysis or systematic review | May carry a product rule |
| B | Randomised study | May carry a rule, with attribution |
| C | Observational, expert, blog | Only as a hypothesis or experiment |

## Map of `research/`

- [<topic>.md](<topic>.md) — <what we know, with sources and level>
- [wantlist.md](wantlist.md) — Sources we still want to acquire.
- [radar.md](radar.md) — Tech radar (Adopt/Trial/Assess/Hold); monthly `make radar-reminder`.
- [digest/](digest/README.md) — Inbound feeds; `digest-fetch` / `digest-propose` (curate before the radar).
- `experiments/` — One report per experiment: `make experiment s=<slug>`.
