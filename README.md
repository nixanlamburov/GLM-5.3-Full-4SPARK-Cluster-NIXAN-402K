# GLM 5.3 Full 4SPARK Cluster NIXAN 402K

A reproducible 402,000-token deployment, orchestration and benchmark recipe for
running the full GLM-5.3 Int4/Int8 mixed-precision checkpoint across four
NVIDIA DGX Spark nodes.

> **Weights are not included.** This repository is a deployment and benchmark
> recipe built on `Tech2wild/GLM-5.3-Int4-Int8Mix`, tested revision
> `206507bbb047d8223964a0414cd83230c59428f9`.

## Verified baseline

- 4 × NVIDIA DGX Spark / GB10
- tensor parallel: 4
- decode context parallel: 4
- vLLM engine context: 402,000 tokens
- client input cap used in the benchmark: 335,440 tokens
- server output cap in the verified baseline: 65,536 tokens
- KV cache: `fp8_ds_mla`, 5.5 GB per rank
- single active long-job sequence
- no OOM, no preemption and no competing request during the completed run

## Completed benchmark

A closed-world Bulgarian legal-agent benchmark completed in 5:29:52.78 with:

- 61 successful model requests;
- 276,426-token largest prompt;
- 9,394,780 cumulative prompt tokens;
- 60,268 cumulative completion tokens;
- 8,430-token final artifact;
- 0 OOM and 0 preemptions;
- hash-verified final delivery.

All scores in this repository concern technical behavior, artifact integrity,
traceability and systems performance only. They are not legal opinions and do
not establish legal correctness.

## Repository map

- `docs/` — full deployment recipe, architecture, rollback and reproducibility pins.
- `recipe/` — sanitized launch arguments, environment example and checkpoint chat template.
- `patches/` — local attention overlay, with its verification limit stated in `patches/README.md`.
- `gateway/` — sanitized LiteLLM examples and reservation policy.
- `benchmarks/` — technical report and machine-readable metrics.
- `scripts/` — upstream download, audit and public-tree validation.
- `LICENSE-GLM-5.3` — byte copy of the upstream license. It is separate from the Apache-2.0 `LICENSE` of the NIXAN recipe.

## Publication status

This is a private deployment recipe. Model weights are absent.

Pinned: checkpoint revision `206507bbb047d8223964a0414cd83230c59428f9`,
upstream license, checkpoint chat template, vLLM commit
`fe4df3df0eb703862c686b256e9fe44fa94c8945` and image tag
`nixan/vllm-openai:nightly-aarch64-20261012`.

Not re-read from the running nodes on 30.10.2026: container digest, mounted
template hash and mounted overlay hash. See `docs/REPRODUCIBILITY.md`.
Do not treat those three items as verified.
