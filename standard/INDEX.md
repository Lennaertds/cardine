# Standard — what every project looks like

> **Role:** The fixed agreements: where each file sits, what belongs in it, what it is called. One answer per question.
> **Not here:** why ([bron](../bron/INDEX.md)), the files themselves ([kit](../kit/README.md)), the order of working ([new-project](../new-project/INDEX.md), [existing-project](../existing-project/INDEX.md)).

**Do not copy this into a project.** A project follows the standard; it copies the kit. That way the tree lives in one place only (P5, P7).

## Looking things up

| Question | File |
|----------|------|
| Which folders and entry files does a project have, and why? | [skeleton](skelet.md) |
| Who reads each doc, what is in it, what is not? | [per-doc reference](per-file.md) |
| I want to note or keep something: where? | [where does this belong](where-does-this-belong.md) |
| What does an app look like inside (Next, Nest, Python, SQL)? | [stacks.md](stacks.md) |
| Which make targets exist, and how does an app add its own? | [makefile.md](makefile.md) |
| Which profiles exist for different kinds of project? | [profielen.md](profielen.md) |
| How do I keep a status log (topics, what is open/done)? | [logging.md](logging.md) |
| Which data layer for which file? | [data.md](data.md) |
| What lives in git, what does not? | [git.md](git.md) |
| How do I name a file, ADR, test or template? | [naamgeving.md](naamgeving.md) |
| What differs between solo and team? | [solo-team.md](solo-team.md) |
| Which agent role for which task, and when subagents? | [agent-rollen.md](agent-rollen.md) |

## Order to learn

Once, in this order: skeleton, files, where-does-this-belong, stacks, makefile. You open the rest for a concrete question. Principles P22–P28 (intent, seams, isolation, harness tax, model choice, loop spine, deliberately later) live mainly in `per-file.md`, [where does this belong](where-does-this-belong.md), [agent-roles](agent-rollen.md) and [stacks](stacks.md).

## Changing the standard

If something fits nowhere, you change the standard, not just the project:

1. A row in [where does this belong](where-does-this-belong.md) and, if it is a new place, a line in the tree of [skeleton](skelet.md).
