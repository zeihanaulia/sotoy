---
id: notes.agentic-engineering.cloud-agent.handson.reference.karpathy-keep-ai-on-the-leash
title: "Karpathy: Keep AI on the Leash"
desc: "Support note tentang pentingnya pemantauan manusia, incremental chunks, dan verification sebagai bottleneck dalam AI coding." 
updated: 1778001554464
created: 1778001375664
tags:
  - notes
  - agentic-engineering
  - cloud-agent
  - handson
  - reference
  - ai-coding
  - transcript
  - talk
---

## Why this reference matters

Andrej Karpathy menempatkan AI coding dalam batas kontrol yang bisa diaudit. Ia tidak menolak agent—ia justru menjelaskan bagaimana agent bisa berguna ketika diberi autonomy yang proporsional dan dijaga dalam loop verifikasi. Note ini berdasar langsung pada YouTube talk dan transcriptnya.

## Talk context

Berdasar talk "Software Is Changing (Again)" oleh Karpathy:

- 18:29–20:55: partial autonomy, autonomy slider, dan cara menyesuaikan autonomy berdasarkan kompleksitas tugas.
- 22:10–23:16: generation-verification loop, yaitu AI generate dan manusia verify secepat mungkin.
- 22:53–23:35: "Keep the AI on the leash" untuk mencegah diff besar yang sulit diaudit.
- 23:54–24:13: "small incremental chunks" sebagai strategi kerja.

## Terminology

- Leash = batas kontrol terhadap AI. AI boleh bekerja, tapi ruang kerjanya harus tetap bisa diaudit manusia.
- Small incremental chunks = unit kerja kecil dengan scope jelas, verification jelas, dan diff yang mudah diperiksa.
- Generation-verification loop = AI generate → manusia/sistem verify → lanjut.
- Partial autonomy = autonomy slider, bukan on/off. Autonomy dinaikkan atau diturunkan sesuai risiko task.

## What it supports

- AI tidak boleh diberi ruang kerja terlalu besar tanpa pengawasan.
- Penekanan pada "small incremental chunks" cocok dengan agentic engineering.
- Verification adalah pekerjaan manusia yang harus dihidupkan, bukan diabaikan.
- Autonomy harus proporsional dengan kompleksitas dan risiko task.

## Key quotes

- "we're now kind of like cooperating with AIs and usually they are doing the generation and we as humans are doing the verification it is in our interest to make this loop go as fast as possible"
- "we have to keep the AI on the leash"
- "it's not useful to me to get a diff of 10,000 lines of code to my repo ... I'm still the bottleneck right even though that 10,000 lines come out instantly I have to make sure that this thing is not introducing bugs"
- "I'm always scared to get way too big diffs i always go in small incremental chunks i want to make sure that everything is good i want to spin this loop very very fast and I sort of work on small chunks of single concrete thing"
- "if your prompt is vague then the AI might not do exactly what you wanted and in that case verification will fail... it makes a lot more sense to spend a bit more time to be more concrete in your prompts which increases the probability of successful verification"

## Practical takeaway

- Dalam GitLab MR review agent, desain flow yang mendorong incremental change: satu goal → satu checkpoint → satu verification step.
- Buat harness yang mengatur autonomy slider: lebih banyak autonomy hanya untuk task kecil dan jelas; lebih sedikit autonomy untuk task berisiko tinggi.
- Jika agent output terlalu besar, tambahkan boundary eksplisit: out-of-scope, test requirement, review checkpoint.
- Gunakan intermediate artifact (plan, checklist, test plan) sebagai bagian dari leash sebelum code generation.

## References

- https://www.youtube.com/watch?v=LCEmiRjPEtQ
- https://singjupost.com/andrej-karpathy-software-is-changing-again/
- https://www.latent.space/p/s3
- https://clearthink-ai.com/storyboards/software-is-changing-again/story
- https://x.com/karpathy/status/1915581920022585597
