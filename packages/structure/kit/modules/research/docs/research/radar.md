# Tech-radar

> **Rol:** Periodieke herijking van talen, frameworks, dependencies en tooling — wat we Adopt/Trial/Assess/Hold-en.
> **Niet hier:** bronnen verwerven ([wantlist.md](wantlist.md)); domeinliteratuur (`research/<onderwerp>.md`); CVE-scan ([dependencies.md](../architecture/dependencies.md)); raw feeds als waarheid (P5).

Inbound feeds: [digest/](digest/README.md) (`digest-fetch` / `digest-propose`) — voorstellen cureren vóór je hier een rij zet (P5). Bron/horizon: Agent Engineering `bron/fundament/ecosysteem/kit-dekking-en-horizon.md` (C4).

## Ritueel

1. **Maandelijks** (of na grote bump): `make radar-reminder` → herzie deze file.
2. Wijzig een ring alleen met korte notitie; **Adopt** of **Hold** met impact → ADR.
3. Snellere/veiligere deps: ook [dependencies.md](../architecture/dependencies.md)-ritueel; radar houdt de *keuzestand*.
4. `make radar-check` na structurele edits (niet in `make check`).

## Laatst herzien

Laatst herzien: {{DATE}}

(Zet de datum bij elke inhoudelijke update. `make radar-reminder` leest deze regel.)

## Ringen

| Ring | Betekenis |
|------|-----------|
| **Adopt** | Standaardkeuze voor nieuwe stubs; team/solo kent het |
| **Trial** | Actief uitproberen in één slice/app; nog geen default |
| **Assess** | Op de radar; nog geen tijd/experiment |
| **Hold** | Bewust niet (meer) voor nieuw werk; bestaande code mag blijven tot ADR |

## Radar

Vervang voorbeeldrijen door projectkeuzes. Voorbeeldrijen zijn **illustratief**, geen feit over jouw stack.

| Ring | Categorie | Item | Notitie / ADR |
|------|-----------|------|---------------|
| Adopt | talen | TypeScript (Nest/Next) | kit-default; zie ARCHITECTURE |
| Adopt | frameworks | Postgres 17 | enige writer user-data → ADR |
| Trial | deps | `<snellere JSON-lib>` | voorbeeld — meet vóór Adopt |
| Assess | tooling | `<bundler X>` | voorbeeld — nog geen experiment |
| Hold | deps | `<verouderde ORM>` | voorbeeld — geen nieuw gebruik; migratie ADR |

Categorieën (vast houden): **talen** · **frameworks** · **deps** · **tooling**.

## Commando's

```bash
make radar-check      # structuur + Bewust later; vereist module research
make radar-reminder   # tip + Laatst herzien-datum
```

How-to: [../how-to/radar.md](../how-to/radar.md).

## Bewust later

Vaste kop (P28): vraag ernaar of BACKLOG als dit nodig wordt.

| Uitbreiding | Waarom later | Vraag als |
|-------------|--------------|-----------|
| Auto-plakken van digest-voorstellen in deze file | P5 — voorstel ≠ feit | Zero-touch radar-updates |
| Radar in **kern** (elk project) | Opt-in via module `research` volstaat | Project zonder research wil toch radar |
| Always-on regel in AGENTS | Harness tax (P25) | Elke taak moet de radar zien (meestal niet) |
| `radar-check` in `check-full` | Bewust maandelijks, niet bij elke PR | Release-gate eist verse herziening |
| Visual / HTML-export van ringen | Markdown is genoeg voor agents | Stakeholder wil plaatje |
