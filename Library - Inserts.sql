INSERT INTO publishers
VALUES ('publisher_name', 'publisher_country');

INSERT INTO books
VALUES ('0000000000', 'book_title', 'book_genre(s)', 'book_language', 0, 'publisher_name');

INSERT INTO authors (first_name, last_name)
VALUES ('author_first_name', 'author_last_name');

INSERT INTO books_authors
VALUES ('0000000000', 1);
-- VALUES (book_isbn, id_author)

INSERT INTO customers (name, email)
VALUES ('customer_name', 'customer_email@null.com');

INSERT INTO books_rentals (isbn_book, id_customer, is_rented)
VALUES ('0000000000', 1, TRUE);
