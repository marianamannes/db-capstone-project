USE littlelemondb;

DELIMITER // 

CREATE PROCEDURE AddValidBooking(IN booking_date_insert TIMESTAMP, IN table_number_insert INT, customer_id_insert INT, staff_id_insert INT)
BEGIN
    DECLARE table_count INT;
    
    SELECT COUNT(*) INTO @table_count
    FROM bookings
    WHERE CAST(booking_date AS date) = CAST(booking_date_insert AS date) AND
		  table_number = table_number_insert;
          
	START TRANSACTION;
    IF (@table_count > 0)
		THEN ROLLBACK;
			SELECT CONCAT('Table ', table_number_insert, ' is already booked - booking cancelled') AS "Booking status";
	ELSE
		INSERT INTO bookings(customer_id, staff_id, booking_date, table_number) VALUES
					(customer_id_insert, staff_id_insert, booking_date_insert, table_number_insert);
		COMMIT;
		SELECT CONCAT('Booking completed successfully - table ', table_number_insert, ' is now booked') AS "Booking status";
	END IF;
    
END // 

DELIMITER ;

CALL AddValidBooking('2023-01-01 15:00', 5, 1, 4);
CALL AddValidBooking('2023-01-01 15:00', 4, 1, 4);
