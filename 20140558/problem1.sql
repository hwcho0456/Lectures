SELECT	p1.category_id, p2.actor_id, count(*)
FROM	film_category p1, film_actor p2
WHERE	p1.film_id = p2.film_id
GROUP BY p1.category_id, p2.actor_id
HAVING	count(*) > 5;
