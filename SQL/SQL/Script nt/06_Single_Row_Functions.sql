/*
Single Row Functions (Scalar Functions): 
Operate on one row at a time and return one result per row.
- Can take one or more arguments.
- Return a single value for each row processed.
- Can be used in SELECT, WHERE, ORDER BY, etc.
*/

USE MyDatabase;   -- Switch to the database context

/* ==============================================================================
    STRING Functions
=============================================================================== */

-- CONCAT: Join strings together
SELECT *, 
       CONCAT(first_name, '-', country) AS name_country   -- Combine first_name and country with a hyphen
FROM customers;

-- UPPER / LOWER: Change text case
SELECT 
       UPPER(first_name) AS name_upper,   -- Convert first_name to uppercase
       LOWER(country) AS country_lower    -- Convert country to lowercase
FROM customers;

-- TRIM / LEN: Clean spaces and measure length
SELECT *, 
       TRIM(first_name) AS name_country,  -- Remove leading/trailing spaces from first_name
       LEN(first_name) AS name_length     -- Count number of characters in first_name
FROM customers;

-- REPLACE: Substitute text
SELECT 
       REPLACE(country, 'USA', 'U.S.A') AS replace_txt    -- Replace 'USA' with 'U.S.A'
FROM customers;

-- RIGHT / LEFT / SUBSTRING: Extract parts of text
SELECT 
       first_name,
       RIGHT(first_name, 2) AS cha1,       -- Last 2 characters of first_name
       LEFT(first_name, 2) AS cha2,        -- First 2 characters of first_name
       SUBSTRING(first_name, 3, 2) AS SUB  -- 2 characters starting at position 3
FROM customers;


/* ==============================================================================
   NUMBER Functions
=============================================================================== */
 
-- ROUND: Round numbers to specified decimal places
SELECT 
     ROUND(3.526, 2) AS round_1,   -- Round to 2 decimal places → 3.53
     ROUND(3.526, 0) AS round_2,   -- Round to nearest integer → 4
     ROUND(3.526, 1) AS round_3;   -- Round to 1 decimal place → 3.5

-- ABS: Absolute value (remove sign)
-- POWER: Raise a number to a power
SELECT 
     ABS(-10) AS abs_neg,          -- Absolute value of -10 → 10
     ABS(10) AS abs_pos,           -- Absolute value of 10 → 10
     POWER(2, 3) AS pow_val;       -- 2 raised to the power of 3 → 8


/* ==============================================================================
   DATE AND TIME Functions
=============================================================================== */
  
-- GETDATE, DAY, MONTH, YEAR: Current system date and parts
SELECT 
     GETDATE() AS Today,              -- Current system date & time
     DAY(GETDATE()) AS Current_day,   -- Day part of current date
     MONTH(GETDATE()) AS Current_month, -- Month part of current date
     YEAR(GETDATE()) AS Current_year;   -- Year part of current date

-- DATEPART: Extract specific parts of a date
SELECT 
     GETDATE() AS Today, 
     DATEPART(DAY, GETDATE()) AS Current_day,     -- Day number
     DATEPART(MONTH, GETDATE()) AS Current_month, -- Month number
     DATEPART(YEAR, GETDATE()) AS Current_year,   -- Year number
     DATEPART(WEEK, GETDATE()) AS Current_week;   -- Week number of the year

-- DATENAME: Return name of date part
SELECT 
     GETDATE() AS Today,
     DATENAME(DAY, GETDATE()) AS Current_day;     -- Day name (returns string)

-- DATETRUNC: Truncate to specific date part
SELECT 
     GETDATE() AS Today,
     DATETRUNC(HOUR, GETDATE()) AS Current_h;     -- Truncate to start of current hour

-- EOMONTH, CAST: End of month and type conversion
SELECT 
     GETDATE() AS Today,
     EOMONTH(GETDATE()) AS END_MONTH,             -- Last day of current month
     CAST(GETDATE() AS TIME);                     -- Convert datetime to time only

-- DATEDIFF, DATEADD: Difference and addition
SELECT 
      *,
      GETDATE() AS cur_time, 
      DATEDIFF(YEAR, order_date, GETDATE()) AS diff_year, -- Years between order_date and today
      DATEADD(YEAR, 10, GETDATE()) AS add_year            -- Add 10 years to current date
FROM orders;

-- CURRENT_TIMESTAMP: ANSI standard for current date/time
SELECT CURRENT_TIMESTAMP;   -- Same as GETDATE()


/* ==============================================================================
   DATE AND TIME Functions (FORMAT)
=============================================================================== */
  
SELECT 
     order_date,
     FORMAT(order_date, 'dd') AS dd,              -- Day number (01–31)
     FORMAT(order_date, 'ddd') AS ddd,            -- Abbreviated weekday (Mon, Tue…)
     FORMAT(order_date, 'dddd') AS dddd,          -- Full weekday name (Monday…)
     FORMAT(order_date, 'MMMM') AS MM,            -- Full month name (January…)
     FORMAT(order_date, 'yyyy') AS YY,            -- Year in 4 digits
     FORMAT(order_date, 'dd-MM-yyyy') AS FullDate -- Custom format: day-month-year
FROM orders;


/* ==============================================================================
   DATE AND TIME Functions (CONVERT)
=============================================================================== */
  
SELECT 
     CONVERT(INT, '123') AS [String to INT],          -- Convert string '123' to integer
     CONVERT(DATE, '2025-08-20') AS [String to Date]; -- Convert string to DATE type


/* ==============================================================================
   DATE AND TIME Functions (CAST)
=============================================================================== */
  
SELECT 
     CAST('123' AS INT) AS [String to INT],           -- Convert string '123' to integer
     CAST(123 AS VARCHAR) AS [String to varchar];     -- Convert integer 123 to string
