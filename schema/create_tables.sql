CREATE DATABASE ecommerce;
USE ecommerce;

CREATE TABLE customers(
                customer_id INT, 
                customer_name VARCHAR(100), 
                city VARCHAR(100), 
                signup_date DATE);

CREATE TABLE products(
			product_id INT,
			product_name VARCHAR(100),
			category VARCHAR(100),
			price DECIMAL);

CREATE TABLE orders(
			order_id INT,
			customer_id INT,
			product_id INT,
			quantity INT,
			order_date DATE);
