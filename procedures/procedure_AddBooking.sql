USE littlelemondb;

DELIMITER // 
CREATE PROCEDURE AddBooking (IN booking_id_insert INT, 
							 IN customer_id_insert INT,  
                             IN table_number_insert INT, 
                             IN booking_date_insert TIMESTAMP,  
                             IN staff_id_insert INT)
BEGIN                             
    INSERT INTO bookings(id, 
						customer_id, 
                        table_number, 
                        booking_date,  
                        staff_id) 
			VALUES
					(booking_id_insert, 
                     customer_id_insert, 
                     table_number_insert, 
                     booking_date_insert, 
                     staff_id_insert);
	SELECT CONCAT('Booking completed successfully - table ', table_number_insert, ' is now booked') AS "Booking status";
END // 

DELIMITER ;

CALL AddBooking(9, 3, 4, '2022-12-30 15:00', 3);