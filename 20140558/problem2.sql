WITH storeFilmless5 AS (
SELECT	p1.store_id, p1.film_id, count(*)
FROM	inventory p1, rental p2
WHERE	p1.inventory_id	= p2.inventory_id
GROUP BY p1.store_id, p1.film_id
HAVING	count(*) < 5
)
SELECT	store_id, count(*)
FROM	storeFilmless5
GROUP BY store_id;
