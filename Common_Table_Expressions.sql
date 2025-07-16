---------- COMMON TABLE EXPRESSIONS ----------

--> temporary, named result set(virtual table) that can be used multiple times within your query to simplify and organize complex queries.
--> creates a temporary intermediate table.
--> dedicated to a main query and not available in the global database tables.
--> CTE is used to overcome the redundancy issues created during subqueries.
--> CTE improves the readability, modularity, reusability of the code.
--> ORDER BY cannot be used directly in CTE.
--> for better code readability, do not use more than 5 CTEs in a query.

USE firstDatabase;

-- TYPES OF CTE --

-- NON-RECURSIVE CTE --> executed only once => STANDALONE, NESTED
-- RECURSIVE CTE --> self-referencing query that repeatedly processes sata until a specific condition is met =>

-- 1. STANDALONE CTE --
--> defined and used independently, and does not rely on other CTEs or queries.
-- find the total sales per customer
-- CTE
WITH CTE_Total_Sales AS
(
	SELECT
		CustomerID,
		SUM(Sales) AS TotalSales
	FROM orders
	GROUP BY CustomerID
)
--MAIN QUERY
SELECT 
	C.CustomerID,
	C.FirstName,
	C.LastName,
	cts.TotalSales
FROM Customers C
LEFT JOIN CTE_Total_Sales cts
ON cts.CustomerID = C.CustomerID

-- 2. MULTIPLE STANDALONE CTEs --
-- find the last order date for each customer--MAIN QUERY
WITH CTE_Total_Sales AS
(
	SELECT
		CustomerID,
		SUM(Sales) AS TotalSales
	FROM orders
	GROUP BY CustomerID
)
, CTE_Last_Order_Date AS(
SELECT
	CustomerID,
	MAX(OrderDate) AS Last_Order
	FROM orders
	GROUP BY CustomerID
)
-- MAIN QUERY
SELECT 
	C.CustomerID,
	C.FirstName,
	C.LastName,
	cts.TotalSales,
	clo.Last_Order
FROM Customers C
LEFT JOIN CTE_Total_Sales cts
ON cts.CustomerID = C.CustomerID
LEFT JOIN CTE_Last_Order_Date clo
ON clo.CustomerID = C.CustomerID

-- 2. NESTED CTE --
--> CTE inside another CTE.
--> nested CTE uses the result of another CTE, so it cannot run independently.

-- rank the customers based on the total sales per customer.
WITH CTE_Total_Sales AS
(
	SELECT
		CustomerID,
		SUM(Sales) AS TotalSales
	FROM orders
	GROUP BY CustomerID
)
, CTE_Last_Order_Date AS(
SELECT
	CustomerID,
	MAX(OrderDate) AS Last_Order
	FROM orders
	GROUP BY CustomerID
)
, CTE_Customer_Rank AS (
SELECT
	CustomerID,
	TotalSales,
	RANK() OVER(ORDER BY TotalSales DESC) AS CustomerRank
FROM CTE_Total_Sales
)
-- MAIN QUERY
SELECT 
	C.CustomerID,
	C.FirstName,
	C.LastName,
	cts.TotalSales,
	clo.Last_Order,
	ctr.CustomerRank
FROM Customers C
LEFT JOIN CTE_Total_Sales cts
ON cts.CustomerID = C.CustomerID
LEFT JOIN CTE_Last_Order_Date clo
ON clo.CustomerID = C.CustomerID
LEFT JOIN CTE_Customer_Rank ctr
ON ctr.CustomerID = C.CustomerID

-- segment customers based on their total sales
WITH CTE_Total_Sales AS
(
	SELECT
		CustomerID,
		SUM(Sales) AS TotalSales
	FROM orders
	GROUP BY CustomerID
)
, CTE_Last_Order_Date AS(
SELECT
	CustomerID,
	MAX(OrderDate) AS Last_Order
	FROM orders
	GROUP BY CustomerID
)
, CTE_Customer_Rank AS (
SELECT
	CustomerID,
	TotalSales,
	RANK() OVER(ORDER BY TotalSales DESC) AS CustomerRank
FROM CTE_Total_Sales
)
, CTE_Customer_Segment AS(
SELECT
	CustomerID,
	TotalSales,
	CASE 
		WHEN TotalSales > 100 THEN 'HIGH'
		WHEN TotalSales > 50 THEN 'MEDIUM'
		ELSE 'LOW'
	END CustomerSegments
FROM CTE_Total_Sales
)
-- MAIN QUERY
SELECT 
	C.CustomerID,
	C.FirstName,
	C.LastName,
	cts.TotalSales,
	clo.Last_Order,
	ctr.CustomerRank,
	csr.CustomerSegments
FROM Customers C
LEFT JOIN CTE_Total_Sales cts
ON cts.CustomerID = C.CustomerID
LEFT JOIN CTE_Last_Order_Date clo
ON clo.CustomerID = C.CustomerID
LEFT JOIN CTE_Customer_Rank ctr
ON ctr.CustomerID = C.CustomerID
LEFT JOIN CTE_Customer_Segment csr
ON csr.CustomerID = C.CustomerID

-- RECURSIVE CTEs --
--> works like a loop in programming.
--> maximum 100 recursions(default) without breaking.

-- generate a sequence of numbers from 1 to 20.
WITH Series AS (
	-- Anchor Query
	SELECT 
	1 AS MyNumber

	UNION ALL
	
	-- Recursive Query
	SELECT
	MyNumber + 1
	FROM Series
	WHERE MyNumber < 20
)
-- Main Query
SELECT *
FROM series
OPTION(MAXRECURSION 20)

-- show the employee hierarchy by displaying each employee's level within the organization.
WITH CTE_Employee_Hierarchy AS
(
	-- anchor query
	SELECT
		EmployeeID,
		FirstName,
		ManagerID,
		1 AS Level
	FROM Employees
	WHERE ManagerID IS NULL
	
	UNION ALL
	
	-- RECURSIVE QUERY
	SELECT
		E.EmployeeID,
		E.FirstName,
		E.ManagerID,
		Level + 1
	FROM Employees AS E
	INNER JOIN CTE_Employee_Hierarchy ceh
	ON E.ManagerID = ceh.EmployeeID
)
-- MAIN QUERY
SELECT
*
FROM CTE_Employee_Hierarchy
