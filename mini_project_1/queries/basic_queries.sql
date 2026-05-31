-- LEVEL 1: BASIC SQL Queries:
-- SHow all customers:
SELECT * FROM customers;

-- SHOW ALL products belonging to Electronic category:
SELECT * FROM products 
WHERE category = 'Electronics';

-- Show orders placed after 2025-03-05:
SELECT * FROM orders 
WHERE order_date > '2025-03-05';

-- Show products with price > 5000:
SELECT * FROM products
WHERE price > 5000;

--Show customers from Pune:
SELECT * FROM customers
WHERE city = 'Pune';
