
## Why this reference matters

Martin Fowler mengikat agentic engineering ke konsep harness yang disusun untuk coding agent users. Ini penting karena dia menempatkan konteks, verifikasi, dan loop feedback sebagai bagian dari pekerjaan teknis, bukan sekadar dekorasi di atas prompt.

## What it supports

- Perubahan kecil idealnya didefinisikan sebagai scope keputusan dan risiko yang terbatas, bukan jumlah baris.
- Harness yang baik seharusnya meningkatkan probabilitas hasil benar, sekaligus memperbaiki masalah sebelum sampai ke reviewer manusia.
- Agar AI coding bisa dipercaya, kita butuh feedforward (guide) dan feedback (sensor) yang berfungsi bersama.

## Key quotes

- "A well-built outer harness serves two goals: it increases the probability that the agent gets it right in the first place, and it provides a feedback loop that self-corrects as many issues as possible before they even reach human eyes."
- "Separately, you get either an agent that keeps repeating the same mistakes (feedback-only) or an agent that encodes rules but never finds out whether they worked (feed-forward-only)."
- "Feedback sensors, including the new inferential ones, need to be distributed across the lifecycle accordingly."

## Practical takeaway

Untuk GitLab MR review agent dan code generation harness, ini berarti:

- jangan andalkan satu promt besar; bangun gate, linter, dan status check sebagai feedforward.
- jangan hanya review output setelah agent jalan; letakkan sensor yang bisa memvalidasi perubahan sedini mungkin.
- kecilkan ruang keputusan agent dengan single-purpose changes yang punya satu cara verifikasi.

## References

- https://martinfowler.com/articles/harness-engineering.html
