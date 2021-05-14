SELECT	p2.store_id, p4.name, count(*)
FROM	rental p1, inventory p2, film_category p3, category p4
WHERE	p1.inventory_id = p2.inventory_id AND
	p2.film_id = p3.film_id AND
	p3.category_id = p4.category_id
GROUP BY p2.store_id, p4.name
HAVING	count(*) > 500
ORDER BY store_id, count(*) DESC;
