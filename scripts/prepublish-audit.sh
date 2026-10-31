#!/usr/bin/env bash
set -euo pipefail

root="${1:-.}"
cd "${root}"

printf 'Checking forbidden large/model files...\n'
if find . -type f \( -name '*.safetensors' -o -name '*.gguf' -o -name '*.bin' -o -size +100M \) -print | grep -q .; then
  echo 'ERROR: model/large files found.' >&2
  exit 1
fi

printf 'Checking likely secrets/private addresses...\n'
pattern='(sk-[A-Za-z0-9_-]{16,}|hf_[A-Za-z0-9]{16,}|gh[pousr]_[A-Za-z0-9]{16,}|api[_-]?key[[:space:]]*[:=][[:space:]]*[^<${][^[:space:]]+|password[[:space:]]*[:=][[:space:]]*[^<${][^[:space:]]+|100\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}|10\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3})'
if grep -RInE --exclude='prepublish-audit.sh' --exclude-dir='.git' "${pattern}" .; then
  echo 'ERROR: possible secret/private address found. Review every hit.' >&2
  exit 1
fi

printf 'Validating JSON...\n'
while IFS= read -r -d '' f; do python3 -m json.tool "$f" >/dev/null; done < <(find . -name '*.json' -type f -print0)

printf 'Validating shell syntax...\n'
while IFS= read -r -d '' f; do bash -n "$f"; done < <(find . -name '*.sh' -type f -print0)

echo 'Basic pre-publication audit passed.'
