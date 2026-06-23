
## Tentang Sumber

- **Judul**: Architecture Decision Record
- **Penulis / Author**: Martin Fowler
- **Tahun**: 2011 / revisi artikel Bliki
- **Jenis**: artikel web
- **Link / ISBN**: https://martinfowler.com/bliki/ArchitectureDecisionRecord.html

---

## Catatan Per Gagasan

### 1. ADR itu sebenarnya apa, dan kenapa harus pendek?

> ADR adalah dokumen singkat yang menjelaskan satu keputusan arsitektur, konteksnya, dan konsekuensinya.

Catatan gue: ADR bukan dokumentasi teknis yang lengkap; ia adalah sistem rekaman alasan. Kalau dokumen terlalu panjang, ia berubah dari alat bantu keputusan jadi beban baca. Itulah alasan Fowler mendorong gaya "inverted pyramid": inti keputusan di depan, detail pendukung di belakang.

### 2. Kenapa satu keputusan per dokumen?

> Satu ADR per keputusan membantu menjaga batasan yang jelas, timeline yang bersih, dan diskusi tim yang fokus.

Catatan gue: kalau satu file menggabungkan banyak keputusan, riwayat jadi kabur dan supersede jadi rumit. Satu file = satu unit keputusan yang mudah dipindai dan gampang dilacak.

### 3. Kenapa ADR tidak boleh diedit sembarangan, tapi harus di-supersede?

> Setelah accepted, ADR harus dibiarkan utuh. Perubahan dibuat lewat ADR baru yang supersede.

Catatan gue: ini menjaga nilai histori. Keputusan lama mencatat konteks, constraint, dan asumsi saat itu. Mengubah ADR lama sama dengan menghapus jejak pikiran yang pernah memimpin tim.

### 4. Apa hubungan ADR dengan kolaborasi tim, bukan cuma dokumentasi?

> Fowler menempatkan ADR sebagai medium diskusi dan alignment, bukan sekadar arsip setelah keputusan.

Catatan gue: proses menulis ADR memaksa tim menimbang alternatif, trade-off, dan masukan. ADR yang sehat adalah scaffold untuk negosiasi keputusan, bukan rasionalisasi setelah fakta.

### 5. ADR ini nyambung ke praktik lain apa saja di luar artikel Fowler?

> ADR modern terkait dengan praktik seperti MADR, decision log, dan tools ADR.

Catatan gue: Fowler memberi prinsip ringkas dan riwayat. MADR memberi format Markdown yang konsisten. Sementara praktik decision log menekankan bahwa riwayat keputusan bernilai untuk tim baru, audit, dan adaptasi.

---

## Zettels yang Dibuat dari Sumber Ini

- [[zettel.20260420055413]] — ADR adalah decision log yang merekam alasan, bukan dokumentasi desain
- [[zettel.20260420055414]] — Satu keputusan per ADR menjaga batasan dan riwayat yang bersih
- [[zettel.20260420055415]] — ADR accepted harus disupersede, bukan diedit ulang
- [[zettel.20260420055619]] — ADR sehat memaksa maintainer mengubah perilaku, bukan sekadar menambah dokumen
- [[zettel.20260420055738]] — Software architecture adalah jaringan keputusan trade-off, bukan sekadar diagram

## Pertanyaan Terbuka

- Kapan keputusan arsitektur layak di-ADR-kan, dan kapan cukup diarahkan lewat dokumentasi lain?
- Bagaimana tim menjaga ADR tetap ringan tanpa kehilangan nilai historis?
- Apa batas praktis antara "keputusan arsitektur signifikan" dan "keputusan implementasi biasa"?
