# Architecture

```text
Codex / agent client
        |
        v
LiteLLM gateway and reservation policy
        |
        v
vLLM OpenAI-compatible endpoint
        |
        v
4 × DGX Spark: TP4 + DCP4
        |
        v
Tech2wild GLM-5.3 Int4-Int8Mix checkpoint
```

The verified benchmark lane uses one active sequence and reserves the backend
for one long-running job. This proves stable single-job operation, not multi-user
throughput.

Official profile: **GLM 5.3 Full 4SPARK Cluster NIXAN 402K**.
