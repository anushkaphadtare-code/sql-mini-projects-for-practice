-- SQL FUNDAMENTALS:
-- Find employees whose salary is greater than 50,000. Return employee_name and salary
SELECT
	employee_name,
	salary
FROM employees
WHERE salary > 50000;

-- Find the second-highest distinct salary in the employees table. Return only the salary.
SELECT * FROM employees;
SELECT 
	salary second_highest_distict_salary
FROM
(SELECT salary,
     DENSE_RANK() OVER(ORDER BY salary DESC)  ranked_salaries
FROM employees)t
WHERE ranked_salaries = 2;

-- Find departments with more than two employees. Return department_name and employee_count.
SELECT * FROM departments;
SELECT * FROM employees;
SELECT 
	d.department_name,
	COUNT(employee_id) number_of_emp
FROM
departments d 
LEFT JOIN employees e
ON d.department_id = e.department_id
GROUP BY d.department_name
HAVING COUNT(employee_id) > 2;

-- Find the average salary for each department, including only departments whose average salary exceeds 50,000. 
-- Return department_name and average_salary.
SELECT 
	d.department_name,
	AVG(e.salary) avg_salary_per_dept
FROM departments d
LEFT JOIN employees e
ON d.department_id = e.department_id
GROUP BY department_name
HAVING AVG(e.salary) > 50000;

-- ............END..............................
-- Phase 2: JOINS

-- Display every customer and their total number of orders, including customers who have never placed an order.
SELECT 
	c.customer_id,
	c.customer_name,
	COUNT(o.order_id) order_count
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- Find customers who have never placed an order. Return customer_id and customer_name.
SELECT 
      c.customer_id,
	  c.customer_name
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL;

-- Display each employee's name and their manager's name. Include employees who do not have a manager.
SELECT * FROM employees;
SELECT 
	e.employee_name,
	m.employee_name manager_name
FROM employees e
LEFT JOIN employees m
ON e.manager_id = m.employee_id;

-- Find products that have never been ordered. Return product_id and product_name.
SELECT * FROM products;
SELECT * FROM orders
SELECT
	p.product_id,
	p.product_name
FROM products p
LEFT JOIN orders o
ON p.product_id = o.product_id
WHERE o.product_id IS NULL;


-- .......................END...................................
-- Phase 3: Aggregations and Business Logic:

-- Calculate the total amount of Completed orders for each customer. 
-- Include customers with no Completed orders and show zero for their total.
SELECT * FROM customers;
SELECT * FROM orders;
SELECT 
	c.customer_id,
	c.customer_name,
	SUM( CASE WHEN o.status = 'Completed' THEN o.amount
		ELSE 0
	END) total_amount
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- Find customers whose total amount from Completed orders is greater than 60,000. 
-- Return customer_id, customer_name and total_amount.

SELECT * FROM customers;
SELECT * FROM orders;
SELECT 
	c.customer_id,
	c.customer_name,
	SUM(o.amount) total_amount
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.status = 'Completed'
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.amount) > 60000;

-- Find customers who have purchased products from at least two distinct categories in Completed orders. 
-- Return customer_id and customer_name.

SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM products;

SELECT 
	c.customer_id,
	c.customer_name
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN products p
ON o.product_id = p.product_id
WHERE o.status = 'Completed'
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(DISTINCT p.category) >= 2; 

-- Find each product category's total sales amount from Completed orders. 
-- Return category and total_sales, sorted from highest to lowest.
SELECT * FROM products;
SELECT * FROM orders;
SELECT 
	 p.category,
	SUM(o.amount) total_sales
FROM products p
JOIN orders o
ON p.product_id = o.product_id
WHERE o.status = 'Completed'
GROUP BY  p.category
ORDER BY SUM(o.amount) DESC;

-- Phase 4: Subqueries and ranking

-- Find employees who earn more than the overall average salary. Return employee_name and salary.
SELECT 
	employee_name,
	salary
FROM employees
WHERE salary > 
(SELECT 
	AVG(salary) overall_avg_salary
FROM employees);

-- Find the highest-paid employee or employees in each department. 
-- Include all ties. Return department_name, employee_name and salary.
SELECT * FROM employees;
SELECT 
	*
FROM (SELECT
	d.department_name,
	e.employee_name,
	DENSE_RANK() OVER(PARTITION BY d.department_name ORDER BY e.salary) rank_salaries
    FROM employees e
    JOIN departments d
    ON e.department_id = d.department_id)t
WHERE rank_salaries = 1;

-- Find the third-highest distinct salary from employees. Return only the salary.
SELECT 
	salary
FROM(SELECT 
     salary,
	DENSE_RANK() OVER(ORDER BY salary DESC) rank_sal
FROM employees)t
WHERE rank_sal = 3;

-- Find departments whose average salary is greater than the overall average salary across all employees. 
-- Return department_name and department_average_salary.

WITH cte_name AS
(SELECT 
AVG(salary) overall_salary
FROM employees),
department_avg AS
	(SELECT 
		d.department_id,
		d.department_name,
		AVG(salary) departmental_avg_salary
	FROM employees e
	JOIN departments d
	ON e.department_id = d.department_id
	GROUP BY d.department_id, d.department_name
)
SELECT 
	department_name,
	departmental_avg_salary
FROM department_avg
WHERE departmental_avg_salary > (SELECT overall_salary FROM cte_name);

