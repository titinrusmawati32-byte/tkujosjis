-- ============================================================================
-- SKEMA DATABASE SUPABASE (POSTGRESQL) & ROW LEVEL SECURITY (RLS)
-- PUSMENDIK - APLIKASI SIMULASI TKA & ANBK SD (FASE C / KELAS 5 SD)
-- ============================================================================

-- 1. TABEL PENGATURAN SEKOLAH
CREATE TABLE IF NOT EXISTS public.pengaturan_sekolah (
  id TEXT PRIMARY KEY DEFAULT 'cfg-1',
  nama_instansi TEXT NOT NULL DEFAULT 'PUSMENDIK',
  nama_aplikasi TEXT NOT NULL DEFAULT 'APLIKASI TKA & ANBK SD',
  nama_sekolah TEXT NOT NULL DEFAULT 'SD NEGERI 1 SIMULASI TKA',
  logo_url TEXT,
  token_aktif TEXT NOT NULL DEFAULT 'SD26A',
  max_pelanggaran INT NOT NULL DEFAULT 3,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. TABEL RUANG UJIAN
CREATE TABLE IF NOT EXISTS public.ruang_ujian (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  kode_ruang TEXT NOT NULL,
  nama_ruang TEXT NOT NULL,
  keterangan TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 3. TABEL SESI UJIAN
CREATE TABLE IF NOT EXISTS public.sesi_ujian (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  nama_sesi TEXT NOT NULL,
  jam_mulai TEXT NOT NULL,
  jam_selesai TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 4. TABEL MATA PELAJARAN / PAKET UJIAN
CREATE TABLE IF NOT EXISTS public.mapel (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  kode_mapel TEXT NOT NULL,
  nama_mapel TEXT NOT NULL,
  durasi_menit INT NOT NULL DEFAULT 60,
  aktif BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 5. TABEL SISWA / PESERTA TKA SD
CREATE TABLE IF NOT EXISTS public.siswa (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  username TEXT UNIQUE NOT NULL,
  password TEXT NOT NULL,
  nama_lengkap TEXT NOT NULL,
  jenis_kelamin TEXT NOT NULL DEFAULT 'Laki-Laki',
  tgl_lahir TEXT NOT NULL DEFAULT '14-06-2014',
  ruang_id TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 6. TABEL JADWAL PESERTA (MAPPING SISWA, MAPEL, RUANG & SESI)
CREATE TABLE IF NOT EXISTS public.jadwal_peserta (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  siswa_id TEXT NOT NULL,
  mapel_id TEXT NOT NULL,
  ruang_id TEXT,
  sesi_id TEXT,
  hari TEXT DEFAULT 'Senin',
  tanggal TEXT DEFAULT '2026-05-18',
  created_at TIMESTAMPTZ DEFAULT NOW(),
  CONSTRAINT uq_siswa_mapel UNIQUE (siswa_id, mapel_id)
);

-- 7. TABEL WACANA STIMULUS (TEKS & GAMBAR EDUKATIF SD)
CREATE TABLE IF NOT EXISTS public.stimulus (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  mapel_id TEXT NOT NULL,
  judul TEXT NOT NULL,
  konten_teks TEXT,
  gambar_url TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 8. TABEL BUTIR SOAL (PG BIASA, PGK CEKLIS, BENAR/SALAH)
CREATE TABLE IF NOT EXISTS public.soal (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  mapel_id TEXT NOT NULL,
  stimulus_id TEXT NOT NULL,
  nomor_urut INT NOT NULL DEFAULT 1,
  jenis_soal TEXT NOT NULL DEFAULT 'PG', -- 'PG', 'PGK', 'BS'
  bobot INT NOT NULL DEFAULT 25,
  pertanyaan TEXT NOT NULL,
  opsi_a TEXT,
  opsi_b TEXT,
  opsi_c TEXT,
  opsi_d TEXT,
  opsi_e TEXT,
  kunci_jawaban TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 9. TABEL HASIL & REAL-TIME MONITORING UJIAN
CREATE TABLE IF NOT EXISTS public.hasil_ujian (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  siswa_id TEXT NOT NULL,
  mapel_id TEXT NOT NULL,
  jawaban_siswa JSONB DEFAULT '{}'::jsonb,
  skor INT DEFAULT 0,
  jumlah_pelanggaran INT DEFAULT 0,
  status TEXT DEFAULT 'Sedang Mengerjakan',
  waktu_mulai TIMESTAMPTZ DEFAULT NOW(),
  waktu_selesai TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================================
-- AKTIFKAN ROW LEVEL SECURITY (RLS) & POLICIES (ARSITEKTUR HYBRID LOGIN)
-- ============================================================================

ALTER TABLE public.pengaturan_sekolah ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.ruang_ujian ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.sesi_ujian ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.mapel ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.siswa ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.jadwal_peserta ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.stimulus ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.soal ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.hasil_ujian ENABLE ROW LEVEL SECURITY;

-- 1. Akses Publik Read (Siswa dapat membaca data ujian yang diperlukan)
CREATE POLICY "Akses Publik Read Pengaturan" ON public.pengaturan_sekolah FOR SELECT USING (true);
CREATE POLICY "Akses Publik Read Ruang" ON public.ruang_ujian FOR SELECT USING (true);
CREATE POLICY "Akses Publik Read Sesi" ON public.sesi_ujian FOR SELECT USING (true);
CREATE POLICY "Akses Publik Read Mapel" ON public.mapel FOR SELECT USING (true);
CREATE POLICY "Akses Publik Read Stimulus" ON public.stimulus FOR SELECT USING (true);
CREATE POLICY "Akses Publik Read Soal" ON public.soal FOR SELECT USING (true);
CREATE POLICY "Akses Publik Read Jadwal" ON public.jadwal_peserta FOR SELECT USING (true);
CREATE POLICY "Akses Publik Read Siswa" ON public.siswa FOR SELECT USING (true);

CREATE POLICY "Akses Publik Hasil Ujian Insert" ON public.hasil_ujian FOR INSERT WITH CHECK (true);
CREATE POLICY "Akses Publik Hasil Ujian Update" ON public.hasil_ujian FOR UPDATE USING (true);
CREATE POLICY "Akses Publik Hasil Ujian Select" ON public.hasil_ujian FOR SELECT USING (true);

-- 2. Akses Penuh untuk Admin Terautentikasi (auth.role() = 'authenticated')
CREATE POLICY "Admin Full Access Pengaturan" ON public.pengaturan_sekolah FOR ALL USING (auth.role() = 'authenticated');
CREATE POLICY "Admin Full Access Ruang" ON public.ruang_ujian FOR ALL USING (auth.role() = 'authenticated');
CREATE POLICY "Admin Full Access Sesi" ON public.sesi_ujian FOR ALL USING (auth.role() = 'authenticated');
CREATE POLICY "Admin Full Access Mapel" ON public.mapel FOR ALL USING (auth.role() = 'authenticated');
CREATE POLICY "Admin Full Access Siswa" ON public.siswa FOR ALL USING (auth.role() = 'authenticated');
CREATE POLICY "Admin Full Access Jadwal" ON public.jadwal_peserta FOR ALL USING (auth.role() = 'authenticated');
CREATE POLICY "Admin Full Access Stimulus" ON public.stimulus FOR ALL USING (auth.role() = 'authenticated');
CREATE POLICY "Admin Full Access Soal" ON public.soal FOR ALL USING (auth.role() = 'authenticated');
CREATE POLICY "Admin Full Access Hasil Ujian" ON public.hasil_ujian FOR ALL USING (auth.role() = 'authenticated');

-- ============================================================================
-- SEED DATA DEFAULT (KHUSUS TKA SD)
-- ============================================================================

INSERT INTO public.pengaturan_sekolah (id, nama_instansi, nama_aplikasi, nama_sekolah, token_aktif, max_pelanggaran)
VALUES ('cfg-1', 'PUSMENDIK', 'APLIKASI TKA & ANBK SD', 'SD NEGERI 1 SIMULASI TKA', 'SD26A', 3)
ON CONFLICT (id) DO NOTHING;
