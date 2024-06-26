USE littlelemondb;

PREPARE GetOrderDetail FROM 'SELECT id, 
								    quantity, 
								    total_cost
							 FROM orders
							 WHERE customer_id = ?';

SET @id = 1;
EXECUTE GetOrderDetail USING @id;