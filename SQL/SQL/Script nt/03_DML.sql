/*
DML (Data Manipulation Language)
Manages data within existing structures. 
Includes: INSERT, UPDATE, DELETE
*/

-- Switch to the database
USE MyDatabase;

-- Insert multiple rows into customers table
INSERT INTO customers (id, first_name, country, score)
VALUES 
     (6, 'Anne', 'USA', NULL),
     (7, 'Sam', 'UK', NULL);

-- Insert a row with only id and first_name
INSERT INTO customers (id, first_name)
VALUES 
     (8, 'Anne');

-- Insert data into persons table by selecting from customers
-- BOD set to NULL, phone set to 'NO phone'
INSERT INTO persons (id, name, BOD, phone)
SELECT 
     id,
     first_name,
     NULL,
     'NO phone'
FROM customers;

-- Update score and country for customer with id = 8
UPDATE customers 
SET score = 450, country = 'UK' 
WHERE id = 8;

-- Update score for customer with id = 6
UPDATE customers 
SET score = 490
WHERE id = 6;

-- Delete customer with id = 1
DELETE FROM customers 
WHERE id = 1;

-- Delete all rows (commented out for safety)
-- DELETE FROM customers;

-- Truncate table (commented out for safety)
-- TRUNCATE TABLE customers;

-- View all rows in customers
SELECT * FROM customers;

-- View all rows in persons
SELECT * FROM persons;
