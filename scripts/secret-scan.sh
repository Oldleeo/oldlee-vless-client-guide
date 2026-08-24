#!/usr/bin/env bash
set -euo pipefail

root="${1:-.}"

if rg -n --hidden --glob '!.git/**' \
  -e 'BEGIN (OPENSSH|RSA|EC|DSA) PRIVATE KEY' \
  -e 'sk-[A-Za-z0-9_-]{20,}' \
  -e 'ghp_[A-Za-z0-9]{20,}' \
  -e 'github_pat_[A-Za-z0-9_]+' \
  -e '[0-9]{8,12}:[A-Za-z0-9_-]{30,}' \
  -e '\b[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[1-5][0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}\b' \
  -e '([0-9]{1,3}\.){3}[0-9]{1,3}' \
  -e '(https?|socks5h?)://[^[:space:]/]+:[^@[:space:]]+@' \
  "$root"; then
  echo "Potential secret found. Review before publishing." >&2
  exit 1
fi

echo "No obvious secrets found. Review placeholder links manually before publishing."
