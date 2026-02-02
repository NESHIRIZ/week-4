-- =========================================
-- STEP 0: RESET EVERYTHING
-- =========================================
DROP DATABASE IF EXISTS library_db;

-- =========================================
-- STEP 1: CREATE DATABASE
-- =========================================
CREATE DATABASE library_db;
USE library_db;

-- =========================================
-- STEP 2: CREATE PARENT TABLES
-- =========================================

CREATE TABLE Authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birth_year INT
);

CREATE TABLE Members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    join_date DATE NOT NULL
);

-- =========================================
-- STEP 3: INSERT PARENT DATA
-- =========================================

INSERT INTO Authors (first_name, last_name, birth_year) VALUES
('J.K.', 'Rowling', 1965),
('George', 'Orwell', 1903),
('Jane', 'Austen', 1775);

INSERT INTO Members (first_name, last_name, email, join_date) VALUES
('John', 'Doe', 'john.doe@example.com', '2025-01-01'),
('Mary', 'Smith', 'mary.smith@example.com', '2025-01-15');

-- =========================================
-- STEP 4: CREATE CHILD TABLES
-- =========================================

CREATE TABLE Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    genre VARCHAR(50),
    published_year INT,
    author_id INT NOT NULL,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);

CREATE TABLE Borrowings (
    borrow_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    member_id INT NOT NULL,
    borrow_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
);

-- =========================================
-- STEP 5: INSERT CHILD DATA
-- =========================================

INSERT INTO Books (title, genre, published_year, author_id) VALUES
('Harry Potter and the Sorcerer''s Stone', 'Fantasy', 1997, 1),
('1984', 'Dystopian', 1949, 2),
('Pride and Prejudice', 'Romance', 1813, 3);

INSERT INTO Borrowings (book_id, member_id, borrow_date, return_date) VALUES
(1, 1, '2026-01-10', '2026-01-20'),
(2, 2, '2026-01-12', '2026-01-22');

-- =========================================
-- STEP 6: CRUD OPERATIONS
-- =========================================

INSERT INTO Members (first_name, last_name, email, join_date)
VALUES ('Alice', 'Johnson', 'alice.johnson@example.com', '2026-01-25');

UPDATE Books
SET title = 'Harry Potter and the Philosopher''s Stone'
WHERE book_id = 1;

DELETE FROM Borrowings
WHERE borrow_id = 2;

-- =========================================
-- STEP 7: FINAL OUTPUT
-- =========================================

SELECT * FROM Authors;
SELECT * FROM Members;
SELECT * FROM Books;
SELECT * FROM Borrowings;

SELECT 
    m.first_name AS member_first,
    m.last_name AS member_last,
    b.title AS book_title,
    a.first_name AS author_first,
    a.last_name AS author_last,
    br.borrow_date,
    br.return_date
FROM Borrowings br
JOIN Members m ON br.member_id = m.member_id
JOIN Books b ON br.book_id = b.book_id
JOIN Authors a ON b.author_id = a.author_id;