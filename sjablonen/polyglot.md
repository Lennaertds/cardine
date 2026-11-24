# docs/architecture/polyglot.md

> **Rol:** Wanneer extra/native talen mogen; beslisboom en agentgrenzen.
> **Niet hier:** budgets ([performance](performance.md)), containers ([architecture](architecture.md)).

**Kitbestand:** [kit/kern/docs/architecture/polyglot.md](../kit/kern/docs/architecture/polyglot.md) · laag kern · P13, P23, P28  
**Voorbeeld-ADR:** [0000-voorbeeld-native-module-na-budget-breuk.md](../kit/kern/docs/decisions/0000-voorbeeld-native-module-na-budget-breuk.md)

## Wanneer

Dag 0 met de kittekst. Bij eerste budget-breuk die native vraagt: echte ADR via `make adr` (niet de 0000-voorbeeld als geldend laten staan). AGENTS: geen always-on polyglot-link; agent vindt dit via INDEX als de opdracht native/FFI noemt. **Geen** aanname dat `apps/native` bestaat zonder stack.

## Invullen

1. Laat beslisboom en integratietabel staan; vul projectnotities alleen als je afwijkt (ADR).
2. Schrijf projectpaden (`apps/native`), niet kitbronpaden (`kit/stacks/rust`) — die bestaan niet in het project.
3. **`## Bewust later`:** kitrijen laten of aanvullen (P28).
4. CONTEXT/ARCHITECTURE: kit heeft al verwijzingen; schrap ze niet zonder ADR.
5. Soft vs hard FFI: [how-to/native-ci.md](../kit/kern/docs/how-to/native-ci.md); team `native.yml` bij `--team` + native-stacks.

## Snelle toets

- [ ] `make polyglot-check` is groen.
- [ ] `polyglot-check` staat in `make help`, niet in `CHECK` / `check-full`.
- [ ] `native-bindings-strict` / `NATIVE_STRICT` via `check-full` of how-to.
- [ ] Doc zegt expliciet: native-map alleen met die stack + ADR.
- [ ] `## Bewust later` heeft minstens één uitbreidingsrij (P28).
- [ ] AGENTS heeft geen always-on polyglot-pad; INDEX + `polyglot.md` dekken “geen aanname geen Rust” / native na meting + ADR.
