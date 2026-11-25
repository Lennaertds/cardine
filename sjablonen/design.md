# docs/design/DESIGN.md

> **Role:** Entry point for every UI task: principles, what is never allowed, tokens, and the map to one craft file.
> **Not here:** what it does ([product](product.md)), the values of the tokens (the code).

**Kit files:** [DESIGN.md](../kit/modules/design/docs/design/DESIGN.md), craft under `shared/` · `desktop/` · `iphone/`, [`.cursor/agents/ui.md`](../kit/modules/design/.cursor/agents/ui.md) · module `design`

## When

For a UI with its own house style, or as soon as an agent builds screens that have to look alike. An internal dashboard on a standard component library: not needed. Module `design` installs the hard route in `AGENTS.md`: UI task → this file first, and installs the UI subagent ([cursor-agents](cursor-agents.md)).

## What the kit already delivers

Module `design` copies a **house-standard craft library** (premium look: glass chrome, solid content, motion, touch, overlays). Those files are ready to follow — not empty.

| Folder | Content |
|--------|---------|
| `docs/design/shared/` | a11y, never, glass |
| `docs/design/desktop/` | gate, performance, a11y + `landingpage/` showcase craft |
| `docs/design/iphone/` | touch, motion, materials, never-checklist + `application/` product craft |

**Not in the kit** (the project fills these in): product IA, lat chrome, session chrome, landing beats, brand personality, About/hotspots.

## Filling in (project)

1. **First sentence** stays: "Open this on every UI task; then pick one craft file."
2. **Principles:** three to five testable house rules (or link to the craft that already fixes them). The kit placeholder may stay until you sharpen it.
3. **Never:** site-wide lives in `shared/never.md`. Project extras go under **Never** in `DESIGN.md`.
4. **Tokens:** path to the code + meaning table. Values stay in CSS (P7).
5. **Map:** the kit rows are already there. Add project chrome (§ Project chrome). Never override the shared floor more loosely.
6. **Extending the craft:** a new topic = a new file + one row in the map. No dumping a whole folder on a task.

## Example (map, shortened)

```markdown
> **Role:** Entry point for every UI task. Open this file, then one craft file.

## Shared
| File | Question |
|------|----------|
| shared/a11y.md | Focus, contrast, prefs |
| shared/never.md | Site-wide prohibitions |
| shared/glass.md | One `.glass` class |

## Showcase desktop
| … | desktop/landingpage/… |

## Application
| … | iphone/application/… |

## Project chrome
| PageShell / tabs | lat-chrome.md (project) |
```

## Quick check

- [ ] No hex codes or pixel values that also live in the code.
- [ ] Kit craft is under `docs/design/` after `--modules design`.
- [ ] A fresh agent asked "fix the sticky head" opens `DESIGN.md` first, then `surfaces-sticky-heads`.
- [ ] Project chrome is in the map; lat/session do not sit in the kit as a GF copy.
