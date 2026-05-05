---
id: notes.security.pii-agent-architecture.agent-execution-environment
title: "AI Agent Execution Environment to Safeguard User Data"
desc: "Deep dive GAAP: eksekusi environment untuk agent AI yang menjamin kerahasiaan data pengguna melalui information flow control."
updated: 1777873618660
created: 1777871740192
tags:
  - notes
  - security
  - privacy
  - agent
---

## Problem
Paper ini menyoroti bahwa agent AI sering memegang private data dalam prompt atau model context, yang membuat mereka rentan terhadap exfiltration lewat tool calls, prompt injection, atau model provider yang tidak dipercaya.

## Solution
GAAP membangun execution environment yang memisahkan private data dan permission policy dari model dan provider. Paper menyatakan bahwa GAAP "considers the user prompt, model provider, and model context to be fully untrusted." Ia menggunakan private data database, permission database, dan information flow control (IFC) pada code artifact untuk menentukan apakah disclosure data diperbolehkan.

## Real case implementation
Dalam implementasi nyata, agent menghasilkan code artifact untuk tool execution, lalu IFC mengevaluasi aliran data pribadi dalam artifact tersebut. Hanya disclosure yang policy-approved yang diizinkan, sementara data sensitif tetap dipisahkan dari konteks model.

## Relevance
GAAP memberi blueprint untuk agentic privacy yang deterministik. Untuk user-supplied PII, ia mengajarkan bahwa boundary eksekusi harus menjadi gatekeeper yang menolak raw private data dari model/provider, bukan hanya berharap model berperilaku baik.

Original paper: https://arxiv.org/abs/2604.19657

Link: [[notes.security.pii-agent-architecture]]
