# Reservation policy

The completed benchmark reserved both GLM aliases for one authenticated run and
rejected foreign requests before model generation. A production implementation
must bind the reservation to:

- exact run ID;
- exact client identity;
- allowed model aliases;
- expiration and cleanup;
- audit log;
- fail-closed admission behavior.

The live callback must be exported and sanitized by Живко. Do not publish keys,
production user identities or internal endpoints.
