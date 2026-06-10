/*
NULL , CASE , Aggregate Fuction
*/

USE MyDatabase;   -- Switch to the database context

/* ==============================================================================
    NULL
=============================================================================== */


SELECT *,
     -- Replace NULL scores with 0
     COALESCE(score , 0) AS without_null,

     -- Calculate the average score across all rows
     -- (window function, no GROUP BY needed)
     AVG(score) OVER() AS avg_score,

     -- Another way to replace NULL with 0 (SQL Server specific)
     ISNULL(score , 0) AS without_null2,

     -- Return NULL if score = 0, otherwise return the score
     NULLIF(score , 0) AS without_null3
FROM customers;

/* ==============================================================================
    CASE
=============================================================================== */

SELECT *,
    CASE
        WHEN score <= 500 THEN 'LOW SCORE'
        WHEN score >= 500 THEN 'HIGH SCORE'
        ELSE 'unkown'
    END AS SCore_rate
FROM customers;

SELECT *,
    CASE country
        WHEN 'USA' THEN 'U.S.A'
        WHEN 'UK' THEN 'U.K'
        ELSE 'unkown'
    END AS map_contry
FROM customers;

/* ==============================================================================
    Aggregate Fuction
=============================================================================== */

/*
Multi-Row (Aggregate) Functions:
Operate on a set of rows and return a single value.
- Often used with GROUP BY.
- Examples: COUNT, SUM, AVG, MIN, MAX
*/

-- COUNT: Number of rows
SELECT COUNT(*) AS total_customers
FROM customers;

-- SUM: Add up numeric values
SELECT SUM(score) AS total_score
FROM customers;

-- AVG: Average of numeric values
SELECT AVG(score) AS avg_score
FROM customers;

-- MIN / MAX: Smallest and largest values
SELECT MIN(score) AS min_score,
       MAX(score) AS max_score
FROM customers;

-- Group customers by country and calculate aggregates
SELECT 
     country,
     COUNT(country) country_count,
     AVG(score) avg_score
FROM customers 
GROUP BY country;

-- Filter groups based on aggregate values
SELECT country,
       AVG(score) AS avg_score
FROM customers
GROUP BY country
HAVING AVG(score) > 50;