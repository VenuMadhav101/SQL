---------- VIEWS IN SQL ----------
--> virtual table in SQL based on the result set of a query, without storing the data in database.
--> views are persisted SQL queries in the database.
--> slower than compared to tables and read only.
--> views are primarily used to store the central, complex query logic in the database for access by multiple queries, reducing project complexity.
--> views reduce redundancy and improve reusability in multiple queries.
--> views are a little complicated than compared to tables and CTEs.

USE firstDatabase;

--> find the running total of sales each month
-- using CTE
WITH CTE_Monthly_Summary AS (
	SELECT 
	DATETRUNC(month,OrderDate)  OrderMonth,
	SUM(Sales) TotalSales,
	COUNT(OrderID) TotalOrders,
	SUM(Quantity) TotalQuantities
	FROM orders
	GROUP BY DATETRUNC(month,OrderDate) 
)
SELECT 
OrderMonth,
SUM(TotalSales) OVER(ORDER BY OrderMonth) AS RunningTotal
FROM CTE_Monthly_Summary

-- using view

CREATE VIEW Monthly_Summary_View AS (
	SELECT 
	DATETRUNC(month,OrderDate)  OrderMonth,
	SUM(Sales) TotalSales,
	COUNT(OrderID) TotalOrders,
	SUM(Quantity) TotalQuantities
	FROM orders
	GROUP BY DATETRUNC(month,OrderDate)
)

SELECT * FROM Monthly_Summary_View

DROP VIEW Monthly_Summary_View

--> to update query in view, drop the original view and rewrite the query with the update
-- other way
IF OBJECT_ID('dbo.Monthly_Summary_View', 'V') IS NOT NULL
	DROP VIEW dbo.Monthly_Summary_View;
GO
CREATE VIEW Monthly_Summary_View AS (
	SELECT 
	DATETRUNC(month,OrderDate)  OrderMonth,
	SUM(Sales) TotalSales,
	COUNT(OrderID) TotalOrders,
	SUM(Quantity) TotalQuantities
	FROM orders
	GROUP BY DATETRUNC(month,OrderDate)
)

-- hiding and reducing complexity

-- provide a view that combines detailes from orders, products, customers, and employees.
CREATE VIEW OrderDetails AS (
	SELECT 
	O.OrderID,
	O.OrderDate,
	P.Product,
	P.Category,
	COALESCE(C.FirstName, '') + ' ' + COALESCE(C.LastName, '') CustomerName,
	C.Country CustomerCountry,
	COALESCE(E.FirstName, '') + ' ' + COALESCE(E.LastName, '') SalesName,
	E.Department,
	O.Sales,
	O.Quantity
	FROM orders O
	LEFT JOIN Products P
	ON P.ProductID = O.ProductID
	LEFT JOIN Customers C
	ON C.CustomerID = O.CustomerID
	LEFT JOIN Employees E
	ON E.EmployeeID = o.SalesPersonID
)

SELECT * FROM OrderDetails

-- data security

-- provide a view for EU sales team that combines detailes from all tables and excludes data related to USA.
CREATE VIEW EU_Sales_Details AS (
	SELECT 
	O.OrderID,
	O.OrderDate,
	P.Product,
	P.Category,
	COALESCE(C.FirstName, '') + ' ' + COALESCE(C.LastName, '') CustomerName,
	C.Country CustomerCountry,
	COALESCE(E.FirstName, '') + ' ' + COALESCE(E.LastName, '') SalesName,
	E.Department,
	O.Sales,
	O.Quantity
	FROM orders O
	LEFT JOIN Products P
	ON P.ProductID = O.ProductID
	LEFT JOIN Customers C
	ON C.CustomerID = O.CustomerID
	LEFT JOIN Employees E
	ON E.EmployeeID = o.SalesPersonID
	WHERE C.Country != 'USA'
)

SELECT * FROM EU_Sales_Details