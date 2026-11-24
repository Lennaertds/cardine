# docs/architecture/security.md

> **Rol:** Welke gevoelige gegevens er zijn, waar ze staan, en hoe ze beschermd worden.
> **Niet hier:** de "Nooit"-regels voor de agent ([agents-root](agents-root.md)), het privacybeleid in mensentaal (`docs/business/`).

**Kitbestand:** [kit/kern/docs/architecture/security.md](../kit/kern/docs/architecture/security.md) · laag kern · P17

## Wanneer

Dag 0 met de eerste rij in elke tabel. Bij elk nieuw soort gegeven, elk nieuw secret en elke nieuwe externe dienst.

## Invullen

1. **Persoonsgegevens:** wat, waar, wie leest, hoe lang. Ook wat lokaal in `data/runtime/` of `data/raw/` staat.
2. **Secrets:** naam (nooit de waarde), waar het leeft lokaal en in productie, wie het nodig heeft. Elk secret staat met een veilige voorbeeldwaarde in de `.env.example` van de app.
3. **Auth:** hoe aanmelden, hoe lang een sessie, wie wat mag zien.
4. **Dreigingen en maatregelen:** met wat de maatregel bewaakt (test, hook, header).
5. **Actieve validatie (Strix):** sectie uit de kit laten staan; vul zo nodig project-specifieke targets of staging-URL’s aan. Scans via `make security-scan*`, niet via `make check`. How-to: `docs/how-to/security-scan.md`.
6. **`## Bewust later`:** kitrijen laten staan of aanvullen (P28).

## Voorbeeld (GymFreak)

```markdown
## Persoonsgegevens

| Gegeven | Waar | Wie leest | Bewaartermijn |
|---------|------|-----------|---------------|
| Slaap, hartslag (Health-export) | `data/runtime/user/<id>/`, tabel `sleep_night` | api | tot de gebruiker verwijdert |
| E-mail, wachtwoordhash | tabel `user` | api | tot account verwijderd |

## Dreigingen en maatregelen

| Dreiging | Maatregel | Bewaakt door |
|----------|-----------|--------------|
| Health-XML van 500 MB legt de API plat | streaming parser, limiet 200 MB | `upload.e2e-spec.ts` |
| Secret in een commit | gitleaks in pre-commit | `.pre-commit-config.yaml` |
| Supply-chain: installatiescripts van npm/pip/cargo | Containers isoleren via `make container-setup`; gebruik `npm-safe`/`pip-safe`/`cargo-safe` | `AGENTS.md` commando-regel |
```

## Snelle toets

- [ ] Geen enkele secretwaarde in dit bestand of in een voorbeeld.
- [ ] Elk persoonsgegeven heeft een bewaartermijn.
- [ ] Strix-sectie staat er; ontbrekende installatie/key staat in BACKLOG, niet stilzwijgend weg.
- [ ] `## Bewust later` heeft minstens één uitbreidingsrij (P28).
- [ ] `AGENTS.md` § Nooit verwijst hierheen.
