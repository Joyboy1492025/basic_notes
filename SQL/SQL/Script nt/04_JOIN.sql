/*
JOIN : Combine rows
*/
USE MyDatabase;
/* ==============================================================================
    INNER JOIN: Returns only rows that have matching values in both tables.
    Example: Customers with matching orders.
=============================================================================== */

-- Explanation: Only customers who have placed orders will appear.
-- If a customer has no order, they are excluded.
SELECT 
     customers.id,          -- Customer ID
     customers.first_name,  -- Customer name
     orders.order_id,       -- Order ID
     orders.sales           -- Sales amount
FROM customers 
JOIN orders 
ON customers.id = orders.customer_id;

-- Same query using table aliases for brevity
SELECT 
     c.id,                  -- Customer ID
     c.first_name,          -- Customer name
     o.order_id,            -- Order ID
     o.sales                -- Sales amount
FROM customers AS c
INNER JOIN orders AS o 
ON c.id = o.customer_id;


/* ==============================================================================
    LEFT JOIN (LEFT OUTER JOIN): Returns all rows from the left table and matched rows from the right table.
    Example: All customers, even those without orders.
=============================================================================== */

-- Explanation: Every customer is listed.
-- If a customer has no order, order_id and sales will show NULL.
SELECT 
     c.id,                  -- Customer ID
     c.first_name,          -- Customer name
     o.order_id,            -- Order ID (NULL if no order)
     o.sales                -- Sales amount (NULL if no order)
FROM customers AS c
LEFT JOIN orders AS o 
ON c.id = o.customer_id;


/* ==============================================================================
    RIGHT JOIN (RIGHT OUTER JOIN): Returns all rows from the right table and matched rows from the left table.
    Example: All orders, even if customer info is missing.
=============================================================================== */

-- Explanation: Every order is listed.
-- If an order has no matching customer, customer fields show NULL.
SELECT 
     c.id,                  -- Customer ID (NULL if missing)
     c.first_name,          -- Customer name (NULL if missing)
     o.order_id,            -- Order ID (always returned)
     o.sales                -- Sales amount (always returned)
FROM customers AS c
RIGHT JOIN orders AS o 
ON c.id = o.customer_id;

/* ==============================================================================
 FULL JOIN (FULL OUTER JOIN): Returns all rows when there is a match in either table.
   Unmatched rows from both sides show NULLs.
   Example: All customers and all orders, matched or not.
=============================================================================== */

-- Explanation:
-- Combines LEFT JOIN and RIGHT JOIN results.
-- Every customer and every order will be listed.
-- If a customer has no order → order_id and sales show NULL.
-- If an order has no customer → customer fields show NULL.

SELECT 
     c.id,                  -- Customer ID (NULL if missing)
     c.first_name,          -- Customer name (NULL if missing)
     o.order_id,            -- Order ID (always returned)
     o.sales                -- Sales amount (always returned)
FROM customers AS c
FULL JOIN orders AS o 
ON c.id = o.customer_id;

/* ==============================================================================
Anti JOIN: you can use any join and apply this concepts
=============================================================================== */


SELECT 
     c.id,                  -- Customer ID (NULL if missing)
     c.first_name,          -- Customer name (NULL if missing)
     o.order_id,            -- Order ID (always returned)
     o.sales                -- Sales amount (always returned)
FROM customers AS c
FULL JOIN orders AS o 
ON c.id = o.customer_id
WHERE c.id is null;         -- Only keep rows where customer_id is missing

/* ==============================================================================
CROSS JOIN ( Cartesion Join ): Returns the Cartesian product — every row from the first table
   combined with every row from the second table.
   Example: All possible customer–order combinations.
=============================================================================== */

SELECT *
FROM customers
CROSS JOIN orders;


