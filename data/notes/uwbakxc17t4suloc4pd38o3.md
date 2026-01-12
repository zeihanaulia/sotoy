
## Background

Gue mau gantiin Streamlit. Bukan karena jelek, tapi karena udah mulai nggak cukup. Gue butuh UI yang lebih fleksibel, bisa dirender dari DSL, dan gampang diembed ke platform yang lebih besar. Tujuannya satu: bangun frontend untuk salah satu proyek biar nggak ketergantungan sama UI yang statis dan seadanya. Sebetulnya Streamlit ini enak banget dan ajaib, cuma ada beberapa hal yang sepertinya nggak bisa nih pake Streamlit. Salah satu issuenya maintain state, jadi gue coba pindahin ke Refine biar jadi satu dashboard yang lebih proper buat client dan pastinya komponen bisa lebih di-custom.

## Pemilihan Framework

Awalnya sempet bingung mau pakai framework apa. Ini pertama kalinya gue coba develop frontend apps karena biasanya cuma mainan backend aja. Di kepala gue, ada beberapa nama besar yang muncul: Next.js, Vue, Svelte, sama Angular.

Next.js jadi kandidat paling pertama. Banyak yang pake, komunitas besar, dan bisa SSR. Tapi setelah gue dalemin, ternyata banyak setup yang sebenernya gue nggak butuh. Gue nggak ngejar SEO, nggak perlu static generation, dan kerjaan gue full dashboard internal. Jadinya malah terlalu kompleks buat sesuatu yang sebenernya bisa diselesain di level SPA.

Vue juga sempet gue lirik. Secara sintaksis, dia lebih ringan dibanding React. Tapi karena mayoritas plugin, komunitas, dan tooling yang gue pakai udah di ekosistem React, rasanya nggak worth effort buat pindah ke paradigma baru hanya demi perasaan "cleaner".

Svelte itu menarik. Simple, deklaratif, dan hasil bundle-nya kecil banget. Tapi masalahnya sama kayak Vue: ekosistem gue bukan di situ. Gue butuh tooling yang matang dan siap pakai untuk hal-hal kayak form management, table, dan integrasi auth — dan Svelte belum bisa kasih itu dengan nyaman.

Angular? Skip. Terlalu berat, terlalu banyak boilerplate, dan terlalu enterprise buat kebutuhan gue yang pengen iterasi cepat.

Akhirnya gue ketemu Refine. Gue lihat dia bukan cuma framework frontend, tapi toolkit lengkap buat bangun internal tools. Ada resource management, form, table, bahkan data provider dan auth provider udah disiapin. Dan yang paling gue suka, dia support banyak jenis backend: REST API, GraphQL, bahkan direct integration ke Supabase.

Nah, soal auth, Refine punya kelebihan karena dia udah siap langsung connect ke berbagai auth provider kayak Auth0, Firebase, Keycloak, dan Supabase. Karena backend gue udah terhubung sama Supabase buat penyimpanan metadata dan autentikasi user, gue tinggal pakai authProvider bawaan dari Refine dan langsung sambungin ke Supabase. Jadinya setup auth bisa gue kerjain dalam hitungan menit, nggak perlu setup OAuth atau login system dari nol.

Terakhir, soal UI framework. Refine nggak maksa kita buat pakai UI tertentu. Dia kasih opsi dari Ant Design, Material UI, Chakra UI, sampe Tailwind. Ant Design terlalu berat dan kaku buat kebutuhan gue. Material UI juga sama aja, opinionated dan sulit di-custom. Chakra UI lumayan menarik, tapi gue lebih prefer styling yang langsung bisa dikontrol lewat utility class. Makanya gue pilih Tailwind.

Dan supaya nggak bikin semua komponen dari nol, gue gabungin Tailwind dengan shadcn/ui. Kombinasi ini ideal: gue bisa styling fleksibel pakai Tailwind, dan pakai komponen seperti Button, Dialog, dan Card dari shadcn yang udah accessible dan ringan. Jadi akhirnya gue pilih Refine + Vite + Tailwind + shadcn, karena ini paling cocok buat build dashboard internal berbasis DSL yang fleksibel, scalable, dan gampang dipelihara. Karena dia kasih struktur yang cukup tanpa bikin gue terkekang. Dan yang paling penting: dia nggak maksa gue pakai UI library tertentu. Gue bisa pilih Tailwind dan bangun komponen gue sendiri di atasnya.gue pilih Refine. Karena dia kasih struktur yang cukup tanpa bikin gue terkekang. Dan yang paling penting: dia nggak maksa gue pakai UI library tertentu. Gue bisa pilih Tailwind dan bangun komponen gue sendiri di atasnya.

## Setup Awal dengan CLI

Gue mulai dari nol. Literally direktori kosong. Karena Refine udah nyediain CLI yang cukup enak, gue pakai itu.

Langkah-langkahnya gue breakdown di bawah:

1. Masuk ke direktori kosong

    ```sh
    mkdir transformer-ui
    cd transformer-ui
    ```

2. Jalanin CLI Refine langsung di dalam direktori
    ```
    npx create-refine-app .
    ```
    Penting: tanda titik (.) artinya generate-nya langsung di folder ini, bukan bikin folder baru.

3. Pilih project template, `Pilih: refine-vite`, Gue nggak butuh SSR atau static rendering, jadi Next.js dilewatin.

4. Pilih backend `Pilih: REST API` Karena gue pakai FastAPI di backend, bukan Supabase langsung. Tapi nanti auth-nya tetap pakai Supabase.

5. Pilih auth provider Karena pilih `REST`, pilihan Supabase nggak muncul. Jadi gue pilih None dulu, nanti setup auth Supabase-nya manual.

5. Pilih UI Framework `Pilih: Tailwind CSS` Gue mau bangun UI yang bisa dirender dari DSL, dan Tailwind itu enak banget buat styling dinamis. AntD atau MUI terlalu rigid.

6. Pilih nama project Karena udah di direktori transformer-ui, tinggal tekan Enter aja.

7. Contoh halaman Pilih: No, karena gue nggak butuh halaman CRUD dummy. Semuanya bakal gue render dari DSL.

Setelah semuanya kelar, Refine akan generate struktur proyek lengkap, udah include config Vite, Tailwind, dan file dasar kayak src/App.tsx, src/pages, dll.

Satu hal yang perlu disetel manual: path alias di tsconfig.json. Ini penting supaya struktur folder dan import path kita nggak jadi ribet. Daripada nulis ../../../components/ui/button, gue lebih prefer cukup tulis @/components/ui/button. Alias-alias ini gue tambahin di bagian compilerOptions.paths:

```json
{
    "compilerOptions": {
        "baseUrl": ".",
            "paths": {
                "@/components/*": ["src/components/*"],
                "@/lib/*": ["src/lib/*"],
                "@/app/*": ["src/app/*"]
            }
        }
    }
}
```

Tanpa ini, setiap kali pindah folder atau mindahin komponen, import path-nya bisa bikin puyeng. Alias bikin semuanya lebih rapi dan maintainable.

Nah, satu hal lain yang juga krusial adalah versi Tailwind yang dipakai. Refine CLI default-nya masih pakai Tailwind v3, sedangkan shadcn versi terbaru (@latest) udah disiapin buat Tailwind v4. Kalau lo langsung pakai shadcn@latest init, bisa berantakan karena struktur tailwind.config.ts dan penggunaan preset-nya udah beda jauh.

Makanya, gue pilih untuk tetap di Tailwind v3 dan jalanin `npx shadcn@2.5.0 init`. Versi ini masih sepenuhnya compatible, dan semua komponen kayak button, card, dialog tetap jalan normal. Lo tetap dapet styling modular, utility-based, tapi nggak harus repot upgrade Tailwind manual.

Kalau suatu hari perlu Tailwind v4, ya tinggal diupgrade. Tapi buat sekarang, gue prioritaskan kestabilan dulu biar bisa langsung fokus ke logic DSL dan integrasi backend. UI pakai Vite + Tailwind v3, styling dari shadcn, dan semuanya dikontrol penuh dari konfigurasi DSL nanti. dan setup Supabase auth manual. Karena gue pengen bangun DSL renderer sendiri, dan Tailwind itu cocok banget buat styling yang dinamis dan modular. Gue nggak butuh komponen siap pakai kayak Ant Design atau MUI, yang malah jadi beban kalau mau diutak-atik.

## Integrasi shadcn/ui

Sampai sini semuanya mulus, sampai masuk ke shadcn/ui. Tadinya gue pakai `npx shadcn-ui@latest init`, eh ternyata udah deprecated. Sekarang mesti pakai `npx shadcn@latest init`. Tapi ada catatan penting di dokumentasinya: shadcn versi terbaru didesain buat Tailwind v4, sedangkan Refine masih default di Tailwind v3. Jadi solusinya: pakai `npx shadcn@2.5.0 init` buat jaga kompatibilitas.

Pas init, gue pilih style Default, warna base Neutral, dan gue aktifin CSS variables buat theming. Ini penting biar nanti bisa diganti-ganti via DSL kalau mau. Setelah selesai, gue tambahin komponen dasar kayak button, input, card, textarea, dan dialog.

## Next Step

Selanjutnya gue bakal mulai ngebangun `UploadSection.tsx`, `LogStream.tsx`, dan `DSLRenderer.tsx`. Tapi sebelum ke situ, rekap ini penting. Bukan cuma buat dokumentasi pribadi, tapi juga sebagai catatan kalau suatu hari nanti proyek ini perlu dijalanin ulang dari nol, atau mau dibagi ke orang lain yang mau kontribusi.
