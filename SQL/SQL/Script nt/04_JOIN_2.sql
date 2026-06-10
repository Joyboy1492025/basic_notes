/* ==============================================================================
SELF JOIN: Joins a table to itself — useful for hierarchical or relational data.
   Example: Employees and their managers from the same table.
=============================================================================== */
USE SalesDB; 

SELECT *
FROM Sales.Employees e
JOIN Sales.Employees M
ON e.EmployeeID = m.ManagerID;


/* ==============================================================================
MULTI JOIN
=============================================================================== */

SELECT 
     o.OrderID,
     o.Sales,
     c.FirstName,
     c.LastName,
     p.Product,
     p.Price,
     e.FirstName
FROM Sales.Orders AS o
JOIN Sales.Customers AS c ON o.CustomerID = c.CustomerID
JOIN Sales.Products AS p ON o.ProductID = p.ProductID
JOIN Sales.OrdersArchive AS s ON p.ProductID = s.ProductID
JOIN Sales.Employees AS e ON s.SalesPersonID = e.EmployeeID;
