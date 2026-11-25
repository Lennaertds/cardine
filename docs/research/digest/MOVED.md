# The digest now lives in bron/

The live digest (feeds, systemd, weekly briefs) lives in this repo:

- **Feeds:** [`bron/digest/SOURCES.md`](../../../bron/digest/SOURCES.md)
- **Weekly briefs:** `bron/weken/`
- **Running it daily:** `make digest-day` (systemd timer via `make install-digest-timers`)

This directory is the historical lab scaffold and stays as a kit example.
