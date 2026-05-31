-- SECTION 3: ANTI JOIN, SEMI-JOIN Thinking:

-- Find employees who never worked on projects:
SELECT
		employee_name,
		project_id
FROM employees AS e
LEFT JOIN employee_projects AS ep
ON e.employee_id = ep.employee_id
WHERE project_id IS NULL;

-- Find projects with no assigned employees:
SELECT 
		p.project_id,
		ep.employee_id
FROM projects AS p
LEFT JOIN employee_projects AS ep
ON p.project_id = ep.project_id
WHERE ep.employee_id IS NULL;

-- Find departments without any projects:
SELECT 
		d.department_id,
		p.project_id
FROM departments AS d
LEFT JOIN projects AS p
ON d.department_id = p.department_id
WHERE p.project_id IS NULL;

-- Find employees who exist in current employees but not former employees:
SELECT employee_name
FROM employees
EXCEPT
SELECT employee_name
FROM former_employees;
-- Possible Data quality issue here (employee_name: Rohan Kulkarni present in both employees and former_employees table)
