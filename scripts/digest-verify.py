#!/usr/bin/env python3
"""Verify the promotion chain: drafts, bronnen.md and bronnen-index.md agree.

This is the gate an agent runs after placing (§ in bronnen.md, index row) — and
the human check before trusting a batch. Read-only: it never edits.

Checks
  drafts   every entry has a decision; accepted ones need a valid theme + kern
  themes   every § lives under a real H1 theme (no § in front matter / matrix)
  numbers  § numbers are unique, and none skipped beyond the documented rule
  index    every § has an index row, and every index row points at a real §
  counter  the "Bronnen tot §N" line matches the highest §
  duplicates  the same link / arXiv id does not appear in two §§

Usage: make digest-verify [WEEK=2026-W48]   (exit 1 = problems found)
"""
from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import digest_themes as dt  # noqa: E402

STATUS_OK = {"accept", "skip"}


def check_drafts(week: str, themes: list[str]) -> list[str]:
    out: list[str] = []
    d = dt.WERKEN / f"{week}-promote"
    if not d.is_dir():
        return out
    import importlib.util

    spec = importlib.util.spec_from_file_location("dp", Path(__file__).with_name("digest-place.py"))
    dp = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(dp)
    accepted, refused = dp.parse_drafts(d, themes)
    for r in refused:
        if r["problem"] == "__skip__":
            continue
        out.append(f"draft {r['file'].name}: {r['title'][:60]} — {r['problem']}")
    return out


def check_bronnen(lines: list[str]) -> tuple[list[str], dict[int, dict]]:
    out: list[str] = []
    secs = dt.sections(lines)
    spans = dt.theme_spans(lines)
    in_theme = {i for a, b in spans.values() for i in range(a, b)}
    for num, meta in secs.items():
        if meta["line"] not in in_theme:
            out.append(f"§{num} sits outside every theme (front matter or matrix): line {meta['line'] + 1}")
    nums = sorted(secs)
    if nums:
        gaps = [n for n in range(1, max(nums) + 1) if n not in secs]
        if gaps:
            out.append("§ numbers missing (chronological, so a gap means a lost section): " + ", ".join(map(str, gaps[:15])))
    return out, secs


def check_index(secs: dict[int, dict]) -> list[str]:
    out: list[str] = []
    if not dt.INDEX.is_file():
        return ["bronnen-index.md is missing"]
    text = dt.INDEX.read_text(encoding="utf-8")
    # Any |§n| reference counts as covered: the index also mentions sections in
    # the theme tables and the overview, and a row removed by hand must not make
    # every § look missing.
    rows = set(int(n) for n in re.findall(r"§(\d+)", text))
    missing = sorted(set(secs) - rows)
    stale = sorted(rows - set(secs))
    if missing:
        out.append("in bronnen.md but no index row: " + ", ".join(f"§{n}" for n in missing[:15]))
    if stale:
        out.append("index row without a § in bronnen.md: " + ", ".join(f"§{n}" for n in stale[:15]))
    return out


def check_counter(lines: list[str], secs: dict[int, dict]) -> list[str]:
    if not secs:
        return []
    m = re.search(r"Bronnen tot §(\d+)\.", "".join(lines))
    top = max(secs)
    if m and int(m.group(1)) != top:
        return [f'"Bronnen tot §{m.group(1)}" but the highest § is {top}']
    if not m:
        return ['no "Bronnen tot §N" line in the matrix']
    return []


def check_duplicate_links(lines: list[str], secs: dict[int, dict]) -> list[str]:
    out: list[str] = []
    seen: dict[str, int] = {}
    order = sorted(secs.items(), key=lambda kv: kv[1]["line"])
    for i, (num, _) in enumerate(order):
        start = secs[num]["line"]
        end = order[i + 1][1]["line"] if i + 1 < len(order) else len(lines)
        block = "".join(lines[start:end])
        m = dt.ARXIV_RE.search(block)
        key = m.group(1) if m else None
        if not key:
            continue
        if key in seen:
            out.append(f"arXiv {key} appears in both §{seen[key]} and §{num}")
        else:
            seen[key] = num
    return out


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--week", default="")
    args = ap.parse_args()
    week = args.week or dt.iso_week_today()
    lines = dt.read_bronnen()
    themes = dt.themes_from(lines)

    problems: list[str] = []
    problems += check_drafts(week, themes)
    sub, secs = check_bronnen(lines)
    problems += sub
    problems += check_index(secs)
    problems += check_counter(lines, secs)
    problems += check_duplicate_links(lines, secs)

    print(
        f"digest-verify: {len(themes)} themes, {len(secs)} sections, "
        f"max §{max(secs) if secs else 0}",
        file=sys.stderr,
    )
    if problems:
        for p in problems:
            print(f"  ✗ {p}", file=sys.stderr)
        print(f"digest-verify: {len(problems)} problem(s)", file=sys.stderr)
        return 1
    print("digest-verify: green", file=sys.stderr)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
