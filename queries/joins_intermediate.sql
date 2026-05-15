-- LEVEL 3: 
-- Find customers who never placed any orders:
SELECT 
	*
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- Find products that were never ordered:
SELECT *
FROM products AS p
LEFT JOIN orders AS o
ON p.product_id = o.product_id
WHERE o.order_id IS NULL;

-- Show customers along with their order IDs, including customers without orders:
SELECT
	c.customer_id,
	c.customer_name,
	o.order_id
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id;
