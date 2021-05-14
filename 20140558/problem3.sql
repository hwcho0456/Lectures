SELECT	p1.film_id, p1.title, count(*)
FROM	film p1, inventory p2, rental p3
WHERE	p1.film_id = p2.film_id AND
	p2.inventory_id = p3.inventory_id AND
	unix_timestamp(p3.rental_date) >= unix_timestamp('2005.06.01') AND
      	unix_timestamp(p3.rental_date) <= unix_timestamp('2005.08.31') 
GROUP BY p1.film_id
HAVING	count(*) > 26
ORDER BY count(*) DESC;
