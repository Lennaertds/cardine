# .cursor/agents/&lt;role&gt;.md

> **Role:** Cursor subagent per project role: when to delegate, which docs first, what to report back.
> **Not here:** read routes that apply to *every* task ([agents-root](agents-root.md)), path-scoped `.mdc` ([cursor-rule](cursor-rule.md)), the overview of roles ([agent-rollen](../standard/agent-rollen.md)).

**Kit files:**
`architecture` + `reviewer` + `clarify` → [kit/modules/cursor/.cursor/agents/](../kit/modules/cursor/.cursor/agents/) · module `cursor`
`ui` → [kit/modules/design/.cursor/agents/ui.md](../kit/modules/design/.cursor/agents/ui.md) · module `design`
`product` → [kit/modules/product/.cursor/agents/product.md](../kit/modules/product/.cursor/agents/product.md) · module `product`
`research` → [kit/modules/research/.cursor/agents/research.md](../kit/modules/research/.cursor/agents/research.md) · module `research`
· P24, P25, P26 · examples prompt→approach: [agent-rollen](../standard/agent-rollen.md#examples-prompt-approach)

## When

Module `cursor` (at least `architecture` + `reviewer`), plus the modules whose role agent you want. Without Cursor subagents, the read routes in `AGENTS.md` are enough.

## Filling in

1. **`description`:** English triggers + "Use proactively for …" so Cursor delegates automatically. Keep it specific (otherwise the parent picks the wrong role).
2. **Body:** steps 1–4: the map doc first, then code/data, then finishing. No repetition of `AGENTS.md` § Never.
3. **`readonly: true`** only for reviewer-like roles.
4. **`model`:** default `inherit`; set a lighter model only if the role is pure search/check work (P26).
5. Delete an agent file if that module/role does not exist in this project.

## Example (call)

```text
UI fix on the sleep dashboard. Use subagents where it helps.
```

Or explicitly: `/ui` · `/reviewer confirm the slice meets the spec` · `/clarify` before a vague task (not by default for every prompt).

## Quick check

- [ ] `description` names the triggers; without that sentence Cursor rarely delegates automatically.
- [ ] Body ≤ ±40 lines; points at existing docs, does not copy them.
- [ ] The reviewer is `readonly: true` and asks for a Pass/Fail back.
- [ ] `AGENTS.md` has (with module `cursor`) one line about `.cursor/agents/`, no role essays.
