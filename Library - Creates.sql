CREATE TABLE publishers(
	pb_name VARCHAR(200) PRIMARY KEY,
	country VARCHAR(200)
);

CREATE TABLE books(
	isbn VARCHAR(20) PRIMARY KEY,
	title VARCHAR(200) NOT NULL,
	genre VARCHAR(200),
	langua VARCHAR(200),
	quantity INT NOT NULL,
	pb_name VARCHAR(200) REFERENCES publishers(pb_name)
);

CREATE TABLE authors(
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(100),
	last_name VARCHAR(100),
	UNIQUE (first_name, last_name)
);

CREATE TABLE books_authors(
	isbn_book VARCHAR(20) REFERENCES books(isbn),
	id_author INT REFERENCES authors(id),
	UNIQUE (isbn_book, id_author)
);

CREATE TABLE customers(
	id SERIAL PRIMARY KEY,
	name VARCHAR(200) NOT NULL,
	email VARCHAR(200) NOT NULL
);

CREATE TABLE books_rentals(
	id SERIAL UNIQUE,
	isbn_book VARCHAR(20) REFERENCES books(isbn),
	id_customer INT REFERENCES customers(id),
	rental_date DATE DEFAULT CURRENT_DATE,
	due_date DATE DEFAULT (CURRENT_DATE + INTERVAL '15 days'),
	return_date DATE DEFAULT NULL,
	is_rented BOOLEAN NOT NULL,
	UNIQUE (isbn_book, id_customer, rental_date, is_rented)
);
