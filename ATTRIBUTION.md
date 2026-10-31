# Attribution

## NIXAN contribution

**Official profile name:** `GLM 5.3 Full 4SPARK Cluster NIXAN 402K`

Nikolay Lamburov / NIXAN contributes the deployment, serving, orchestration,
benchmarking, documentation and reproducibility profile for a 402,000-token
GLM-5.3 deployment on four NVIDIA DGX Spark nodes.

This publication does **not** claim authorship of the base model or of the
Int4/Int8 mixed-precision checkpoint.

## Upstream projects

- Base model: `zai-org/GLM-5.3` — Z.AI.
- Quantized checkpoint: `Tech2wild/GLM-5.3-Int4-Int8Mix`.
- Tested checkpoint revision: `206507bbb047d8223964a0414cd83230c59428f9`.
- Inference: vLLM and related open-source dependencies.
- Quantized checkpoint tooling/lineage must be credited exactly as stated in
  the upstream repository before public release.

## Upstream license

`LICENSE-GLM-5.3` is a byte-for-byte copy of `LICENSE` from
`Tech2wild/GLM-5.3-Int4-Int8Mix` revision
`206507bbb047d8223964a0414cd83230c59428f9`
(git blob `f860919cd5a5377c0bc9d590ea9d1b8743475ca5`).

The NIXAN recipe files use the separate Apache-2.0 `LICENSE`. That license
does not replace the GLM-5.3 license for the weights or the checkpoint.
