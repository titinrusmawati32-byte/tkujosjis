# PUSMENDIK - Aplikasi Simulasi TKA & ANBK SD (Fase C / Kelas 4 - 6)

Aplikasi WebApp PWA Single-File mandiri untuk **Simulasi TKA (Tes Kemampuan Akademik) & ANBK tingkat Sekolah Dasar (SD/MI)**. Dirancang khusus dengan pendekatan ramah anak (*child-friendly*), materi stimulus wacana edukatif & menarik (fabel moral dan konteks petualangan berhitung), desain Glassmorphism khas Pusmendik, tata letak responsif, Fullscreen Anti-Curang, Auto-Rotate Token 15 Menit, dan Live Monitoring Kegiatan Peserta secara Real-Time.

---

## 📁 Berkas yang Tersedia
1. **`index.html`**: Seluruh kode frontend, CSS Tailwind, FontAwesome, JavaScript Logic, dan PWA Service Worker dalam 1 file tunggal siap pakai.
2. **`schema.sql`**: Skrip pembuatan tabel database PostgreSQL & konfigurasi keamanan Row Level Security (RLS) di Supabase.

---

## 🎯 Fokus Materi & Karakteristik Ujian Anak SD
- **Mata Ujian**:
  - **Numerasi (Matematika) SD/MI (Fase C)**: Durasi 60 Menit.
  - **Literasi Membaca SD/MI (Fase C)**: Durasi 60 Menit.
- **Wacana Stimulus Ramah Anak**:
  - *Panen Buah di Kebun Stroberi Ceria* (Numerasi kontekstual: berhitung keranjang, berat gram/kg, diskon belanjaan).
  - *Kelinci Putih dan Keranjang Wortel Sahabat* (Literasi fabel pendidikan karakter: tolong-menolong dan kerja keras).
- **Format Soal Variatif**: Pilihan Ganda (PG), Pilihan Ganda Kompleks (PGK kotak ceklis > 1 jawaban benar), dan Tabel Benar/Salah (BS).
- **Rentang Umur & Tanggal Lahir**: Disesuaikan untuk anak usia 9–13 tahun (tahun lahir 2011–2018).

---

## 🚀 Langkah Instalasi & Deployment

### 1. Eksekusi Skema di Supabase
1. Buka dashboard proyek Supabase Anda: [supabase.com](https://supabase.com).
2. Masuk ke menu **SQL Editor**.
3. Buat query baru, salin seluruh isi dari file [`schema.sql`](file:///c:/TKA/schema.sql), lalu klik tombol **Run**.
4. Semua tabel dan kebijakan keamanan RLS otomatis aktif.

### 2. Daftarkan Akun Admin di Supabase Auth
1. Masuk ke menu **Authentication** > **Users** di dashboard Supabase Anda.
2. Klik **Add User** > **Create User**.
3. Masukkan Email dan Password Admin / Proktor (misal: `admin@sdnegeri1.sch.id`).

### 3. Hubungkan Aplikasi ke Supabase
Buka file [`index.html`](file:///c:/TKA/index.html) dan ubah bagian konfigurasi:
```javascript
const IS_PREVIEW = false; // Ubah menjadi false untuk menghubungkan ke Supabase
const SUPABASE_URL = "https://xxxx.supabase.co"; // URL Supabase Anda
const SUPABASE_ANON_KEY = "eyJh......"; // Anon Key Supabase Anda
```

### 4. Cara Deploy ke Blogger / GitHub Pages
- **Blogger**: Buat postingan/halaman baru, ubah ke mode HTML, lalu salin dan tempelkan seluruh isi `index.html`.
- **GitHub Pages**: Cukup aktifkan GitHub Pages dari branch `main` pada repositori Anda.
