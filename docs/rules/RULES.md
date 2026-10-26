# Regels

> **Rol:** Inhoudelijke grenzen: wat dit project nooit doet, en wat altijd moet.
> **Niet hier:** codestijl (de linter), werkwijze van de agent ([AGENTS.md](../../AGENTS.md)), technische maatregelen ([security.md](../architecture/security.md)).

Elke regel is één zin met het waarom erbij. Is een regel afdwingbaar met een test, hook of CI-check, dan doe je dat ook, en verwijst de regel ernaar.

## Nooit

- Geen data of secrets uit andere projecten (GymFreak, DEP2, …) overnemen in code, tests, docs of prompts: het lab (en later het product) moet reproduceerbaar blijven zonder andermans inhoud.
- Geen productie-hosting of publieke release **tijdens de labfase**: eerst lokaal bewijzen; deploy/portfolio-release alleen na expliciete productisatie-keuze (dan mag gratis OS of closed).
- Geen betaalde SaaS of verplichte cloud-billing als productmodel: richting is eigen API-keys van de gebruiker (DeepSeek of andere) en hoogstwaarschijnlijk volledig gratis.
- Geen API-keys of `.env` in git, docs of prompts: keys (DeepSeek e.d.) blijven lokaal bij de eigenaar.
- Geen lessen of standaardwijzigingen rechtstreeks in deze repo of in de kit: eerst een § in Agent_Engineering `bron/bronnen.md` (en brug), anders breekt de SSOT tussen de drie sporen.
- Geen duplicatie van Agent_Engineering-bron of -kitinhoud hier: verwijs, kopieer niet — één feit op één plek.
- Geen stack of runtime kiezen of genereren tot er een expliciete Pi/TS- (of andere) runtime-keuze is: voorkomt vroegtijdige lock-in en feature-bloat.
- Geen feature-bloat buiten de minimale harness (alleen wat `harness` / `structure` / `indexing` nodig hebben): lab en metingen vragen om een smal oppervlak; productgroei volgt pas na bewezen kwaliteit.

## Altijd

- Nieuwe inzichten uit experimenten landen eerst als bron (§) in Agent_Engineering; pas daarna eventueel brug naar kit of lab-code.
- Domeinnamen in code, productdocs en prompts volgen [GLOSSARY.md](../context/GLOSSARY.md) (`harness`, `structure`, `indexing`).
- LLM-aanroepen gebruiken configureerbare providers via eigen keys (DeepSeek als goedkope default-richting; andere keys toegestaan) — geen hardgecodeerde provider-lock zonder ADR.
