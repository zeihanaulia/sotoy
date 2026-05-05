---
id: zettel.1777881761976
title: "Pre-execution metadata filtering is essential for agentic x402 payments"
desc: "In AI agentic payment flows, x402 metadata can leak PII to payment facilitators before settlement, so filtering must happen before execution." 
tags:
  - zettel
  - privacy
  - payment
  - pii
  - agent
---

> In agentic x402 payment flows, the payment metadata fields `resource_url`, `description`, and `reason` are a PII leakage vector that must be filtered before the payment request is executed.

Catatan gue:

- x402 isn't just money transfer; it's also metadata transfer.
- In agentic mode, metadata is auto-filled and can include email, name, SSN, IBAN, or phone numbers.
- If this metadata is sent raw, PII leaks to payment servers and facilitators before settlement.

Implikasi:

- payment security for agentic systems needs pre-execution guards, not just on-chain or post-payment checks.
- the right control point is the client-side middleware that sanitizes x402 metadata.
- high assurance requires both PII filtering and policy enforcement (spending limits, replay detection, auditability).

Link:
- [[notes.security.pii-agent-architecture.hardening-x402]]
- [[notes.security.pii-agent-architecture]]
