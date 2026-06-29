# 📚 Repositori Basis Data: MySQL, MongoDB, & Pencarian Semantik Vektor

Selamat datang di repositori proyek basis data! Repositori ini menggabungkan tiga pendekatan penyimpanan dan pemrosesan data yang berbeda: **RDBMS relasional (MySQL)**, **NoSQL berbasis dokumen (MongoDB)**, dan **Pencarian Semantik Berbasis Vektor (Pinecone & Sentence Transformers)**.

Proyek ini dirancang untuk menunjukkan implementasi praktis dari manajemen basis data perpustakaan tradisional hingga teknologi pencarian canggih berbasis kecerdasan buatan (*AI Semantic Search*).

---

## 📁 Struktur Direktori & Komponen Utama

Berikut adalah gambaran umum dari berkas-berkas yang ada di dalam proyek ini:

```text
File repository github/
├── MongoDb/                      # Data NoSQL berbasis Dokumen
│   ├── authors.json              # Koleksi data penulis
│   ├── books.json                # Koleksi data buku
│   ├── publishers.json           # Koleksi data penerbit
│   ├── reviews.json              # Koleksi data ulasan
│   └── users.json                # Koleksi data pengguna
├── Mysql/                        # Data RDBMS Relasional
│   ├── 01_schema.sql             # Skema DDL tabel & relasi
│   └── 02_dummy_data.sql         # Data dummy DML awal
└── vektor/                       # Aplikasi Semantic Search Vektor
    ├── .streamlit/               # Konfigurasi Streamlit
    ├── app.py                    # Aplikasi Streamlit & integrasi Pinecone
    └── requirements.txt          # Dependensi library Python
```

---

## 🏛️ 1. Database MySQL - `perpustakaan_goodreads`

Folder [Mysql](file:///c:/Users/new%20user/OneDrive/%E3%83%89%E3%82%AD%E3%83%A5%E3%83%A1%E3%83%B3%E3%83%88/File%20repository%20github/Mysql) berisi skema database relasional (RDBMS) dan data dummy untuk sistem manajemen perpustakaan yang terinspirasi dari platform Goodreads.

### 📄 Berkas SQL
*   **[01_schema.sql](file:///c:/Users/new%20user/OneDrive/%E3%83%89%E3%82%AD%E3%83%A5%E3%83%A1%E3%83%B3%E3%83%88/File%20repository%20github/Mysql/01_schema.sql)**: Berisi skema DDL (Data Definition Language) untuk membuat database beserta tabel-tabel dan relasi *Foreign Key*.
*   **[02_dummy_data.sql](file:///c:/Users/new%20user/OneDrive/%E3%83%89%E3%82%AD%E3%83%A5%E3%83%A1%E3%83%B3%E3%83%88/File%20repository%20github/Mysql/02_dummy_data.sql)**: Berisi perintah DML (Data Manipulation Language) untuk mengisi tabel dengan contoh data awal.

### 📊 Relasi & Struktur Tabel
Skema relasional ini terdiri dari tabel-tabel berikut:

#### Tabel Master
1.  **`publisher`**: Menyimpan data penerbit buku.
    *   `publisher_id` (INT, PK, Auto Increment)
    *   `publisher_name` (VARCHAR)
2.  **`language`**: Menyimpan daftar bahasa buku beserta kodenya (misal: `eng`, `ind`).
    *   `language_id` (INT, PK, Auto Increment)
    *   `language_code` (VARCHAR), `language_name` (VARCHAR)
3.  **`author`**: Menyimpan data penulis buku.
    *   `author_id` (INT, PK, Auto Increment)
    *   `author_name` (VARCHAR)
4.  **`member`**: Menyimpan data anggota perpustakaan.
    *   `member_id` (INT, PK, Auto Increment)
    *   `member_name` (VARCHAR), `email` (VARCHAR), `phone` (VARCHAR)

#### Tabel Utama & Penghubung
1.  **`book`**: Menyimpan detail buku beserta referensi ke penerbit dan bahasa.
    *   `book_id` (INT, PK), `title` (VARCHAR), `isbn` (VARCHAR), `average_rating` (DECIMAL), `num_pages` (INT), `publication_date` (DATE)
    *   `publisher_id` (FK -> `publisher`), `language_id` (FK -> `language`)
2.  **`loan`**: Transaksi peminjaman buku oleh anggota.
    *   `loan_id` (INT, PK, Auto Increment)
    *   `member_id` (FK -> `member`), `book_id` (FK -> `book`), `loan_date` (DATE), `return_date` (DATE)
3.  **`book_author`**: Tabel penghubung relasi *Many-to-Many* antara Buku (`book`) dan Penulis (`author`).
    *   Composite PK: (`book_id`, `author_id`)

### 🚀 Cara Impor Database MySQL
Anda dapat mengimpor berkas SQL menggunakan MySQL Command Line Client atau aplikasi GUI seperti phpMyAdmin dan DBeaver.

#### Menggunakan Command Line (CLI)
1. Aktifkan server MySQL Anda.
2. Jalankan perintah di terminal untuk membuat skema database:
   ```bash
   mysql -u root -p < Mysql/01_schema.sql
   ```
3. Jalankan perintah berikut untuk mengisi data dummy:
   ```bash
   mysql -u root -p < Mysql/02_dummy_data.sql
   ```

#### Menggunakan phpMyAdmin
1. Buat database baru bernama `perpustakaan_goodreads`.
2. Klik tab **Import**, pilih berkas `01_schema.sql`, lalu jalankan (**Go**).
3. Setelah selesai, ulangi proses impor untuk berkas `02_dummy_data.sql`.

---

## 🍃 2. Database MongoDB - Koleksi Data Perpustakaan

Folder [MongoDb](file:///c:/Users/new%20user/OneDrive/%E3%83%89%E3%82%AD%E3%83%A5%E3%83%A1%E3%83%B3%E3%83%88/File%20repository%20github/MongoDb) berisi kumpulan dataset berformat JSON yang merepresentasikan database perpustakaan dalam model dokumen NoSQL.

### 📁 Koleksi JSON & Contoh Dokumen
1.  **[authors.json](file:///c:/Users/new%20user/OneDrive/%E3%83%89%E3%82%AD%E3%83%A5%E3%83%A1%E3%83%B3%E3%83%88/File%20repository%20github/MongoDb/authors.json)**: Menyimpan informasi penulis.
    ```json
    {
      "_id": { "$oid": "6a3a9d38d42975d5f38abfd5" },
      "author_id": "A001",
      "name": "J.K. Rowling",
      "country": "United Kingdom"
    }
    ```
2.  **[books.json](file:///c:/Users/new%20user/OneDrive/%E3%83%89%E3%82%AD%E3%83%A5%E3%83%A1%E3%83%B3%E3%83%88/File%20repository%20github/MongoDb/books.json)**: Koleksi data buku (Strukturnya saat ini serupa dengan data authors).
3.  **[publishers.json](file:///c:/Users/new%20user/OneDrive/%E3%83%89%E3%82%AD%E3%83%A5%E3%83%A1%E3%83%B3%E3%83%88/File%20repository%20github/MongoDb/publishers.json)**: Menyimpan data penerbit.
    ```json
    {
      "_id": { "$oid": "6a3a9d38d42975d5f38abfda" },
      "publisher_id": "P001",
      "name": "Bloomsbury"
    }
    ```
4.  **[reviews.json](file:///c:/Users/new%20user/OneDrive/%E3%83%89%E3%82%AD%E3%83%A5%E3%83%A1%E3%83%B3%E3%83%88/File%20repository%20github/MongoDb/reviews.json)**: Ulasan dari pengguna terhadap buku tertentu.
    ```json
    {
      "_id": { "$oid": "6a3a9d38d42975d5f38abfe5" },
      "user_id": "U001",
      "book_id": 1,
      "rating": 5,
      "review": "Excellent fantasy novel"
    }
    ```
5.  **[users.json](file:///c:/Users/new%20user/OneDrive/%E3%83%89%E3%82%AD%E3%83%A5%E3%83%A1%E3%83%B3%E3%83%88/File%20repository%20github/MongoDb/users.json)**: Profil pengguna perpustakaan.
    ```json
    {
      "_id": { "$oid": "6a3a9d38d42975d5f38abfe2" },
      "user_id": "U001",
      "name": "Virginia"
    }
    ```

### 🚀 Cara Impor ke MongoDB
Data JSON dapat dimasukkan ke database lokal atau MongoDB Atlas menggunakan `mongoimport` CLI atau antarmuka MongoDB Compass.

#### Menggunakan `mongoimport` (CLI)
Pastikan MongoDB Database Tools telah terinstal di komputer Anda. Jalankan perintah ini dari direktori root proyek:
```bash
# Mengimpor seluruh koleksi ke database 'perpustakaan_goodreads'
mongoimport --db perpustakaan_goodreads --collection authors --file MongoDb/authors.json --jsonArray
mongoimport --db perpustakaan_goodreads --collection books --file MongoDb/books.json --jsonArray
mongoimport --db perpustakaan_goodreads --collection publishers --file MongoDb/publishers.json --jsonArray
mongoimport --db perpustakaan_goodreads --collection reviews --file MongoDb/reviews.json --jsonArray
mongoimport --db perpustakaan_goodreads --collection users --file MongoDb/users.json --jsonArray
```

#### Menggunakan MongoDB Compass (GUI)
1. Hubungkan Compass ke instance MongoDB Anda.
2. Buat database baru bernama `perpustakaan_goodreads`.
3. Buat koleksi baru (misalnya `authors`).
4. Klik **Add Data** -> **Import JSON or CSV file**, lalu pilih berkas `MongoDb/authors.json` dan klik **Import**.
5. Ulangi untuk koleksi lainnya.

---

## 🔍 3. Vektor - Pencarian Artikel Semantik (Pinecone & Streamlit)

Folder [vektor](file:///c:/Users/new%20user/OneDrive/%E3%83%89%E3%82%AD%E3%83%A5%E3%83%A1%E3%83%B3%E3%83%88/File%20repository%20github/vektor) berisi proyek pencarian semantik (*semantic search*) berbasis AI yang memanfaatkan Pinecone Vector Database, model NLP Sentence Transformers (`all-MiniLM-L6-v2`), dan web interface Streamlit.

### 🌟 Fitur Utama
*   **Pencarian Semantik**: Mencari dokumen berdasarkan kesamaan konteks/makna kalimat menggunakan skor kemiripan kosinus (*cosine similarity*), bukan sekadar pencarian kata kunci literal.
*   **Vektorisasi Otomatis**: Memanfaatkan model `all-MiniLM-L6-v2` berdimensi 384 yang cepat dan akurat.
*   **Integrasi Pinecone Serverless**: Mengunggah (*upsert*) representasi vektor artikel ke cloud database Pinecone secara realtime.
*   **Antarmuka Interaktif**: Dibuat menggunakan Streamlit untuk mempermudah pencarian artikel.

### ⚙️ Instalasi & Menjalankan Aplikasi

> [!NOTE]
> Proyek ini memerlukan Python versi 3.8 ke atas.

#### 1. Instalasi Dependensi
Arahkan terminal ke folder `vektor` atau dari root jalankan instalasi *requirements*:
```bash
pip install -r vektor/requirements.txt
```

#### 2. Konfigurasi API Key Pinecone
API Key Pinecone dikonfigurasi langsung di dalam berkas **[app.py](file:///c:/Users/new%20user/OneDrive/%E3%83%89%E3%82%AD%E3%83%A5%E3%83%A1%E3%83%B3%E3%83%88/File%20repository%20github/vektor/app.py)** pada baris:
```python
PINECONE_API_KEY = "pcsk_..."
```
*(Disarankan menggunakan environment variables atau Streamlit Secrets untuk mode produksi).*

#### 3. Menjalankan Server Streamlit
Jalankan perintah berikut di terminal:
```bash
streamlit run vektor/app.py
```
Aplikasi secara otomatis akan terbuka pada browser Anda di alamat default `http://localhost:8501`.

### 📖 Cara Kerja Pencarian Vektor
1.  **Inisialisasi Indeks**: Sistem mendeteksi keberadaan indeks Pinecone `artikel-index`. Jika belum ada, sistem akan membuatnya dengan parameter metrik *cosine similarity* dan 384 dimensi.
2.  **Proses Upsert**: Dokumen artikel bawaan akan dikonversi menjadi embedding vektor lalu dikirim ke database Pinecone.
3.  **Kueri & Pencarian**: Saat pengguna memasukkan input pencarian, query akan di-embed ke dalam bentuk vektor, dikirim ke Pinecone untuk dicocokkan, dan 5 hasil dengan kemiripan tertinggi akan ditampilkan beserta *similarity score*-nya.

---

Semoga dokumentasi terpadu ini membantu mempermudah eksplorasi dan pengembangan sistem basis data di repositori ini!
