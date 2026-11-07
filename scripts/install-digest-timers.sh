#!/usr/bin/env bash
# Installeer systemd --user timers voor digest-fetch / digest-week.
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC="$ROOT/scripts/systemd"
DST="${XDG_CONFIG_HOME:-$HOME/.config}/systemd/user"
mkdir -p "$DST" "$ROOT/data/external/digest"
for f in digest-fetch.service digest-fetch.timer digest-week.service digest-week.timer; do
  cp -f "$SRC/$f" "$DST/$f"
done
systemctl --user daemon-reload
systemctl --user enable --now digest-fetch.timer digest-week.timer
systemctl --user list-timers 'digest-*' --all
echo "install-digest-timers: klaar — log: $ROOT/data/external/digest/cron.log"
