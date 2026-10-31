# Attention overlay

`flashinfer_mla_sparse_sm120.py` is the local NIXAN overlay for
`FLASHINFER_MLA_SPARSE_SM120` on vLLM `0.31.1rc1.dev296+gfe4df3df0`
(commit `fe4df3df0eb703862c686b256e9fe44fa94c8945`).

The file header records a decode-context-parallel port from vLLM PR #47779
onto that image, dated 14.10.2026. Its SHA-256 is in
`THIRD_PARTY_MANIFEST.json`.

This copy comes from the local overlay tree. It was not re-read from the
containers that served run `20261030T123433Z-a52f56954d33`. Until that read
matches, do not treat the file as a proven byte-identical mount.

Application order for that image:

1. Start from vLLM commit `fe4df3df0eb703862c686b256e9fe44fa94c8945`.
2. Mount this file read-only over
   `vllm/v1/attention/backends/mla/flashinfer_mla_sparse_sm120.py`.

No other patch is included. Do not reconstruct a second patch from memory.
