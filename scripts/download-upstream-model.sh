#!/usr/bin/env bash
set -euo pipefail

MODEL_ID="Tech2wild/GLM-5.3-Int4-Int8Mix"
REVISION="206507bbb047d8223964a0414cd83230c59428f9"
TARGET="${1:-/models/glm-5.3-int4-int8mix}"

hf download "${MODEL_ID}" \
  --revision "${REVISION}" \
  --local-dir "${TARGET}"
