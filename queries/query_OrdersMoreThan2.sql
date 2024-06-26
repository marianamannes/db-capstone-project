USE littlelemondb;

SELECT m.id AS menu_id,
	   c.name AS cuisine_name,
       m.name AS menu_name
FROM menu m 
LEFT JOIN cuisines c ON m.cuisine_id = c.id
WHERE m.id = ANY (SELECT menu_id FROM orders GROUP BY menu_id HAVING COUNT(*) > 2);