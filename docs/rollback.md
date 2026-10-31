# Rollback procedure

1. Stop admitting new long jobs.
2. Let the active request finish or cancel it through the controller.
3. Save current service logs and configuration hashes.
4. Restore the last known-good image digest and baseline argument file.
5. Start ranks in the documented order.
6. Validate `/health`, model listing and a short deterministic probe.
7. Re-enable the gateway only after all four ranks are healthy.
