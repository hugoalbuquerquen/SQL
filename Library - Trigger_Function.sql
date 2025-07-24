SELECT * FROM books LIMIT 5


CREATE OR REPLACE FUNCTION update_book_quantity_func()
    RETURNS TRIGGER
	AS 
$BODY$
	BEGIN
		IF EXISTS (SELECT 1 FROM books_rentals WHERE isbn_book = NEW.isbn_book AND id_customer = NEW.id_customer AND rental_date = NEW.rental_date AND is_rented = true) THEN
			IF (SELECT out_rented FROM books_rentals WHERE id = NEW.id) IS FALSE THEN
				
				UPDATE books
				SET quantity = quantity + 1
				WHERE isbn = NEW.isbn_book;
	
				UPDATE books_rentals
				SET return_date = CURRENT_DATE
				WHERE id = NEW.id;

			ELSE
				IF (SELECT quantity FROM books WHERE isbn = NEW.isbn_book) > 0 THEN
					UPDATE books
					SET quantity = quantity - 1
					WHERE isbn = NEW.isbn_book;
				ELSE
					RAISE EXCEPTION 'Sorry. No copies available.';
				END IF;
			END IF;

		ELSE
			RAISE EXCEPTION 'Can''t return a book that wasn''t rented.';

		END IF;
		RETURN NEW;
	END;
$BODY$
LANGUAGE PLPGSQL;

CREATE TRIGGER update_book_quantity_trig
AFTER INSERT ON books_rentals
FOR EACH ROW
EXECUTE FUNCTION update_book_quantity_func();
