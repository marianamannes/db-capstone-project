USE littlelemondb;

DELIMITER // 
CREATE PROCEDURE UpdateBooking (IN booking_id_update INT, 
                                IN booking_date_update TIMESTAMP)
BEGIN                           
     
    UPDATE bookings
    SET booking_date = booking_date_update
    WHERE id = booking_id_update;
    
	SELECT CONCAT('Booking ', booking_id_update, ' updated successfully') AS "Confirmation";
    
END // 

DELIMITER ;

CALL UpdateBooking(9, '2022-12-17 13:00')