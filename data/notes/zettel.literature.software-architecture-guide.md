
## Tentang Sumber

- halaman panduan Martin Fowler tentang software architecture
- fokus: peta topik, bukan definisi teknis sempit
- inti: arsitektur adalah keputusan tentang hal-hal paling penting dan paling mahal kalau salah

## Pertanyaan yang dibuka oleh halaman ini
1. Apa sebenarnya yang dimaksud “software architecture”?
2. Kenapa architecture penting secara bisnis, bukan cuma teknis?
3. Apa beda application architecture vs enterprise architecture?
4. Kalau mau belajar lanjut, cabang topik apa yang paling relevan?

## Jawaban Inti

1. Arsitektur adalah keputusan tentang hal-hal yang paling penting dan paling sulit dibalik; keputusan yang dampaknya besar pada perubahan, reliabilitas, koordinasi tim, dan umur sistem. Fowler menolak definisi yang terlalu formal seperti "struktur paling fundamental" karena yang fundamental sering baru terlihat setelah sistem berkembang.
2. Architecture penting karena dia menentukan `speed of future change`. Cruft dan kompleksitas tersembunyi bikin biaya perubahan melejit; internal quality yang baik justru mempercepat delivery. Arsitektur adalah modal untuk menjaga kemampuan evolusi sistem, bukan sekadar estetika teknis.
3. Application architecture fokus pada boundary satu unit yang dianggap satu aplikasi oleh tim, bisnis, dan pemilik budget. Enterprise architecture looks architecture across a large enterprise; organisasi sebesar itu biasanya terlalu besar untuk mengelompokkan semua perangkat lunaknya secara kohesif, sehingga masalah utama berubah menjadi koordinasi antar tim dengan banyak codebase, pendanaan yang terpisah, dan pengguna yang berbeda. EA yang sehat membangun interoperabilitas dan pembelajaran bersama tanpa mengorbankan otonomi lokal. EA juga paling efektif ketika arsitek terhubung ke tim pengembangan dan organisasi, bukan terpisah dari realitas delivery.
4. Cabang topik yang relevan meliputi:
   - microservices dan application boundary sebagai cara memikirkan satu aplikasi
   - micro frontends dan GUI/UI architectures untuk kompleksitas frontend
   - serverless sebagai trade-off antara operasional dan vendor dependency
   - presentation/domain/data layering dan distributed systems patterns untuk modularitas internal
   - feature toggles sebagai mekanisme perubahan yang aman untuk aplikasi berskala
   - enterprise architecture, Architect Elevator, Lean Enterprise EA, dan enterprise REST integration
   - enterprise architects join the team, business-technology strategy, product mode, dan learning system organisasi
   - legacy modernization dan Patterns of Legacy Displacement untuk migrasi bertahap

## Struktur Halaman

- definisi arsitektur sebagai “important stuff” dan shared understanding antara expert developer
- alasan kenapa architecture penting: internal quality, cruft, dan speed of future change
- pembagian ke application architecture dan enterprise architecture
- link-card ke topik turunan yang relevan untuk eksplorasi lebih lanjut

## Insight Utama

- Arsitektur bukan layer di atas coding; arsitektur hidup dalam praktik sehari-hari.
- Keputusan arsitektur yang baik adalah soal `mana keputusan yang layak dipikirkan keras, dan mana yang jangan dibesar-besarkan`.
- Banyak tim salah kaprah: mereka merasa "bergerak cepat" dengan memotong kualitas, padahal sebenarnya meminjam kecepatan dari masa depan.
- Fowler membagi medan masalah jadi dua peta utama: desain internal aplikasi dan koordinasi organisasi. Di masing-masing peta ada trade-off nyata, bukan jawaban gaung seperti "microservices harus".

## Relevansi dengan konsep lain

- sangat dekat dengan evolutionary architecture dan architecture as enabling change
- menekankan internal quality, refactoring, dan modularity sebagai cara menjaga opsi perubahan tetap terbuka
- Monolith First, Microservice Trade-Offs, dan Patterns of Legacy Displacement adalah cabang penting dari peta ini

## Hubungan ke catatan lain

- [[zettel.20260420055738]] — inti sama: arsitektur adalah jaringan keputusan trade-off, bukan sekadar diagram
- [[zettel.literature.architecture-decision-records]] — praktik pencatatan dan alasan keputusan arsitektur
- [[zettel.moc.software-architecture]] — entry point MOC untuk topik ini
- [[zettel.literature.architecture-important-stuff]] — definisi arsitektur sebagai keputusan mahal bila salah
- [[zettel.literature.architecture-not-a-blueprint]] — arsitektur bukan blueprint terpisah dari kode
- [[zettel.literature.internal-quality-is-speed]] — internal quality sebagai infrastruktur kecepatan
- [[zettel.literature.application-boundary-social-construction]] — boundary aplikasi sebagai konstruksi sosial
- [[zettel.literature.enterprise-architecture-coordination-cost]] — EA sebagai biaya koordinasi dan pembelajaran bersama
