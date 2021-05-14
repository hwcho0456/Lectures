WITH countryIncome AS (
SELECT	p1.country, sum(p6.amount)
FROM	country p1, city p2, address p3, store p4, staff p5, payment p6
WHERE	p1.country_id = p2.country_id AND
	p2.city_id = p3.city_id AND
	p3.address_id = p4.address_id AND
	p4.store_id = p5.store_id AND
	p5.staff_id = p6.staff_id
GROUP BY p1.country
),
countryStorenum AS (
SELECT	p1.country, count(*)
FROM	country p1, city p2, address p3, store p4
WHERE	p1.country_id = p2.country_id AND
	p2.city_id = p3.city_id AND
	p3.address_id = p4.address_id
GROUP BY p1.country
)
SELECT	* FROM countryStorenum NATURAL JOIN countryIncome;
