
## Problem
Paper ini mengangkat masalah personalization LLM yang menulis data pengguna ke dalam bobot model. Ketika personalisasi disimpan secara langsung di shared weights, menghapus data individu menjadi sulit atau bahkan tidak mungkin tanpa retraining.

## Solution
Separable Expert Architecture memperkenalkan adapter komposabel yang dapat dihapus dan user proxies yang dapat dihilangkan. Alih-alih memodifikasi bobot utama model secara permanen, personalisasi dialokasikan ke komponen terpisah yang dapat di-pull-in atau dihapus.

## Real case implementation
Dalam arsitektur agent, ini berarti personalisasi user-specific harus terjadi di adapter atau proxy yang terpisah dari base model. Ketika data personal tidak lagi diperlukan atau user meminta penghapusan, adapter ini dapat dicabut tanpa retraining seluruh model.

## Relevance
Pendekatan ini penting untuk user-supplied PII di agent personal AI. Ia menawarkan cara untuk memberikan personalisasi tanpa mengunci data sensitif ke dalam model utama, sehingga mitigasi privacy dan unlearning menjadi lebih praktis.

Original paper: https://arxiv.org/abs/2604.21571

Link: [[notes.security.pii-agent-architecture]]
