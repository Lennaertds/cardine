#!/usr/bin/env python3
"""Place accepted promote drafts into bronnen.md + bronnen-index.md, with a real §.

P5 still holds: this never *decides*. It only inserts entries that an agent (or
you) marked `decision: accept` and gave an exact theme + kern. Everything else is
refused and reported, leaving the draft untouched.

Guarantees
  - theme must be an exact H1 of bronnen.md (no phantom themes)
  - kern must be non-empty and not a TODO placeholder
  - the link must not already be in bronnen.md (no double § on a re-run)
  - the section is appended at the end of its theme, before the next `# H1`
  - bronnen-index.md gets a row in that theme's table
  - --dry-run prints the exact plan and writes nothing

Usage: make digest-place WEEK=2026-W48 [DRY_RUN=1] [ALLOW_PARTIAL=1]
"""
from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import digest_themes as dt  # noqa: E402

# [ \t] not \s: a following "key:" line must stay its own (empty) field, otherwise
# "decision:\ntheme:" parses as decision="theme:".
FIELD_RE = re.compile(r"^(decision|theme|title|kern|relevance):[ \t]*(.*)$", re.M)
TITLE_RE = re.compile(r"^###\s+(.+?)\s*$", re.M)
LINK_RE = re.compile(r"^- \*\*Link:\*\*\s*(\S+)", re.M)


def parse_drafts(draft_dir: Path, themes: list[str]) -> tuple[list[dict], list[dict]]:
    """(accepted, refused). Each entry keeps `file` and `offset` for rewriting."""
    accepted: list[dict] = []
    refused: list[dict] = []
    for f in sorted(draft_dir.glob("*.md")):
        if f.name == "INDEX.md":
            continue
        text = f.read_text(encoding="utf-8")
        starts = [m.start() for m in TITLE_RE.finditer(text)] + [len(text)]
        for a, b in zip(starts, starts[1:]):
            block = text[a:b]
            hdr = TITLE_RE.match(block)
            if not hdr:
                continue
            fields = {m.group(1): m.group(2).strip() for m in FIELD_RE.finditer(block)}
            link_m = LINK_RE.search(block)
            entry = {
                "file": f,
                "start": a,
                "end": b,
                "heading": hdr.group(1),
                "link": link_m.group(1) if link_m else "",
                "decision": (fields.get("decision") or "").lower(),
                "theme": fields.get("theme") or "",
                "title": fields.get("title") or hdr.group(1),
                "kern": fields.get("kern") or "",
                "relevance": fields.get("relevance") or "",
            }
            problem = validate(entry, themes)
            (refused if problem else accepted).append({**entry, "problem": problem})
    return accepted, refused


def validate(e: dict, themes: list[str]) -> str | None:
    if e["decision"] == "skip":
        return "__skip__"
    if e["decision"] == "":
        return "decision not filled in"
    if e["decision"] != "accept":
        return f"unknown decision {e['decision']!r}"
    if e["theme"] not in themes:
        return f"theme {e['theme']!r} is not an exact H1 of bronnen.md"
    kern = e["kern"].strip()
    if not kern or kern.upper().startswith("TODO") or kern.rstrip(".") == e["title"]:
        return "kern is empty or still a placeholder"
    if not e["link"] or not e["link"].startswith("http"):
        return "no usable link"
    return None


def section_md(e: dict, num: int) -> str:
    parts = [
        f"## §{num}. {e['title']}",
        "",
        f"**Type:** Paper · **URL:** [{e['link']}]({e['link']})",
        "",
        f"- **Kern:** {e['kern'].strip()}",
    ]
    if e["relevance"].strip():
        parts += ["", "#### Relevantie", "", f"* {e['relevance'].strip()}"]
    parts += ["", "---", "", ""]
    return "\n".join(parts)


def index_row(num: int, e: dict) -> str:
    short = re.sub(r"\s*\((?:[^()]*\d{4}[^()]*)\)\s*$", "", e["title"]).strip()
    over = " ".join(e["kern"].split())
    over = over[:110].rsplit(" ", 1)[0] + "…" if len(over) > 110 else over
    return f"| §{num} | {short} | {over} |"


def theme_table_range(lines: list[str], theme: str) -> tuple[int, int] | None:
    """(first_row_line, end_line) of that theme's table in bronnen-index.md."""
    idx = dt.INDEX.read_text(encoding="utf-8").splitlines(keepends=True)
    start = None
    for i, line in enumerate(idx):
        if line.startswith("###") and theme in line:
            start = i
            break
    if start is None:
        return None
    first = last = None
    for i in range(start + 1, len(idx)):  # +1: the heading itself starts with "###"
        if idx[i].startswith(("##", "###")):
            break
        # a data row is "| §<n> | …"; header ("| § | Titel |") and separator are not
        if re.match(r"^\|\s*§\d+\s*\|", idx[i]):
            first = first if first is not None else i
            last = i
    if first is None:
        return None
    return first, last + 1


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--week", default="")
    ap.add_argument("--dry-run", action="store_true")
    ap.add_argument("--allow-partial", action="store_true", help="place accepted even if some are refused")
    args = ap.parse_args()

    week = args.week or dt.iso_week_today()
    draft_dir = dt.WERKEN / f"{week}-promote"
    if not draft_dir.is_dir():
        print(f"digest-place: no drafts at {draft_dir} — run make digest-promote first", file=sys.stderr)
        return 1

    lines = dt.read_bronnen()
    themes = dt.themes_from(lines)
    accepted, refused = parse_drafts(draft_dir, themes)
    skipped = [r for r in refused if r["problem"] == "__skip__"]
    problems = [r for r in refused if r["problem"] != "__skip__"]

    print(f"digest-place: {len(accepted)} accepted, {len(skipped)} skipped, {len(problems)} refused", file=sys.stderr)
    for r in problems[:20]:
        print(f"  refused: {r['title'][:60]} — {r['problem']}", file=sys.stderr)
    if problems:
        print("  (fix these in the drafts; skipped entries are fine)", file=sys.stderr)
        if not args.allow_partial:
            print("digest-place: nothing written (pass ALLOW_PARTIAL=1 to place the valid ones)", file=sys.stderr)
            return 1
    if not accepted:
        print("digest-place: nothing to place", file=sys.stderr)
        return 0

    existing = "\n".join(lines)
    already = [
        e for e in accepted if re.search(rf"\]\({re.escape(e['link'])}\)", existing)
    ]
    for e in already:
        print(f"  already in bronnen.md: {e['title'][:60]} — {e['link']}", file=sys.stderr)
    accepted = [e for e in accepted if e not in already]
    if not accepted:
        print("digest-place: all accepted links are already in bronnen.md — nothing to do", file=sys.stderr)
        return 0

    # assign numbers in theme order (Vierlagen first), then document order
    order = {t: i for i, t in enumerate(themes)}
    accepted.sort(key=lambda e: (order.get(e["theme"], 99), e["title"].lower()))
    start_num = dt.next_free_section(lines)

    plan = []
    for n, e in enumerate(accepted, start=start_num):
        plan.append((n, e))
        print(f"  §{n}  [{e['theme']}] {e['title'][:70]}", file=sys.stderr)

    if args.dry_run:
        print("digest-place: dry-run — nothing written", file=sys.stderr)
        return 0

    # Insert per theme from the BOTTOM up. Spans are computed once on the
    # original list; each insertion grows the list, so handling a higher theme
    # first keeps every lower offset valid. Iterating in theme order instead
    # shifted each following span and dropped sections into the wrong theme.
    spans = dt.theme_spans(lines)
    by_theme: dict[str, list[tuple[int, dict]]] = {}
    for n, e in plan:
        by_theme.setdefault(e["theme"], []).append((n, e))
    missing = [t for t in by_theme if t not in spans]
    if missing:
        print(f"digest-place: theme vanished: {missing}", file=sys.stderr)
        return 1
    for theme in sorted(by_theme, key=lambda t: spans[t][1], reverse=True):
        items = by_theme[theme]
        _, end = spans[theme]
        anchor = end
        while anchor > 0 and lines[anchor - 1].strip() == "":
            anchor -= 1
        block = "".join(section_md(e, n) for n, e in sorted(items, key=lambda x: x[0]))
        lines[anchor:anchor] = ["\n", block]
    # The insertions above must not change the theme of any existing section:
    # a section left outside every theme (front matter) is a hard error.
    after = dt.sections(lines)
    stray = [n for n, m in after.items() if m["theme"] is None]
    if stray:
        print(f"digest-place: refusing to write — sections outside any theme: {stray[:5]}", file=sys.stderr)
        return 1
    dt.BRONNEN.write_text("".join(lines), encoding="utf-8")

    # index rows, ascending: re-read per theme so earlier inserts do not shift
    for n, e in plan:
        rng = theme_table_range(dt.INDEX.read_text(encoding="utf-8").splitlines(keepends=True), e["theme"])
        idx = dt.INDEX.read_text(encoding="utf-8").splitlines(keepends=True)
        if rng is None:
            print(f"digest-place: no index table for {e['theme']} — add row §{n} by hand", file=sys.stderr)
            continue
        _, last = rng
        idx.insert(last, index_row(n, e) + "\n")
        dt.INDEX.write_text("".join(idx), encoding="utf-8")

    # keep the "Bronnen tot §N" line honest
    total = max(n for n, _ in plan)
    br = dt.BRONNEN.read_text(encoding="utf-8")
    br = re.sub(r"Bronnen tot §\d+\.", f"Bronnen tot §{total}.", br, count=1)
    dt.BRONNEN.write_text(br, encoding="utf-8")

    print(f"digest-place: placed {len(plan)} section(s) §{start_num}–§{total}", file=sys.stderr)
    print("digest-place: next → make digest-verify", file=sys.stderr)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
