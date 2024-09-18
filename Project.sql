create database library;
use library;

CREATE TABLE books (
    id INT PRIMARY KEY,
    title VARCHAR(255),
    author VARCHAR(255),
    publication_date DATE,
    ISBN VARCHAR(13)
);

-- Authors Table
CREATE TABLE authors (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    biography TEXT
);

-- Publishers Table
CREATE TABLE publishers (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    address VARCHAR(255)
);

-- Genres Table
CREATE TABLE genres (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    description TEXT
);

-- Book_Genres Table
CREATE TABLE book_genres (
    id INT PRIMARY KEY,
    book_id INT,
    genre_id INT,
    FOREIGN KEY (book_id) REFERENCES books(id),
    FOREIGN KEY (genre_id) REFERENCES genres(id)
);

-- Insert data into books table
INSERT INTO books (id, title, author, publication_date, ISBN)
VALUES
(1, 'To Kill a Mockingbird', 'Harper Lee', '1960-07-11', '9780061120084'),
(2, '1984', 'George Orwell', '1949-06-08', '9780451524935'),
(3, 'The Great Gatsby', 'F. Scott Fitzgerald', '1925-04-10', '9780743273565'),
(4, 'Pride and Prejudice', 'Jane Austen', '1813-01-28', '9780141439511');

-- Insert data into authors table
INSERT INTO authors (id, name, biography)
VALUES
(1, 'Harper Lee', 'Harper Lee was an American novelist known for her Pulitzer Prize-winning novel, To Kill a Mockingbird.'),
(2, 'George Orwell', 'George Orwell was a British novelist and critic known for his dystopian novel, 1984.'),
(3, 'F. Scott Fitzgerald', 'F. Scott Fitzgerald captured the essence of the Jazz Age.'),
(4, 'Jane Austen', 'Jane Austen was an English novelist known for works like Pride and Prejudice.');

-- Insert data into publishers table
INSERT INTO publishers (id, name, address)
VALUES
(1, 'J.B. Lippincott & Co.', 'Philadelphia, PA'),
(2, 'Secker and Warburg', 'London, UK'),
(3, 'Charles Scribner\'s Sons', 'New York, NY'),
(4, 'T. Egerton', 'London, UK');

-- Insert data into genres table
INSERT INTO genres (id, name, description)
VALUES
(1, 'Fiction', 'Novels and short stories that are not based on real events.'),
(2, 'Classics', 'Literature of high importance and influence.');

-- Insert data into book_genres table
INSERT INTO book_genres (id, book_id, genre_id)
VALUES
(1, 1, 2), -- To Kill a Mockingbird is a Classic
(2, 2, 1), -- 1984 is Fiction
(3, 3, 2); -- The Great Gatsby is a Classic



-- Create patrons table
CREATE TABLE patrons (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255),
    phone_number VARCHAR(15),
    address VARCHAR(255)
);

-- Create membership_types table
CREATE TABLE membership_types (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    description TEXT,
    duration INT
);

-- Create patron_membership table
CREATE TABLE patron_membership (
    id INT PRIMARY KEY,
    patron_id INT,
    membership_type_id INT,
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (patron_id) REFERENCES patrons(id),
    FOREIGN KEY (membership_type_id) REFERENCES membership_types(id)
);

-- Create patron_fines table
CREATE TABLE patron_fines (
    id INT PRIMARY KEY,
    patron_id INT,
    fine_amount DECIMAL(5, 2),
    fine_date DATE,
    FOREIGN KEY (patron_id) REFERENCES patrons(id)
);

-- Create patron_payments table
CREATE TABLE patron_payments (
    id INT PRIMARY KEY,
    patron_id INT,
    payment_amount DECIMAL(5, 2),
    payment_date DATE,
    FOREIGN KEY (patron_id) REFERENCES patrons(id)
);

INSERT INTO patrons values(1, "John Doe", "johndoe@example.com", "123-456-7890", "123 Main St"),
(2, "Jane Smith", "janesmith@example.com", "987-654-3210", "456 Elm St"),
(3, "Bob Johnson", "bobjohnson@example.com", "555-123-4567", "789 Oak St");

INSERT INTO patrons values(4, "Alice Brown", "alicebrown@example.com", "111-222-3333", "321 Maple St"),
(5, "Mike Davis", "mikedavis@example.com", "444-555-6666", "901 Pine St");

INSERT INTO membership_types values(1, "Basic", "Access to library materials for 1 year", 365),
 (2, "Premium", "Access to library materials, digital media, and special events for 1 year", 365),
(3, "Student", "Access to library materials for 6 months", 180),
(4, "Senior", "Access to library materials for 1 year, with discounts on programs and services", 365),
(5, "Family", "Access to library materials for 1 year, for up to 5 family members", 365);

insert into patron_membership values(1, 1, 1, "2022-01-01", "2023-01-01"),
(2, 2, 2, "2022-06-01", "2023-06-01"),
(3, 3, 3, "2022-09-01", "2023-03-01"),
 (4, 4, 4, "2022-03-01", "2023-03-01"),
 (5, 5, 5, "2022-12-01", "2023-12-01");

insert into patron_fines values(1, 1, 5.00, "2022-02-01"),
 (2, 2, 10.00, "2022-07-01"),
(3, 3, 2.00, "2022-10-01"),
(4, 4, 8.00, "2022-04-01"),
(5, 5, 12.00, "2022-11-01");

insert into patron_payments values(1, 1, 20.00, "2022-01-15"),
(2, 2, 50.00, "2022-06-15"),
(3, 3, 15.00, "2022-09-15"),
(4, 4, 30.00, "2022-03-15"),
(5, 5, 60.00, "2022-12-15");


-- Create checkouts table
CREATE TABLE checkouts (
    id INT PRIMARY KEY,
    book_id INT,
    patron_id INT,
    checkout_date DATE,
    due_date DATE,
    FOREIGN KEY (book_id) REFERENCES books(id),
    FOREIGN KEY (patron_id) REFERENCES patrons(id)
);

-- Create returns table
CREATE TABLE returns (
    id INT PRIMARY KEY,
    checkout_id INT,
    return_date DATE,
    FOREIGN KEY (checkout_id) REFERENCES checkouts(id)
);

-- Create holds table
CREATE TABLE holds (
    id INT PRIMARY KEY,
    book_id INT,
    patron_id INT,
    hold_date DATE,
    expiration_date DATE,
    FOREIGN KEY (book_id) REFERENCES books(id),
    FOREIGN KEY (patron_id) REFERENCES patrons(id)
);

-- Create waitlists table
CREATE TABLE waitlists (
    id INT PRIMARY KEY,
    book_id INT,
    patron_id INT,
    waitlist_date DATE,
    FOREIGN KEY (book_id) REFERENCES books(id),
    FOREIGN KEY (patron_id) REFERENCES patrons(id)
);

-- Create checkout_history table
CREATE TABLE checkout_history (
    id INT PRIMARY KEY,
    book_id INT,
    patron_id INT,
    checkout_date DATE,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES books(id),
    FOREIGN KEY (patron_id) REFERENCES patrons(id)
);


-- Insert data into checkouts table
INSERT INTO checkouts (id, book_id, patron_id, checkout_date, due_date)
VALUES
(1, 1, 1, '2022-01-01', '2022-01-31');

-- Insert data into returns table
INSERT INTO returns (id, checkout_id, return_date)
VALUES
(1, 1, '2022-01-20');

-- Insert data into holds table
INSERT INTO holds (id, book_id, patron_id, hold_date, expiration_date)
VALUES
(1, 1, 2, '2022-01-05', '2022-01-15');

-- Insert data into waitlists table
INSERT INTO waitlists (id, book_id, patron_id, waitlist_date)
VALUES
(1, 1, 3, '2022-01-10');


insert into checkout_history(id,book_id, patron_id, checkout_date,return_date )
values(1, 1, 1, "2022-01-01", "2022-01-20"),
(2, 2, 2, "2022-02-01", "2022-02-15"),
(3, 3, 3, "2022-03-01", "2022-03-25"),
(4, 4, 4, "2022-04-01", "2022-04-10"),
(5, 5, 5, "2022-05-01", "2022-05-15");




CREATE TABLE orders (
    id INT PRIMARY KEY,
    book_id INT,
    quantity INT,
    order_date DATE,
    total_cost DECIMAL(10, 2),
    FOREIGN KEY (book_id) REFERENCES books(id)
);

insert into orders values((1,1,5,"2022-01-01",100.00),
(2,2,10,"2022-02-01",200.00),
(3,3,3,"2022-03-01",75.00),
(4,4,8,"2022-04-01",160.00),
(5,5,12,"2022-05-01",300.00);


CREATE TABLE vendors (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    address VARCHAR(255),
    contact_info VARCHAR(255)
);

CREATE TABLE order_items (
    id INT PRIMARY KEY,
    order_id INT,
    book_id INT,
    quantity INT,
    cost DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (book_id) REFERENCES books(id)
);

CREATE TABLE receipts (
    id INT PRIMARY KEY,
    order_id INT,
    receipt_date DATE,
    total_cost DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES orders(id)
);

CREATE TABLE invoices (
    id INT PRIMARY KEY,
    order_id INT,
    invoice_date DATE,
    total_cost DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES orders(id)
);

CREATE TABLE circulation_stats (
    id INT PRIMARY KEY,
    date DATE,
    total_checkouts INT,
    total_returns INT
);

CREATE TABLE patron_stats (
    id INT PRIMARY KEY,
    date DATE,
    total_patrons INT,
    total_membership INT
);

CREATE TABLE survey_responses (
    id INT PRIMARY KEY,
    date DATE,
    question_id INT,
    response_text TEXT
);

