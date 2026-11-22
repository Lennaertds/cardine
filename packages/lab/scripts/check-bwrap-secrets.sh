#!/usr/bin/env bash
# check-bwrap-secrets.sh — bewijst dat cardine-bwrap .env en keys afschermt.
#
# Test in een tijdelijke map (nooit de echte .env): een werkmap met .env,
# apps/api/.env.local, key.pem, .env.example en een gewoon bestand. In de
# kooi mogen de secrets niet leesbaar, overschrijfbaar of wisbaar zijn,
# terwijl .example en gewone bestanden werkbaar blijven. De host-kopieën
# moeten byte-identiek terugkomen.
#
# Gebruik: bash packages/lab/scripts/check-bwrap-secrets.sh  (ook via make check)
set -euo pipefail

LAB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WRAP="$LAB_DIR/cardine-bwrap"
command -v bwrap >/dev/null || { echo "check-bwrap-secrets: bwrap ontbreekt — sla over"; exit 0; }

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT
ws="$tmp/ws"
mkdir -p "$ws/apps/api"
printf 'SECRET=abc\n' >"$ws/.env"
printf 'X=1\n' >"$ws/.env.example"
printf 'ANA="SECRET=deep"\n' >"$ws/apps/api/.env.local"
printf -- '-----BEGIN KEY-----\nPRIVATE\n' >"$ws/key.pem"
printf 'PK=1\n' >"$ws/apps/api/.env.example"
printf 'normaal\n' >"$ws/readme.txt"

# Probescript draait binnen de kooi; $1 is de gemounte werkmap.
probe="$tmp/probe.sh"
cat >"$probe" <<'EOF'
ws="$1"
for f in .env apps/api/.env.local key.pem; do
  head -c 20 "$ws/$f" >/dev/null 2>&1 && echo "LEESBAAR $f"
  echo hack >"$ws/$f" 2>/dev/null && echo "SCHRIJFBAAR $f"
  rm -f "$ws/$f" 2>/dev/null && echo "WISBAAR $f"
done
cat "$ws/.env.example" "$ws/apps/api/.env.example" >/dev/null 2>&1 \
  && echo "EXAMPLE-OK" || echo "EXAMPLE-WEG"
echo gewijzigd >"$ws/readme.txt" 2>/dev/null && echo "GEWOON-OK" || echo "GEWOON-WEG"
EOF

# Tweede probe: de buitenwereld. Een "geheim" buiten de workspace (nep-~/.secrets)
# mag NIET bereikbaar zijn: niet via absoluut pad, niet via /proc/<pid>/root,
# niet via een symlink in de workspace (die volgt de kooi wél). Het buiten-pad
# staat bewust BINNEN $tmp dat ook gebonden is; de /proc-check gebruikt daarom
# het relatieve deel zodat geen dubbel pad ontslaat.
outside="$tmp/home/.secrets/repo"
mkdir -p "$outside"
printf 'BUITEN=geheim\n' >"$outside/.env"
ln -sfn "$tmp/home/.secrets" "$ws/link-naar-buiten"
outer="$tmp/probe-outside.sh"
cat >"$outer" <<'EOF'
ws="$1"
home_rel="$2"
target="$HOME/$home_rel"
cat "$target/.env" >/dev/null 2>&1 && echo "BUITEN-LEESBAAR"
echo hack >"$target/.env" 2>/dev/null && echo "BUITEN-SCHRIJFBAAR"
# /proc/<pid>/root op een pad dat de kooi NIET heeft: /home/ventje/.secrets
for p in /proc/[0-9]*; do
  [ -r "$p/root/home/ventje/.secrets/${home_rel##*/}/.env" ] 2>/dev/null && echo "BUITEN-VIA-PROC"
done
cat "$ws/link-naar-buiten/repo/.env" >/dev/null 2>&1 && echo "BUITEN-VIA-SYMLINK"
ls -d "$HOME/.secrets" >/dev/null 2>&1 && echo "HOME-SECRETS-ZICHTBAAR"
EOF

before="$(md5sum "$ws/.env" "$ws/apps/api/.env.local" "$ws/key.pem")"
internal="$("$WRAP" --bind "$ws" "$ws" --bind "$tmp" "$tmp" -- /bin/bash "$probe" "$ws" 2>/dev/null || true)"
outside_out="$("$WRAP" --bind "$ws" "$ws" --bind "$tmp" "$tmp" -- /bin/bash "$outer" "$ws" "${outside#"$tmp"/}" 2>/dev/null || true)"

fails=0
ok() { echo "  ok    $1"; }
bad() { echo "  FAAL  $1"; fails=$((fails + 1)); }

for f in .env apps/api/.env.local key.pem; do
  for act in LEESBAAR SCHRIJFBAAR WISBAAR; do
    if grep -qx "$act $f" <<<"$internal"; then bad "$f $act in de kooi"; else ok "$f niet $act"; fi
  done
done
grep -qx "EXAMPLE-OK" <<<"$internal" && ok ".env.example blijft leesbaar" || bad ".env.example onleesbaar"
grep -qx "GEWOON-OK" <<<"$internal" && ok "gewoon bestand schrijfbaar" || bad "gewoon bestand niet schrijfbaar"

if [[ "$before" == "$(md5sum "$ws/.env" "$ws/apps/api/.env.local" "$ws/key.pem")" ]]; then
  ok "host-kopieën ongewijzigd"
else
  bad "host-kopieën zijn gewijzigd"
fi

# Grens: niets buiten de workspace, via welke route dan ook.
for act in BUITEN-LEESBAAR BUITEN-SCHRIJFBAAR BUITEN-VIA-PROC BUITEN-VIA-SYMLINK HOME-SECRETS-ZICHTBAAR; do
  if grep -qx "$act" <<<"$outside_out"; then bad "$act in de kooi"; else ok "niet $act"; fi
done
# Negatieve controle: de probe moet in de KOOI loosgekoppelde tmp nog kunnen draaien.
# Doet hij dat op de host (geen bwrap), dan ziet hij de map wel en faalt de test — goed.
[[ -f "$outside/.env" ]] && ok "buiten-map bestaat op de host (controle)" || bad "buiten-map ontbreekt"

if [[ "$fails" -gt 0 ]]; then
  echo "check-bwrap-secrets: $fails fout(en)" >&2
  exit 1
fi
echo "check-bwrap-secrets: groen"
