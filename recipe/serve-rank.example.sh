#!/usr/bin/env bash
set -euo pipefail

: "${MODEL_DIR:?Set MODEL_DIR}"
: "${NODE_RANK:?Set NODE_RANK 0..3}"
: "${MASTER_ADDR:?Set MASTER_ADDR to <SPARK_RANK0_FABRIC_IP>}"
: "${MASTER_PORT:=29502}"
: "${CHAT_TEMPLATE:=/templates/chat_template.jinja}"

case "${NODE_RANK}" in
  0|1|2|3) ;;
  *)
    echo "NODE_RANK must be 0, 1, 2 or 3" >&2
    exit 2
    ;;
esac

exec vllm serve "${MODEL_DIR}" \
  --served-model-name glm-5.3 \
  --tensor-parallel-size 4 \
  --nnodes 4 \
  --node-rank "${NODE_RANK}" \
  --master-addr "${MASTER_ADDR}" \
  --master-port "${MASTER_PORT}" \
  --host 127.0.0.1 \
  --port 8002 \
  --max-model-len 402000 \
  --max-num-seqs 1 \
  --max-num-batched-tokens 2048 \
  --kv-cache-dtype fp8_ds_mla \
  --kv-cache-memory-bytes 5500000000 \
  --gpu-memory-utilization 0.85 \
  --decode-context-parallel-size 4 \
  --cp-kv-cache-interleave-size 1 \
  --attention-backend FLASHINFER_MLA_SPARSE_SM120 \
  --chat-template "${CHAT_TEMPLATE}" \
  --reasoning-parser glm45 \
  --tool-call-parser glm47 \
  --enable-auto-tool-choice \
  --uvicorn-log-level warning \
  --disable-uvicorn-access-log \
  --logprobs-mode raw_logprobs \
  --max-logprobs 20 \
  --no-enable-prefix-caching \
  -cc.cudagraph_mode=FULL_DECODE_ONLY
