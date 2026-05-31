-- Section 4: Set Operators:

-- Show all unique cities of employees and contractors:
SELECT city FROM employees 
UNION
SELECT city FROM contractors;

-- show all cities including duplicates from employees and contractors:
SELECT city FROM employees
UNION ALL
SELECT city FROM contractors;

-- Find cities common between employees and contractors:

SELECT city FROM employees
INTERSECT
SELECT city FROM contractors;

-- Find cities whose employees exist but contractors do not
SELECT city
FROM employees
EXCEPT 
SELECT city 
FROM contractors;

-- Find all employees and contractors with city Pune or Mumbai without any duplicates:
SELECT employee_name 
FROM employees
WHERE city = 'Pune' OR city = 'Mumbai'
UNION 
SELECT contractor_name
FROM contractors 
WHERE city = 'Pune' OR city = 'Mumbai';
