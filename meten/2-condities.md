# Stap 2 — Condities kiezen

> **Rol:** Welke varianten van structuur en docs je tegen elkaar meet, telkens met één verandering.
> **Niet hier:** hoe je ze uitvoert ([protocol](3-protocol.md)).

Vergelijk telkens **één** verandering tegelijk (ablatie, §19). Mogelijke condities:

| Code | Conditie | Wat je verwijdert of toevoegt |
|------|----------|-------------------------------|
| **C0** | Geen agentcontext | `AGENTS.md`, `.cursorrules` en `.cursor/rules/` weg; `docs/` blijft |
| **C1** | Huidige stand | Niets veranderd |
| **C2** | Nieuw skelet | Na de herordening uit [bestaand-project](../bestaand-project/INDEX.md), of de kit bij een nieuw project |
| C3 | C2 zonder kaart | Alleen `docs/INDEX.md` weg |
| C4 | C2 zonder `make check` | Check-commando uit `AGENTS.md` en `Makefile` weg |
| C5 | C2 met mappenboom | Een volledige boom toegevoegd aan `AGENTS.md` |
| C6 | Geen docs | `docs/` en alle `.md` weg (zoals in §20: toont of docs nog iets toevoegen) |

Voor een eerste meting volstaan **C0, C1 en C2**. C3 tot C6 zijn ablaties die tonen *welk* onderdeel het verschil maakt. Daar zit de bijdrage van een bachelorproef.
