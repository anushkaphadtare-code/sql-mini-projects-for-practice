-- SECTION 2: CROSS And Advanced Joins:
-- Generate all possible employee project combinations using CROSS JOIN:
SELECT 
	e.employee_name,
	p.project_name
FROM employees AS e
CROSS JOIN projects AS p;

-- Find employees who are assigned to multiple projects:
SELECT 
	ep.employee_id,
	e.employee_name
FROM employee_projects AS ep
INNER JOIN employees AS e
ON e.employee_id = ep.employee_id
GROUP BY ep.employee_id, employee_name
HAVING COUNT(ep.project_id) > 1;

-- Find departments managing more than one project
SELECT 
	d.department_name
FROM departments AS d
INNER JOIN projects AS p
ON d.department_id = p.department_id
GROUP BY d.department_name
HAVING COUNT(p.project_id) > 1;

-- Find highest paid employee in each department:
select * from employees;
SELECT employee_name,
	   department_id,
	   salary
FROM employees AS e1
WHERE salary = (SELECT MAX(salary) FROM employees AS e2
WHERE e1.department_id = e2.department_id);

-- Find employees who share the same city:
SELECT * FROM employees;
SELECT 
	e.employee_name, 
	e1.employee_name,
	e.city
FROM employees AS e
INNER JOIN employees AS e1
ON e.city = e1.city
WHERE e.employee_id < e1.employee_id;
