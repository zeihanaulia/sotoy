---
id: notes.security.overtrust.workflow-detail
title: "Overtrust workflow detail: cara kerja local scanner dan trust boundary"
desc: "Rincian cara Overtrust bekerja sebagai scanner lokal untuk trust boundary workstation dan apa yang gue tangkap dari logika rule-nya."
updated: 1777996797705
created: 1777993879589
tags:
  - notes
  - security
  - overtrust
  - agentic-coding
---

Overtrust buat gue bukan alat yang cuma "ngasih daftar issue". Dari cara kerjanya, dia lebih kayak audit lokal untuk trust boundary workstation.

Yang bikin Overtrust beda adalah workflow-nya:

- dia jalanin scan lokal tanpa cloud,
- dia klasifikasi file dan process,
- dia hitung risiko dengan rule deterministik,
- dia keluarkan output yang bisa ditriage.

Bukti ini nggak cuma feeling: kode asli Overtrust di `.references/overtrust` nunjukin prosesnya jelas. Bahkan sebagian besar logikanya memang hardcoded: pattern secret di `secrets.cpp`, heuristik file kind di `classifier.cpp`, scoring rule di `manifest.cpp`, dan privilege/process rule di `procscanner_linux.cpp`.

### Evidence langsung dari kode

Di `src/main.cpp`, eksekusi utama masuk ke `overtrust::ScanEngine` dan `run_headless()`. Itu berarti target scan, progress, dan hasil JSON semuanya dikelola di executable, bukan di cloud.

Di `src/scanner/engine.cpp`, ada fase-fase ini:

```cpp
// Phase 1: Walk filesystem
walk_directory(fs::path(target_), files, total, ignore_patterns);

// Phase 2: Classify + scan each file
for (auto& path : files) {
    FileKind kind = classify_file(path);
    switch (kind) {
      case FileKind::VsCodeExtension: ...
      case FileKind::NpmPackageJson: ...
      case FileKind::Dockerfile: ...
    }
    if (kind == FileKind::TextFile ... ) {
        auto secrets = scan_for_secrets(content, pstr);
        for (auto& s : secrets) emit(secret_to_finding(s, pstr));
    }
}

// Phase 3: Process scan
for (auto& f : scan_processes()) emit(f);

// Phase 4: Build trust graph + compute score
```

Di `src/scanner/classifier.cpp`, Overtrust pakai heuristik path dan nama file untuk mengidentifikasi target risiko:

```cpp
if (path_contains(pathstr, "/.aws/") && (name == "credentials" || name == "config"))
    return FileKind::AwsCredentials;
if (path_contains(pathstr, "/.kube/") && name == "config")
    return FileKind::KubeConfig;
if (name == ".bash_history" || name == ".zsh_history")
    return FileKind::ShellHistory;
if (name == "package.json" && path_contains(pathstr, "/.vscode/extensions/"))
    return FileKind::VsCodeExtension;
```

Di `src/scanner/secrets.cpp`, secret detection pakai lima langkah:

1. keyword pre-filter (`pat.keyword`)
2. regex scan (`std::regex re(pat.regex_str)`)
3. entropy check
4. false positive guard
5. PEM/source-code guard

Contoh:

```cpp
if (content.find(pat.keyword) == std::string::npos)
    continue;
...
if (shannon_entropy(matched) < pat.min_entropy)
    continue;
if (is_false_positive(matched)) continue;
```

Dan untuk scan process, `src/scanner/procscanner_linux.cpp` ternyata nggak cuma baca PID. Dia filter system daemon, kemudian flag:

- proses user dengan kapabilitas berbahaya (`CAP_SYS_PTRACE`, `CAP_SYS_ADMIN`),
- root process tanpa seccomp,
- proses yang buka sensitive file descriptor,
- agent AI yang baca sensitive file.

Seperti di kode:

```cpp
if (is_ai_tool(p) && !p.sensitive_fds.empty()) {
    add("PROC-004", Severity::Critical, 9.5,
        "AI tool " + proc_label + " is reading sensitive files",
        "Open sensitive FDs: " + std::to_string(p.sensitive_fds.size()));
}
```

Jadi bukti dari repo memang konsisten: Overtrust bukan sekadar secret scanner. Dia punya sequencing jelas, rule deterministik, dan process-aware logic yang bisa jadi dasar trust boundary check.

Ini bukan review cloud, bukan inference AI, dan jelas juga bukan pentest runtime. Overtrust lebih cocok kalau lo lagi mau cek: apakah ada komponen lokal yang bisa nyentuh secret, atau apakah ada process/tool yang bisa nge-eksekusi command berbahaya.

### Kerjaannya dari gue lihat

Walau terdengar sederhana, Overtrust sebenarnya punya beberapa layer logika:

- `walker.cpp` untuk jalanin filesystem dan apply ignore path.
- `classifier.cpp` untuk menebak jenis file atau artefak.
- `manifest.cpp` buat parse manifest VS Code, npm, Dockerfile.
- `secrets.cpp` buat deteksi secret, keyword, regex, entropy, dan guard false positive.
- `procscanner_linux.cpp` / `procscanner_win.cpp` buat scan process dan privilege.

Intinya: Overtrust nggak cuma "baca file dan flag". Dia juga nanya soal konteks. Contohnya:

- apakah file itu credential wajar?
- apakah proses ini berjalan dengan privilege tinggi?
- apakah ekstensi editor punya auth provider?
- apakah npm script atau Dockerfile jalanin `curl | bash`?

Semua ini dikerjain secara lokal, nggak dikirim ke cloud.

### Flow yang gue nangkep

Pertama, Overtrust inisialisasi scan. Lo kasih root path, dia crawl file lokal. Yang menarik: dia nggak cuma ngebaca repo, tapi dia juga ngecek file di luar repo seperti `~/.aws/credentials` dan `~/.kube/config`.

Kedua, dia klasifikasi konten. Gue lihat beberapa contoh penting:

- `Dockerfile` bisa berarti risiko root/container atau `curl | bash`.
- `package.json` / `npmrc` bisa jadi tanda install script berbahaya atau credential lepas.
- dotfile seperti `.env`, `.npmrc`, `.pypirc` fokus ke credential state.
- manifest extension VS Code bisa ngasih sinyal runtime extension yang punya terminal/auth access.

Kalau file itu punya ciri secret, Overtrust nggak langsung flag 100%. Dia cek format, entropy, dan apakah keyword itu masuk akal. Jadi ini bukan alarm tanpa filtro.

### Beda paling penting: process dan privilege

Bagian ini yang bikin Overtrust bukan sekadar secret scanner biasa.

Untuk Linux, dia lihat process yang jalan dengan privilege kayak:

- `CAP_SYS_PTRACE`
- `CAP_SYS_ADMIN`
- file descriptor sensitif

Untuk Windows, dia lihat token seperti:

- `SeDebugPrivilege`
- `SeTcbPrivilege`
- elevated token

Jadi, bukan cuma "ada secret di disk". Dia juga nanya, "ada process yang bisa baca secret itu sekarang nggak?"

### Evaluasi trust boundary

Dari seluruh deteksi tadi, Overtrust merangkai risk boundary:

- apakah extension editor bisa jalankan terminal atau akses data?
- apakah process punya privilege yang bisa ngexfiltrate?
- apakah ada manifest yang nge-trigger command berbahaya?
- apakah credential file itu accessible?

Gue suka bagian ini karena dia mendorong kita mikir ulang tentang workstation: bukan cuma repo, tapi boundary antara manusia, tool, dan secret.

### Outputnya bukan sekadar flag

Hasil scan Overtrust bukan list issue doang. Dia ngasih skor, kategori, dan konteks. Dari situ, lo bisa langsung triage:

- issue mana kritis karena process privileged?
- issue mana low-risk karena file credentialnya nggak aktif atau hanyalah config dev?
- issue mana false positive karena manifest cuma buat dev biasa?

Makanya gue bilang, kalau `notes.security.overtrust` cuma ringkas, kita bisa kehilangan inti workflow lokal dan trust boundary yang sebenarnya.

### Kenapa ini penting buat gue

Overtrust jadi relevan buat gue di dua keadaan:

- sebelum jalanin agentic tool, cek dulu apakah workstation punya trust gap.
- saat nge-review lingkungan dev, karena perhatian seharusnya nggak berhenti di repo.

Kalau lo cuma anggap ini `secrets scanner`, lo kelewatan. Ini lebih tentang "siapa yang bisa baca secret" dan "siapa yang bisa ngejalanin command".

### Kelemahan yang harus diakui

Sekalipun gue suka, gue juga ngerasa ini bukan jawaban semua.

- ini bukan vulnerability scanner aplikasi.
- ini bukan alat untuk runtime exploit di cloud.
- ini nggak punya threat intel package reputation.
- ini rule-based, jadi butuh maintenance kalau ekosistem tool atau extension bergeser.

Jadi dalam gaya gue: ini bagus buat audit lokal dan boundary, tapi jangan disalahartikan sebagai pengganti pentest atau SAST.

### Hubungan dengan note ringkasan Overtrust

`notes.security.overtrust` tetap versi high-level. Note ini gue buat supaya ada versi detail yang jelas gaya gue dan tetap cerita dari sudut pandang developer.

Kalau lo mau baca yang ringkas dulu, buka `[[notes.security.overtrust]]`.

## Related Notes
- [[notes.security.overtrust]]
- [[daily.journal.2026.05.05]]
- [[notes.security.agentic-coding-permission-boundary]]
- [[notes.security.deepsec-docs]]
- [[notes.security.deepsec-harness]]

## Referensi
- `https://github.com/cheese-cakee/overtrust`
- `.references/overtrust`
- `src/main.cpp`
- `src/scanner/engine.cpp`
- `src/scanner/classifier.cpp`
- `src/scanner/secrets.cpp`
- `src/scanner/procscanner_linux.cpp`
- [[notes.security.overtrust]]

