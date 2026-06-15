---
id: notes.agentic-engineering.cloud-agent.handson.reference.google-small-cls
title: "Google Small CLs"
desc: "Support note tentang kenapa perubahan kecil membuat review lebih cepat, lebih aman, dan lebih mudah untuk rollback." 
updated: 1778003052450
created: 1778001403559
tags:
  - notes
  - agentic-engineering
  - cloud-agent
  - handson
  - reference
  - code-review
---

## Why this reference matters

Google Small CLs adalah bukti praktis dari engineering review discipline: ketika task dibatasi pada satu tujuan dan satu risiko, reviewer bisa lebih cepat, review lebih lengkap, dan error lebih mudah dilokalisasi.

## What it supports

- Perubahan kecil memungkinkan review cepat dan lebih teliti.
- Perubahan kecil mengurangi peluang bug karena dampak yang bisa ditimbang lebih mudah.
- Perubahan kecil mengurangi biaya rollback dan konflik merge.
- "Small" berarti satu self-contained change, bukan angka baris.

## Key quotes

- "Small, simple CLs are reviewed more quickly. It’s easier for a reviewer to find five minutes several times to review small CLs than to set aside a 30 minute block to review one large CL."
- "Small, simple CLs are reviewed more thoroughly. With large changes, reviewers and authors tend to get frustrated by large volumes of detailed commentary shifting back and forth—sometimes to the point where important points get missed or dropped."
- "Less likely to introduce bugs. Since you’re making fewer changes, it’s easier for you and your reviewer to reason effectively about the impact of the CL and see if a bug has been introduced."
- "In general, the right size for a CL is one self-contained change. This means that: The CL makes a minimal change that addresses just one thing. ... Everything the reviewer needs to understand about the CL is in the CL, the CL’s description, the existing codebase, or a CL they’ve already reviewed."

## Practical takeaway

- Untuk agentic engineering, jangan biarkan satu agent prompt mengambil scope yang sama dengan beberapa tujuan.
- Batasilah setiap change pada satu self-contained risk/goal, sekaligus sertakan semua related test code.
- Kalau reviewer bisa menolak karena CL terlalu besar, itu bukan kelemahan reviewer—itu sign bahwa scope harus dibelah.

## References

- https://google.github.io/eng-practices/review/developer/small-cls.html
