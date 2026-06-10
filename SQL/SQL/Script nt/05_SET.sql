/*
SET Operators: Combine results from multiple queries
*/

/* ==============================================================================
   UNION: Combine results, remove duplicates
=============================================================================== */
USE SalesDB;

SELECT customerid, firstname, lastname
FROM Sales.Customers
UNION
SELECT EmployeeID, firstname, lastname
FROM Sales.Employees;

-- Explanation: Combines customers + employees, duplicates removed.


SELECT customerid AS id, firstname, lastname
FROM Sales.Customers
UNION
SELECT EmployeeID, firstname AS name, lastname
FROM Sales.Employees;

-- Explanation: Same as UNION, but with aliases to align column names.


/* ==============================================================================
   UNION ALL: Combine results, keep duplicates
=============================================================================== */
SELECT customerid AS id, firstname, lastname
FROM Sales.Customers
UNION ALL
SELECT EmployeeID, firstname AS name, lastname
FROM Sales.Employees;

-- Explanation: Combines customers + employees, duplicates kept.


/* ==============================================================================
   EXCEPT: First query minus second
=============================================================================== */
SELECT customerid AS id, firstname, lastname
FROM Sales.Customers
EXCEPT
SELECT EmployeeID, firstname AS name, lastname
FROM Sales.Employees;

-- Explanation: Shows customers who are not employees.


/* ==============================================================================
   INTERSECT: Common rows in both queries
=============================================================================== */
SELECT customerid AS id, firstname, lastname
FROM Sales.Customers
INTERSECT
SELECT EmployeeID, firstname AS name, lastname
FROM Sales.Employees;

-- Explanation: Shows people who are both customers and employees.
