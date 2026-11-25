# Panduan PUSMENDIK - Aplikasi Simulasi TKA & ANBK (Supabase + PWA)

Aplikasi WebApp PWA Single-File mandiri untuk **Simulasi TKA (Tes Kemampuan Akademik) & ANBK Pusmendik**. Dirancang dengan desain Glassmorphism modern, tata letak responsif (Desktop & Mobile), Fullscreen Anti-Curang, Auto-Rotate Token 15 Menit, dan Live Monitoring Kegiatan Peserta secara Real-Time.

---

## 📁 File yang Tersedia
1. **`index.html`**: Seluruh kode frontend, CSS Tailwind, FontAwesome, JavaScript Logic, dan PWA Service Worker dalam 1 file tunggal siap pakai.
2. **`schema.sql`**: Skrip pembuatan tabel database PostgreSQL & konfigurasi keamanan Row Level Security (RLS) di Supabase.

---

## 🚀 Langkah Instalasi & Deployment

### 1. Eksekusi Skema di Supabase
1. Buka dashboard proyek Supabase Anda: [supabase.com](https://supabase.com).
2. Masuk ke menu **SQL Editor**.
3. Buat query baru, salin seluruh isi dari file [`schema.sql`](file:///c:/TKA/schema.sql), lalu klik tombol **Run**.
4. Semua tabel (`pengaturan_sekolah`, `ruang_ujian`, `sesi_ujian`, `mapel`, `siswa`, `jadwal_peserta`, `stimulus`, `soal`, `hasil_ujian`) dan kebijakan RLS akan dibuat secara otomatis.

### 2. Daftarkan Akun Admin di Supabase Auth
1. Masuk ke menu **Authentication** > **Users** di dashboard Supabase Anda.
2. Klik **Add User** > **Create User**.
3. Masukkan Email dan Password untuk Admin / Proktor (misal: `admin@sekolah.sch.id`).

### 3. Hubungkan Aplikasi ke Supabase
Buka file [`index.html`](file:///c:/TKA/index.html) dan temukan bagian konfigurasi di awal `<script>`:
```javascript
const IS_PREVIEW = false; // Ubah menjadi false untuk menghubungkan ke Supabase
const SUPABASE_URL = "https://xxxx.supabase.co"; // Ganti dengan URL Supabase Anda
const SUPABASE_ANON_KEY = "eyJh......"; // Ganti dengan Anon Key Supabase Anda
```

### 4. Cara Deploy ke Blogger / Website
- **Blogger**: 
  1. Buat Halaman Baru (atau Widget HTML/JavaScript).
  2. Beralih ke mode **Tampilan HTML**.
  3. Salin seluruh isi file [`index.html`](file:///c:/TKA/index.html) dan tempelkan.
  4. Publikasikan. Aplikasi akan otomatis memenuhi seluruh layar (*Full Page Override*).
- **Hosting Lokal / Web Server**: Cukup letakkan file `index.html` di root folder web server Anda (Apache, Nginx, Vercel, Netlify, atau GitHub Pages).

---

## 🌟 Fitur Utama Aplikasi
- **Sistem Login Hybrid**: Siswa masuk dengan Username & Password dari database, Proktor/Admin masuk via Supabase Auth.
- **Tampilan Persis Pusmendik ANBK**: Header geometris poligon, kartu watermark, radio/checkbox khas ANBK.
- **Wacana Stimulus & Soal Side-by-Side**: Stimulus kiri bisa di-scroll vertikal & horizontal, gambar mandiri, font resizable (A A A).
- **Tipe Soal ANBK Lengkap**: Pilihan Ganda Biasa, Pilihan Ganda Kompleks (Kotak Ceklis > 1 jawaban), dan Benar/Salah (Multi Pernyataan).
- **Anti-Cheat Engine Super Ketat**: Mode Layar Penuh wajib, deteksi alt-tab/pindah window/minimize/split-screen, batas toleransi kecurangan otomatis kumpul ujian.
- **Token Ujian Dinamis (15 Menit)**: Countdown timer otomatis memperbarui token setiap 15 menit.
- **Live Monitoring & Log Kecurangan**: Proktor dapat memantau pergerakan nomor soal siswa dan pelanggaran secara real-time.
- **Cetak Kartu Peserta & Rekap Nilai**: Preview cetak langsung di tab baru dengan kop resmi.
