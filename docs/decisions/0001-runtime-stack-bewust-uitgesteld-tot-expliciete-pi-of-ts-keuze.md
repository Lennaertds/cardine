# 0001 — Runtime-stack bewust uitgesteld tot expliciete Pi of TS-keuze

- **Status:** aanvaard
- **Datum:** 2026-10-26
- **Raakt:** `ARCHITECTURE.md` § Stack, `BACKLOG.md`, BOOTSTRAP stap 3, geen `apps/*/app.mk` tot keuze

## Samenvatting

In de context van een lab-eerst project (later mogelijk gratis product) zonder gekozen runtime, geconfronteerd met het risico van vroegtijdige lock-in en feature-bloat, kozen we voor het uitstellen van elke stack/generator tot een expliciete Pi- of TS-keuze en tegen nu al een starter te kopiëren, om de harness minimaal en meetbaar te houden, en we aanvaarden dat `make check` rood blijft op “geen app” tot die keuze er is.

## Context

- Kit staat met modules agent, research, product; geen stacks.
- Succes nu = lokaal meetbaar lab; later mogelijk gratis product (portfolio; OS of closed nader).
- LLM via eigen keys (DeepSeek-richting); Pi-fork is een latere optie, geen default.

## Besluit

We genereren of kiezen geen app-stack (en geen database/hosting-stack) tot de mens expliciet een runtime-richting kiest (bijv. Pi of TypeScript). ARCHITECTURE houdt containers/domeinen wel vast; pad/poort/tech blijven open.

## Alternatieven

| Optie | Waarom niet |
|-------|-------------|
| Nu TS-starter (Nest/Next e.d.) | Lock-in vóór Pi-afweging; bloated lab |
| Nu Pi-fork | Geen expliciete keuze; thesis/runtime nog open |
| Stack “tijdelijk” zonder ADR | Wordt stille waarheid; moeilijk terug te draaien |

## Gevolgen

- **Makkelijker:** context/grenzen en domeinen eerst; experimenten blijven smal.
- **Moeilijker of risico:** geen groene `make check` tot stap 3; agents mogen geen stack invullen “vooruit”.
- **Te doen:** na keuze → nieuwe ADR (concrete stack) + BOOTSTRAP stap 3 (`--starter` / generators).
