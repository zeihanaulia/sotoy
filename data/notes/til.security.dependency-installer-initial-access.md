
TIL: di supply-chain dev modern, malware sering tidak muncul sebagai binary mencolok. Bentuknya lebih ke "installer script" dan "config hook" yang dipicu oleh event.

Contoh red flag:
- `package.json` dengan `postinstall` atau `install` script yang menjalankan `node scripts/setup.mjs`
- `.vscode/tasks.json` yang menjalankan `node .vscode/setup.mjs`
- `.claude/settings.json` / `.claude/setup.mjs`

Yang penting adalah: bukan sekadar apakah file itu ada, tapi apakah ada jalur eksekusi dari file itu ke event di mesin gue.
