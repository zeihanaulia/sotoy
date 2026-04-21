---
id: zettel.20260421184801
title: "Pre-mortem analysis memaksa perencanaan menilai hasil dengan asumsi kegagalan"
desc: "Pre-mortem analysis mengenalkan kegagalan hipotetis sebagai cara menemukan risiko tersembunyi sebelum mengunci keputusan."
tags:
  - bmad
  - pre-mortem
  - ai-native
  - reasoning
---

## Pertanyaan yang dibuka

1. Bagaimana metode ini mengubah cara artefak diperiksa?
2. Apa asumsi tersembunyi yang biasanya terbuka dengan cara ini?
3. Kapan metode ini cocok dipakai dalam workflow AI-native?

## Klaim utama

Pre-mortem analysis membuat tim mempertimbangkan kegagalan potensial sejak awal, sehingga risiko dan mitigasi muncul lebih jelas.

## Penjelasan

Pre-mortem menempatkan keputusan di bawah asumsi bahwa sistem sudah gagal. Ini memaksa tim atau model mencari alasan konkret untuk kegagalan tersebut, bukan hanya membenarkan jalur sukses.

## Contoh

Dalam plan rollout, pre-mortem bisa mengungkap bahwa email gagal terkirim, dependency pihak ketiga down, atau helpdesk kewalahan karena error message yang membingungkan.

## Implikasi

* Menjadikan risiko eksplisit lebih awal mengurangi false confidence.
* Berguna untuk spec, plan, dan strategi peluncuran yang melibatkan banyak asumsi.

## Lihat juga

* [[zettel.20260421184757]] — Advanced Elicitation memaksa model menggunakan lensa berpikir eksplisit untuk reconsider output
* [[zettel.20260421191335]] — Pre-mortem bisa dilakukan tanpa event nyata dengan asumsi terstruktur
* [[zettel.literature.bmad-advanced-elicitation]] — literature note BMAD Advanced Elicitation
