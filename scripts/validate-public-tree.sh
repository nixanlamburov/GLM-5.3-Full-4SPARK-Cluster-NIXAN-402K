#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
cd "${root}"

forbidden=(
  PROMPT_ZHIVKO_CURSOR.md
  START_HERE.md
  UPLOAD_CHECKLIST.md
  PACKAGE_BUILD_INFO.json
  PACKAGE_MANIFEST.json
  PUBLIC_UPLOAD_MANIFEST.md
  LICENSE-GLM-5.3-REQUIRED.md
  recipe/chat_template.REQUIRED.md
)
for name in "${forbidden[@]}"; do
  if [[ -e "${name}" ]]; then
    echo "ERROR: staging file still present: ${name}" >&2
    exit 1
  fi
done

if find . -type f \( -name '*.safetensors' -o -name '*.gguf' -o -name '*.bin' \) -print | grep -q .; then
  echo "ERROR: weight files are present" >&2
  exit 1
fi

required=(
  --tensor-parallel-size
  --decode-context-parallel-size
  --max-model-len
  --max-num-seqs
  --max-num-batched-tokens
  --kv-cache-dtype
  --kv-cache-memory-bytes
  --gpu-memory-utilization
  --no-enable-prefix-caching
  FLASHINFER_MLA_SPARSE_SM120
  --chat-template
)
launcher="recipe/serve-rank.example.sh"
for flag in "${required[@]}"; do
  grep -q -- "${flag}" "${launcher}"
done
grep -q -- "402000" "${launcher}"
grep -q -- "5500000000" "${launcher}"
grep -q -- "fp8_ds_mla" "${launcher}"
grep -q -- "0.85" "${launcher}"
grep -q -- "2048" "${launcher}"

if grep -q -- "--enable-prefix-caching" "${launcher}"; then
  echo "ERROR: verified launcher enables prefix caching" >&2
  exit 1
fi
grep -q -- "--enable-prefix-caching" recipe/vllm-args-canary-NOT-VERIFIED.txt
grep -q -- "8192" recipe/vllm-args-canary-NOT-VERIFIED.txt
grep -q -- "<UNVERIFIED_FOR_20261030_RUN>" recipe/env.example

python3 - <<'PY'
import hashlib, json, pathlib
root = pathlib.Path(".").resolve()
manifest = json.loads((root / "THIRD_PARTY_MANIFEST.json").read_text())
for entry in manifest["entries"]:
    digest = hashlib.sha256((root / entry["path"]).read_bytes()).hexdigest()
    if digest != entry["sha256"]:
        raise SystemExit(f"hash mismatch: {entry['path']}")
metrics = json.loads((root / "benchmarks/metrics-summary.json").read_text())
assert metrics["prompt_tokens_cumulative"] == 9394780
assert metrics["max_prompt_tokens"] == 276426
print("manifest hashes and benchmark metrics match")
PY

python3 -m json.tool benchmarks/metrics-summary.json >/dev/null
python3 -m json.tool THIRD_PARTY_MANIFEST.json >/dev/null
bash -n recipe/serve-rank.example.sh
bash -n scripts/download-upstream-model.sh
bash -n scripts/prepublish-audit.sh
bash -n scripts/validate-public-tree.sh

echo "public tree validation passed"
