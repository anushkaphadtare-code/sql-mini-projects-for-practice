-- Section 1: Basic and Intermediate Joins:

-- Show employee names with their department names:
SELECT e.employee_name, 
	   d.department_name
FROM employees AS e
INNER JOIN departments AS d
ON e.department_id = d.department_id;

-- Show employees working on projects:(only emp names)
SELECT 
	 DISTINCT e.employee_name
FROM employees AS e
INNER JOIN employee_projects AS ep
ON e.employee_id = ep.employee_id;

-- Show employee names and project names:
SELECT 
	employee_name,
	project_name
FROM employees AS e
INNER JOIN employee_projects AS ep
ON e.employee_id = ep.employee_id 
INNER JOIN projects AS p
ON ep.project_id = p.project_id;

-- Find employees who are not assigned to any project:
SELECT e.employee_name AS names_with_no_projects
FROM employees AS e
LEFT JOIN employee_projects AS ep
ON e.employee_id = ep.employee_id
WHERE ep.employee_id IS NULL;

-- Find department with no employees:
SELECT department_name
FROM departments AS d
LEFT JOIN employees AS e
ON d.department_id = e.department_id
WHERE e.department_id IS NULL;

-- Show all projects and assigned employee names:
SELECT p.project_name,
		e.employee_name
FROM projects AS p
LEFT JOIN employee_projects AS ep
ON p.project_id = ep.project_id
LEFT JOIN employees AS e
ON ep.employee_id = e.employee_id;

-- Find employees earning more than average salary:
SELECT employee_name 
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- Find employees who do not have managers:
SELECT 
	employee_name
FROM employees 
WHERE manager_id IS NULL;

-- Find employees working in the same department:
-- SELF JOIN example:
SELECT 
	e.employee_name,
	e1.employee_name
FROM employees AS e
INNER JOIN employees AS e1
ON e.department_id = e1.department_id
WHERE e.employee_id < e1.employee_id;
-- OR the WHERE condition can be: e.employee_id > e1.employee_id
