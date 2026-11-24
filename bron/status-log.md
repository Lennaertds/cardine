# Status-log

> **Rol:** Één bron van waarheid over wat er gedaan is en wat nog open staat.
> **Bijgewerkt:** 2026-11-19 (eerste vulling)
> **Zie ook:** `bron/onderwerpen/` voor details per onderwerp · `bron/sessies/INDEX.md` voor oude sessie-logs (historisch)

## 🔴 Bezig

| ID | Onderwerp | Laatste update | Notities |
|----|-----------|---------------|----------|
| T01 | Token-logger voor DeepSeekHarness | 2026-11-19 | post-request hook in DSH; spoor A (plugins), B (Zed logs), C (proxy) |

## 🟡 Open

| ID | Onderwerp | Laatste update | Notities |
|----|-----------|---------------|----------|
| T02 | 4-pijlers structuurplan in kit gieten (§9) | 2026-11-19 | Drieplaats-regel: standaard + kit + sjablonen |
| T03 | DeepInfra multimodale modellen check | 2026-11-19 | `curl` API check of DeepInfra multimodale modellen heeft |

## ✅ Afgerond (naslag)

| ID | Onderwerp | Laatste update | Notities |
|----|-----------|---------------|----------|
| T04 | Kit-profielen (app/research/studie/schoolwerk) | 2026-11-19 | 4 profielen + `--profile` vlag in new-project.sh + `make check` groen |
| T05 | Papers §193–§196 toevoegen | 2026-11-19 | Efficient Transformers, LeanVec, CoT, Long Contexts |
| T06 | `make finish` met sessielog | 2026-11-19 | Schrijft sessiebestand + INDEX.md entry (oude systeem) |
| T07 | DSH sandbox-onderzoek | 2026-11-19 | Bubblewrap blokkeert `~/.dsh/`; omgevingsvariabelen uitgelezen |
| T08 | Status-log systeem (dit bestand) | 2026-11-19 | Onderwerp-gecentreerd log i.p.v. sessiebestanden |

---

## Log

| Datum | Wat |
|-------|-----|
| 2026-11-19 | Status-log aangemaakt met eerste vulling uit sessiebestanden |
| 2026-11-19 14:24 | Status-log systeem geïmplementeerd: onderwerp-gecentreerd loggen in bron/status-log.md + bron/onderwerpen/ (deze repo) en kit/logging/ (drieplaats-regel). Make finish schrijft nu korte logregel. Sessiebestanden gemarkeerd als historisch. Kit-update: standaard/loggen.md, kit/logging/, sjablonen/loggen.md. |

| 2026-11-20 11:25 | kit-versioning opgezet: scripts/tag-kit.sh, Makefile tag-kit target, standaard/versioning.md, AGENTS.md update; kit-v0.1.0 tag |
