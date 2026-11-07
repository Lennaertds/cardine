# Spec — onderdeel-tools

> **Rol:** Open keuzes voor de exec-/tool-laag (read, edit, shell, MCP).
> **Kaart:** [totaalproduct.md](../../product/totaalproduct.md)

- **Item:** [BACKLOG.md](../BACKLOG.md)
- **Status:** open
- **Product (bijhouden):** [../../product/tools.md](../../product/tools.md)
- **Hypothese:** Relatief basic; komt mee met de harness — niet zelf een tool-runtime forken tenzij DSH/Pi tekortschiet.

## Wat het is

Wat de agent **mag doen** buiten “denken”: bestanden lezen/schrijven, shell, zoeken (vaak via indexing-tools), MCP, approvals.

Jij noemt dit terecht “niet al te complex” voor v1 — complexiteit zit in **permissions + sandbox + logging**, niet in nog een tool-framework.

## Open beslissingen

| # | Vraag | Opties | Blokkeert |
|---|-------|--------|-----------|
| T1 | Tool-set eigendom? | harness-default / subset whitelist | security |
| T2 | Approval-model? | always ask / allowlist paths / auto in lab | UX |
| T3 | Sandbox? | geen / bubblewrap / harness-builtin | Arch |
| T4 | MCP: aan/uit v1? | uit tot nodig | scope |
| T5 | Indexing-tools vs generic `rg`? | verplicht via indexing-seam / beide | X1 |

## Acceptatie (later)

- [ ] Whitelist + approval vast in harness-ADR
- [ ] Geen secrets in tool-logs (RULES)
