File ini berisi kueri pengisian data (insert) untuk seluruh tabel yang telah dibuat pada file skema di atas
.
-- Penginputan Data Publisher
INSERT INTO publisher (publisher_name) VALUES
('Scholastic'),
('Penguin Books'),
('Bloomsbury'),
('Vintage'),
('HarperCollins'),
('Oxford Press'),
('Pearson'),
('Gramedia'),
('Mizan'),
('Erlangga');

-- Penginputan Data Language
INSERT INTO language (language_code, language_name) VALUES
('eng','English'),
('ind','Indonesian'),
('spa','Spanish'),
('fra','French'),
('ger','German'),
('ita','Italian'),
('por','Portuguese'),
('jpn','Japanese'),
('kor','Korean'),
('chi','Chinese');

-- Penginputan Data Author
INSERT INTO author (author_name) VALUES
('J.K. Rowling'),
('George Orwell'),
('Paulo Coelho'),
('Stephen King'),
('Dan Brown'),
('John Green'),
('Tere Liye'),
('Andrea Hirata'),
('Pramoedya Ananta Toer'),
('Dee Lestari');

-- Penginputan Data Member
INSERT INTO member (member_name,email,phone) VALUES
('Andi Saputra','andi@gmail.com','0811111111'),
('Budi Santoso','budi@gmail.com','0811111112'),
('Citra Lestari','citra@gmail.com','0811111113'),
('Dewi Anggraini','dewi@gmail.com','0811111114'),
('Eko Prasetyo','eko@gmail.com','0811111115'),
('Farah Putri','farah@gmail.com','0811111116'),
('Gilang Ramadhan','gilang@gmail.com','0811111117'),
('Hani Nuraini','hani@gmail.com','0811111118'),
('Indra Wijaya','indra@gmail.com','0811111119'),
('Joko Susanto','joko@gmail.com','0811111120');

-- Penginputan Data Book
INSERT INTO book (book_id,title,isbn,average_rating,num_pages,publication_date,ratings_count,text_reviews_count,publisher_id,language_id) VALUES
(1,'Harry Potter and the Sorcerer''s Stone','9780439708180',4.57,309,'1997-06-26',8654321,140235,1,1),
(2,'Animal Farm','9780451526342',3.98,122,'1945-08-17',3456789,75342,2,1),
(3,'The Alchemist','9780061122415',4.10,208,'1988-05-01',5678901,95432,2,1),
(4,'The Shining','9780307743657',4.24,447,'1977-01-28',1456789,40321,4,1),
(5,'Inferno','9781400079155',3.95,480,'2013-05-14',934567,28765,5,1),
(6,'The Fault in Our Stars','9780525478812',4.18,313,'2012-01-10',4897654,124563,5,1),
(7,'Bumi','9786020332956',4.60,440,'2014-02-10',120345,6521,8,2),
(8,'Laskar Pelangi','9789793062792',4.55,529,'2005-09-01',210432,9876,8,2),
(9,'Bumi Manusia','9789799731234',4.70,535,'1980-01-01',187654,8543,10,2),
(10,'Supernova','9789799625717',4.40,320,'2001-04-01',154321,6321,9,2);

-- Penginputan Data Book_Author
INSERT INTO book_author (book_id,author_id) VALUES
(1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10);

-- Penginputan Data Loan
INSERT INTO loan (member_id,book_id,loan_date,return_date) VALUES
(1,1,'2026-01-01','2026-01-08'),
(2,2,'2026-01-02','2026-01-09'),
(3,3,'2026-01-03','2026-01-10'),
(4,4,'2026-01-04','2026-01-11'),
(5,5,'2026-01-05','2026-01-12'),
(6,6,'2026-01-06','2026-01-13'),
(7,7,'2026-01-07','2026-01-14'),
(8,8,'2026-01-08','2026-01-15'),
(9,9,'2026-01-09','2026-01-16'),
(10,10,'2026-01-10','2026-01-17');