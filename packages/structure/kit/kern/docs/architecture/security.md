# Security

> **Rol:** Welke gevoelige gegevens er zijn, waar ze staan, en hoe ze beschermd worden.
> **Niet hier:** de "nooit"-regels voor de agent ([AGENTS.md](../../AGENTS.md)), het privacybeleid in mensentaal (`business/`).

## Persoonsgegevens

| Gegeven | Waar | Wie leest | Bewaartermijn |
|---------|------|-----------|---------------|
| <e-mail, wachtwoordhash> | <Postgres, tabel `user`> | <API> | <tot account verwijderd> |

## Secrets

| Secret | Waar het leeft | Wie het nodig heeft |
|--------|----------------|---------------------|
| <`JWT_SECRET`> | <`.env` lokaal, variabele bij de host in productie> | <API> |

## Authenticatie en autorisatie

<Hoe een gebruiker zich aanmeldt, hoe lang een sessie geldt, wie wat mag zien.>

## Dreigingen en maatregelen

| Dreiging | Maatregel | Bewaakt door |
|----------|-----------|--------------|
| <Upload van een kwaadaardig bestand> | <type en grootte controleren, nooit uitvoeren> | <test `upload.spec.ts`> |
| Supply-chain: npm/pip/cargo installatiescripts lezen SSH-keys, .env, bestanden | Containers isoleren install: `make container-setup`, daarna `npm-safe`/`pip-safe`/`cargo-safe` gebruiken. Zie [how-to](../how-to/container-safe.md). | `AGENTS.md` commando-regel + `make container-setup` bij projectstart |

## Actieve security-validatie (Strix)

Autonome pentest-agents die findings met **werkende PoC** valideren (niet alleen SAST-warnings). Standaardtool: [Strix](https://strix.ai/) (CLI + optionele coding-agent skills). Naslag in de standaard-repo: bron §47.

| Wat | Afspraak |
|-----|----------|
| Wanneer | Voor release / na auth- of API-wijzigingen; niet bij elke micro-fix |
| Commando | `make security-scan-quick` of `make security-scan` (zie [how-to](../how-to/security-scan.md)) |
| Scope | Alleen eigen code, staging, of targets met expliciete toestemming |
| Vereisten | Docker + `strix` + LLM-API-key |
| Niet in | `make check` (te traag, niet-deterministisch, kost tokens) |
| Skills | Optioneel: `npx skills add usestrix/strix` |

Ontbreekt installatie of key: target faalt met uitleg → regel in `docs/work/BACKLOG.md` (§ Straks), docs blijven de waarheid over *hoe*. Bewuste weglatingen: [Bewust later](#bewust-later) (P28).

## Bewust later

Vaste kop (P28): vraag ernaar of BACKLOG als dit nodig wordt.

| Uitbreiding | Waarom later | Vraag als |
|-------------|--------------|-----------|
| Strix/Docker/LLM-key altijd geïnstalleerd in CI | Runtime is projectkeuze; docs + Make blijven | Scans moeten in nachtelijke CI zonder handwerk |
| Alternatieve scanner i.p.v. Strix | Eén default voorkomt tool-chaos | Strix past niet (policy, air-gap) → ADR |
| DPA / AVG-operationele checklist in kern | Deels in security + business-module | School/klant eist vaste privacy-checklist |
| Secrets-manager-module (Vault e.d.) | `security.md` + `.env.example` volstaan lokaal | Productie deelt geen env-vars meer veilig |
