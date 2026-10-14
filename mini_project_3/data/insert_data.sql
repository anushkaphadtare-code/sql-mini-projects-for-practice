INSERT INTO departments (department_id, department_name)
VALUES
    (10, 'IT'),
    (20, 'HR'),
    (30, 'Finance'),
    (40, 'Marketing'),
    (50, 'Operations');

-- Insert employees who have no managers first
INSERT INTO employees
    (employee_id, employee_name, department_id, salary, manager_id, hire_date)
VALUES
    (103, 'Charlie', 10, 75000, NULL, '2020-03-20'),
    (104, 'David',   30, 55000, NULL, '2023-02-01');

-- Insert the remaining employees
INSERT INTO employees
    (employee_id, employee_name, department_id, salary, manager_id, hire_date)
VALUES
    (101, 'Alice', 10, 60000, 103, '2022-01-15'),
    (102, 'Bob',   20, 45000, 104, '2021-06-10'),
    (105, 'Emma',  20, 50000, 104, '2022-11-12'),
    (106, 'Frank', NULL, 65000, 103, '2023-05-18'),
    (107, 'Grace', 10, 75000, 103, '2021-09-05'),
    (108, 'Henry', 40, 40000, 104, '2024-01-10');

INSERT INTO customers (customer_id, customer_name, city)
VALUES
    (201, 'John',  'Mumbai'),
    (202, 'Sarah', 'Pune'),
    (203, 'Mike',  'Delhi'),
    (204, 'Priya', 'Bangalore'),
    (205, 'Rahul', 'Hyderabad'),
    (206, 'Neha',  'Chennai'),
    (207, 'Arjun', 'Mumbai');

INSERT INTO products (product_id, product_name, category, price)
VALUES
    (301, 'Laptop',     'Electronics', 50000),
    (302, 'Phone',      'Electronics', 30000),
    (303, 'Headphones', 'Electronics', 5000),
    (304, 'Office Chair','Furniture',  10000),
    (305, 'Desk',       'Furniture',   20000),
    (306, 'Monitor',    'Electronics', 15000),
    (307, 'Notebook',   'Stationery',    200),
    (308, 'Pen',        'Stationery',     50);

INSERT INTO orders
    (order_id, customer_id, product_id, order_date, quantity, amount, status)
VALUES
    (1001, 201, 301, '2024-01-10',  1, 50000, 'Completed'),
    (1002, 202, 302, '2024-01-12',  2, 60000, 'Completed'),
    (1003, 201, 303, '2024-02-05',  2, 10000, 'Cancelled'),
    (1004, 203, 301, '2024-02-10',  1, 50000, 'Completed'),
    (1005, 204, 304, '2024-03-01',  2, 20000, 'Completed'),
    (1006, 202, 302, '2024-03-15',  1, 30000, 'Cancelled'),
    (1007, 201, 304, '2024-03-20',  1, 10000, 'Completed'),
    (1008, 205, 305, '2024-04-01',  1, 20000, 'Completed'),
    (1009, 203, 306, '2024-04-10',  2, 30000, 'Completed'),
    (1010, 205, 307, '2024-04-15',  5,  1000, 'Completed'),
    (1011, 202, 301, '2024-05-01',  1, 50000, 'Completed'),
    (1012, 204, 302, '2024-05-05',  1, 30000, 'Pending'),
    (1013, 201, 305, '2024-05-12',  2, 40000, 'Completed'),
    (1014, 207, 308, '2024-06-01', 10,   500, 'Completed'),
    (1015, 205, 304, '2024-06-10',  1, 10000, 'Cancelled');
GO

SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;
