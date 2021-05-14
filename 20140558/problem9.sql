WITH countryFilmsales2005 AS (
SELECT	p7.country, p3.film_id, sum(p1.amount) AS 'sales' 
FROM	payment p1, rental p2, inventory p3, store p4, address p5, city p6, country p7
WHERE	p1.rental_id = p2.rental_id AND
	p2.inventory_id = p3.inventory_id AND
	p3.store_id = p4.store_id AND
	p4.address_id = p5.address_id AND
	p5.city_id = p6.city_id AND
	p6.country_id = p7.country_id AND
	unix_timestamp(p1.payment_date) >= unix_timestamp('2005.01.01') AND
	unix_timestamp(p1.payment_date) < unix_timestamp('2006.01.01')
GROUP BY p7.country, p3.film_id
),
actorSales2005 AS (
SELECT	p1.country, p4.name, p2.actor_id, sum(p1.sales) AS 'sales'
FROM	countryFilmsales2005 p1, film_actor p2, film_category p3, category p4
WHERE	p1.film_id = p2.film_id AND
	p1.film_id = p3.film_id AND
	p3.category_id = p4.category_id
GROUP BY p1.country, p4.name, p2.actor_id
),
actorRank2005 AS (
SELECT country, name, actor_id, sales, RANK() OVER (PARTITION BY country, name ORDER BY Sales DESC) Ranking
FROM actorSales2005
)
SELECT	country, name, actor_id
FROM	actorRank2005
WHERE	Ranking = 1;
