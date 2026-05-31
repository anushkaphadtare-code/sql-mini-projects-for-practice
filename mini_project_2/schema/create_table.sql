CREATE DATABASE company_analytics;

USE company_analytics;

-- Table 1: Employees:
CREATE TABLE employees (
    employee_id INT,
    employee_name VARCHAR(100),
    department_id INT,
    manager_id INT,
    salary DECIMAL(10,2),
    city VARCHAR(100)
);

-- Table 2: departments:
CREATE TABLE departments (
    department_id INT,
    department_name VARCHAR(100)
);

-- Table 3: projects:
CREATE TABLE projects (
    project_id INT,
    project_name VARCHAR(100),
    department_id INT
);

-- Table 4: employee_projects
CREATE TABLE employee_projects (
    employee_id INT,
    project_id INT
);

-- Table 5: contractors
CREATE TABLE contractors (
    contractor_id INT,
    contractor_name VARCHAR(100),
    city VARCHAR(100)
);

-- Table 6: former_employees:
CREATE TABLE former_employees (
    employee_id INT,
    employee_name VARCHAR(100),
    city VARCHAR(100)
);
