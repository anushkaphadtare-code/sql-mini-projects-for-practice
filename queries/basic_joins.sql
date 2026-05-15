-- LEVEL 2: BASIC JOINS:
-- Show customer names along with their order IDs:
-- INNER JOIN :
SELECT 
	c.customer_name,
	o.order_id
FROM customers AS c
INNER JOIN orders AS o
ON c.customer_id = o.customer_id;

-- SHow customer names and products they ordered:
SELECT 
	customer_name,
	product_name
FROM customers AS c
INNER JOIN orders AS o
ON c.customer_id = o.customer_id
INNER JOIN products AS p
ON p.product_id = o.product_id;

-- Show product names and quantities ordered:
SELECT 
	p.product_name,
	o.quantity
FROM products AS p
INNER JOIN orders AS o
ON p.product_id = o.product_id;

-- Show order date along with customer name:
SELECT 
	order_date,
	customer_name
FROM orders AS o
INNER JOIN customers AS c
ON o.customer_id = c.customer_id;

-- Show customer name, product name and quantity in one table:
SELECT 
	c.customer_name,
	p.product_name,
	o.quantity
FROM customers AS c
INNER JOIN orders AS o
ON c.customer_id = o.customer_id
INNER JOIN products AS p
ON o.product_id = p.product_id;
