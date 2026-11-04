# Benchmark material

Public release may include methodology, aggregate metrics, mode definitions and
sanitized comparison tables only.

It must **not** include private corpus files, hidden answer keys, real client
information, raw private logs, Keychain material or live credentials.

## Contents

| File | What it is |
|---|---|
| `MODEL_COMPARISON_2026-11.md` | **Four-model comparison** with full checkpoint names, recipes, hardware and scores. |
| `model-comparison-summary.json` | Machine-readable summary (full names + recipe ids + hardware). |
| `KALINA_LEGAL_BENCHMARK_TECHNICAL_REPORT.md` | Earlier single-run technical report for GLM 402K without prefix cache. |
| `metrics-summary.json` | Metrics for that earlier GLM Kalina run. |

All scores concern technical behaviour, harness integrity and (where labelled)
quality-rubric review. They are **not** legal opinions and do not establish
legal correctness.
