# 0001 — The runtime stack is deliberately deferred until an explicit Pi or TS choice

- **Status:** accepted
- **Date:** 2026-10-26
- **Touches:** `ARCHITECTURE.md` § Stack, `BACKLOG.md`, BOOTSTRAP step 3, no `apps/*/app.mk` until the choice

## Summary

In the context of a lab-first project (possibly a free product later) without a chosen runtime, faced with the risk of early lock-in and feature bloat, we chose to defer every stack and generator until an explicit Pi or TS choice, over copying a starter now, in order to keep the harness minimal and measurable, and we accept that `make check` stays red on "no app" until that choice is made.

## Context

- The kit has the agent, research and product modules; no stacks.
- Success now = a locally measurable lab; later possibly a free product (portfolio; OS or closed to be decided).
- LLM through your own keys (DeepSeek direction); a Pi fork is a later option, not a default.

## Decision

We generate or choose no app stack (and no database or hosting stack) until the human explicitly picks a runtime direction (for example Pi or TypeScript). ARCHITECTURE does hold the containers and domains; path, port and tech stay open.

## Alternatives

| Option | Why not |
|-------|-------------|
| A TS starter now (Nest/Next etc.) | Lock-in before weighing Pi; a bloated lab |
| A Pi fork now | No explicit choice; thesis and runtime still open |
| A "temporary" stack without an ADR | It becomes silent truth; hard to undo |

## Consequences

- **Easier:** context, boundaries and domains first; experiments stay narrow.
- **Harder or risky:** no green `make check` until step 3; agents may not fill in a stack "ahead of time".
- **To do:** after the choice → a new ADR (the concrete stack) + BOOTSTRAP step 3 (`--starter` and generators).
