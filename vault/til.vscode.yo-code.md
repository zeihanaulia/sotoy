---
id: til.vscode.yo-code
title: "Yo Code untuk Extension VS Code"
desc: "TIL tentang apa itu yo code, kapan cocok dipakai, dan kapan sebaiknya skip untuk membuat VS Code extension."
updated: 1777954474806
created: 1777952830259
tags:
  - til
  - vscode
  - yeoman
---

Yang baru gue tangkap hari ini: `yo code` itu bukan magic, dia cuma Yeoman generator yang bikin struktur extension VS Code jadi cepat kebangun.

Selama ini gue pikir bikin extension harus pake semua file manual. Ternyata, `yo code` cuma bantu scaffold manifest, file `src/extension.ts`, `tsconfig.json`, dan config debug. Intinya dia memotong kebosanan boilerplate, bukan mengganti logika extension.

Use case yang jelas:

- kalao lagi pengin cepat prototipe extension baru.
- kalao pengen valid manifest dan altenatif struktur file standar tanpa mikir dari awal.
- kalao mau belajar extension dengan contoh yang langsung bisa di `F5`.
- kalao nggak punya ide file mana yang harus ada, apalagi kalau baru pertama kali bikin extension.

Kapan gue pakai `yo code`:

- pas jalanin tutorial VS Code pertama kali.
- pas butuh starter yang langsung jalan di Extension Development Host.
- pas mau bandingkan manual setup vs scaffold tanpa buang waktu copy-paste.

Kapan gue nggak perlu `yo code`:

- kalau gue sudah paham struktur extension manual dan ingin kontrol penuh.
- kalau ingin bikin layout custom yang berbeda dari template generator.
- kalau proyeknya cuma butuh sedikit file dan aku pengin mencek seperti apa `package.json`, `activationEvents`, dan `extension.ts` secara langsung.
- kalau mau belajar dasar `vscode.commands`, `activate()`, `webview`, atau tree view tanpa auto-generated noise.

Kesimpulan singkatnya: `yo code` bagus buat mulai cepat dan mengecek standard scaffolding, tapi bukan sesuatu yang wajib kalau lu ingin ngerti seluk-beluk extension dari nol.
