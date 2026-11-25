#!/usr/bin/env python3
"""Triage weekbrief-status t.o.v. bronnen.md + interests.md. Geen auto-§ (P5)."""
from __future__ import annotations

import argparse
import os
import re
import sys
from datetime import date, timedelta
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
BRONNEN = ROOT / "bron" / "bronnen.md"
INTERESTS = ROOT / "bron" / "digest" / "interests.md"
WEKEN = ROOT / "bron" / "weken"

ARXIV_RE = re.compile(
    r"(?:arxiv\.org/(?:abs|pdf)/|huggingface\.co/papers/)(\d{4}\.\d{4,5})",
    re.I,
)
ARXIV_BARE = re.compile(r"\b(\d{4}\.\d{4,5})(?:v\d+)?\b")
SECTION_RE = re.compile(r"^##\s+(§\d+)\.\s", re.M)
H1_RE = re.compile(r"^#\s+(.+)$", re.M)
ROW_RE = re.compile(
    r"^\|\s*(.*?)\s*\|\s*(.*?)\s*\|\s*(.*?)\s*\|\s*(.*?)\s*\|$"
)

# Core AE + bachelor — always keep on a title hit.
AE_KEYWORDS = [
    "agent",
    "agentic",
    "harness",
    "scaffold",
    "context engineering",
    "context rot",
    "prompt",
    "skill",
    "mcp",
    "rag",
    "retriev",
    "index",
    "grep",
    "embedding",
    "token",
    "kv cache",
    "inference",
    "moe",
    "quant",
    "reasoning",
    "tool use",
    "tool-use",
    "coding agent",
    "swe-bench",
    "swe bench",
    "benchmark",
    "eval",
    "memory",
    "loop engineering",
    "workflow",
    "spec-driven",
    "multi-agent",
    "llm",
    "language model",
    "transformer",
]

HIGH_SIGNAL_BRON = (
    "hf trending",
    "hf q:",
    "hf week",
    "hf day",
    "hf daily",
)


def load_interests(path: Path) -> list[str]:
    if not path.is_file():
        return []
    out: list[str] = []
    for line in path.read_text(encoding="utf-8").splitlines():
        s = line.strip()
        if not s or s.startswith("#") or s.startswith(">"):
            continue
        if s.startswith("```"):
            continue
        out.append(s.lower())
    return out


def load_bronnen_index(path: Path) -> tuple[dict[str, str], list[str]]:
    """arxiv_id → §n ; theme keywords from H1 headings."""
    text = path.read_text(encoding="utf-8")
    id_to_sec: dict[str, str] = {}
    current_sec: str | None = None
    for line in text.splitlines():
        m = re.match(r"^##\s+(§\d+)\.", line)
        if m:
            current_sec = m.group(1)
            continue
        if current_sec:
            for m2 in ARXIV_RE.finditer(line):
                id_to_sec[m2.group(1)] = current_sec
            for m2 in ARXIV_BARE.finditer(line):
                # only in a URL-like context: avoid years in prose
                if "arxiv" in line.lower() or "abs/" in line or "papers/" in line:
                    id_to_sec.setdefault(m2.group(1), current_sec)

    themes: list[str] = []
    for m in H1_RE.finditer(text):
        title = m.group(1).strip()
        if title.lower().startswith("bronnen"):
            continue
        themes.append(title.lower())
        # losse tokens ≥4 chars uit thema-titel
        for tok in re.split(r"[^a-z0-9]+", title.lower()):
            if len(tok) >= 4:
                themes.append(tok)
    # uniek behouden volgorde
    seen: set[str] = set()
    theme_kw: list[str] = []
    for t in themes:
        if t not in seen:
            seen.add(t)
            theme_kw.append(t)
    return id_to_sec, theme_kw


def arxiv_id(link: str) -> str | None:
    m = ARXIV_RE.search(link)
    if m:
        return m.group(1)
    m = ARXIV_BARE.search(link)
    return m.group(1) if m else None


def is_high_signal(bron: str) -> bool:
    b = bron.lower()
    return any(s in b for s in HIGH_SIGNAL_BRON)


def title_hits(title: str, keywords: list[str]) -> str | None:
    t = title.lower()
    for kw in keywords:
        if not kw:
            continue
        if len(kw) <= 3:
            if re.search(rf"\b{re.escape(kw)}\b", t):
                return kw
        elif kw in t:
            return kw
    return None


def decide(
    title: str,
    link: str,
    bron: str,
    status: str,
    id_to_sec: dict[str, str],
    keywords: list[str],
    force: bool,
    bronnen_text: str,
) -> tuple[str, str]:
    """Return (new_status, reason)."""
    st = status.strip()
    if re.fullmatch(r"§\d+", st):
        return st, "manual-§"

    aid = arxiv_id(link)
    if aid and aid in id_to_sec:
        return id_to_sec[aid], f"in-bronnen:{aid}"

    if link and link != "—" and link in bronnen_text:
        return "have", "url-in-bronnen"

    # always open; other statuses only recomputed with --force
    if not force and st not in {"open", ""}:
        return st, "preserve"

    if is_high_signal(bron):
        return "keep", f"signal:{bron}"

    hit = title_hits(title, keywords)
    if hit:
        return "keep", f"kw:{hit}"

    if "hf blog" in bron.lower():
        if title_hits(title, ["llm", "agent", "model", "ocr", "token"]):
            return "keep", "soft-blog"

    return "skip", "no-signal"


def default_weeks() -> list[str]:
    today = date.today()
    y, w, _ = today.isocalendar()
    weeks = [f"{y}-W{w:02d}"]
    if today.isoweekday() == 1:  # Monday: also the previous
        prev = today - timedelta(days=7)
        py, pw, _ = prev.isocalendar()
        weeks.append(f"{py}-W{pw:02d}")
    return weeks


def triage_file(
    path: Path,
    id_to_sec: dict[str, str],
    keywords: list[str],
    force: bool,
    dry_run: bool,
    bronnen_text: str,
) -> dict[str, int]:
    text = path.read_text(encoding="utf-8")
    lines = text.splitlines(keepends=True)
    counts: dict[str, int] = {}
    out_lines: list[str] = []
    in_table = False

    for line in lines:
        raw = line.rstrip("\n")
        if raw.startswith("## Papers / feed-hits"):
            in_table = True
            out_lines.append(line)
            continue
        if in_table and raw.startswith("## "):
            in_table = False

        if not in_table:
            out_lines.append(line)
            continue

        m = ROW_RE.match(raw.strip())
        if not m or "Titel" in m.group(1) or re.match(r"^[-:|\s]+$", raw.strip()):
            out_lines.append(line)
            continue
        if set(m.group(1).strip()) <= {"-", ":"}:
            out_lines.append(line)
            continue

        title, link, bron, status = (m.group(i).strip() for i in range(1, 5))
        new_st, reason = decide(
            title, link, bron, status, id_to_sec, keywords, force, bronnen_text
        )
        counts[new_st] = counts.get(new_st, 0) + 1
        if new_st != status:
            counts["_changed"] = counts.get("_changed", 0) + 1
        new_row = f"| {title} | {link} | {bron} | {new_st} |\n"
        if dry_run and new_st != status:
            print(f"  {status} → {new_st} ({reason}): {title[:70]}", file=sys.stderr)
        out_lines.append(new_row)

    if not dry_run:
        # Update checklist tip
        joined = "".join(out_lines)
        if "- [ ] Irrelevante rijen" in joined and "digest-triage" not in joined:
            joined = joined.replace(
                "## Checklist\n",
                "## Checklist\n\n"
                "> Na fetch: `make digest-triage` (zie [../digest/TRIAGE.md](../digest/TRIAGE.md)).\n",
                1,
            )
        path.write_text(joined, encoding="utf-8")
    return counts


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--week", action="append", help="ISO-week YYYY-Www (herhaalbaar)")
    ap.add_argument("--force", action="store_true", help="herbereken keep/skip")
    ap.add_argument("--dry-run", action="store_true")
    args = ap.parse_args()
    force = args.force or os.environ.get("DIGEST_TRIAGE_FORCE") == "1"
    weeks = args.week or ([os.environ["WEEK"]] if os.environ.get("WEEK") else default_weeks())

    if not BRONNEN.is_file():
        print(f"digest-triage: ontbreekt {BRONNEN}", file=sys.stderr)
        return 1

    bronnen_text = BRONNEN.read_text(encoding="utf-8")
    id_to_sec, theme_kw = load_bronnen_index(BRONNEN)
    interests = load_interests(INTERESTS)
    keywords = list(dict.fromkeys(AE_KEYWORDS + theme_kw + interests))

    print(
        f"digest-triage: {len(id_to_sec)} arXiv-ids in bronnen; "
        f"{len(keywords)} keywords; force={force}",
        file=sys.stderr,
    )

    for w in weeks:
        path = WEKEN / f"{w}.md"
        if not path.is_file():
            print(f"digest-triage: skip ontbreekt {path}", file=sys.stderr)
            continue
        print(f"digest-triage: {path.name}", file=sys.stderr)
        counts = triage_file(
            path, id_to_sec, keywords, force, args.dry_run, bronnen_text
        )
        changed = counts.pop("_changed", 0)
        summary = ", ".join(f"{k}={v}" for k, v in sorted(counts.items()))
        print(f"  → {summary} (gewijzigd: {changed})", file=sys.stderr)

    print("digest-triage: klaar — review keep-rijen; § blijft handmatig (P5)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
