/* ============================================================
   Window Aggregate and Ranking Functions
   ============================================================ */
USE SalesDB;

-- 1️⃣ Count all orders (no partitioning)
-- COUNT(OrderID) OVER() → total count of all rows, repeated for each row
SELECT
     OrderID,
     OrderStatus,
     COUNT(OrderID) OVER() AS total_orders
FROM Sales.Orders;

-- 2️⃣ Count orders per status
-- PARTITION BY OrderStatus → count grouped by status, but still shows per row
SELECT
     OrderID,
     OrderStatus,
     COUNT(OrderID) OVER(PARTITION BY OrderStatus) AS total_orders
FROM Sales.Orders;

-- 3️⃣ Total sales per status
-- SUM(Sales) OVER(PARTITION BY OrderStatus) → total sales grouped by status
SELECT
     OrderStatus,
     SUM(Sales) OVER(PARTITION BY OrderStatus) AS T_sale
FROM Sales.Orders;

-- 4️⃣ Average salary per Department + Gender
-- AVG(Salary) OVER(PARTITION BY Department, Gender ORDER BY Salary DESC)
-- → average salary for each Department/Gender group, ordered by salary
SELECT
  EmployeeID,
  FirstName,
  Department,
  Gender,
  AVG(Salary) OVER(PARTITION BY Department, Gender ORDER BY Salary DESC) AS avg_salary
FROM Sales.Employees;

-- 5️⃣ Max and Min sales per status
-- MAX(Sales) OVER(PARTITION BY OrderStatus ORDER BY Sales) → highest sale per status
-- MIN(Sales) OVER(PARTITION BY OrderStatus) → lowest sale per status
SELECT
     OrderID,
     OrderStatus,
     MAX(Sales) OVER(PARTITION BY OrderStatus ORDER BY Sales) AS max_sales,
     MIN(Sales) OVER(PARTITION BY OrderStatus) AS min_sales
FROM Sales.Orders;


/* ============================================================
   Ranking Functions
   ============================================================ */

-- 6️⃣ ROW_NUMBER()
-- Assigns a unique sequential number to each row.
-- ❌ Does not handle ties → duplicate values still get different numbers.
SELECT
     OrderID,
     OrderStatus,
     Sales,
     ROW_NUMBER() OVER(ORDER BY Sales DESC) AS row_num
FROM Sales.Orders;

-- 7️⃣ RANK()
-- Assigns a rank to each row.
-- ✅ Handles ties → same value gets same rank.
-- ⚠ Leaves gaps in ranking when ties occur.
SELECT
     OrderID,
     OrderStatus,
     Sales,
     RANK() OVER(ORDER BY Sales DESC) AS rank_num
FROM Sales.Orders;

-- 8️⃣ DENSE_RANK()
-- Similar to RANK but does not leave gaps.
-- ✅ Handles ties → same value gets same rank.
-- 🚫 No gaps → next rank is consecutive.
SELECT
     OrderID,
     OrderStatus,
     Sales,
     DENSE_RANK() OVER(PARTITION BY OrderStatus ORDER BY Sales DESC) AS dense_rank_num
FROM Sales.Orders;

-- 9️⃣ NTILE(n)
-- Divides rows into n groups of approximately equal size.
-- Useful for percentiles, quartiles, deciles, etc.
SELECT
     OrderID,
     OrderStatus,
     Sales,
     NTILE(2) OVER(PARTITION BY OrderStatus ORDER BY Sales DESC) AS bucket
FROM Sales.Orders;

/* ============================================================
   Distribution Functions (CUME_DIST, PERCENT_RANK)
   ============================================================ */

-- 1️⃣ CUME_DIST()
-- Cumulative distribution: shows the relative position of a row
-- within its partition. Value ranges from 0 to 1.
-- Formula: (# of rows ≤ current row) / total rows
SELECT
     OrderID,
     OrderStatus,
     Sales,
     CUME_DIST() OVER(PARTITION BY OrderStatus ORDER BY Sales DESC) AS cume_dist
FROM Sales.Orders;

-- 2️⃣ PERCENT_RANK()
-- Percent rank: shows the relative rank of a row as a percentage.
-- Formula: (rank - 1) / (total rows - 1)
-- Value ranges from 0 to 1.
SELECT
     OrderID,
     OrderStatus,
     Sales,
     PERCENT_RANK() OVER(PARTITION BY OrderStatus ORDER BY Sales DESC) AS percent_rank
FROM Sales.Orders;

/* ============================================================
   Other Window Functions
   ============================================================ */

-- 1️⃣ LEAD()
-- Returns the value from a subsequent row (look ahead).
-- Syntax: LEAD(column, offset, default)
-- offset = how many rows forward to look
-- default = value if no row exists
SELECT
     OrderID,
     OrderStatus,
     Sales,
     LEAD(Sales, 2, 10) OVER(PARTITION BY OrderStatus ORDER BY Sales DESC) AS lead_sales
FROM Sales.Orders;

-- 2️⃣ LAG()
-- Returns the value from a previous row (look back).
-- Syntax: LAG(column, offset, default)
-- offset = how many rows backward to look
-- default = value if no row exists
SELECT
     OrderID,
     OrderStatus,
     Sales,
     LAG(Sales, 2, 10) OVER(PARTITION BY OrderStatus ORDER BY Sales DESC) AS lag_sales
FROM Sales.Orders;

-- 3️⃣ FIRST_VALUE()
-- Returns the first value in the window (based on ORDER BY).
SELECT
     OrderID,
     OrderStatus,
     Sales,
     FIRST_VALUE(Sales) OVER(PARTITION BY OrderStatus ORDER BY Sales DESC) AS first_sale
FROM Sales.Orders;

-- 4️⃣ LAST_VALUE()
-- Returns the last value in the window (based on ORDER BY).
SELECT
     OrderID,
     OrderStatus,
     Sales,
     LAST_VALUE(Sales) OVER(PARTITION BY OrderStatus ORDER BY Sales DESC) AS last_sale
FROM Sales.Orders;
