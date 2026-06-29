import streamlit as st
from pinecone import Pinecone, ServerlessSpec
from sentence_transformers import SentenceTransformer

# ==================================================
# KONFIGURASI PINECONE
# ==================================================
PINECONE_API_KEY = "pcsk_586sC9_N2E93NhLH9fCV5U1hBmqVZnNYYwxtYeKiUqfqauN3xLmJAiuSKE7RrYu6Gqudzt"

pc = Pinecone(api_key=PINECONE_API_KEY)

# ==================================================
# MODEL EMBEDDING GRATIS
# ==================================================
model = SentenceTransformer("all-MiniLM-L6-v2")

INDEX_NAME = "artikel-index"

# ==================================================
# MEMBUAT INDEX JIKA BELUM ADA
# ==================================================
if INDEX_NAME not in pc.list_indexes().names():
    pc.create_index(
        name=INDEX_NAME,
        dimension=384,
        metric="cosine",
        spec=ServerlessSpec(
            cloud="aws",
            region="us-east-1"
        )
    )

index = pc.Index(INDEX_NAME)

# ==================================================
# DATA ARTIKEL
# ==================================================
artikel = [
    ("1", "Perkembangan AI Kecerdasan buatan berkembang pesat dalam berbagai bidang industri."),
    ("2", "Belajar Python Python adalah bahasa pemrograman yang mudah dipelajari."),
    ("3", "Kesehatan Jantung Menjaga pola makan penting untuk kesehatan jantung."),
    ("4", "Olahraga Pagi Olahraga di pagi hari membantu meningkatkan energi."),
    ("5", "Blockchain Blockchain digunakan untuk keamanan data."),
    ("6", "E-learning Pendidikan online memudahkan belajar."),
    ("7", "Diet Sehat Makanan bergizi penting untuk tubuh."),
    ("8", "Sepak Bola Olahraga paling populer di dunia."),
    ("9", "Cloud Computing Penyimpanan data online."),
    ("10", "Machine Learning Komputer belajar dari data."),
    ("11", "Air Putih Penting untuk hidrasi tubuh."),
    ("12", "Basket Strategi permainan berkembang."),
    ("13", "Cyber Security Melindungi data pribadi."),
    ("14", "SQL Database relasional."),
    ("15", "Yoga Mengurangi stres."),
    ("16", "Big Data Analisis data besar."),
    ("17", "Renang Melatih seluruh tubuh."),
    ("18", "IoT Perangkat terhubung internet."),
    ("19", "Java Bahasa enterprise."),
    ("20", "Mental Health Penting untuk kesejahteraan.")
]

# ==================================================
# FUNGSI EMBEDDING
# ==================================================
def get_embedding(text):
    return model.encode(text).tolist()

# ==================================================
# INSERT DATA KE PINECONE
# ==================================================
if "uploaded" not in st.session_state:

    vectors = []

    for doc_id, text in artikel:
        vectors.append(
            {
                "id": doc_id,
                "values": get_embedding(text),
                "metadata": {
                    "text": text
                }
            }
        )

    index.upsert(vectors=vectors)

    st.session_state.uploaded = True

# ==================================================
# TAMPILAN STREAMLIT
# ==================================================
st.title("🔍 Pencarian Artikel dengan Pinecone")

st.write(
    "Masukkan kata kunci untuk mencari artikel yang relevan."
)

query = st.text_input("Masukkan kata kunci")

if st.button("Cari"):

    if query.strip():

        query_embedding = get_embedding(query)

        result = index.query(
            vector=query_embedding,
            top_k=5,
            include_metadata=True
        )

        st.subheader("Hasil Pencarian")

        for match in result.matches:
            st.write(f"📄 {match.metadata['text']}")
            st.write(f"Similarity Score: {match.score:.4f}")
            st.divider()

    else:
        st.warning("Masukkan kata kunci terlebih dahulu.")