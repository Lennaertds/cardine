#!/usr/bin/env bash
# check-bwrap-secrets.sh — proves the cage of ADR 0017:
#
#   1. a normal write in the workspace lands on the host (bind, no overlay);
#   2. .env/keys in the workspace are not readable and their host inode stays;
#   3. ~/.dsh/.env, ~/.ssh, ~/.secrets, /etc/shadow and a sibling repo are
#      unreachable, and a write outside leaves the host byte intact;
#   4. the cage must really run — "found nothing" or a silent exit 0
#      without a probe is red.
#
# Counter-check: without the wrapper the fixture secret IS readable. If that
# is not the case, a green wrapper run proves nothing.
#
# Gebruik: bash packages/lab/scripts/check-bwrap-secrets.sh
set -euo pipefail

LAB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WRAP="$LAB_DIR/cardine-bwrap"
command -v bwrap >/dev/null || { echo "check-bwrap-secrets: bwrap missing — skipped"; exit 0; }
[[ -x "$WRAP" ]] || { echo "check-bwrap-secrets: $WRAP is not executable" >&2; exit 1; }

tmp="$(mktemp -d)"
host_only="${HOME}/.cardine-sandbox-probe.$$"
trap 'rm -rf "$tmp"; rm -f "$host_only"' EXIT
ws="$tmp/ws"
mkdir -p "$ws/apps/api"
printf 'SECRET=abc\n' >"$ws/.env"
printf 'X=1\n' >"$ws/.env.example"
printf 'ANA="SECRET=deep"\n' >"$ws/apps/api/.env.local"
printf -- '-----BEGIN KEY-----\nPRIVATE\n' >"$ws/key.pem"
printf 'PK=1\n' >"$ws/apps/api/.env.example"
printf 'normaal\n' >"$ws/readme.txt"
printf 'intact\n' >"$host_only"


# A folder OUTSIDE the workspace must be invisible from the cage. The sibling repo
# used to be used for this; it no longer exists, so we take the parent folder of
# this repo — which is by definition outside the workspace.
sibling="$(dirname "$(cd "$LAB_DIR/../.." && pwd)")"

# Without the wrapper the fixture must leak, else "not readable" proves nothing.
# Bare bwrap, with /lib so the binary starts, without our masks.
# A "No such file" from cat would otherwise be the missing loader, not proof.
bare="$(bwrap --ro-bind /usr /usr \
  --symlink usr/bin /bin --symlink usr/lib /lib --symlink usr/lib64 /lib64 \
  --bind "$ws" "$ws" --dev /dev --proc /proc --unshare-pid --die-with-parent \
  -- /usr/bin/cat "$ws/.env" 2>"$tmp/bare.err" || true)"
if ! grep -q 'SECRET=abc' <<<"$bare"; then
  echo "check-bwrap-secrets: negative control failed — without the wrapper the fixture is not readable" >&2
  cat "$tmp/bare.err" >&2 || true
  exit 1
fi

probe="$tmp/probe.sh"
cat >"$probe" <<'EOF'
ws="$1"
for f in .env apps/api/.env.local key.pem; do
  if head -c 200 "$ws/$f" 2>/dev/null | grep -q -e 'SECRET' -e 'PRIVATE' -e 'ANA='; then
    echo "LEESBAAR $f"
  fi
  if echo hack >"$ws/$f" 2>/dev/null; then
    echo "SCHRIJFBAAR $f"
  fi
  if rm -f "$ws/$f" 2>/dev/null; then
    echo "WISBAAR $f"
  fi
done
cat "$ws/.env.example" "$ws/apps/api/.env.example" >/dev/null 2>&1 \
  && echo "EXAMPLE-OK" || echo "EXAMPLE-WEG"
echo gewijzigd >"$ws/readme.txt" 2>/dev/null && echo "GEWOON-OK" || echo "GEWOON-WEG"
echo "PROBE-DRAAIT"
EOF

outer="$tmp/probe-outside.sh"
cat >"$outer" <<'EOF'
host_only="$1"
sibling="$2"
home="$3"
for f in /etc/shadow /etc/passwd /etc/sudoers /etc/ssh /etc/gshadow; do
  echo "ZICHTBAAR $f: $([ -e "$f" ] && echo ja || echo nee)"
done
for f in /etc/shadow /etc/passwd "$home/.dsh/.env" "$home/.secrets" "$home/.ssh"; do
  head -c 5 "$f" >/dev/null 2>&1 && echo "LEESBAAR $f"
done
for p in /proc/[0-9]*/root; do
  [ -r "$p$home/.dsh/.env" ] 2>/dev/null && echo "PROC-ZIET-DSH-ENV"
done
echo hack >/etc/shadow 2>/dev/null && echo "SCHREEF-ETC-SHADOW"
ln -sfn "$home/.dsh" /tmp/bwtest-link 2>/dev/null || true
cat /tmp/bwtest-link/.env >/dev/null 2>&1 && echo "VIA-SYMLINK"
command -v dsh >/dev/null 2>&1 && echo "DSH-STARTBAAR"
[ -f /etc/hosts ] || echo "ETC-HOSTS-WEG"
[ -r /etc/resolv.conf ] || echo "ETC-RESOLV-WEG"
# The identity map 0 0 4294967295 is the host. A user namespace has a small
# map; without that map the cage runs as the real uid.
if [[ ! -r /proc/self/uid_map ]] || awk '$1==0 && $2==0 && $3==4294967295 { found=1 } END { exit !found }' /proc/self/uid_map; then
  echo "GEEN-USERNS"
fi
# Het netwerk blijft open (ADR 0017). Exit 0 = connect gelukt. Alles anders
# is no proof that the shell has the network, so red.
if ! command -v node >/dev/null 2>&1; then
  echo "NETWERK-NIET-GEMETEN"
else
  node -e 'const n=require("net"); const s=n.connect(443,"1.1.1.1"); const t=setTimeout(()=>{s.destroy(); process.exit(2)},1500); s.on("connect",()=>{clearTimeout(t); process.exit(0)}); s.on("error",()=>{clearTimeout(t); process.exit(1)})'
  if [[ "$?" -eq 0 ]]; then echo "NETWERK-OPEN"; else echo "NETWERK-DICHT"; fi
fi
if [[ -n "$sibling" ]]; then
  ls "$sibling" >/dev/null 2>&1 && echo "SIBLING-ZICHTBAAR"
fi
if grep -q intact "$host_only" 2>/dev/null; then
  echo "BUITEN-GELEZEN"
fi
echo hack >"$host_only" 2>/dev/null || true
echo "PROBE-DRAAIT"
EOF

secrets_before="$(md5sum "$ws/.env" "$ws/apps/api/.env.local" "$ws/key.pem")"
host_before="$(md5sum "$host_only")"

internal_status=0
internal="$("$WRAP" --bind "$ws" "$ws" --bind "$tmp" "$tmp" -- /bin/bash "$probe" "$ws" 2>"$tmp/internal.err")" || internal_status=$?
outside_status=0
outside_out="$("$WRAP" --bind "$ws" "$ws" --bind "$tmp" "$tmp" -- /bin/bash "$outer" "$host_only" "$sibling" "$HOME" 2>"$tmp/outside.err")" || outside_status=$?

fails=0
ok() { echo "  ok    $1"; }
bad() { echo "  FAAL  $1"; fails=$((fails + 1)); }

if [[ "$internal_status" -eq 0 ]]; then
  ok "inside-cage exit was 0"
else
  bad "inside-cage exit was $internal_status ($(tr '\n' ' ' <"$tmp/internal.err"))"
fi
if [[ "$outside_status" -eq 0 ]]; then
  ok "outside-cage exit was 0"
else
  bad "outside-cage exit was $outside_status ($(tr '\n' ' ' <"$tmp/outside.err"))"
fi

grep -qx "PROBE-DRAAIT" <<<"$internal" && ok "probe runs inside the cage" || bad "probe did not run (cage broken?)"
grep -qx "PROBE-DRAAIT" <<<"$outside_out" && ok "outside probe runs inside the cage" || bad "outside probe did not run"
grep -qx "NETWERK-OPEN" <<<"$outside_out" && ok "shell has network" || bad "shell has no network"

for f in .env apps/api/.env.local key.pem; do
  for act in LEESBAAR SCHRIJFBAAR WISBAAR; do
    if grep -qx "$act $f" <<<"$internal"; then bad "$f $act inside the cage"; else ok "$f not $act"; fi
  done
done
grep -qx "EXAMPLE-OK" <<<"$internal" && ok ".env.example stays readable" || bad ".env.example unreadable"
grep -qx "GEWOON-OK" <<<"$internal" && ok "normal file writable inside the cage" || bad "normal file not writable"

if [[ "$(cat "$ws/readme.txt" 2>/dev/null || true)" == "gewijzigd" ]]; then
  ok "normal write lands on the host"
else
  bad "normal write does not land on the host"
fi
if [[ "$(stat -c '%u' "$ws/readme.txt" 2>/dev/null || true)" == "$(id -u)" ]]; then
  ok "host write keeps this uid"
else
  bad "host write has uid $(stat -c '%u' "$ws/readme.txt" 2>/dev/null || echo '?')"
fi

if [[ "$secrets_before" == "$(md5sum "$ws/.env" "$ws/apps/api/.env.local" "$ws/key.pem" 2>/dev/null || true)" ]]; then
  ok "secret host copies unchanged"
else
  bad "secret host copies changed"
fi
if [[ "$host_before" == "$(md5sum "$host_only")" ]]; then
  ok "write outside the workspace leaves the host byte intact"
else
  bad "write outside the workspace changed the host"
fi

for f in /etc/shadow /etc/passwd /etc/sudoers /etc/ssh /etc/gshadow; do
  if grep -qxF "ZICHTBAAR $f: ja" <<<"$outside_out"; then bad "sees $f inside the cage"; else ok "does not see $f"; fi
done
for act in "LEESBAAR /etc/shadow" "LEESBAAR /etc/passwd" "LEESBAAR $HOME/.dsh/.env" \
           "LEESBAAR $HOME/.secrets" "LEESBAAR $HOME/.ssh" \
           PROC-ZIET-DSH-ENV VIA-SYMLINK DSH-STARTBAAR ETC-HOSTS-WEG ETC-RESOLV-WEG \
           SIBLING-ZICHTBAAR BUITEN-GELEZEN GEEN-USERNS NETWERK-DICHT NETWERK-NIET-GEMETEN; do
  if grep -qxF "$act" <<<"$outside_out"; then bad "$act inside the cage"; else ok "not: $act"; fi
done

if [[ "$fails" -gt 0 ]]; then
  echo "check-bwrap-secrets: $fails failure(s)" >&2
  exit 1
fi
echo "check-bwrap-secrets: green"
