WITH prolificActor AS (
SELECT	actor_id
FROM	film_actor
GROUP BY actor_id
HAVING count(*) > 30
),
R AS (
SELECT	p1.customer_id, p2.film_id
FROM	rental p1, inventory p2
WHERE	p1.inventory_id = p2.inventory_id
GROUP BY p1.customer_id, p2.film_id
),
S AS (
SELECT	p1.film_id
FROM	film p1, film_actor p2, prolificActor p3
WHERE	p1.film_id >= 10 AND
	p1.film_id < 20 AND
	p1.rental_rate > 4 AND
	p1.film_id = p2.film_id AND
	p2.actor_id = p3.actor_id
GROUP BY p1.film_id
),
customerID AS (
SELECT	DISTINCT r1.customer_id
FROM	R r1
WHERE	NOT EXISTS(
	SELECT	*
	FROM	S s
	WHERE	NOT EXISTS(
		SELECT	*
		FROM	R r2
		WHERE	r2.customer_id = r1.customer_id AND
			r2.film_id = s.film_id
		) 
	)
)
SELECT	p1.customer_id, p1.first_name, p1.last_name
FROM	customer p1, customerID p2
WHERE	p1.customer_id = p2.customer_id;
