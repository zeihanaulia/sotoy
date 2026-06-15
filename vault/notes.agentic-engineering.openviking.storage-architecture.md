---
id: notes.agentic-engineering.openviking.storage-architecture
title: "OpenViking storage architecture"
desc: "POV catatan tentang desain penyimpanan OpenViking yang memisahkan AGFS sebagai source of truth dari Vector Index sebagai katalog pencarian."
updated: 1780427822719
created: 1780427598443
tags:
  - notes
  - agentic-engineering
  - openviking
  - storage
---

Link: https://docs.openviking.ai/en/concepts/05-storage

**Storage Architecture di OpenViking adalah desain penyimpanan internal yang memisahkan konten asli dari indeks pencarian semantic**. Ini bukan sekadar "di-save di folder mana", tapi cara OpenViking menjaga agar context bisa dibaca seperti filesystem sekaligus dicari seperti vector database.

## 1. Pertanyaan kunci yang gue pegang

1. Kenapa OpenViking memisahkan content storage dan index storage?
2. Apa peran VikingFS?
3. Apa yang disimpan AGFS?
4. Apa yang disimpan Vector Index?
5. Bagaimana URI `viking://...` dipetakan ke lokasi fisik?
6. Bagaimana relation antar resource disimpan?
7. Bagaimana OpenViking menjaga konsistensi saat delete atau move?

## 2. Storage Architecture menurut gue

Kalau disederhanakan, OpenViking punya dua dunia penyimpanan utama:

- **AGFS** menyimpan isi asli: L0, L1, L2, multimedia, dan relations.
- **Vector Index** menyimpan peta semantic: URI, vector, metadata, abstract.

Di atas keduanya ada **VikingFS**: lapisan URI abstraction yang menerjemahkan `viking://...` ke storage fisik dan mengatur operasi read, write, move, delete, relation, dan find.

Analoginya simpel:

- AGFS = rak buku dan isi bukunya.
- Vector Index = katalog perpustakaan.
- VikingFS = pustakawan yang tahu cara menerjemahkan "cari auth docs" menjadi lokasi, ringkasan, dan isi.

Kalau katalog rusak, buku tetap ada. Kalau buku dipindah, katalog harus ikut diperbarui.

## 3. Kenapa harus dipisah?

OpenViking memisahkan dua layer karena tugasnya berbeda.

AGFS butuh durability, hierarki, dukungan file multimodal, dan operasi file klasik. Vector Index butuh kecepatan similarity search, filter metadata, dan recall hybrid.

Kalau dua tanggung jawab ini dicampur, vector store bisa berubah jadi gudang penuh konten:

- duplikasi data,
- ketidaksinkronan versi,
- storage mahal,
- delete/move susah,
- debug lebih rumit.

Dengan pemisahan:

- AGFS jadi source of truth,
- Vector Index jadi search accelerator.

## 4. Apa peran VikingFS?

VikingFS adalah lapisan abstraksi URI.

Dia mengurus:

- menerjemahkan `viking://...` ke lokasi fisik,
- membaca dan menulis di AGFS,
- memindah dan menghapus resource,
- mengelola relation,
- mencari dengan Vector Index.

Jadi ketika agent memanggil:

```python
client.read("viking://resources/docs/auth")
```

VikingFS mengarahkan ke AGFS.

Ketika agent memanggil:

```python
client.find("authentication methods")
```

VikingFS/ Search layer pakai Vector Index untuk menemukan URI kandidat, lalu konten asli tetap dibaca dari AGFS.

## 5. Apa yang disimpan AGFS?

AGFS adalah backend content storage. Dia menyimpan:

- `.abstract.md` = L0,
- `.overview.md` = L1,
- file asli / folder = L2,
- multimedia (image, audio, video),
- `.relations.json` = graph relation antar resource.

Page juga menulis bahwa AGFS sudah diimplementasi ulang sebagai Rust RAGFS. Artinya backend content storage bisa optimal dan portable.

Intinya:

- AGFS menyimpan konten penuh,
- AGFS menyimpan struktur filesystem,
- AGFS menyimpan relations.

## 6. Apa yang disimpan Vector Index?

Vector Index adalah semantic index storage.

Dia menyimpan:

- `uri`,
- `parent_uri`,
- `context_type`,
- `is_leaf`,
- `vector`,
- `sparse_vector`,
- `abstract`,
- `name`,
- `description`,
- `created_at`,
- `active_count`.

Catatan penting:

- Vector Index tidak menyimpan isi file penuh.
- Abstract L0 boleh ditempatkan di index karena dipakai untuk recall cepat.
- Isi penuh dibaca dari AGFS.

Kalau index hanya menyimpan peta dan metadata, ia tetap ringan dan bisa dibangun ulang dari AGFS.

## 7. Bagaimana URI `viking://...` dipetakan?

`viking://` adalah alamat konseptual. VikingFS yang menerjemahkan ke lokasi fisik.

Contoh sederhana:

- `viking://resources/docs/auth` → `/local/{account}/resources/docs/auth`
- `viking://user/memories/preferences` → `/local/{account}/user/{user}/memories/preferences`
- `viking://agent/skills/search-web` → `/local/{account}/agent/{agent}/skills/search-web`

URI tetap stabil walau storage fisik diubah. Ini penting untuk portability dan konsistensi.

## 8. Bagaimana relation disimpan?

OpenViking tidak hanya memakai hierarchy. Ia juga menyimpan graph relation melalui `.relations.json`.

Ketika resource saling terkait, VikingFS bisa menyimpan link seperti:

```python
viking_fs.link(
  from_uri="viking://resources/docs/auth",
  uris=["viking://resources/docs/security"],
  reason="Related security docs"
)
```

Lalu relation diambil via:

```python
relations = viking_fs.relations("viking://resources/docs/auth")
```

Ini penting karena tidak semua hubungan bisa direpresentasikan lewat folder tree saja.

## 9. Bagaimana konsistensi dijaga saat delete/move?

Konsistensi adalah kunci karena AGFS dan Vector Index dipisah.

### Delete sync

Kalau resource dihapus lewat VikingFS,

- AGFS menghapus konten,
- Vector Index menghapus semua record dengan URI prefix yang sama.

Ini mencegah dangling index references.

### Move sync

Kalau resource dipindah/rename,

- AGFS memindah file/directory,
- Vector Index update `uri` dan `parent_uri`.

Kalau tidak, search akan kembali ke path lama yang tidak ada.

## 10. Kenapa ini penting?

OpenViking menerapkan prinsip:

- AGFS = file content source of truth,
- Vector Index = search catalog,
- VikingFS = URI abstraction & orchestration.

Dengan cara ini:

- search cepat,
- content tetap konsisten,
- delete/move bisa dijaga,
- file bisa dibaca sebagai filesystem,
- query bisa ditemukan sebagai vector search.

## 11. Apa implikasi untuk agent?

Agent bisa:

- `find` candidate via Vector Index,
- `read` actual content via AGFS,
- `abstract`/`overview` via AGFS,
- `follow relations` via `.relations.json`.

Kalau agent hanya tahu `viking://` URI, dia tidak perlu tahu detail storage fisik.

## 12. Related documents

- [[notes.agentic-engineering.openviking.architecture]]
- [[notes.agentic-engineering.openviking.context-extraction]]
- [[notes.agentic-engineering.openviking.context-layers]]
- [[notes.agentic-engineering.openviking.context-types]]
- [[notes.agentic-engineering.openviking.context-database]]
- [[vault/daily.journal.2026.06.03|Daily 2026-06-03]]
