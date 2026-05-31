-- INSERT operations:
-- departments

INSERT INTO departments VALUES
(1, 'Engineering'),
(2, 'Marketing'),
(3, 'Finance'),
(4, 'HR'),
(5, 'Operations');



-- employees

INSERT INTO employees VALUES
(101, 'Aarav Mehta', 1, 201, 85000, 'Pune'),
(102, 'Priya Sharma', 2, 202, 65000, 'Mumbai'),
(103, 'Rohan Kulkarni', 1, 201, 92000, 'Pune'),
(104, 'Sneha Iyer', 3, 203, 70000, 'Bangalore'),
(105, 'Karan Patel', 2, 202, 60000, 'Ahmedabad'),
(106, 'Neha Joshi', NULL, NULL, 50000, 'Delhi'),
(107, 'Vikram Rao', 4, 204, 75000, 'Hyderabad'),
(108, 'Ananya Das', 1, 201, 88000, 'Mumbai'),
(109, 'Rahul Verma', 5, NULL, 55000, 'Chennai'),
(110, 'Pooja Nair', 3, 203, 72000, 'Bangalore'),
(111, 'Aditya Singh', 2, 202, 62000, 'Pune'),
(112, 'Meera Shah', NULL, NULL, 48000, 'Surat');



-- projects

INSERT INTO projects VALUES
(1001, 'Customer Analytics', 1),
(1002, 'Marketing Dashboard', 2),
(1003, 'Finance Forecasting', 3),
(1004, 'Employee Portal', 1),
(1005, 'Payroll Automation', 3),
(1006, 'Recruitment System', 4),
(1007, 'Inventory Tracker', 5);



-- employee_projects

INSERT INTO employee_projects VALUES
(101, 1001),
(101, 1004),
(102, 1002),
(103, 1001),
(103, 1003),
(104, 1003),
(105, 1002),
(107, 1006),
(108, 1001),
(108, 1004),
(110, 1005),
(111, 1002);



-- contractors

INSERT INTO contractors VALUES
(301, 'Raj Malhotra', 'Pune'),
(302, 'Simran Kaur', 'Delhi'),
(303, 'Amit Naik', 'Mumbai'),
(304, 'Farah Khan', 'Kolkata'),
(305, 'Dev Meena', 'Ahmedabad'),
(306, 'Kriti Jain', 'Jaipur');



-- former_employees

INSERT INTO former_employees VALUES
(103, 'Rohan Kulkarni', 'Pune'),
(115, 'Sanjay Gupta', 'Delhi'),
(116, 'Nikita Rao', 'Mumbai'),
(117, 'Harsh Vyas', 'Ahmedabad');
