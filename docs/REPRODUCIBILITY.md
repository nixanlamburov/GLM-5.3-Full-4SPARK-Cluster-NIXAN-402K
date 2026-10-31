# Reproducibility pins

Official name: `GLM 5.3 Full 4SPARK Cluster NIXAN 402K`.

This repository does not contain model weights.

## Pinned from primary evidence

| Item | Value | Evidence |
| --- | --- | --- |
| Checkpoint | `Tech2wild/GLM-5.3-Int4-Int8Mix` | deployment recipe |
| Revision | `206507bbb047d8223964a0414cd83230c59428f9` | deployment recipe |
| Upstream license | `LICENSE-GLM-5.3` | git blob matches that revision |
| Checkpoint chat template | `recipe/chat_template.jinja` | git blob matches that revision |
| vLLM version string | `0.31.1rc1.dev296+gfe4df3df0` | deployment recipe |
| vLLM commit | `fe4df3df0eb703862c686b256e9fe44fa94c8945` | commit prefix matches the version string; resolved on GitHub on 2026-10-30 |
| Image tag | `nixan/vllm-openai:nightly-aarch64-20261012` | deployment recipe |
| Torch | `2.13.0+cu130` | deployment recipe |
| CUDA family | `13.0` | deployment recipe |
| Attention backend | `FLASHINFER_MLA_SPARSE_SM120` | verified baseline command |
| Baseline | TP 4, DCP 4, context 402000, 1 sequence, 2048 batched tokens, `fp8_ds_mla`, 5500000000 KV bytes, GPU memory utilization 0.85, prefix caching off | verified baseline command |
| Completed run | `20261030T123433Z-a52f56954d33` | technical benchmark report |

## Still open

These were not re-read from the four running nodes on 2026-10-30:

- container image digest;
- SHA-256 of the chat template actually mounted at `/templates/chat_template.jinja`;
- SHA-256 of the attention file actually mounted inside those containers;
- exact FlashInfer package version inside those containers.

`recipe/env.example` keeps the digest as `<UNVERIFIED_FOR_20261030_RUN>`.
`recipe/vllm-args-canary-NOT-VERIFIED.txt` is a future canary, not a verified
profile. The verified baseline keeps prefix caching disabled and
`--max-num-batched-tokens 2048`.

## Launch

Run `recipe/serve-rank.example.sh` once per rank with `NODE_RANK` set to
`0`, `1`, `2` and `3`. Set `MASTER_ADDR` locally. Do not commit a real
fabric address.
