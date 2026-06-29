# 🔍 Sistem Pencarian Artikel dengan Pinecone & Sentence Transformers

Repositori ini berisi proyek akhir untuk mata kuliah **Sistem Basis Data (SBD)**. Proyek ini mengimplementasikan pencarian artikel berbasis semantik (*semantic search*) menggunakan **Pinecone Vector Database** dan model embedding **Sentence Transformers** (`all-MiniLM-L6-v2`), dengan antarmuka berbasis web menggunakan **Streamlit**.

---

## 🚀 Fitur Utama

- **Pencarian Semantik (*Semantic Search*)**: Mencari artikel tidak hanya berdasarkan kata kunci persis, melainkan berdasarkan kecocokan makna/konteks menggunakan *vector similarity*.
- **Integrasi Pinecone**: Menyimpan dan mengindeks embedding artikel ke dalam index Pinecone secara otomatis.
- **Model Embedding Efisien**: Menggunakan model `all-MiniLM-L6-v2` yang ringan, cepat, dan akurat untuk menghasilkan representasi vektor berdimensi 384.
- **Antarmuka Streamlit**: Tampilan web yang sederhana, interaktif, dan mudah digunakan untuk melakukan pencarian.
- **Skor Kemiripan (*Similarity Score*)**: Menampilkan hasil pencarian teratas beserta skor kemiripan kosinus (*cosine similarity*).

---

## 🛠️ Arsitektur & Teknologi

*   **Bahasa Pemrograman**: Python
*   **Web Framework**: Streamlit
*   **Vector Database**: Pinecone (Serverless AWS `us-east-1`)
*   **Model NLP**: Sentence Transformers (`all-MiniLM-L6-v2`)
*   **Metrik Kemiripan**: Cosine Similarity

---

## 📂 Struktur Proyek

```text
FINAL TUGAS SBD/
├── .streamlit/           # Konfigurasi Streamlit (jika ada)
├── app.py                # Kode utama aplikasi Streamlit
├── requirements.txt      # Daftar dependensi library Python
└── README.md             # Dokumentasi proyek
```

---

## ⚙️ Persyaratan Sistem & Instalasi

### 1. Prasyarat
Pastikan Anda sudah menginstal **Python 3.8** atau versi yang lebih baru di sistem Anda.

### 2. Instalasi Dependensi
Buka terminal/command prompt di direktori proyek ini, lalu jalankan perintah berikut untuk menginstal semua library yang dibutuhkan:

```bash
pip install -r requirements.txt
```

### 3. Konfigurasi API Key Pinecone
Secara bawaan, API Key Pinecone telah dikonfigurasi di dalam file [app.py](file:///c:/FINAL%20TUGAS%20SBD/app.py):
```python
PINECONE_API_KEY = "pcsk_..."
```
*(Catatan: Untuk keamanan produksi, disarankan untuk menggunakan env variables atau Streamlit secrets).*

---

## 🖥️ Cara Menjalankan Aplikasi

Jalankan perintah berikut di terminal Anda untuk memulai server lokal Streamlit:

```bash
streamlit run app.py
```

Setelah berhasil dijalankan, Streamlit akan membuka tab baru di browser Anda secara otomatis (biasanya di alamat `http://localhost:8501`).

---

## 📖 Cara Kerja Sistem

1. **Inisialisasi Indeks**: Saat aplikasi pertama kali dijalankan, sistem akan memeriksa apakah indeks Pinecone bernama `artikel-index` sudah ada. Jika belum, sistem akan membuatnya dengan spesifikasi dimensi 384 dan metrik kemiripan *cosine*.
2. **Upsert Data Artikel**: Kumpulan data artikel default yang ada di dalam kode akan diubah menjadi representasi vektor (embedding) menggunakan model `SentenceTransformer` dan diunggah (*upsert*) ke Pinecone.
3. **Pencarian**:
   - Pengguna memasukkan kata kunci/query pencarian pada kolom input Streamlit.
   - Query tersebut diubah menjadi embedding dengan model yang sama.
   - Sistem melakukan query ke Pinecone untuk mencari 5 artikel teratas dengan nilai *similarity* tertinggi.
   - Hasil pencarian beserta nilai skor kecocokan ditampilkan ke layar.

---

Selamat mencoba! Semoga proyek ini bermanfaat untuk pembelajaran Sistem Basis Data.
