USE littlelemondb;

DELIMITER // 
CREATE PROCEDURE CancelBooking  (IN booking_id_cancel INT)
BEGIN                             
    DELETE FROM bookings
    WHERE id = booking_id_cancel;
	SELECT CONCAT('Booking ', booking_id_cancel, ' is cancelled') AS "Confirmation";
END // 

DELIMITER ;

CALL CancelBooking(9);