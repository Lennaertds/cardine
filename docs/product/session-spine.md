# Session / spine

> **Rol:** Bijhouden waar agent-voortgang leeft als chat of cwd wisselt — folder-spine i.p.v. alleen IDE-history.
> **Niet hier:** werkplan ([onderdeel-session-spine](../work/specs/onderdeel-session-spine.md)); harness session-files; samenhang ([totaalproduct.md](totaalproduct.md)).

**Stand:** vorm (A9 C′) · **Spec:** [onderdeel-session-spine](../work/specs/onderdeel-session-spine.md) · detailvorm: [ideeen A9](../research/ideeen-en-vragen.md)

## Wat de gebruiker kan

- Na map-/workspace-wissel nog weten wat geprobeerd/werkte — zonder dat Cursor-achtige chat-history aan het verkeerde pad hangt (§132).

## Hypothese

**C′:** spine in `<cwd>/.agent/` (gitignore): korte `status.md` + `ledger.jsonl`; chat mag leeg na padwissel. Harness-sessions (Pi/DSH) zijn complement, niet enige SoR.

## Stand van zaken

| Onderwerp | Status | Notitie |
|-----------|--------|---------|
| Pad `.agent/` vs `.planning/` P1 | open | voorstel `.agent/` |
| JSONL vs status.md P2 | open | A8 dual |
| Sync harness session-id P3 | open | |
| Promoten naar `make log` P4 | open | |
| ADR / RULES-conventie | open | |

## Raakvlakken

- Geschreven/gelezen door: [harness.md](harness.md), jij via IDE
- Formaat: A8 · ritueel: `docs/work/logs/`

## Bewust niet

- Alleen IDE-chat als bron van waarheid.
- Spine met secrets committen.
