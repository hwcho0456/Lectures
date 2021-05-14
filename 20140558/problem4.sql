WITH	overdueCustomer AS (
SELECT	p1.customer_id, p1.store_id, count(*) AS 'num'
FROM	customer p1, rental p2
WHERE	p1.customer_id = p2.customer_id AND
	p2.rental_date + interval 30 day <  CURRENT_DATE() AND
	p2.return_date IS NULL
GROUP BY p1.customer_id
)
SELECT	customer_id, store_id, num
FROM	customer NATURAL LEFT OUTER JOIN overdueCustomer
WHERE	store_id = 1 AND
	customer_id < 100;
