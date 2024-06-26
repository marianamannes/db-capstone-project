USE littlelemondb;

DELIMITER // 
CREATE PROCEDURE CancelOrder(IN order_id INT)
BEGIN
	DELETE 
    FROM orders
    WHERE id = order_id;
    SELECT CONCAT("Order ",order_id, " is cancelled.") AS Confirmation;
END // 

DELIMITER ;

CALL CancelOrder(5);
