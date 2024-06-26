USE littlelemondb;

DELIMITER // 
CREATE PROCEDURE CheckBooking(IN booking_date_check DATE, IN table_number_check INT)
BEGIN
    DECLARE table_count INT;
    
    SELECT COUNT(*) INTO @table_count
    FROM bookings
    WHERE CAST(booking_date AS date) = booking_date_check AND
		  table_number = table_number_check;
          
    IF (@table_count > 0)
		THEN 
			SELECT CONCAT('Table ', table_number_check, ' is already booked') AS "Booking status";
		ELSE
			SELECT CONCAT('Table ', table_number_check, ' is not booked') AS "Booking status";
	END IF;
    
END // 

DELIMITER ;

CALL CheckBooking('2023-01-01', 1);
