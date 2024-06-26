USE littlelemondb;

CREATE VIEW OrdersView AS
	(SELECT id AS order_id,
		    quantity,
			total_cost
	FROM orders
	WHERE quantity > 2);

SELECT *
FROM OrdersView;