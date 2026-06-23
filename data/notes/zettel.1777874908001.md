
> Memory is not just chat history. For long-lived autonomous agents, memory is an architectural control plane that decides what to store, retrieve, update, and forget.
>
> Source: https://arxiv.org/html/2603.07670v1

Catatan gue:

- Agent memory punya read path dan write path. Tanpa policy yang jelas, cross-session memory bisa mengakumulasi PII dan membentuk profil yang re-identifiable.
- Long context window bukan memory; memory harus bisa menilai relevansi, staleness, dan privacy scope.
- Untuk PII-safe agent, memory governance perlu filtering sebelum store, metadata tagging, evidence-based reflection, dan forgetting policy.

Implikasi:

- Sistem security agent harus memperlakukan memory sebagai sumber data sensitif, bukan sekadar chat log.
- Episodic memory yang disimpan tanpa kontrol bisa jadi tempat PII tertumpuk dan kemudian direkonstruksi.
- Memory layer harus terintegrasi dengan retention policy, access scope, audit trail, dan kemampuan safe delete.

Hubungan:

- [[notes.security.pii-agent-architecture]]
