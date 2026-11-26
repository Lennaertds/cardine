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
| T09 | Digest-keten gerepareerd (fetch → triage → check) | 2026-11-26 | Triage las 0 rijen (kop `feed-hits` ≠ `feed hits`); fetch las het oude `docs/`-scaffold; lab-wrapper cd'de kapot; check-script had dode greps |
| T10 | Promotie-keten weekbrief → § per thema | 2026-11-26 | `digest-promote` / `digest-place` / `digest-verify`; P5 blijft: geen § zonder ingevulde beslissing |
| T11 | W48 gepromoveerd: 196 → 459 §, 14 → 19 thema's | 2026-11-26 | 263 aangenomen, 184 geskipt; 5 nieuwe thema's (Embodied, World models, Eval, Vision/docs, Agent Safety) |
| T12 | Focus-feeds + interesses | 2026-11-26 | 5 topic-feeds (sandbox, agent safety, prompt injection, document parsing, computer use); interests.md heringedeeld |

## 🟡 Open (vervolg)

| ID | Onderwerp | Laatste update | Notities |
|----|-----------|---------------|----------|
| T13 | Triage-selectiviteit | 2026-11-26 | Elke `HF q:*`-feed is "hoog signaal" → automatisch `keep`; focussen vraagt een **demote**-regel i.p.v. meer keep-signalen |
| T14 | Nieuwe thema's automatiseren | 2026-11-26 | Nieuw thema vergt nu handmatig een `# Titel`-shell in `bronnen.md` **én** een `### [Titel]`-tabel in `bronnen-index.md` |

---

---

## Log

| Datum | Wat |
|-------|-----|
| 2026-11-19 | Status-log aangemaakt met eerste vulling uit sessiebestanden |
| 2026-11-19 14:24 | Status-log systeem geïmplementeerd: onderwerp-gecentreerd loggen in bron/status-log.md + bron/onderwerpen/ (deze repo) en kit/logging/ (drieplaats-regel). Make finish schrijft nu korte logregel. Sessiebestanden gemarkeerd als historisch. Kit-update: standaard/loggen.md, kit/logging/, sjablonen/loggen.md. |

| 2026-11-20 11:25 | kit-versioning opgezet: scripts/tag-kit.sh, Makefile tag-kit target, standaard/versioning.md, AGENTS.md update; kit-v0.1.0 tag |
| 2026-11-26 10:33 | Digest-keten gerepareerd: triage las 0 rijen door een hernoemde kop (`feed-hits` → `feed hits`), fetch las het oude scaffold-pad i.p.v. `bron/digest/SOURCES.md`, de lab-wrapper cd'de naar een verdwenen map, en `digest-check.sh` had twee dode greps. `digest-day` haalt nu 24 feeds op en triage zet 506 rijen. |
| 2026-11-26 11:00 | Promotie-keten gebouwd: `digest-promote` (per-thema drafts met abstract), `digest-place` (echte § + indexrij; weigert zonder `theme`/`kern`), `digest-verify` (read-only poort). Bug gevonden en gefixt: place voegde top-down in, waardoor alle 263 §'s in het verkeerde thema belandden; nu bottom-up + weiger-guard. |
| 2026-11-26 11:30 | W48 gepromoveerd: 196 → 459 §, 14 → 19 thema's (Embodied & Physical AI, World models & generative video, Evaluation & benchmarks, Vision/docs & perception, Agent Safety). 263 aangenomen, 184 geskipt (waarvan ~90 zonder tekst in de dumps). Router haalt 45% op mijn eigen beslissingen — pre-sorter, geen classificatie. |
| 2026-11-26 12:00 | Focus-feeds toegevoegd (sandbox, agent safety, prompt injection, document parsing, computer use) en `interests.md` heringedeeld naar drie focusgebieden. Gemeten: `papers/search` rankt op relevantie (2017→nu), dus met `DIGEST_JSON_DAYS=90` blijven er 0–3 per dag over; smalle queries werken beter dan brede. |
