#!/usr/bin/env python3
"""Parse RSS/Atom XML of HF/JSON API → items.md (title + link). Stdlib only."""
from __future__ import annotations

import argparse
import html
import json
import os
import re
import sys
import xml.etree.ElementTree as ET
from datetime import datetime, timedelta, timezone
from email.utils import parsedate_to_datetime
from pathlib import Path
from typing import Any
from urllib.parse import urlparse


def _local(tag: str) -> str:
    return tag.rsplit("}", 1)[-1] if "}" in tag else tag


def _text(el: ET.Element | None) -> str:
    if el is None or el.text is None:
        return ""
    return html.unescape(" ".join(el.text.split()))


def _link_from(el: ET.Element) -> str:
    for child in el:
        if _local(child.tag) == "link":
            href = child.attrib.get("href") or child.attrib.get("url")
            if href:
                return href.strip()
            if child.text and child.text.strip().startswith("http"):
                return child.text.strip()
    return ""


def parse_items_xml(xml_bytes: bytes) -> list[tuple[str, str]]:
    root = ET.fromstring(xml_bytes)
    items: list[tuple[str, str]] = []
    # RSS 2.0
    for channel in root.iter():
        if _local(channel.tag) != "channel":
            continue
        for item in channel:
            if _local(item.tag) != "item":
                continue
            title = ""
            link = ""
            for child in item:
                name = _local(child.tag)
                if name == "title":
                    title = _text(child)
                elif name == "link":
                    link = (child.text or "").strip() or child.attrib.get("href", "")
            if title or link:
                items.append((title or "(no title)", link))
        break
    if items:
        return items
    # Atom
    for entry in root.iter():
        if _local(entry.tag) != "entry":
            continue
        title = ""
        link = _link_from(entry)
        for child in entry:
            if _local(child.tag) == "title":
                title = _text(child)
        if title or link:
            items.append((title or "(no title)", link))
    return items


def _parse_iso(ts: str | None) -> datetime | None:
    if not ts or not isinstance(ts, str):
        return None
    try:
        return datetime.fromisoformat(ts.replace("Z", "+00:00"))
    except ValueError:
        return None


def _hf_paper_link(pid: str) -> str:
    pid = pid.strip()
    if re.fullmatch(r"\d{4}\.\d{4,5}(v\d+)?", pid):
        return f"https://arxiv.org/abs/{pid}"
    return f"https://huggingface.co/papers/{pid}"


def _iter_json_records(data: Any) -> list[dict[str, Any]]:
    if isinstance(data, list):
        return [x for x in data if isinstance(x, dict)]
    if isinstance(data, dict):
        for key in ("results", "papers", "data", "items"):
            val = data.get(key)
            if isinstance(val, list):
                return [x for x in val if isinstance(x, dict)]
        return [data]
    return []


def parse_items_json(
    raw: bytes,
    *,
    since: datetime | None = None,
) -> list[tuple[str, str]]:
    data = json.loads(raw)
    items: list[tuple[str, str]] = []
    seen: set[str] = set()
    for rec in _iter_json_records(data):
        paper = rec.get("paper") if isinstance(rec.get("paper"), dict) else rec
        if not isinstance(paper, dict):
            continue
        title = (paper.get("title") or rec.get("title") or "").strip()
        pid = str(paper.get("id") or rec.get("id") or "").strip()
        link = ""
        if pid:
            link = _hf_paper_link(pid)
        elif isinstance(paper.get("url"), str):
            link = paper["url"].strip()
        if since is not None:
            ts = (
                _parse_iso(paper.get("publishedAt"))
                or _parse_iso(rec.get("publishedAt"))
                or _parse_iso(paper.get("submittedOnDailyAt"))
                or _parse_iso(rec.get("submittedOnDailyAt"))
            )
            # Search APIs mix old and new; without a date we let it through (daily_papers usually has ts).
            if ts is not None and ts < since:
                continue
        if not title and not link:
            continue
        link = normalize_link(link)
        key = (link or title).lower()
        if key in seen:
            continue
        seen.add(key)
        items.append((title or "(no title)", link))
    return items


# arxiv.org/abs/2611.01860v2 and arxiv.org/abs/2611.01860 are one paper: the
# version suffix changes per revision, so it is dropped before dedupe/date filter.
_ARXIV_VER_RE = re.compile(r"^(https?://(?:www\.)?arxiv\.org/abs/\d{4}\.\d{4,5})v\d+$", re.I)


def normalize_link(link: str) -> str:
    link = link.strip()
    m = _ARXIV_VER_RE.match(link)
    return m.group(1) if m else link


def parse_pubdate(items_xml: bytes) -> list[tuple[str, str, datetime | None]]:
    """RSS items as (title, link, published) — published from <pubDate>/<dc:date>."""
    root = ET.fromstring(items_xml)
    out: list[tuple[str, str, datetime | None]] = []
    for channel in root.iter():
        if _local(channel.tag) != "channel":
            continue
        for item in channel:
            if _local(item.tag) != "item":
                continue
            title = link = ""
            ts = None
            for child in item:
                name = _local(child.tag)
                if name == "title":
                    title = _text(child)
                elif name == "link":
                    link = (child.text or "").strip()
                elif name in ("pubDate", "date", "published", "updated"):
                    raw = _text(child)
                    try:
                        ts = parsedate_to_datetime(raw)
                    except (TypeError, ValueError):
                        ts = _parse_iso(raw)
                    if ts is not None and ts.tzinfo is None:
                        ts = ts.replace(tzinfo=timezone.utc)
            if title or link:
                out.append((title or "(no title)", normalize_link(link), ts))
        break
    return out


def looks_like_json(raw: bytes) -> bool:
    s = raw.lstrip()
    return bool(s) and s[0:1] in (b"{", b"[")


def write_items_md(items: list[tuple[str, str]], out: Path, source: str, limit: int) -> int:
    lines = [
        f"# Items — {source}",
        "",
        "> Generated by digest-fetch. Not SSOT — curate via digest-propose → radar (P5).",
        "",
        "| Titel | Link |",
        "|-------|------|",
    ]
    n = 0
    for title, link in items[:limit]:
        t = title.replace("|", "\\|")
        lines.append(f"| {t} | {link or '—'} |")
        n += 1
    out.write_text("\n".join(lines) + "\n", encoding="utf-8")
    return n


def _since_from_env() -> datetime | None:
    raw = os.environ.get("DIGEST_JSON_SINCE", "").strip()
    if raw:
        try:
            d = datetime.fromisoformat(raw)
            if d.tzinfo is None:
                d = d.replace(tzinfo=timezone.utc)
            return d
        except ValueError:
            print(f"digest-rss: ongeldige DIGEST_JSON_SINCE={raw!r}", file=sys.stderr)
            return None
    # Default: last 14 days for HF/JSON (keeps topic search fresh).
    days = os.environ.get("DIGEST_JSON_DAYS", "14").strip()
    try:
        n = int(days)
    except ValueError:
        n = 14
    if n <= 0:
        return None
    return datetime.now(timezone.utc) - timedelta(days=n)


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("-i", "--input", required=True, help="pad naar feed XML of JSON")
    ap.add_argument("-o", "--output", required=True, help="pad naar items.md")
    ap.add_argument("-s", "--source", default="", help="bron-URL of slug")
    ap.add_argument("-n", "--limit", type=int, default=30)
    # -b START[,END] (YYYY-MM-DD): keep only items published inside the window.
    # arXiv RSS/Atom always return *today's* list; for a past week the whole
    # fetch is useless without this (the week letter then shows nothing).
    ap.add_argument("-b", "--between", default="", help="publication window YYYY-MM-DD[,YYYY-MM-DD]")
    args = ap.parse_args()
    lo = hi = None
    if args.between:
        try:
            parts = args.between.split(",")
            lo = datetime.fromisoformat(parts[0]).replace(tzinfo=timezone.utc)
            if len(parts) > 1 and parts[1]:
                hi = datetime.fromisoformat(parts[1]).replace(tzinfo=timezone.utc)
        except ValueError:
            print(f"digest-rss: invalid --between {args.between!r}", file=sys.stderr)
            return 1
    path = Path(args.input)
    if not path.is_file():
        print(f"digest-rss: file missing: {path}", file=sys.stderr)
        return 1
    raw = path.read_bytes()
    source = args.source or str(path)
    host = urlparse(source).netloc.lower() if source.startswith("http") else ""
    try:
        if looks_like_json(raw):
            since = _since_from_env() if "huggingface.co" in host or path.suffix == ".json" else None
            items = parse_items_json(raw, since=since)
            kind = "json"
        else:
            m = re.search(rb"<[\s\S]+", raw)
            if not m:
                print("digest-rss: no XML/JSON found", file=sys.stderr)
                return 1
            if lo is None:
                items = parse_items_xml(m.group(0))
            else:
                dated = parse_pubdate(m.group(0))
                in_win = [t for t in dated if t[2] is None or (t[2] >= lo and (hi is None or t[2] <= hi))]
                items = [(t, link) for t, link, _ in in_win]
                print(
                    f"digest-rss: window {args.between}: {len(items)}/{len(dated)} items kept",
                    file=sys.stderr,
                )
            kind = "xml"
    except (ET.ParseError, json.JSONDecodeError, TypeError, ValueError) as e:
        print(f"digest-rss: parse error: {e}", file=sys.stderr)
        return 1
    n = write_items_md(items, Path(args.output), source, args.limit)
    print(f"digest-rss: {n} items ({kind}) → {args.output}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
