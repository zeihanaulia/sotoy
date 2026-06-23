
## Pertanyaan yang dibuka

1. Kenapa review biasa sering berhenti pada ‘terlihat masuk akal’?
2. Bagaimana teknik review bisa mengubah frame mental reviewer dari approval ke masalah?
3. Apa peran human filtering ketika review dipaksa mencari kelemahan?

## Klaim utama

Adversarial Review bukan tentang jadi sinis. Ini tentang mengunci jalur mental "looks good" dan memaksa reviewer masuk ke mode "find problems".

Dalam BMAD, teknik ini melawan confirmation bias dengan aturan prosedural: jika nol temuan, review harus dihentikan, dianalisis ulang, atau dijelaskan kenapa memang tidak ada masalah.

## Penjelasan

Review biasa sering gagal karena reviewer memakai verification by familiarity. Mereka melihat artefak yang terasa cocok dengan ekspektasi umum, lalu cepat menyimpulkan aman.

Adversarial Review mengalihkan pertanyaan dari:

* "apakah ini terlihat masuk akal?"

ke:

* "di mana kemungkinan kelemahannya?"
* "apa yang tidak ada?"
* "apa yang seharusnya ada tapi belum muncul?"
* "kalau ini salah, salahnya kemungkinan di mana?"

BMAD menegaskan beberapa aspek kunci:

* Temuan nol bukan jawabannya. Reviewer harus memperbaiki asumsi atau menjelaskan secara eksplisit kenapa tidak ada isu.
* Teknik ini berfungsi sebagai stance umum, bukan hanya untuk code review: spec, architecture, implementation readiness, dan review artefak lain semua layak diperlakukan adversarial.
* Fresh context, tanpa akses ke reasoning asli, menurunkan informasi asimetri dan membuat artefak diuji secara lebih objektif.

## Trade-off

Adversarial Review meningkatkan recall masalah, tetapi juga menaikkan kemungkinan false positive dan noise.
Karena itu, hasil adversarial review harus melalui human filtering: bedakan temuan valid vs komentar nitpick, lalu prioritaskan yang signifikan.

## Implikasi

* Review lebih efektif jika ia memaksa pencarian missingness, bukan hanya memvalidasi kehadiran kejanggalan.
* Artefak yang baik harus bisa berdiri sendiri; jika reviewer perlu tahu intent author untuk memahaminya, itu tanda artefak belum cukup matang.
* Mode review ini paling cocok ketika digunakan bersamaan dengan struktur pemahaman dan kontrol kualitas lain.

## Lihat juga

* [[zettel.20260421180059]] — Checkpoint Preview membuat review manusia fokus pada pemahaman, bukan sekadar diff
* [[zettel.20260421183954]] — Preventing Agent Conflicts membangun shared context, bukan mengandalkan agent tunggal
* [[zettel.moc.ai-native]] — MOC AI-native engineering
