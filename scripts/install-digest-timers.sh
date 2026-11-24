#!/usr/bin/env bash
# Installeer systemd --user timer voor digest-day; schakel oude digest-* timers uit.
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC="$ROOT/scripts/systemd"
DST="${XDG_CONFIG_HOME:-$HOME/.config}/systemd/user"
mkdir -p "$DST" "$ROOT/data/external/digest"

# Oude Cardine-timers stoppen (indien aanwezig).
for u in digest-fetch.timer digest-week.timer digest-fetch.service digest-week.service; do
  systemctl --user disable --now "$u" 2>/dev/null || true
  rm -f "$DST/$u"
done

# @REPO_ROOT@ invullen, zodat de unit naar déze repo wijst en niet naar een
# hardgecodeerd pad.
sed "s|@REPO_ROOT@|$ROOT|g" "$SRC/digest-day.service" > "$DST/digest-day.service"
cp -f "$SRC/digest-day.timer" "$DST/digest-day.timer"
systemctl --user daemon-reload
systemctl --user enable --now digest-day.timer
systemctl --user list-timers 'digest-*' --all
echo "install-digest-timers: klaar — log: $ROOT/data/external/digest/cron.log"
