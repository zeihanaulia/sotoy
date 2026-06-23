
Yang gue lihat dari repo Semgrep resmi di `.references/semgrep`:

- Semgrep bukan alat AI; dia adalah application security tool untuk SAST dan static code analysis.
- Repo ini bukan cuma script Python sekali jalan. Dia sudah port ke OCaml dan dibangun dengan `dune`.
- `src/osemgrep/cli/CLI.ml` adalah entry point utama untuk CLI. Dia nge-dispatch per subcommand seperti `scan`, `ci`, `login`, `logout`, `lsp`, `show`, `test`, dan `validate`.
- Kalau command tertentu belum ter-handle di port OCaml, ada fallback ke `Pysemgrep.Fallback`, jadi Semgrep masih bisa support edge case lama via Python.

Inti arsitekturnya bisa dibagi jadi tiga lapisan:

1. CLI / subcommand dispatch
   - `src/osemgrep/cli/CLI.ml`: baca argv, tentukan subcommand, kirim ke `Scan_subcommand.main`, `Ci_subcommand.main`, dll.
   - Ada hook untuk fitur Pro / publish, tapi yang paling penting `scan` adalah default.

2. Rule parsing dan model
   - `src/parsing/Parse_rule_formula.ml`: parser untuk `pattern`, `pattern-inside`, `pattern-either`, `pattern-regex`, dan variabel metapola.
   - `src/rule/Rule.ml`: mendefinisikan struktur rule Semgrep, metadata, layout, dan opsi tambahan seperti `severity`, `languages`, `message`.
   - Parser ini ternyata menangani lebih dari sekadar string: dia juga mengecek `metavariable-type`, `focus-metavariable`, dan opsi `aliengrep/spacegrep` untuk target yang bukan sekadar sintaks standar.

3. Matching engine
   - `src/engine/Match_search_mode.ml`: mengatur bagaimana pattern dicocokkan terhadap tree kode, terutama perbedaan antara `pattern:` dan `pattern-inside:` atau gabungan pattern.
   - `src/engine/Match_rules.ml`: orkestrasi rule matching, termasuk penggabungan hasil dan bagaimana engine menjalankan rule terhadap AST target.
   - `src/matching/Pattern_vs_code.ml`: bekerja di level yang lebih rendah untuk mencocokkan pattern AST dengan kode sumber sebenarnya.
   - `src/engine/Xpattern_matcher.ml` + `src/engine/Xpattern_match_*`: berbagai backend matching untuk regex, spacegrep, dan bahasa custom.

Karena Semgrep adalah "semantic grep", cara kerjanya bukan sekadar regex. Dia:

- memparsing source code ke AST / struktur yang bisa dimatch,
- memparsing pattern Semgrep yang ditulis seperti kode biasa,
- menemukan kecocokan antara pattern dan kode, termasuk metavariabel seperti `$X`, `$Y`, dan repetition patterns,
- lalu mengeluarkan temuan berdasarkan rule metadata.

### Use case praktis Semgrep

1. Guardrail MR / PR
   - `verify.sh` bisa menjalankan `semgrep --config .semgrep.yml` dan gagal jika rule N+1 atau `repository call in loop` terpenuhi.
   - Ini cocok buat pakai kembali judgement senior: kalau reviewer sering komentar `hati-hati N+1`, bisa ubah jadi rule Semgrep.

2. CI / pre-commit linting
   - Semgrep bisa jadi security lint yang jalan di pipeline sebelum test suite penuh.
   - Contohnya: deteksi `subprocess.run(..., shell=True)` atau `eval(...)` di Python.

3. Security scanning dan policy enforcement
   - Untuk SAST, Semgrep OSS bagus untuk pola sintaks lokal.
   - Untuk dataflow/cross-file analysis, Semgrep AppSec Platform yang menyediakan kemampuan tambahan.

4. IDE support
   - rules dipakai di editor untuk deteksi langsung, bukan hanya batch scan.
   - Ini jadi cepat feedback loop untuk developer.

5. Custom rule authoring
   - tim bisa bikin rule khusus domain: `dangerous HTTP header handling`, `raw SQL builder`, `untrusted input ke logging`, `N+1 query pattern`.

### Contoh rule yang bisa dibuat

Basic find:

```yaml
rules:
  - id: insecure-shell-call
    languages: [python]
    severity: WARNING
    message: "Jangan pake shell=True di subprocess.run"
    pattern: subprocess.run(..., shell=True)
```

`pattern-inside` untuk target yang lebih sempit:

```yaml
rules:
  - id: insecure-exec-in-handler
    languages: [python]
    severity: ERROR
    message: "Eksekusi shell di dalam request handler"
    pattern-inside: |
      def handle_request(...):
          ...
    pattern: subprocess.run(..., shell=True)
```

`pattern-either` untuk logic OR:

```yaml
rules:
  - id: sql-injection-or-raw-sql
    languages: [python]
    severity: WARNING
    message: "Raw SQL atau string concatenation berbahaya"
    pattern-either:
      - pattern: execute("SELECT " + ...)
      - pattern: raw_sql(...)
```

Metavariable pattern:

```yaml
rules:
  - id: n-plus-one-candidate
    languages: [python]
    severity: WARNING
    message: "Kemungkinan N+1: loop dengan query di dalamnya"
    pattern-inside: |
      for $ITEM in $COLLECTION:
          $DB.query(...)
```
```

Contoh ini yang paling relevan buat `verify.sh`: rule Semgrep ini bisa jadi sensor awal, sebelum pipeline coba verifikasi behavior query count nyata.

### Hal penting yang gue catat dari repo

- Repo ini memang salah satunya port ke OCaml, bukan versi Python semata. Jadi kodenya bukan hanya `semgrep` CLI Python, tapi engine yang lebih native.
- Fallback ke `Pysemgrep.Fallback` masih ada, artinya sebagian perintah lama masih didukung lewat Python jika OCaml belum lengkap.
- Rule parsing dan matching adalah dua stage berbeda: parse YAML/`pattern:` dulu, lalu match ke AST/kode.
- `pattern-inside` bukan cuma nested search biasa; engine punya semantik khusus untuk menggabungkan ruang lingkup pattern dengan window di sekitarnya.

Kalau mau, gue bisa tambahkan section `how to inspect rule hits di repo` dengan file pointer seperti `src/engine/Match_rules.ml` dan `src/matching/Pattern_vs_code.ml` untuk jadikan note ini lebih teknis lagi.