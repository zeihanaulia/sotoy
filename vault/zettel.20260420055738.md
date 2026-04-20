---
id: zettel.20260420055738
title: "Software architecture adalah jaringan keputusan trade-off, bukan sekadar diagram"
desc: "Inti software architecture adalah keputusan signifikan yang mencatat konteks, trade-off, dan alasan, bukan hanya struktur sistem."
tags:
  - permanent-note
  - software-architecture
  - architecture
  - decision-making
---

> Software architecture paling berguna ketika dia mengekspresikan keputusan dan trade-off yang mendasari struktur, bukan ketika dia hanya memetakan komponen.

Catatan gue:

- Banyak tim mengira arsitektur adalah diagram dan komponen. Padahal arsitektur sejatinya adalah keputusan tentang batasan, interaksi, dan kualitas.
- Diagram seperti C4 membantu menjelaskan "apa" yang ada. ADR dan decision log menjelaskan "kenapa" arah itu dipilih.
- Jika arsitektur tidak menyimpan alasan, artinya tim kehilangan konteks penting ketika sistem berevolusi.

Implikasi:

- Software architecture harus dilengkapi dengan catatan keputusan seperti ADR, pattern, dan trade-off.
- Keputusan arsitektur yang baik punya batasan scope: hanya hal-hal yang berdampak pada tim, operasional, atau kualitas jangka panjang.
- Tim harus menghubungkan artefak: diagram, ADR, issue, PR, dan implementation guide.

Contoh hubungan:

- diagram C4 menggambarkan struktur service dan boundary,
- ADR menjelaskan mengapa boundary itu ada, opsi yang ditolak, dan kapan keputusan harus dievaluasi ulang,
- trade-off note membantu tim memahami rasa dari akibat keputusan tersebut.

→ Dikuatkan oleh [[zettel.literature.architecture-decision-records]]
