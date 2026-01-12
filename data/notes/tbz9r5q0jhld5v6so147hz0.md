
Link:

- [Software Architecture Superstream: Software Architecture Trade-Offs](https://learning.oreilly.com/live-events/software-architecture-superstream-software-architecture-trade-offs/0636920083581/0636920083579/)
- [Fundamentals of Software Architecture](https://learning.oreilly.com/library/view/fundamentals-of-software/9781492043447/)

## Law of Software Architechture

> Everything in software architecture is a trade-off.
>
>                - First Law of Software Architecture

Gak ada yang disemua lini itu bagus. Setiap keputusan harus mempertimbangkan banyak faktor yang saling berlawanan.

>If an architect thinks they have discovered something that isn’t a trade-off, more likely they just haven’t identified the trade-off yet.

Arsitekture lebih luas dari sekedar kombinasi struktural.

> Why is more important than how.

Sebagai Architect kita harus fokus kepada **WHY** dibandingkan dengan **HOW**.
Apa alasan kenapa kita perlu banget lalu baru bicara HOW. Mungkin seorang arsitek bisa memahami bagaimana sistem yang ada diimplementasikan dari segi architechture, tapi tidak tau kenapa keputusan itu diambil. Maka dari itu pentingnya membuat ADR untuk mencatat kenapa hal itu diputuskan.

## Analyzing Architechture Tradeoff

![software architechture tradeoff](assets/1-software-architechture-tradeoff.png)

Jika kamu diminta oleh tim bisnis untuk membantu mewujudkan goalnya yaitu "kita perlu cepat **time to market**" maka yang perlu kamu lakukan adalah mentransform "Time to Market" ke dalam Architechture characteristing ada 3 karakteristik utama yaitu Maintainability, Testatility, Deployability.

- Maintainability adalah kemampuan dimana lo bisa dengan mudah menemukan lokasi code dan menggantinya. the ability to find and locate and change our code
- Testability adalah  ease of but the completeness of testing
- Deployability adalah which is about the frequency of deployment

Setelah mendapatkan karakteristiknya maka selanjutkan kita analisa trade-offnya antara performance vs maintainability.

Lalu bagaimana lo memilihnya? ya balik lagi ke architechture karakteristik dan balik lagi ke bisnis apa yang lebih penting untuk saat ini.

## Modern tradeoff analysis

![modern tradeoff analisys](assets/2-software-architechture-tradeoff-modern-tradeoff-analysis.png)

Tipsnya adalah dengan membuat perbandingan dengan menggunakan scorecard. Misalnya lo gak tau nih gimana cara kita tau lebih bagus mana membuat shared library atau shared service?

![trader of modern analysys](assets/3-software-architechture-traderoff-modern-analysis.png)  

Kriterianya adalah

- Heterogeneous code: Kriteria ini mengukur tingkat keragaman kode yang digunakan dalam arsitektur. Arsitektur yang memiliki kode yang lebih homogen akan dianggap lebih baik daripada arsitektur yang memiliki kode yang beragam.

- High code volatility: Kriteria ini mengukur tingkat perubahan kode yang terjadi dalam arsitektur. Arsitektur yang memiliki tingkat perubahan kode yang rendah akan dianggap lebih baik daripada arsitektur yang memiliki tingkat perubahan kode yang tinggi.

- Ability to version changes: Kriteria ini mengukur kemampuan arsitektur untuk mengelola perubahan kode dalam versi yang berbeda. Arsitektur yang memiliki kemampuan yang baik dalam hal ini akan dianggap lebih baik daripada arsitektur yang kurang baik dalam hal ini.

- Overall change risk: Kriteria ini mengukur risiko perubahan keseluruhan yang terjadi dalam arsitektur. Arsitektur yang memiliki risiko perubahan yang rendah akan dianggap lebih baik daripada arsitektur yang memiliki risiko perubahan yang tinggi.

- Performance: Kriteria ini mengukur tingkat kinerja arsitektur. Arsitektur yang memiliki kinerja yang baik akan dianggap lebih baik daripada arsitektur yang kinerjanya kurang baik.

- Fault tolerance: Kriteria ini mengukur tingkat toleransi arsitektur terhadap kesalahan. Arsitektur yang memiliki tingkat toleransi yang tinggi akan dianggap lebih baik daripada arsitektur yang memiliki tingkat toleransi yang rendah.

- Scalability: Kriteria ini mengukur tingkat skalabilitas arsitektur. Arsitektur yang dapat di skalakan dengan mudah akan dianggap lebih baik daripada arsitektur yang kurang dapat di skalakan.- Heterogeneous code apakah compatible dengan semua bahasa pemrograman?
