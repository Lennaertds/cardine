# Spec — onderdeel-tools

> **Rol:** Open keuzes voor de exec-/tool-laag (read, edit, shell, MCP).
> **Kaart:** [totaalproduct.md](../../product/totaalproduct.md)

- **Item:** [BACKLOG.md](../BACKLOG.md)
- **Status:** open — volgt het DSH-voorstel; sluit mee met de harness-ADR
- **Product (bijhouden):** [../../product/tools.md](../../product/tools.md)
- **Hypothese:** Geen eigen runtime. Toolset = DSH (read/edit/shell) + indexing-MCP. `bwrap` voor untrusted shell. Niet zelf een tool-runtime forken.

## Wat het is

Wat de agent **mag doen** buiten “denken”: bestanden lezen/schrijven, shell, zoeken (vaak via indexing-tools), MCP, approvals.

Jij noemt dit terecht “niet al te complex” voor v1 — complexiteit zit in **permissions + sandbox + logging**, niet in nog een tool-framework.

## Stappenplan

H1 is voorgesteld (DSH). Deze laag sluit mee in die ADR. Eén stap per sessie. Uitkomst in [tools.md](../../product/tools.md). Geen eigen tool-runtime.

### Stap A — Whitelist op papier

1. T1: de toolset is die van de gekozen harness, ingekort tot read, edit, shell en de indexing-tools uit het contract van stap 3 indexing.
2. T2: paden binnen de workspace staan op de allowlist. Daarbuiten vraagt de agent eerst.
3. T3: shell en package-install (`npm`, `pip`) lopen onder bubblewrap met alleen de workspace gemount. Zed en de core blijven native.
4. T4: MCP staat aan voor de indexing-daemon. Een open MCP-markt hoort er niet bij.
5. T5: zoeken loopt via de indexing-tools. `rg` blijft de meet-fallback uit indexing stap 4.
6. Tool-logs bevatten geen secrets en geen `.env`.

### Stap B — Meenemen in de harness-ADR

Het voorstel gaat mee in de ADR van H1/H2, of in een korte aanvulling als die ADR al ja heeft. Deze spec sluit daarna.

## Open beslissingen

| # | Vraag | Opties | Blokkeert |
|---|-------|--------|-----------|
| T1 | Tool-set eigendom? | harness-default / subset whitelist | security |
| T2 | Approval-model? | always ask / allowlist paths / auto in lab | UX |
| T3 | Sandbox? | geen / bubblewrap / harness-builtin | Arch |
| T4 | MCP: aan/uit v1? | voorstel: aan, alleen indexing-daemon | scope |
| T5 | Indexing-tools vs generic `rg`? | verplicht via indexing-seam / beide | X1 |

## Acceptatie (later)

- [ ] Whitelist + approval vast in harness-ADR
- [ ] Geen secrets in tool-logs (RULES)
