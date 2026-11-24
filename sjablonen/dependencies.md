# docs/architecture/dependencies.md

> **Rol:** Dependency-hygiëne: audits, ritueel, snellere/veiligere alternatieven.
> **Niet hier:** Strix ([security](security.md)), budgets ([performance](performance.md)).

**Kitbestand:** [kit/kern/docs/architecture/dependencies.md](../kit/kern/docs/architecture/dependencies.md) · laag kern · P13, P17

## Wanneer

Dag 0 met de kittekst. Bij de eerste release: `make deps-audit` een keer lokaal + in CI (`check-full`). Maandelijks: ritueel uit de architecture-doc. AGENTS: alleen via INDEX als de opdracht het noemt.

## Invullen

1. Laat de audit-tabel staan; stacks zonder die bestanden slaat het script over.
2. Bij bewuste CVE/license-compromis: ADR, niet stil in deze file.
3. **`## Bewust later`:** kitrijen laten staan of projectrijen toevoegen (P28). How-to: [deps-audit](../kit/kern/docs/how-to/deps-audit.md). Geen paden naar Agent Engineering `bron/` in het projectbestand.

## Snelle toets

- [ ] `make deps-audit` is groen (of alleen docs-check + duidelijke skips zonder tool).
- [ ] `deps-audit` staat in `make help` en in `check-full`, niet in `CHECK` / `make check`.
- [ ] `## Bewust later` heeft minstens één uitbreidingsrij (P28).
- [ ] Maandelijks ritueel is bekend (of in teamkalender / BACKLOG-herinnering).
