WITH avgKeep AS (
SELECT avg(num) 
FROM (	SELECT	film_id, count(*) AS 'num'
	FROM	inventory
	GROUP BY film_id ) p1
),
filmOveravg AS (
SELECT	p1.film_id
FROM	inventory p1
GROUP BY p1.film_id
HAVING	count(*) > (SELECT * FROM avgKeep)
)
SELECT	p2.film_id, count(*)
FROM	rental p1, inventory p2, filmOveravg p3
WHERE	p1.inventory_id = p2.inventory_id AND
	p2.film_id = p3.film_id
GROUP BY p2.film_id
HAVING	count(*) >= 30
ORDER BY p2.film_id;
