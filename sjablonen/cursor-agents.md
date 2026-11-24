# .cursor/agents/&lt;rol&gt;.md

> **Rol:** Cursor-subagent per projectrol: wanneer delegeren, welke docs eerst, wat terugrapporteren.
> **Niet hier:** leesroutes die bij élke taak gelden ([agents-root](agents-root.md)), path-scoped `.mdc` ([cursor-rule](cursor-rule.md)), het overzicht van rollen ([agent-rollen](../standaard/agent-rollen.md)).

**Kitbestanden:**  
`architecture` + `reviewer` + `clarify` → [kit/modules/cursor/.cursor/agents/](../kit/modules/cursor/.cursor/agents/) · module `cursor`  
`ui` → [kit/modules/design/.cursor/agents/ui.md](../kit/modules/design/.cursor/agents/ui.md) · module `design`  
`product` → [kit/modules/product/.cursor/agents/product.md](../kit/modules/product/.cursor/agents/product.md) · module `product`  
`research` → [kit/modules/research/.cursor/agents/research.md](../kit/modules/research/.cursor/agents/research.md) · module `research`  
· P24, P25, P26 · voorbeelden prompt→aanpak: [agent-rollen](../standaard/agent-rollen.md#voorbeelden-prompt--aanpak)

## Wanneer

Module `cursor` (minstens `architecture` + `reviewer`), plus de modules waarvan je de rol-agent wilt. Zonder Cursor-subagents volstaan de leesroutes in `AGENTS.md`.

## Invullen

1. **`description`:** Engelse triggers + "Use proactively for …" zodat Cursor automatisch delegeert. Houd hem specifiek (anders kiest de parent de verkeerde rol).
2. **Body:** stappen 1–4: eerst de kaart-doc, dan code/data, dan afronden. Geen herhaling van `AGENTS.md` § Nooit.
3. **`readonly: true`** alleen voor reviewer-achtige rollen.
4. **`model`:** default `inherit`; zet een lichter model alleen als de rol puur zoek-/checkwerk is (P26).
5. Schrap een agentbestand als die module/rol in dit project niet bestaat.

## Voorbeeld (aanroep)

```text
UI-fix op het sleep-dashboard. Gebruik subagents waar passend.
```

Of expliciet: `/ui` · `/reviewer bevestig dat de slice aan de spec voldoet` · `/clarify` vóór een vage opdracht (niet standaard voor elke prompt).

## Snelle toets

- [ ] `description` noemt de triggers; zonder die zin delegeert Cursor zelden automatisch.
- [ ] Body ≤ ±40 regels; wijst naar bestaande docs, kopieert ze niet.
- [ ] Reviewer is `readonly: true` en vraagt een Pass/Fail terug.
- [ ] `AGENTS.md` heeft (met module `cursor`) één regel over `.cursor/agents/`, geen rol-essays.
