-- =====================================================================
-- One-to-many relationships: customers -> orders
-- Topics: FOREIGN KEY, ON DELETE CASCADE, subqueries, INNER/LEFT JOIN,
--         GROUP BY with joins, IFNULL
-- =====================================================================

CREATE DATABASE IF NOT EXISTS shop;
USE shop;

DROP TABLE IF EXISTS orders, customers;

CREATE TABLE customers (
    id         INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name  VARCHAR(50),
    email      VARCHAR(50)
);

CREATE TABLE orders (
    id          INT PRIMARY KEY AUTO_INCREMENT,
    order_date  DATE,
    amount      DECIMAL(8, 2),
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers (id) ON DELETE CASCADE
);

INSERT INTO customers (first_name, last_name, email)
VALUES ('Boy', 'George', 'george@gmail.com'),
       ('George', 'Michael', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'bette@aol.com');

INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2016-02-10', 99.99, 1),
       ('2017-11-11', 35.50, 1),
       ('2014-12-12', 800.67, 2),
       ('2015-01-03', 12.50, 2),
       ('1999-04-11', 450.25, 5);

-- The foreign key rejects orders for customers that don't exist:
-- INSERT INTO orders (order_date, amount, customer_id) VALUES ('2022-11-11', 50.68, 975);  -- error 1452

-- Orders for a customer, found with a subquery
SELECT *
FROM orders
WHERE customer_id = (SELECT id FROM customers WHERE last_name = 'George');

-- Cross join (every customer x every order)
SELECT * FROM customers, orders;

-- Inner join
SELECT first_name, last_name, order_date, amount
FROM customers
JOIN orders ON customers.id = orders.customer_id;

-- Total spent per customer, highest first
SELECT first_name, last_name, SUM(amount) AS total
FROM customers
JOIN orders ON orders.customer_id = customers.id
GROUP BY first_name, last_name
ORDER BY total DESC;

-- Left join keeps customers with no orders
SELECT first_name, last_name, order_date, amount
FROM customers
LEFT JOIN orders ON customers.id = orders.customer_id;

SELECT first_name, last_name, IFNULL(SUM(amount), 0) AS money_spent
FROM customers
LEFT JOIN orders ON customers.id = orders.customer_id
GROUP BY first_name, last_name;

-- ON DELETE CASCADE removes this customer's orders too
DELETE FROM customers WHERE last_name = 'George';
SELECT * FROM orders;
