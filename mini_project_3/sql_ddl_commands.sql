-- Create the database
CREATE DATABASE SQLInterviewPractice;
GO

-- Switch to the new database
USE SQLInterviewPractice;
GO

-- 1. Departments table
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL
);

-- 2. Employees table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    department_id INT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    manager_id INT NULL,
    hire_date DATE NOT NULL,

    CONSTRAINT FK_employees_departments
        FOREIGN KEY (department_id)
        REFERENCES departments(department_id),

    CONSTRAINT FK_employees_manager
        FOREIGN KEY (manager_id)
        REFERENCES employees(employee_id)
);

-- 3. Customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL
);

-- 4. Products table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

-- 5. Orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    order_date DATE NOT NULL,
    quantity INT NOT NULL,
    amount DECIMAL(12, 2) NOT NULL,
    status VARCHAR(20) NOT NULL,

    CONSTRAINT FK_orders_customers
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    CONSTRAINT FK_orders_products
        FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);
GO
