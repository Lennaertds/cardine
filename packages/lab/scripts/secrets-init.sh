#!/usr/bin/env bash
# secrets-init.sh — zet de secrets-centrale op de juiste rechten.
#
# Run this in YOUR OWN terminal (outside DSH/bwrap): in the cage
# ~/.secrets does not exist. Idempotent: it only changes modes, never content.
#
#   bash packages/lab/scripts/secrets-init.sh
set -euo pipefail

SECRETS_DIR="${HOME}/.secrets"

if [ ! -d "$SECRETS_DIR" ]; then
  mkdir -p "$SECRETS_DIR"
  echo "aangemaakt: $SECRETS_DIR"
fi

chmod 700 "$SECRETS_DIR"
echo "ok  $SECRETS_DIR -> 700"

while IFS= read -r -d '' dir; do
  chmod 700 "$dir"
  echo "ok  ${dir/#$HOME/~} -> 700"
done < <(find "$SECRETS_DIR" -mindepth 1 -type d -print0)

while IFS= read -r -d '' file; do
  chmod 600 "$file"
  echo "ok  ${file/#$HOME/~} -> 600"
done < <(find "$SECRETS_DIR" -type f -print0)

echo
echo "Controleer met: bash packages/lab/scripts/check-secrets.sh (in je terminal)"
