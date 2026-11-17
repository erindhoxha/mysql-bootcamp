-- =====================================================================
-- Section: Creating databases & tables, inserting data, CRUD
-- Database: pet_shop
-- =====================================================================

CREATE DATABASE IF NOT EXISTS pet_shop;
USE pet_shop;

-- ---------------------------------------------------------------------
-- Defaults & NOT NULL
-- ---------------------------------------------------------------------
CREATE TABLE cats2 (
    name VARCHAR(50) DEFAULT 'Untitled',
    age  INT         DEFAULT 99
);

INSERT INTO cats2 () VALUES ();          -- uses both defaults
INSERT INTO cats2 (age) VALUES (2);      -- name falls back to 'Untitled'
SELECT * FROM cats2;

-- ---------------------------------------------------------------------
-- Primary keys & AUTO_INCREMENT
-- ---------------------------------------------------------------------
CREATE TABLE unique_cats (
    cat_id INT NOT NULL PRIMARY KEY,
    name   VARCHAR(30),
    age    INT
);

INSERT INTO unique_cats (cat_id, name, age) VALUES (3, 'Whiskers', 23);
-- Inserting cat_id 3 again fails: Duplicate entry '3' for key 'PRIMARY'

CREATE TABLE unique_cats2 (
    cat_id INT AUTO_INCREMENT,
    name   VARCHAR(30),
    age    INT,
    PRIMARY KEY (cat_id)
);

INSERT INTO unique_cats2 (name, age) VALUES ('Hello', 23);
INSERT INTO unique_cats2 (name, age) VALUES ('Hello', 23);  -- same values, new id
SELECT * FROM unique_cats2;

-- ---------------------------------------------------------------------
-- Exercise: employees table with constraints
-- ---------------------------------------------------------------------
CREATE TABLE employees (
    id             INT AUTO_INCREMENT,
    last_name      VARCHAR(50) NOT NULL,
    first_name     VARCHAR(50) NOT NULL,
    middle_name    VARCHAR(50),
    age            INT         NOT NULL,
    current_status VARCHAR(50) NOT NULL DEFAULT 'Employed',
    PRIMARY KEY (id)
);

INSERT INTO employees (last_name, first_name, middle_name, age)
VALUES ('Smith', 'John', NULL, 32);

SELECT * FROM employees;

-- ---------------------------------------------------------------------
-- CRUD on cats
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS cats;
CREATE TABLE cats (
    cat_id INT AUTO_INCREMENT,
    name   VARCHAR(100),
    breed  VARCHAR(100),
    age    INT,
    PRIMARY KEY (cat_id)
);

INSERT INTO cats (name, breed, age)
VALUES ('Ringo', 'Tabby', 4),
       ('Cindy', 'Maine Coon', 10),
       ('Dumbledore', 'Maine Coon', 11),
       ('Egg', 'Persian', 4),
       ('Misty', 'Tabby', 13),
       ('George Michael', 'Ragdoll', 9),
       ('Jackson', 'Sphynx', 7);

-- Read
SELECT * FROM cats WHERE age = 4;
SELECT cat_id FROM cats WHERE name = 'Egg';
SELECT name FROM cats WHERE breed = 'Persian';
SELECT name, breed FROM cats;
SELECT cat_id AS id FROM cats;
SELECT * FROM cats WHERE name = 'jacksOn';   -- comparisons are case-insensitive

-- Update
UPDATE cats SET breed = 'Shorthair' WHERE breed = 'Tabby';
UPDATE cats SET age = 14 WHERE name = 'Misty';
UPDATE cats SET name = 'Jack' WHERE name = 'Jackson';
UPDATE cats SET name = 'Jackson' WHERE name = 'Jack';

UPDATE employees SET current_status = 'Laid Off', last_name = 'Wowzer';

-- Delete
DELETE FROM cats WHERE name = 'Egg';
SELECT * FROM cats;
