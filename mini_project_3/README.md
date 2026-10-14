# SQLInterviewPractice — SQL Interview Preparation

## Overview

**SQLInterviewPractice** is a SQL Server database created to practice frequently asked SQL interview questions for Data Analyst and Data Engineer roles.

The project contains five related tables with sample records designed to practice SQL fundamentals, joins, aggregations, subqueries, window functions, and Common Table Expressions (CTEs).

## Database Information

- **Database Name:** `SQLInterviewPractice`
- **Database System:** Microsoft SQL Server
- **SQL Dialect:** T-SQL
- **Number of Tables:** 5
- **Number of Practice Questions:** 16

## Database Schema

### 1. Departments

Stores department details.

| Column | Data Type | Description |
|---|---|---|
| department_id | INT | Primary key |
| department_name | VARCHAR(50) | Name of the department |

**Sample departments:** IT, HR, Finance, Marketing, Operations.

### 2. Employees

Stores employee information, salary, department, and reporting structure.

| Column | Data Type | Description |
|---|---|---|
| employee_id | INT | Primary key |
| employee_name | VARCHAR(100) | Employee name |
| department_id | INT | Foreign key referencing departments |
| salary | DECIMAL(10,2) | Employee salary |
| manager_id | INT | Self-referencing foreign key referencing employees |
| hire_date | DATE | Employee hire date |

**Key concepts:** Self-joins, salary analysis, department-wise aggregations, and handling NULL values.

Some employees do not have a manager, and one employee has no assigned department.

### 3. Customers

Stores customer information.

| Column | Data Type | Description |
|---|---|---|
| customer_id | INT | Primary key |
| customer_name | VARCHAR(100) | Customer name |
| city | VARCHAR(50) | Customer city |

The dataset includes customers who have never placed an order.

### 4. Products

Stores product details, prices, and categories.

| Column | Data Type | Description |
|---|---|---|
| product_id | INT | Primary key |
| product_name | VARCHAR(100) | Product name |
| category | VARCHAR(50) | Product category |
| price | DECIMAL(10,2) | Product price |

**Product categories:** Electronics, Furniture, Stationery.

The dataset includes a product that has never been ordered.

### 5. Orders

Stores customer orders, products purchased, order dates, quantities, amounts, and statuses.

| Column | Data Type | Description |
|---|---|---|
| order_id | INT | Primary key |
| customer_id | INT | Foreign key referencing customers |
| product_id | INT | Foreign key referencing products |
| order_date | DATE | Date of the order |
| quantity | INT | Quantity ordered |
| amount | DECIMAL(12,2) | Recorded order amount |
| status | VARCHAR(20) | Order status |

**Order statuses:** Completed, Cancelled, Pending.

For sales-related questions, use `orders.amount` as the recorded order amount.

## Table Relationships

- `employees.department_id` → `departments.department_id`
- `employees.manager_id` → `employees.employee_id`
- `orders.customer_id` → `customers.customer_id`
- `orders.product_id` → `products.product_id`

These relationships allow practice with primary keys, foreign keys, joins, and self-joins.

## Sample Data Summary

| Table | Number of Records |
|---|---:|
| departments | 5 |
| employees | 8 |
| customers | 7 |
| products | 8 |
| orders | 15 |

To inspect the data in SQL Server:

```sql
USE SQLInterviewPractice;
GO

SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;
```

## SQL Interview Questions

The database is used to solve the following 16 interview questions.

### SQL Fundamentals and Aggregation

**Q1. Employees earning more than 50,000**

Find employees whose salary is greater than 50,000. Return employee name and salary.

**Q2. Second-highest distinct salary**

Find the second-highest distinct salary in the employees table.

**Q3. Departments with more than two employees**

Return department name and employee count for departments having more than two employees.

**Q4. Department average salary above 50,000**

Find departments whose average salary exceeds 50,000.

### Joins and Missing Relationships

**Q5. Total order count for every customer**

Display every customer and their total number of orders, including customers who have never placed an order.

**Q6. Customers who never placed an order**

Find customers who have no matching records in the orders table.

**Q7. Employees and their managers**

Display each employee's name and their manager's name. Include employees without managers.

**Q8. Products that have never been ordered**

Find products that do not appear in the orders table.

### Conditional Aggregation and Category Analysis

**Q9. Completed order amount per customer**

Calculate the total amount of completed orders for every customer. Include customers with no completed orders and display zero for their total.

**Q10. Customers with completed order totals above 60,000**

Find customers whose total amount from completed orders exceeds 60,000.

**Q11. Customers who ordered from at least two distinct categories**

Find customers who purchased products from at least two different categories through completed orders.

**Q12. Completed sales amount by product category**

Calculate total sales from completed orders for each product category and sort the results in descending order of sales.

### Subqueries, Window Functions, and CTEs

**Q13. Employees earning above the overall average salary**

Find employees whose salary is greater than the average salary of all employees.

**Q14. Highest-paid employee(s) in each department**

Find the highest-paid employee or employees in each department, including ties.

**Q15. Third-highest distinct salary**

Find the third-highest distinct salary in the employees table.

**Q16. Departments whose average salary exceeds the overall average salary**

Find departments whose average salary is greater than the overall average salary across all employees.

## SQL Concepts Practiced

- SELECT, WHERE, and ORDER BY
- INNER JOIN and LEFT JOIN
- Self-joins
- Finding unmatched records using LEFT JOIN and IS NULL
- GROUP BY and HAVING
- COUNT(), SUM(), and AVG()
- COUNT(DISTINCT ...)
- Conditional aggregation using CASE
- Handling NULL values using COALESCE
- Subqueries
- Window functions using DENSE_RANK()
- Common Table Expressions (CTEs)
- Primary keys and foreign keys

## Key Learning Takeaways

1. Use `WHERE` to filter rows before aggregation and `HAVING` to filter aggregated groups.
2. Use `LEFT JOIN` when all records from the left table must be retained.
3. Use `COUNT(non_nullable_column)` to count matching records after a LEFT JOIN when unmatched rows should contribute zero.
4. Use `COUNT(DISTINCT column)` when the requirement involves unique values.
5. Use `CASE` inside aggregate functions for conditional aggregation.
6. Use `DENSE_RANK()` to rank distinct salary levels while preserving ties.
7. Understand the difference between filtering rows in the `ON` clause and filtering them in the `WHERE` clause.
8. Use CTEs to make complex queries easier to read and maintain.

## How to Use This Project

1. Create the `SQLInterviewPractice` database in SQL Server.
2. Create the five tables using DDL statements.
3. Insert the sample records using DML statements.
4. Execute the 16 SQL interview questions.
5. Validate query outputs and understand the logic behind each solution.

The goal of this project is to strengthen SQL problem-solving skills through hands-on practice with a relational database.
