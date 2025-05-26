---
id: 6szjp3xq8zomb5lhyfxd3nz
title: "RLS Supabase: Biar Data Lo Gak Jadi Konsumsi Publik"
desc: ''
updated: 1748257326562
created: 1748257270940
---


Lo pasti pernah kepikiran: “Gimana caranya user cuma bisa ngakses data yang emang buat dia?” Nah, RLS atau Row-Level Security itu jawabannya. Di Supabase (dan di Postgres juga), RLS itu semacam **penjaga pintu**—dia bakal nentuin data mana yang boleh dan nggak boleh diakses sama user tertentu.

## **Apa Itu RLS?**
Secara teknis, RLS itu fitur bawaan Postgres yang bikin lo bisa filter data langsung di level baris (row), bukan cuma kolom doang. Jadi, kalau lo punya tabel **orders** isinya 1 juta baris, user A cuma boleh liat order yang dia bikin doang—nggak bisa kepoin order orang lain. Semua logicnya ditulis di database, bukan di backend lo.

Gampangnya, **RLS** adalah fitur keren di Postgres yang bikin lo bisa atur siapa yang bisa lihat data di level baris (row). Jadi, bukan cuma tabel yang di-protect, tapi per **baris** data pun bisa lo atur aksesnya. RLS ini kayak satpam di pintu-pintu rumah lo – lo bisa atur siapa yang boleh lewat, siapa yang nggak.

### **Kenapa Penting?**
Tanpa RLS, lo harus rely sama backend lo buat handle data filtering. Itu riskan banget. Misalnya, di backend lo lupa check `where user_id = session_user`, user bisa dapetin data orang lain—bahaya! Dengan RLS, lo **mindahin logic proteksi** langsung ke database. Hasilnya:
- Data lebih aman.
- Backend lo lebih simpel (nggak perlu query filter yang ribet).
- Semua permintaan ke database (termasuk API Supabase) udah auto-filtered.

Lo bayangin kalo lo punya satu database tapi dipake rame-rame: ada admin, user biasa, dan customer premium. Tanpa RLS, kalo lo nggak hati-hati, siapa aja bisa lihat semua data. Bahaya, kan? Nah, RLS bikin lo bisa setel “aturan main” biar user A cuma liat data dia doang, admin bisa liat semua, dan lain-lain.

## Cara Kerja RLS

Secara default, Postgres **nggak aktifin** RLS. Lo harus nyalain dulu:

```sql
alter table profiles enable row level security;
```

Abis itu, lo bikin policy. Misalnya, lo pengen user biasa cuma bisa liat datanya sendiri:

```sql
create policy "user can view own profile"
on profiles
for select
using (auth.uid() = id);
```

Nah, `auth.uid()` ini di Supabase otomatis dapet dari JWT user yang login. Jadi lo nggak perlu nulis kode filter data di backend lo, semua udah dihandle sama database!

## **Contoh Use Case**
Lo punya app SaaS buat beberapa tenant. Di sana ada admin yang harus bisa liat semua data, dan ada user biasa yang cuma boleh liat data organisasinya doang. Contohnya di tabel `profiles`:

* User Biasa: cuma boleh liat data user di tenant dia sendiri.
* Admin: boleh liat data semua orang.
* Guest / Anon: nggak boleh liat sama sekali.

### **Simulasi Sederhana**
Di Supabase, lo bisa bikin 2 policy di tabel `profiles` kayak gini:

```sql
-- Admin bisa akses semua
create policy "admin can access all profiles"
on public.profiles
as permissive
for all
to authenticated
using (
  auth.jwt() ->> 'role' = 'admin'
);

-- User biasa cuma bisa akses profil sendiri
create policy "user can access own profile"
on public.profiles
as permissive
for select
to authenticated
using (auth.uid() = id);
```

Jadi waktu ada request:

* Admin dapet full akses.
* User biasa cuma liat data yang ID-nya sama dengan `auth.uid()`.
* Kalau anon? Kena RLS—data nggak muncul sama sekali.

### **Custom Claims di Supabase**

Supabase support banget buat custom JWT claims—artinya lo bisa nyelipin info tambahan kayak `role`, `tenant_id`, atau apapun yang lo butuhin di JWT user. Nah, kenapa ini penting?

Biasanya, JWT default dari Supabase cuma punya info standar kayak `sub` (user id), `email`, sama `role` yang default (`authenticated` / `anon`). Tapi buat app multi-tenant, lo butuh role yang lebih spesifik—misalnya admin, sales, customer, dsb.

Di Supabase, caranya lewat **Auth Hooks**. Lo bisa bikin **custom access token hook** di PostgreSQL yang akan “selipin” field baru ke JWT sebelum dikasih ke user. Contoh:

```sql
create or replace function public.custom_access_token_hook(event jsonb)
returns jsonb
language plpgsql
as $$
declare
  claims jsonb;
  user_role text;
begin
  -- Ambil role dari tabel profiles
  select role into user_role
  from public.profiles
  where id = (event->>'sub')::uuid;

  -- Kalo nggak ketemu, fallback ke 'user'
  if user_role is null then
    user_role := 'user';
  end if;

  -- Ambil claims dari event
  claims := coalesce(event->'claims', '{}');

  -- Tambahin custom claim 'role'
  claims := jsonb_set(claims, '{app_metadata, role}', to_jsonb(user_role)::jsonb);

  -- Update claims di event
  event := jsonb_set(event, '{claims}', claims);

  return event;
end;
$$;
```

Hasilnya? JWT user lo sekarang bakal punya `app_metadata.role` = “admin” atau “user”, sesuai yang lo simpen di tabel `profiles`. Ini yang nanti **dipake di policy RLS**!


**Tips**
✅ **Jangan asal nambahin claims**—cuma yang emang dibutuhin buat RLS.
✅ **Tes hook lo**—biar JWT yang dihasilkan sesuai ekspektasi dan nggak ngerusak policy yang udah lo bikin.
✅ **Hindari leak data sensitif**—jangan selipin info yang nggak perlu di JWT.

---

## **Best Practice**
Jangan cuma bikin policy yang kelihatannya aman. Ada beberapa tips biar lo nggak keteteran:

1. **Selalu tes policy lo**—pakai akun dummy yang role-nya beda-beda.
2. **Pisahin policy buat read (select) sama write (insert/update/delete)**—biar lo bisa detailin kontrolnya.
3. **Gunakan claim JWT** kayak `role` atau `tenant_id` buat filter lebih spesifik—jadi bukan cuma ID user doang.
4. **Jangan kasih grant `select` atau `all` langsung ke `anon` / `authenticated`** tanpa policy. Tanpa policy, data lo kebuka semua.
5. **Kalau ada query yang harus admin-only, kasih policy spesifik**—jangan sampe admin lo kena limit yang sama kayak user biasa.

## Reference

- [Row Level Security di Supabase Docs](https://supabase.com/docs/guides/database/postgres/row-level-security)
- [Postgres Official Docs](https://www.postgresql.org/docs/current/ddl-rowsecurity.html)  
- [Supabase Auth Hooks: Custom Access Token Hook](https://supabase.com/docs/guides/auth/auth-hooks/custom-access-token-hook)

