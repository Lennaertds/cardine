# 0011 — The stack follows the decision docs and an approval against a catalogue

- **Status:** accepted
- **Date:** 2026-11-17
- **Touches:** [PRODUCT.md](../product/PRODUCT.md), [structure.md](../product/structure.md), [0001](0001-runtime-stack-deliberately-deferred-until-an-explicit-pi-or-ts-choice.md), [0009](0009-the-product-is-the-free-project-structure-and-a-guide-to-the-agent-paths.md).

## Summary

In the context of an empty project start, faced with users who do not want to write the project text themselves and with models that reach for the most popular stack, we chose questions that fill the decision docs plus a catalogue from which the agent proposes two or three options, over a silent stack choice and over a mandatory self-written text, in order to let the user approve what goes down, and we accept that the catalogue must be maintained and that a generator runs only after that approval.

## Context

- The structure package ([0009](0009-the-product-is-the-free-project-structure-and-a-guide-to-the-agent-paths.md)) lays down the tree. What the project *is* is still blank at that point.
- A model that picks a language itself usually names the popular option. A catalogue with only "when it fits" reinforces that.
- [0001](0001-runtime-stack-deliberately-deferred-until-an-explicit-pi-or-ts-choice.md) holds stack generators back until there is a choice. That choice is the approval here, not a default in the catalogue.
- [0004](0004-the-project-standard-is-dual-a-thin-agents-md-and-a-hard-make-check.md) remains the enforcement afterwards: a thin `AGENTS.md`, a hard `make check`.

## Decision

- On day 0 there are two kinds of file. Questions steer the conversation. Decisions record the outcome: `PRODUCT.md`, `BUSINESSMODEL.md`, `GOALS.md` and the docs that must be able to explain a later choice.
- The user fills them in, or walks them through from empty with the agent. A sentence lands in a decision file when the user approves it.
- The agent then names two or three options from a catalogue of languages and software. Each proposal states what it does, when it fits, when it is a bad choice, and a sentence from `PRODUCT.md` it rests on.
- The user asks further, approves or rejects. A generator runs only after that approval.
- The catalogue is reference material for those proposals. It does not choose by itself.

## Alternatives

| Option | Why not |
|-------|-------------|
| The agent picks the stack from `PRODUCT.md` without a catalogue | The popular default then wins |
| The user must write the essay alone | That is the work people skip |
| A long menu without a proposal | There is then no tie to the goal, and the first row wins anyway |

## Consequences

- **Easier:** starting a project is a conversation with an outcome you can read back later.
- **Harder or risky:** every card in the catalogue needs a "when not", otherwise it stays a popularity list. The three agent paths from [0010](0010-the-meta-package-points-to-separate-packages-for-structure-and-three-zed-paths.md) must be able to read the same docs.
- **To do:** the questions, the decision docs in the structure package, and the catalogue. Not in the kit yet. A kit change waits for a bridge and a yes.
