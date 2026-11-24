# docs/INDEX.md (de kaart)

> **Rol:** Eén ingang voor alle docs: per bestand de vraag die het beantwoordt, en wanneer niet.
> **Niet hier:** de werkwijze ([agents-root](agents-root.md)), de mappenboom ([skelet](../standaard/skelet.md)).

**Kitbestand:** [kit/kern/docs/INDEX.md](../kit/kern/docs/INDEX.md) · laag kern · P2, naar het voorbeeld van llms.txt (§15)

## Wanneer

Altijd. Het script laat alleen de secties staan van de modules die je koos. Elke keer dat een doc bijkomt of verdwijnt, past de kaart mee aan.

## Invullen

1. **Per sectie** een vraag die de lezer heeft ("hoe zit het in elkaar"), niet de mapnaam.
2. **Per bestand:** `[naam](pad) — <welke vraag>. Niet: <aanpalende vraag → ander bestand>.` Het "niet" voorkomt dat de agent het verkeerde bestand opent.
3. **Mappen met veel bestanden** (`decisions/`, `logs/`, `experiments/`): geen lijst per bestand, maar hoe je zoekt (`rg`, het nummer, de datum). Uitzondering: de geldende ADR's, zolang het er minder dan ±15 zijn.
4. **Regels met `<…>`** vervangen of schrappen. Geen links naar bestanden die nog niet bestaan.
5. **Wat niet vooraf gelezen wordt** (`work/`, `deliverables/`, `archive/`) staat onderaan, met die waarschuwing.

## Voorbeeld (GymFreak, één sectie)

```markdown
## Architectuur — hoe het in elkaar zit

- [ARCHITECTURE.md](architecture/ARCHITECTURE.md) — Containers, hosting, poorten, wie schrijft waar. Start hier voor "waar zit X".
- [runtime-client.md](architecture/runtime-client.md) — PWA, offline, push, chrome-poll. Niet: containers → ARCHITECTURE.
- [auth.md](architecture/auth.md) — JWT, demo-account, cookies in code. Niet: privacy-claims → legal.
- [data-import.md](architecture/data-import.md) — Hoe Hevy- en Health-exports binnenkomen. Niet: wat een veld betekent → GLOSSARY.
- [llm.md](architecture/llm.md) — Welke prompts, welk model, wat nooit naar de LLM gaat.
- [security.md](architecture/security.md) — Gezondheidsdata, secrets, auth-principes, Strix.
- [observability.md](architecture/observability.md) — Signalen en LGTM (opt-in).
- [performance.md](architecture/performance.md) — Budgets en bench (opt-in).
- [dependencies.md](architecture/dependencies.md) — CVE-audits (`deps-audit`, opt-in).
- [polyglot.md](architecture/polyglot.md) — Extra talen na meting (`polyglot-check`, opt-in).
```

## Snelle toets

- [ ] `make links` is groen.
- [ ] Elk doc onder `docs/` staat op de kaart, of in een map waarvan de kaart zegt hoe je zoekt.
- [ ] Geen bestand staat er twee keer.
- [ ] Een frisse agent kiest bij "waar zit de import van Hevy?" meteen het goede bestand.
