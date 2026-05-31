-- LEVEL 5: Intermediate Analytics:
-- Find the top selling products based on quantity sold:
SELECT TOP 5 
	p.product_name, SUM(o.quantity) AS total_quantity
FROM products AS p
LEFT JOIN orders AS o
ON p.product_id = o.product_id
GROUP BY p.product_name
ORDER BY SUM(o.quantity) DESC;

-- Find monthly revenue:
SELECT MONTH(order_date) FROM orders;
SELECT
	MONTH(o.order_date),
	SUM(o.quantity * p.price) AS revenue
FROM orders AS o
INNER JOIN products AS p
ON o.product_id = p.product_id
GROUP BY MONTH(o.order_date); 


-- Find products ordered more than once:
SELECT 
	p.product_name,
	COUNT(o.product_id) AS count
FROM products AS p
INNER JOIN orders AS o
ON p.product_id = o.product_id
GROUP BY p.product_name
HAVING COUNT(o.product_id) > 1

-- Find customers who purchased electronis products:
SELECT 
	c.customer_name
FROM customers AS c
INNER JOIN orders AS o
ON c.customer_id = o.customer_id
INNER JOIN products AS p
ON p.product_id = o.product_id
WHERE p.category = 'Electronics'
GROUP BY c.customer_name;

--Find total number of unique cust who placed orders:
SELECT COUNT(DISTINCT c.customer_id) AS total_unique
FROM customers AS c
INNER JOIN orders AS o
ON c.customer_id = o.customer_id;
