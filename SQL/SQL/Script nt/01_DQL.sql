-- This is a comment 
/*

DQL (Data Query language) 
Used to fetch data from the database. 
SELECT

*/

/* ==============================================================================
   SELECT
=============================================================================== */


-- Switch to the database named 'MyDatabase'
USE MyDatabase;

-- Simple SELECT statement returning a string literal
SELECT 'Hello World';

-- SELECT statement performing arithmetic (multiplication)
SELECT 4 * 6;

-- Retrieve all columns from the 'customers' table
SELECT * 
FROM customers;

-- Retrieve only specific columns (id and first_name) from the 'customers' table
SELECT 
    id, 
    first_name
FROM customers;

-- Retrieve all columns plus a computed column
-- CONCAT joins first_name and score with a hyphen
-- AS renames the computed column to 'Customer_Score'
SELECT 
    *, 
    CONCAT(first_name, '-', score) AS Customer_Score
FROM customers;

-- Return distinct values (removes duplicates)
SELECT DISTINCT country 
FROM customers;

/* ==============================================================================
   WHERE
=============================================================================== */

-- Select all customers where score is not equal to 0
-- <> CAN be use
SELECT *  
FROM customers
WHERE score != 0;

-- Select only first_name and country columns
-- but only for customers whose country is Germany
SELECT 
     first_name,
     country  
FROM customers
WHERE country = 'Germany';

-- Select all customers and order them by score
-- in descending order (highest score first)
-- ASC for ascending order
SELECT *  
FROM customers
ORDER BY score DESC;

-- Select all customers, ordered first by country (ascending A→Z)
-- and then within each country, order by score (descending high→low)
SELECT *  
FROM customers
ORDER BY country ASC, score DESC;

-- Select only first_name, country, and score columns
-- Filter out customers whose score is 0
-- Then order results by score in descending order
SELECT
    first_name,
    country,
    score
FROM customers
WHERE score != 0
ORDER BY score DESC;

-- Select all customers ordered by score in descending order (highest first)
SELECT * 
FROM customers
ORDER BY score DESC;


/* ==============================================================================
   GROUP BY
=============================================================================== */

-- Sum of scores grouped by country
-- Shows total score for each country
SELECT
      country,
      SUM(score) AS total_score
FROM customers 
GROUP BY country;

-- Count of customers and sum of scores grouped by country
-- Gives both total number of customers and total score per country
SELECT
      country,
      COUNT(id) AS total_customer,
      SUM(score) AS total_score
FROM customers 
GROUP BY country;

-- Count of customers and average score grouped by country
-- Filters out rows where score = 0
-- HAVING ensures only countries with avg_score > 430 are shown
SELECT
      country,
      COUNT(id) AS total_customer,
      AVG(score) AS avg_score
FROM customers
WHERE score != 0
GROUP BY country
HAVING AVG(score) > 430;

-- Select distinct countries from the customers table
-- DISTINCT removes duplicate values, so each country appears only once
SELECT DISTINCT country
FROM customers;

-- Select the top 3 customers with the highest scores
-- TOP 3 is SQL Server syntax (Oracle/MySQL use LIMIT instead)
SELECT TOP 3 *
FROM customers 
ORDER BY score DESC;

/* ==============================================================================
   All Together
=============================================================================== */

/* Calculate the average score for each country 
   considering only customers with a score not equal to 0
   and return only those countries with an average score greater than 430
   and sort the results by the highest average score first (ONLY one result) . */

SELECT TOP 1
       country,
       AVG(score) AS avg_score 
FROM customers
WHERE score != 0
GROUP BY country
HAVING AVG(score) > 430
ORDER BY AVG(score) DESC;


-- Select a static or constant value without accessing any table
SELECT 123 AS static_number;

SELECT 'Hello' AS static_string;

-- Assign a constant value to a column in a query
SELECT
    id,
    first_name,
    'New Customer' AS customer_type
FROM customers;





/* ==============================================================================
   WHERE Clause Operators
   Used to filter rows based on conditions
=============================================================================== */

/* -----------------------------
   1. Comparison Operators
----------------------------- */

-- Equal to
SELECT * 
FROM customers 
WHERE country = 'India';

-- Not equal to (<> or !=)
SELECT * 
FROM customers 
WHERE score <> 0;

SELECT * 
FROM customers 
WHERE score != 0;

-- Greater than
SELECT * 
FROM customers 
WHERE score > 500;

-- Greater than or equal to
SELECT * 
FROM customers 
WHERE score >= 500;

-- Less than
SELECT * 
FROM customers 
WHERE score < 500;

-- Less than or equal to
SELECT * 
FROM customers 
WHERE score <= 500;


/* -----------------------------
   2. Logical Operators
----------------------------- */

-- AND: both conditions must be true
SELECT * 
FROM customers 
WHERE country = 'India' AND score > 400;

-- OR: at least one condition must be true
SELECT * 
FROM customers 
WHERE country = 'India' OR country = 'USA';

-- NOT: negates the condition
SELECT * 
FROM customers 
WHERE NOT country = 'India';


/* -----------------------------
   3. Range Operator
----------------------------- */

-- BETWEEN: inclusive range
SELECT * 
FROM customers 
WHERE score BETWEEN 400 AND 600;


/* -----------------------------
   4. Membership Operators
----------------------------- */

-- IN: matches any value in the list
SELECT * 
FROM customers 
WHERE country IN ('USA', 'UK');

-- NOT IN: excludes values in the list
SELECT * 
FROM customers 
WHERE country NOT IN ('USA', 'Brazil');


/* -----------------------------
   5. Search Operator
----------------------------- */

-- LIKE: pattern matching with wildcards
-- % = any sequence of characters
-- _ = single character

-- Names starting with 'M'
SELECT * 
FROM customers 
WHERE first_name LIKE 'M%';

-- Names ending with 'a'
SELECT * 
FROM customers 
WHERE first_name LIKE '%e';

-- Names containing 'ri'
SELECT * 
FROM customers 
WHERE first_name LIKE '%ri%';

-- Names with second letter 'a'
SELECT * 
FROM customers 
WHERE first_name LIKE '_a%';

-- Select all customers whose first_name starts and ends with 'g'
SELECT * 
FROM customers
WHERE first_name LIKE 'g%g';

-- Select all customers whose first_name starts and ends with a vowel (a, e, i, o, u)
SELECT * 
FROM customers
WHERE first_name LIKE '[aeiou]%[aeiou]';

-- Select all customers whose first_name starts with any letter from 'a' to 'm'
SELECT * 
FROM customers
WHERE first_name LIKE '[a-m]%';

-- Select all customers where score is not NULL (exclude missing values)
SELECT * 
FROM customers
WHERE score IS NOT NULL;
