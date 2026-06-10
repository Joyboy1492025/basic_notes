/*
DDL (Data Definition Language) 
Defines the structure of the database. 
Includes: CREATE, ALTER, DROP, TRUNCATE
*/

/* ==============================================================================
   CREATE
=============================================================================== */

-- Create a new database named DEMO
-- CREATE DATABASE DEMO;

-- Delete the database named DEMO
-- DROP DATABASE DEMO;

-- Switch to the database named 'MyDatabase'
USE MyDatabase;

-- Create a new table called 'persons'
-- Columns: id, name, BOD (Birth of Date), phone
-- Primary Key constraint ensures 'id' is unique and not NULL
CREATE TABLE persons (
    id INT,
    name VARCHAR(50) NOT NULL,
    BOD DATE,
    phone VARCHAR(50) NOT NULL,
    CONSTRAINT pk_persons PRIMARY KEY (id)
);

-- Delete the table 'persons'
-- DROP TABLE persons;

-- Add a new column 'email' to the persons table
ALTER TABLE persons
ADD email VARCHAR(50) NOT NULL;

-- Remove the column 'phone' from the persons table
ALTER TABLE persons
DROP COLUMN phone;

-- Remove all data from the persons table
-- The table structure (columns, constraints) remains
-- TRUNCATE TABLE persons;

-- Retrieve all rows and columns from the persons table
SELECT * 
FROM persons;



/* ==============================================================================
   DATA TYPES
   Define what kind of values a column can store
=============================================================================== */

-- Numeric types
-- INT, BIGINT, SMALLINT → whole numbers
-- DECIMAL(p,s), NUMERIC → fixed precision (good for money)
-- FLOAT, REAL → approximate values

-- Character types
-- CHAR(n) → fixed length
-- VARCHAR(n) → variable length
-- TEXT → long text

-- Date/Time types
-- DATE → YYYY-MM-DD
-- TIME → HH:MM:SS
-- DATETIME / TIMESTAMP → date + time

-- Boolean type
-- BOOLEAN (or BIT in SQL Server) → TRUE/FALSE

-- Binary types
-- BLOB, VARBINARY(n) → images, files, raw data


/* ==============================================================================
   CONSTRAINTS
   Rules applied to columns to enforce data integrity
=============================================================================== */

-- PRIMARY KEY → unique + not NULL
-- FOREIGN KEY → links one table to another
-- UNIQUE → ensures all values are different
-- NOT NULL → prevents NULL values
-- CHECK → enforces a condition (e.g., score >= 0)
-- DEFAULT → provides a default value if none is given


/* ==============================================================================
   EXAMPLE TABLE
=============================================================================== */

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,                  -- Unique identifier
    name VARCHAR(100) NOT NULL,              -- Cannot be NULL
    email VARCHAR(100) UNIQUE,               -- Must be unique
    salary DECIMAL(10,2) CHECK (salary > 0), -- Must be positive
    country VARCHAR(50) DEFAULT 'India',     -- Default value if not provided
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES persons(id) -- Links to another table
);
