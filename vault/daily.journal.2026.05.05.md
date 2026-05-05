---
id: daily.journal.2026.05.05
title: '2026-05-05'
desc: "Catatan perubahan billing GitHub Copilot Pro dari premium request ke token-based credit"
tags:
  - daily
  - github
  - copilot
  - ai-billing
created: 1777981824408

updated: 1777986631924
traitIds:
  - journalNote
---

## Hari ini gue baca [GitHub Blog: GitHub Copilot is moving to usage-based billing](https://github.blog/news-insights/company-news/github-copilot-is-moving-to-usage-based-billing/)

### Konteks
- artikel 27 April 2026, perubahan efektif 1 Juni 2026.

### Yang gue tangkep
- Copilot Pro tidak naik harga $10/bulan, tapi unit pemakaian berubah dari "premium request units" ke "GitHub AI Credits".

### Apa yang berubah di Copilot Pro
- sistem premium request units (PRU) dihapus.
- diganti dengan GitHub AI Credits yang dipakai berdasarkan token.
- token yang dihitung meliputi input token (konteks/prompt), output token (jawaban/kode), dan cached token (konteks ulang pakai).
- GitHub menyebut 1 AI Credit = $0.01, jadi $10 Copilot Pro = 1.000 AI Credits.
- model sekarang masih punya multiplier, tapi relevansinya berbeda:
  - untuk annual Copilot Pro/Pro+ yang masih berada di sistem request-based sampai masa annual habis.
  - untuk usage-based billing baru, yang sekarang lebih granular: biaya = token × tarif model per jenis token.
- model murah tetap lebih hemat; model kuat tetap lebih mahal, tapi sekarang per-token pricing membuat perbedaan itu lebih presisi.

### Kenapa ini penting buat gue
- model baru bikin billing Copilot lebih mirip layanan compute/AI API.
- request pendek cukup murah; sesi agentic panjang, baca banyak file, atau refactor repo besar bisa pakai kredit jauh lebih cepat.
- dulu satu request kecil dan satu sesi panjang bisa dihitung sama; sekarang biaya lebih dekat ke actual compute/token cost.
- thread Theo menunjukkan anomali lama: sedikit message bisa memicu ratusan juta token backend dan biaya inference besar, padahal billing lama hanya hitung per message. [[https://x.com/theo/status/2051395816410210604]]
  - <blockquote class="twitter-tweet"><p lang="en" dir="ltr">- 15 messages<br>- $221 of tokens<br>- 1.6% of my $40 plan used<br><br>It&#39;s obvious that GitHub couldn&#39;t keep this model for billing on Copilot. <a href="https://t.co/x2QGOCMnhw">https://t.co/x2QGOCMnhw</a> <a href="https://t.co/XRXiwYjn8E">pic.twitter.com/XRXiwYjn8E</a></p>&mdash; Theo - t3.gg (@theo) <a href="https://twitter.com/theo/status/2051395816410210604?ref_src=twsrc%5Etfw">May 4, 2026</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
- respons thread menguatkan bahwa ini bukan sekadar GitHub serakah: banyak user melihat agent coding telah merusak model harga subscription lama.
  - fixed/flat per-task pricing cocok untuk task kecil, tapi boncos saat task agent bisa berjalan puluhan jam.
  - banyak orang setuju unlimited/flat agent pricing akan temui masalah economics yang sama di tools lain.
  - billing harus mengikuti real token consumption, bukan sekadar jumlah interaksi.
- cerita Uber menambah dimensi enterprise: saat ratusan atau ribuan engineer mulai memakai agentic coding, budget bisa berubah dari seat budget menjadi compute/token budget. [[https://x.com/iamharishvasu/status/2051389463444836412]]
- contoh Jaid menguatkan isu pricing exploit pada fixed task pricing, bukan hack teknis. [[https://x.com/JaidCodes/status/2051399596530602330]]

### Apa yang tetap termasuk
- price dasar Copilot Pro: tetap $10/bulan.
- code completions tetap termasuk.
- Next Edit suggestions tetap termasuk.
- akses Pro tetap ada, tapi sekarang ada "potongan" akses/budget token per bulan.

### Perubahan annual plan
- pelanggan bulanan otomatis pindah ke usage-based billing 1 Juni 2026.
- pelanggan tahunan tetap di model premium request sampai masa annual habis.
- multiplier lama masih relevan untuk annual plan yang belum berakhir, karena mereka tetap di sistem request-based sampai expiry.
- setelah annual plan selesai, langganan akan pindah ke Copilot Free; bisa upgrade ke monthly dan sisa nilai annual dikonversi prorata ke kredit.

### Dampaknya buat gue / pemakaian gue
- kalau gue cuma pakai Copilot buat task ringan, dampaknya kemungkinan kecil selama nggak pakai sesi agent panjang atau model premium secara berat.
- kalau gue mulai pakai agentic workflow, kredit bisa habis lebih cepat karena sekarang biaya naik seiring panjang konteks dan model yang dipakai.
- buat gue yang pakai Raptor mini, posisi gue relatif lebih aman dibanding yang sering pakai Claude Sonnet/GPT-5.4/Opus.
- penting dicatat: di UI lama, Raptor mini bisa terasa "free" karena 0x tidak mengurangi jatah premium/request secara kasat mata.
- di sistem baru, Raptor mini tetap murah, tapi tidak benar-benar gratis—meter tokennya mulai kelihatan.
- kasus Jaid Opus menguatkan ini: fixed price per task bisa disalahpakai untuk session long-running yang secara backend cost jauh lebih tinggi.
- yang terjadi di skenario itu lebih tepat disebut economic arbitrage/pricing exploit, bukan hack.
- screenshot token count seperti 59.726 tks kemungkinan menunjukkan konteks per langkah, bukan total biaya final.
  - kalau setiap langkah membawa 40k–60k token dan agent jalan 20 kali, total input bisa mendekati 1 juta token.
  - dengan pricing Raptor/GPT-5 mini, 1 juta input token kira-kira 25 AI Credits; tambahan 100k output token bisa jadi 20 AI Credits.
  - satu task panjang bisa menghabiskan 45–250 AI Credits tergantung berapa banyak step dan output yang dihasilkan.

### Transisi ke local model
- pergeseran Copilot ke billing token-based bikin gue semakin memperhitungkan opsi local/hybrid agents sebagai alternatif biaya.
- kalau cloud token mulai tajam, small model lokal atau Qwen3/MoE 30B murah bisa jadi pertahanan ekonomi, bukan sekadar eksperimen. [[https://www.reddit.com/r/LocalLLaMA/]]
- catatan terkait: [[notes.copilot.raptor-mini-sml-budgeting]], [[notes.copilot.local-llm-hardware-upgrade]], [[notes.copilot.token-cheap-coding-agent-providers]]

### Kesalahan umum
- salah paham bahwa harga Copilot Pro naik. nggak; yang berubah adalah unit ekonominya: dari request-based ke token/credit-based.
- ini bukan kenaikan paket, tapi perubahan cara hitung.

### Insight
- Copilot sekarang diposisikan sebagai layanan AI compute yang bisa jalan lama dan lintas file, bukan sekadar autocomplete/chat kecil.
- buat pemakaian singkat, biaya relatif kecil.
- buat penggunaan agentic panjang, ini bisa jadi sinyal supaya kontrol session, konteks, dan model jadi lebih penting.
- output token jauh lebih mahal daripada input token, jadi prompt yang menghasilkan teks panjang atau banyak file akan meroket biaya.
- istilah "yayasan GitHub peduli" lebih tepat dibaca sebagai cross-subsidy/produk subsidi, bukan charity.
- tidak ada bukti langsung bahwa model murah/0x sengaja diberikan agar GitHub bisa latih Raptor mini dari sesi pengguna.

### Catatan ringkas
- Copilot Pro tetap $10/bulan, tapi budget $10 berubah jadi "AI Credits".
- Raptor mini tercatat di docs sebagai model harga setara GPT-5 mini: murah per token.
- long-running task masih butuh diperhitungkan berdasarkan total token yang dikonsumsi.
- billing baru akan membuat pemakaian panjang / model berat kelihatan lebih mahal.
- peralihan annual plan penting untuk pengguna tahunan yang belum habis masa langganannya.
