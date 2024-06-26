USE littlelemondb;

SELECT c.id AS customer_id,
	   c.name as customer_name,
	   o.id AS order_id,
	   o.total_cost,
	   m.name AS menu_name,
       mi.course_name,
       mi.starter_name
FROM orders o 
LEFT JOIN customers c ON o.customer_id = c.id
LEFT JOIN menu m ON o.menu_id = m.id
LEFT JOIN menu_items mi ON m.menu_item_id = mi.id
WHERE total_cost > 150
ORDER BY total_cost;
