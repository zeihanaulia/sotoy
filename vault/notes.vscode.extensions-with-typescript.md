---
id: notes.vscode.extensions-with-typescript
title: "VS Code Extension dengan TypeScript"
desc: "Ringkasan langkah utama dan struktur untuk membangun extension VS Code menggunakan TypeScript."
updated: 1777966775490
created: 1777950093457
tags:
  - notes
  - vscode
  - typescript
---

## Kapan pakai ini

Gue nulis ini karena gue lagi nyoba pakai Dendron, tapi extension VS Code-nya sudah lama gak di-maintain. Sepertinya `plugin-core` udah lama nggak di-maintain secara aktif, jadi gue pakai note ini untuk mencatat: kalau mau bikin extension dari nol, apa saja yang mesti dipahami dan dicobain.

## Kenapa Dendron bikin penasaran

Dendron di workspace gue udah kayak aplikasi sendiri: ada sidebar `Dendron`, ada backlinks panel, ada graph panel, ada command untuk reload index. Tapi di belakangnya, extension ini bukan cuma request-response sederhana. Ada engine Dendron, ada file watcher, ada language feature, ada webview.

Karena belum pernah bikin extension VS Code sendiri, gue ingin tahu apakah semua itu benar-benar butuh begitu banyak layer. Lebih penting lagi, kenapa beberapa hal di Dendron masih terasa kurang mulus, misalnya: file baru kadang nggak langsung muncul di tree view, `Reload Index` kadang lambat, dan webview-nya berat saat initial load.

## Mulai dari nol: vanilla extension

Sebelum nyerocos ke Dendron, gue mulai dengan versi paling kecil.

### Versi manual: struktur folder yang perlu ada

Kalau mau bikin extension tanpa generator, struktur dasar yang perlu dipahami adalah:

```text
my-extension/
├── package.json
├── tsconfig.build.json
├── src/
│   └── extension.ts
├── out/
│   └── extension.js
└── .vscode/
    └── launch.json
```

- `package.json`
  - manifest extension. Menentukan nama, versi, `engines.vscode`, `activationEvents`, `contributes.commands`, dan output JS.
- `src/extension.ts`
  - entry point runtime.
  - di sini implementasi `activate(context)` hidup.
  - biasanya register command pakai `vscode.commands.registerCommand`.
  - `context.subscriptions.push(...)` wajib supaya cleanup kerja.
- `tsconfig.build.json`
  - untuk compile TypeScript ke `out/`.
  - umum pakai `module: commonjs`, `outDir: ./out`, dan `exclude: ["node_modules", ".vscode-test"]`.
- `out/`
  - hasil compile JS yang dijalankan VS Code.
- optional: `.vscode/launch.json`
  - kalau mau debug extension di Extension Development Host.

### Step-by-step: tulis kode minimal

Setelah struktur siap, ini flow yang gue pakai buat bikin extension kecil:

1. `package.json`
   - definisikan `name`, `displayName`, `publisher`, `version`.
   - pastikan `main` mengarah ke `./out/extension.js`.
   - tambahkan `activationEvents` seperti `onCommand:myExtension.helloWorld`.
   - di `contributes.commands`, daftar command ID dan judulnya.
2. `src/extension.ts`
   - export `activate(context: vscode.ExtensionContext)`.
   - register command `vscode.commands.registerCommand("myExtension.helloWorld", () => { ... })`.
   - push disposables ke `context.subscriptions`.
3. `tsconfig.build.json`
   - compile ke `out/`.
   - set `module: "commonjs"`, `target: "es2020"`, `outDir: "out"`.
   - `include: ["src"]`, `exclude: ["node_modules", ".vscode-test"]`.
4. build dan jalankan
   - `npm install`
   - `npm run compile`
   - buka folder extension di VS Code
   - tekan `F5`
   - jalankan command Hello World di Extension Development Host

Contoh minimal:

```json
{
  "name": "my-extension",
  "displayName": "My Extension",
  "publisher": "me",
  "version": "0.0.1",
  "engines": {
    "vscode": "^1.77.0"
  },
  "activationEvents": [
    "onCommand:myExtension.helloWorld"
  ],
  "main": "./out/extension.js",
  "contributes": {
    "commands": [
      {
        "command": "myExtension.helloWorld",
        "title": "Hello World"
      }
    ]
  },
  "scripts": {
    "compile": "tsc -p tsconfig.build.json"
  },
  "devDependencies": {
    "typescript": "^5.0.0",
    "@types/vscode": "^1.77.0"
  }
}
```

```ts
import * as vscode from 'vscode';

export function activate(context: vscode.ExtensionContext) {
  const disposable = vscode.commands.registerCommand('myExtension.helloWorld', () => {
    vscode.window.showInformationMessage('Hello from my extension!');
  });
  context.subscriptions.push(disposable);
}

export function deactivate() {}
```

```json
{
  "compilerOptions": {
    "module": "commonjs",
    "target": "es2020",
    "outDir": "out",
    "rootDir": "src",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true
  },
  "include": ["src"],
  "exclude": ["node_modules", ".vscode-test"]
}
```

### Versi cepat: pakai `yo code`

Kalau tidak mau ribet bikin semua file manual, `yo code` bisa jadi shortcut yang bagus.

- `yo code` akan scaffold manifest dan file `src/extension.ts` otomatis.
- hasil scaffold biasanya sudah punya `package.json`, `tsconfig.json`, `src/extension.ts`, dan konfigurasi debug.
- setelah itu tinggal fokus ke logic `activate()` dan command saja.
- `yo code` sebenarnya adalah Yeoman generator yang menjalankan paket `generator-code`.

#### Pilihan di prompt `yo code`

```bash
➜  1-hello-world git:(main) ✗ nix develop -c yo code

     _-----_     ╭──────────────────────────╮
    |       |    │   Welcome to the Visual  │
    |--(o)--|    │   Studio Code Extension  │
   `---------´   │        generator!        │
    ( _´U`_ )    ╰──────────────────────────╯
    /___A___\   /
     |  ~  |     
   __'.___.'__   
 ´   `  |° ´ Y ` 

`list` prompt is deprecated. Use `select` prompt instead.
? What type of extension do you want to create?
❯ New Extension (TypeScript)
  New Extension (JavaScript)
  New Color Theme
  New Language Support
  New Code Snippets
  New Keymap
  New Extension Pack
  New Language Pack (Localization)
  New Web Extension (TypeScript)
  New Notebook Renderer (TypeScript)
```

Saat menjalankan `yo code`, generator biasanya menanyakan jenis extension yang ingin dibuat. Ini artinya:

- `New Extension (TypeScript)` — buat extension VS Code dengan TypeScript. Ini pilihan paling umum jika mau mulai dari extension standar dan pakai TS.
- `New Extension (JavaScript)` — versi tanpa TypeScript. Cocok kalau cuma mau coba cepat tanpa setup TS.
- `New Color Theme` — bikin extension tema warna saja. Hasilnya akan menghasilkan skema warna dan konfigurasi tema VS Code.
- `New Language Support` — untuk bikin extension bahasa baru dengan syntax highlighting, snippets, dan grammar. Pilihan ini cocok kalau ingin menambahkan dukungan bahasa di editor.
- `New Code Snippets` — buat extension berisi potongan kode (`snippets`) yang bisa dipanggil lewat Intellisense. Cocok untuk paket tooling atau snippet library.
- `New Keymap` — extension yang mengubah keybinding atau menyalin layout keybindings dari editor lain.
- `New Extension Pack` — kumpulan extension lain dalam satu paket. Biasanya dipakai untuk bundling extension yang saling terkait.
- `New Language Pack (Localization)` — extension terjemahan untuk UI VS Code. Bukan extension fungsional, tapi menambahkan dukungan bahasa ke VS Code.
- `New Web Extension (TypeScript)` — versi extension yang bisa berjalan di environment web, bukan hanya desktop VS Code. Penting jika ingin extension kompatibel dengan `vscode.dev` atau browser-based VS Code.
- `New Notebook Renderer (TypeScript)` — untuk bikin renderer custom pada notebook cell VS Code. Ini lebih spesifik dan berguna kalau butuh tampilan notebook yang berbeda.

Setelah memilih jenis extension, generator akan menanyakan nama extension, identifier, deskripsi, dan beberapa opsi lain. Setelah itu, semua file yang diperlukan akan otomatis dibuat.

```

     _-----_     ╭──────────────────────────╮
    |       |    │   Welcome to the Visual  │
    |--(o)--|    │   Studio Code Extension  │
   `---------´   │        generator!        │
    ( _´U`_ )    ╰──────────────────────────╯
    /___A___\   /
     |  ~  |     
   __'.___.'__   
 ´   `  |° ´ Y ` 

`list` prompt is deprecated. Use `select` prompt instead.
✔ What type of extension do you want to create? New Extension (TypeScript)
✔ What's the name of your extension? hello-world
✔ What's the identifier of your extension? poc-hello-world
✔ What's the description of your extension? first extentions vscode
✔ Initialize a git repository? Yes
`list` prompt is deprecated. Use `select` prompt instead.
? Which bundler to use?
❯ unbundled
  webpack
  esbuild
? Which package manager to use?
  npm
  yarn
❯ pnpm
```

`yo code` juga nanya package manager. Pilihannya biasanya:

- `npm` — paling aman dan paling umum, cocok kalau pengen nge-minimal toolchain.
- `yarn` — enak kalau pengen lockfile lebih stabil dan workflow yang lebih rapi, tapi ada dua generasi (Classic vs Berry) jadi perlu tahu versi yang dipakai.
- `pnpm` — paling cepat install dan paling hemat disk, karena dia pakai store global dan symlink. Biasa jadi pilihan bagus untuk proyek besar atau monorepo.

Untuk extension kecil, `npm` sudah cukup. Kalau pengen upgrade experience di repo yang lebih besar, `pnpm` biasanya paling menarik, asalkan semua orang di tim nyaman ikut pakai.

Apa itu `bundler`? Itu opsi untuk memilih apakah ingin menggunakan bundler seperti Webpack atau esbuild untuk mengemas extension. Biasanya, untuk extension sederhana, `unbundled` sudah cukup. Bundler lebih berguna jika ada banyak dependensi atau ingin optimasi ukuran extension.

- Unbundled: extension akan tetap dalam format file terpisah. Cocok untuk proyek kecil atau jika ingin kontrol penuh atas struktur file.
- Webpack: menggunakan Webpack untuk mengemas semua file dan dependensi menjadi satu bundle.js. Ini bisa mempercepat load extension, tapi setup-nya lebih kompleks.
- esbuild: alternatif bundler yang lebih cepat daripada Webpack. Cocok jika ingin bundling cepat dengan konfigurasi minimal.

Perbedaan utama antara bundler dan unbundled adalah pada performa dan target deployment. VS Code docs menyarankan bundling ketika extension ingin mendukung Web (github.dev/vscode.dev) karena browser hanya bisa memuat satu bundled file saja.

Tabel perbandingan:

| Opsi Bundler | Kelebihan                          | Kekurangan                         |
|--------------|------------------------------------|------------------------------------|
| Unbundled    | Setup sederhana, kontrol penuh     | Load lebih lambat jika banyak file |
| Webpack      | Load lebih cepat, optimasi ukuran  | Setup kompleks, waktu build lebih lama |
| esbuild      | Load cepat, setup minimal          | Kurang fleksibel dibanding Webpack |

Kenapa gak pake Bun?

Gue pernah mikir sama: Bun sekarang punya bundler dan klaim benchmark super cepat, jadi kenapa gak langsung pakai Bun untuk extension VS Code juga?

Jawabannya: buat VS Code extension, dokumentasi resmi masih fokus ke bundler yang jelas-support `vscode` runtime seperti Webpack dan esbuild. Bun bilang dia bisa bundling 10.000 React component dalam 269.1ms, lebih cepat dari esbuild di benchmarknya, tetapi itu benchmark umum bundling, bukan khusus `vscode` extension. Sementara VS Code butuh bundling yang nge-exclude `vscode` runtime module dan bisa cocok untuk web extension.

Fakta tambahan:

- VS Code docs `Bundling Extensions` menyebutkan bundling penting untuk `vscode.dev`/`github.dev` karena browser hanya bisa memuat satu file untuk extension code. ([source](https://code.visualstudio.com/api/working-with-extensions/bundling-extension))
- esbuild klaim dapat melakukan bundle production untuk 10 copy tiga.js dari scratch dalam ~0.39 detik, sedangkan webpack 5 butuh ~41.21 detik di benchmark default. Itu berarti esbuild bisa 100x lebih cepat dalam skenario bundling sederhana. ([source](https://esbuild.github.io/faq/#benchmark-details))
- Bun klaim bundle 10.000 React components dalam 269.1ms, lebih cepat dari esbuild 571.9ms dan webpack 41.21s di benchmark Bun. ([source](https://bun.sh/))
- Untuk extension kecil tanpa banyak dependensi, `unbundled` tetap valid dan lebih mudah karena tidak perlu konfigurasi bundler.

Kalau butuh referensi `yo code` lebih lengkap, lihat TIL [[til.vscode.yo-code]] di repo ini — ini catatan internal, bukan link Dendron.

Dari Dendron, yang paling mirip adalah:

- `packages/plugin-core/package.json` untuk manifest besar
- `packages/plugin-core/src/_extension.ts` sebagai entry point

Kalau yang simple, cukup: `activationEvents` pakai `onCommand:myExtension.helloWorld`, lalu register satu command. Itu sudah cukup buat start.

```
✔ Which package manager to use? pnpm

Writing in /Users/zeihanaulia/Programming/research/vscode/1-hello-world/poc-hello-world...
   create poc-hello-world/.vscode/extensions.json
   create poc-hello-world/.vscode/launch.json
   create poc-hello-world/.vscode/settings.json
   create poc-hello-world/.vscode/tasks.json
   create poc-hello-world/package.json
   create poc-hello-world/tsconfig.json
   create poc-hello-world/.vscodeignore
   create poc-hello-world/vsc-extension-quickstart.md
   create poc-hello-world/.gitignore
   create poc-hello-world/README.md
   create poc-hello-world/CHANGELOG.md
   create poc-hello-world/src/extension.ts
   create poc-hello-world/src/test/extension.test.ts
   create poc-hello-world/.vscode-test.mjs
   create poc-hello-world/eslint.config.mjs
   create poc-hello-world/.npmrc

Changes to package.json were detected.

Running pnpm install for you to install the required dependencies.
 WARN  1 deprecated subdependencies found: glob@10.5.0
Packages: +229
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Progress: resolved 229, reused 229, downloaded 0, added 229, done

devDependencies:
+ @types/mocha 10.0.10
+ @types/node 22.19.17 (25.6.0 is available)
+ @types/vscode 1.118.0
+ @vscode/test-cli 0.0.12
+ @vscode/test-electron 2.5.2
+ eslint 9.39.4 (10.3.0 is available)
+ typescript 5.9.3 (6.0.3 is available)
+ typescript-eslint 8.59.2

Done in 3.3s using pnpm v10.23.0

Your extension poc-hello-world has been created!

To start editing with Visual Studio Code, use the following commands:

     code poc-hello-world

Open vsc-extension-quickstart.md inside the new extension for further instructions
on how to modify, test and publish your extension.

For more information, also visit http://code.visualstudio.com and follow us @code.


`list` prompt is deprecated. Use `select` prompt instead.
✔ Do you want to open the new folder with Visual Studio Code? Open with `code`
```

oke, extension sudah siap. Sekarang tinggal buka folder `poc-hello-world` di VS Code, lalu ikuti instruksi di `vsc-extension-quickstart.md` untuk mulai testing dan modifikasi.


## Ngetes Hello World di Extension Development Host

Ini penting: `npm run compile` hanya mengubah TypeScript jadi JavaScript di folder `out/`. Itu bukan action yang langsung aktif di VS Code biasa atau di macOS. Kalau belum dijalankan lewat `F5`, tidak akan ada efek yang terasa. Kalau sudah muncul `out/extension.js`, berarti build TypeScript-nya sukses.
Kalau notifikasi muncul di Extension Development Host, berarti basic flownya juga sudah benar.

Setelah scaffold, langkah testing-nya begini:

- `npm install` atau `pnpm install` kalau pakai pnpm
- `npm run compile` atau `pnpm run compile`
- tekan cmd + shift + P, lalu pilih `Debug: Start Debugging` atau tekan `F5`
- Setelah muncul window baru (Extension Development Host), tekan cmd + shift + P lagi, lalu cari command `Hello World` yang sudah didaftarkan

## Coba use case sederhana: extension note helper

Biar nggak cuma Hello World, gue cari use case simpel yang masih relevan dengan Dendron: bikin extension yang bantu cari dan buka note.

Use case yang gue bayangkan:

- command `Open Note by ID`
- input prompt `Note ID`
- extension cari file Markdown di workspace
- lalu buka file tersebut di editor

Kenapa ini menarik?

- hampir semua extension VS Code butuh command + input + workspace file access
- dari sini ketahuan apakah `vscode.workspace.findFiles` dan `vscode.window.showQuickPick` cukup
- dan bisa dibandingkan dengan Dendron yang sudah punya note lookup built-in

Kalau ini jalan, berarti basic extension flow sudah cukup untuk implementasi fitur note/navigation.

## Pelajaran dari Dendron vs vanilla

Beberapa hal yang sekarang gue anggap penting:

- `activationEvents: ["*"]` di Dendron membuat extension aktif sangat dini. Itu ngebantu kalau extension punya banyak panel, tapi juga berarti startup lebih berat.
- `contributes.commands` di `package.json` itu cuma daftar. Logic aslinya ada di TypeScript.
- `webview` besar dan terisolasi. Kalau butuh UI custom, harus siap kirim pesan bolak-balik.
- `FileSystemWatcher` itu penting, tapi gampang bikin out-of-sync kalau pattern-nya nggak benar.
- `Reload Index` di Dendron bukan sekedar reload VS Code; itu rebuild engine dan parse note, jadi terasa lebih lambat daripada `workbench.action.reloadWindow`.

## Kekuatan extension VS Code di Dendron

Dari repo ini, gue lihat extension bisa dipakai untuk:

- bikin UI Dendron langsung di VS Code lewat tree view dan webview
- expose command custom untuk workflow note-taking dan engine control
- tambah language intelligence Markdown / frontmatter
- monitor file dan workspace event
- handle workspace trust, shell support, dan telemetry

## Batasan praktis

Tapi ada batasan yang perlu diingat:

- extension cuma bisa pakai API resmi VS Code. Kalau nggak ada kontribusi resmi, nggak bisa nyuntik langsung ke editor core.
- webview harus komunikasi via `postMessage`; nggak bisa panggil fungsi JS extension langsung.
- di mode web extension, beberapa API Node/shell mungkin nggak tersedia.
- fitur berat seperti reload engine bisa terasa lambat, dan itu biasanya bukan salah VS Code tapi domain logic yang sudah kompleks.

## Link referensi langsung

- Official VS Code tutorial: https://code.visualstudio.com/api/get-started/your-first-extension
- Sample repo Hello World: https://github.com/microsoft/vscode-extension-samples/tree/main/helloworld-sample
- Artikel step-by-step TS extension: https://dev.to/fabrikapp/how-to-make-a-vs-code-extension-using-typescript-a-step-by-step-guide-1hp6
- Artikel komprehensif TypeScript: https://www.blog.brightcoding.dev/2024/04/29/building-a-vs-code-extension-with-typescript-a-comprehensive-guide/
- Artikel pengembang lanjut: https://hemaks.org/posts/developing-extensions-for-visual-studio-code-with-typescript/

## Referensi yang gue temuin di repo Dendron

- `packages/plugin-core/vsc-extension-quickstart.md`
- `packages/plugin-core/.vscode/launch.json`
- `packages/plugin-core/package.json`
- `packages/plugin-core/src/_extension.ts`
