#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"
echo "digest-reminder: cureren blijft handmatig (P5 — geen dump als SSOT)."
[[ -f bron/digest/SOURCES.md ]] && echo "ok    bron/digest/SOURCES.md" || echo "tip   vul bron/digest/SOURCES.md"
if [[ -d data/external/digest ]]; then
  n=$(find data/external/digest -mindepth 1 -maxdepth 1 -type d 2>/dev/null | wc -l | tr -d ' ')
  echo "info  dumps: $n mappen"
fi
echo "Volgende: make digest-day → make digest-triage → keep → § (zie bron/digest/TRIAGE.md)"
echo "digest-reminder: klaar"
