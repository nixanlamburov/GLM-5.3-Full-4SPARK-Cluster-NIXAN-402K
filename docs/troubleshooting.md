# Troubleshooting guide

## Startup

- Confirm all four nodes use the same image digest and checkpoint revision.
- Confirm rank, master address and master port are consistent.
- Confirm the custom attention backend is importable before serving.
- Confirm each rank sees the expected fabric interface.

## Context or KV failures

- Verify `--max-model-len 402000` and the exact KV settings.
- Do not increase context and output caps together without a memory test.
- Compare peak KV usage and preemption count to the verified baseline.

## Slow agent runs

- Inspect cumulative prompt replay.
- Compare prefix-cache canary separately from baseline.
- Reduce retrieval turns and use staged artifacts.
- Do not use Max reasoning for mechanical file navigation.

## Rollback

Use the pinned baseline image/config and drain active requests before restart.
Never replace a working public profile without retaining the last known-good
manifest and hashes.
