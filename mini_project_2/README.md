# Company Analytics SQL Project

## Overview

This project simulates a company analytics database and was built to practice core SQL concepts used in Data Analytics, Data Engineering, and Data Warehousing.

The project focuses on writing analytical SQL queries using realistic business scenarios involving employees, departments, projects, contractors, and former employees.

---

## Database Schema

### departments

Stores department information.

| Column          | Data Type |
| --------------- | --------- |
| department_id   | INT       |
| department_name | VARCHAR   |

### employees

Stores employee details.

| Column        | Data Type |
| ------------- | --------- |
| employee_id   | INT       |
| employee_name | VARCHAR   |
| department_id | INT       |
| manager_id    | INT       |
| salary        | DECIMAL   |
| city          | VARCHAR   |

### projects

Stores project information.

| Column        | Data Type |
| ------------- | --------- |
| project_id    | INT       |
| project_name  | VARCHAR   |
| department_id | INT       |

### employee_projects

Bridge table representing employee-project assignments.

| Column      | Data Type |
| ----------- | --------- |
| employee_id | INT       |
| project_id  | INT       |

### contractors

Stores contractor information.

| Column          | Data Type |
| --------------- | --------- |
| contractor_id   | INT       |
| contractor_name | VARCHAR   |
| city            | VARCHAR   |

### former_employees

Stores records of employees who previously worked for the company.

| Column        | Data Type |
| ------------- | --------- |
| employee_id   | INT       |
| employee_name | VARCHAR   |
| city          | VARCHAR   |

---

## SQL Concepts Practiced

### Basic Joins

* INNER JOIN
* LEFT JOIN

Examples:

* Employees with departments
* Employees with projects
* Projects with assigned employees

### Advanced Joins

#### Self Joins

* Employees working in the same department
* Employees living in the same city

#### Anti Joins

* Employees without projects
* Projects without assigned employees
* Departments without employees
* Departments without projects

#### Cross Joins

* Generate all possible employee-project combinations

### Set Operators

#### UNION

* Combine employees and contractors without duplicates

#### UNION ALL

* Combine datasets while preserving duplicates

#### INTERSECT

* Find records present in multiple datasets

#### EXCEPT

* Find records present in one dataset but absent in another

### Aggregations

* Employee count by department
* Project count by department
* Employees assigned to multiple projects
* Highest paid employees
* Salary-based analysis

### Subqueries

* Employees earning above average salary
* Highest paid employee in each department
* Department-level salary comparisons

---

## Learning Outcomes

Through this project I learned:

* Relational database design
* Primary and foreign key relationships
* Many-to-many relationships
* Bridge tables
* Join strategies and business logic
* Set theory in SQL
* Aggregations and filtering
* Subqueries
* Data quality checks
* Analytical query writing

---

## Project Structure

```text
company-analytics-sql-project/
│
├── schema/
│   └── create_tables.sql
│
├── data/
│   └── insert_data.sql
│
├── queries/
│   ├── basic_intermediate_joins.sql
│   ├── advanced_joins.sql
│   ├── anti_joins.sql
│   └── set_operators.sql
│
└── README.md
```

---

## Technologies Used

* SQL Server
* T-SQL
* Git
* GitHub

---

## Project Goal

The goal of this project was to strengthen SQL fundamentals and develop practical skills in joins, set operators, aggregations, and business-oriented analytical querying as preparation for Data Engineering and Analytics roles.
