#!/usr/bin/env python3
"""Parse RSS/Atom XML → items.md (title + link). Stdlib only."""
from __future__ import annotations

import argparse
import html
import re
import sys
import xml.etree.ElementTree as ET
from pathlib import Path


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


def parse_items(xml_bytes: bytes) -> list[tuple[str, str]]:
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
                items.append((title or "(geen titel)", link))
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
            items.append((title or "(geen titel)", link))
    return items


def write_items_md(items: list[tuple[str, str]], out: Path, source: str, limit: int) -> int:
    lines = [
        f"# Items — {source}",
        "",
        "> Gegenereerd door digest-fetch. Geen SSOT — cureren via digest-propose → radar (P5).",
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


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("-i", "--input", required=True, help="pad naar feed XML")
    ap.add_argument("-o", "--output", required=True, help="pad naar items.md")
    ap.add_argument("-s", "--source", default="", help="bron-URL of slug")
    ap.add_argument("-n", "--limit", type=int, default=30)
    args = ap.parse_args()
    path = Path(args.input)
    if not path.is_file():
        print(f"digest-rss: bestand ontbreekt: {path}", file=sys.stderr)
        return 1
    raw = path.read_bytes()
    # Strip BOM / leading junk before first <
    m = re.search(rb"<[\s\S]+", raw)
    if not m:
        print("digest-rss: geen XML gevonden", file=sys.stderr)
        return 1
    try:
        items = parse_items(m.group(0))
    except ET.ParseError as e:
        print(f"digest-rss: parse-fout: {e}", file=sys.stderr)
        return 1
    n = write_items_md(items, Path(args.output), args.source or str(path), args.limit)
    print(f"digest-rss: {n} items → {args.output}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
