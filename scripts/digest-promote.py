#!/usr/bin/env python3
"""Drafts per-theme § candidates from a week letter — P5: nothing lands in bronnen.md.

Input:  bron/weken/<WEEK>.md rows with status `keep` (or `maybe`).
Output: bron/weken/<WEEK>-promote/<theme>.md  (one file per theme)
        bron/weken/<WEEK>-promote/INDEX.md   (overview + per-theme counts)

A deterministic script proposes themes from title+abstract. That proposal is a
*starting point for the agent* (see docs/how-to/digest-promote.md): the agent
reads the abstracts, decides what is worthy and fixes the theme; digest-place.py
then inserts the accepted entries with a real § number.
"""
from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import digest_themes as dt  # noqa: E402

ROW_RE = re.compile(r"^\|\s*(.*?)\s*\|\s*(.*?)\s*\|\s*(.*?)\s*\|\s*(.*?)\s*\|$")
ACCEPTED = {"keep", "maybe"}
# abstract budget per entry: enough for a decent "Kern", small enough to read in bulk
SNIPPET = 600


def parse_rows(path: Path) -> list[dict]:
    rows = []
    in_table = False
    for line in path.read_text(encoding="utf-8").splitlines():
        raw = line.strip()
        if re.match(r"^## Papers / feed[\s-]*hits\b", raw):
            in_table = True
            continue
        if in_table and raw.startswith("## "):
            break
        if not in_table:
            continue
        m = ROW_RE.match(raw)
        if not m:
            continue
        title, link, src, status = (m.group(i).strip() for i in range(1, 5))
        if not title or re.match(r"^(?i:titel|title)$", title):
            continue
        if set(title) <= {"-", ":", " "}:
            continue
        rows.append({"title": title, "link": link, "source": src, "status": status})
    return rows


def one_line(text: str, limit: int = SNIPPET) -> str:
    t = " ".join((text or "").split())
    return t if len(t) <= limit else t[: limit - 1].rstrip() + "…"


def theme_file(bucket: str) -> str:
    """Theme titles contain '/' and '&' — a filename must not. Keep it readable."""
    if bucket == "_uncertain":
        return "_uncertain"
    return re.sub(r"[^a-z0-9]+", "-", bucket.lower()).strip("-") or "theme"


def entry_md(row: dict, theme: str, rule: str, absd: dict | None) -> str:
    parts = [f"### {row['title']}", ""]
    parts.append(f"- **Link:** {row['link'] or '—'}")
    parts.append(f"- **Source:** {row['source']} · **triage:** {row['status']}")
    parts.append(f"- **Theme (proposed):** {theme or '? uncertain'} _({rule})_")
    if absd:
        gist = absd.get("ai_summary") or ""
        body = absd.get("abstract") or ""
        if gist:
            parts.append(f"- **Gist (HF ai_summary):** {one_line(gist)}")
        if body:
            parts.append(f"- **Abstract:** {one_line(body)}")
        up = absd.get("upvotes")
        if up:
            parts.append(f"- **Upvotes:** {up}")
    else:
        parts.append("- **Abstract:** _not found in dumps — read the link before accepting_")
    parts += [
        "",
        "**Agent: fill in before accepting**",
        "",
        "```yaml",
        "# decision: accept | skip   (skip = wanted nothing; it disappears from the draft)",
        "decision:",
        "theme:",  # must be an exact H1 from bronnen.md
        f"title: {row['title']}",
        "kern:",  # 2-3 sentences, Dutch, factual, from the abstract
        "relevance:",  # why it matters for the BP / this theme — one line
        "```",
        "",
        f"**URL check:** {row['link'] or '—'}",
        "",
        "",
    ]
    return "\n".join(parts)


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--week", default="", help="ISO week (default: current)")
    ap.add_argument("--force", action="store_true", help="overwrite an existing draft dir")
    args = ap.parse_args()

    lines = dt.read_bronnen()
    themes = dt.themes_from(lines)
    week = args.week or dt.iso_week_today()
    src = dt.WERKEN / f"{week}.md"
    if not src.is_file():
        print(f"digest-promote: missing {src}", file=sys.stderr)
        return 1
    out_dir = dt.WERKEN / f"{week}-promote"
    if out_dir.exists() and any(out_dir.iterdir()) and not args.force:
        print(
            f"digest-promote: {out_dir} already has drafts "
            "(an agent may be working on them) — pass --force to regenerate",
            file=sys.stderr,
        )
        return 1
    out_dir.mkdir(parents=True, exist_ok=True)

    rows = [r for r in parse_rows(src) if r["status"] in ACCEPTED]
    abstracts = dt.load_abstracts()
    buckets: dict[str, list[str]] = {}
    stats = {"accepted": 0, "uncertain": 0, "no_abstract": 0, "theme": {}}

    seen: set[str] = set()
    for row in rows:
        key = (dt.ARXIV_RE.search(row["link"]).group(1) if dt.ARXIV_RE.search(row["link"]) else row["title"]).lower()
        if key in seen:
            continue
        seen.add(key)
        absd = dt.abstract_for(row["link"], row["title"], abstracts)
        if absd is None:
            stats["no_abstract"] += 1
        text = " ".join(
            filter(None, [row["title"], (absd or {}).get("abstract", ""), (absd or {}).get("ai_summary", "")])
        )
        theme, rule = dt.theme_for(row["title"], text, themes)
        bucket = theme or "_uncertain"
        if not theme:
            stats["uncertain"] += 1
        stats["accepted"] += 1
        stats["theme"][bucket] = stats["theme"].get(bucket, 0) + 1
        buckets.setdefault(bucket, []).append(entry_md(row, theme, rule, absd))

    for bucket, entries in sorted(buckets.items()):
        header = [
            f"# Promote drafts — {week} — {bucket}",
            "",
            "> **Role:** § candidates for one `bronnen.md` theme. Nothing is placed yet (P5).",
            f"> **Agent:** set `decision`, `theme` and `kern` per entry; then `make digest-place WEEK={week}`.",
            "",
        ]
        if bucket == "_uncertain":
            header.insert(
                3,
                "> **Role:** no confident theme — set `theme:` to an exact H1 of `bronnen.md`, or `skip`.",
            )
        (out_dir / f"{theme_file(bucket)}.md").write_text(
            "\n".join(header) + "\n".join(entries), encoding="utf-8"
        )

    index = [
        f"# Promote — {week}",
        "",
        "> **Role:** per-theme drafts from `make digest-promote`. Promote: `make digest-place`.",
        "",
        f"- candidates: **{stats['accepted']}** (unique) out of {len(rows)} keep/maybe rows",
        f"- theme uncertain: **{stats['uncertain']}** → `_uncertain.md`",
        f"- abstract missing: **{stats['no_abstract']}**",
        "",
        "| Theme | Candidates | File |",
        "|-------|-----------:|------|",
    ]
    for bucket, n in sorted(stats["theme"].items(), key=lambda kv: (-kv[1], kv[0])):
        fname = f"{theme_file(bucket)}.md"
        index.append(f"| {bucket} | {n} | [{fname}]({fname}) |")
    (out_dir / "INDEX.md").write_text("\n".join(index) + "\n", encoding="utf-8")

    print(
        f"digest-promote: {out_dir.relative_to(dt.ROOT)} — {stats['accepted']} candidates, "
        f"{len(buckets)} theme file(s), {stats['uncertain']} uncertain",
        file=sys.stderr,
    )
    print("digest-promote: next → agent fills decisions, then make digest-place", file=sys.stderr)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
