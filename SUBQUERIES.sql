-- SUBQUERIES IN SQL --
--> a query(sub query or inner query) inside another query(main query or outer query).
--> subquery is like an intermediate result.
--> subquery can be used only from main query.

USE firstDatabase;

-- TYPES OF SUBQUERIES --

-- BASED ON RESULT TYPE --
-- 1. SCALAR SUBQUERY --
--> returns a single value.
SELECT
AVG(Sales)
FROM orders;

-- 2. ROW SUBQUERY --
--> returns multiple rows and a single column.
SELECT
CustomerID
FROM orders;

-- 3. TABLE SUBQUERY --
--> returns multiple rows and columns.
SELECT *
FROM orders;

-- SUBQUERY IN FROM CLAUSE --
--> used as temporary table for the main query.
-- find the products that have higher price than the average price of all products.
-- main query
SELECT 
*
FROM 
	-- subquery
	(
	SELECT 
	ProductID,
	Price,
	AVG(Price) OVER() AvgPrice
FROM Products
)t
WHERE Price > AvgPrice

-- rank customers based on total amount of sales.

SELECT
*,
RANK() OVER(ORDER BY TotalSales DESC) CustomerRank
FROM (
	SELECT
	CustomerID,
	SUM(Sales) TotalSales
	FROM orders
	GROUP BY CustomerID
)t

-- SUBQUERY IN SELECT CLAUSE --
--> used to aggregate data side by side with the main query's data, allowing direct comparison.
--> subquery result must be a scalar.

-- show the product IDs, product names, prices, and the total number of orders.
-- main query
SELECT
	ProductID,
	Product,
	Price,
	-- subquery
	(SELECT COUNT(*) FROM orders) AS TotalOrders
FROM Products;

-- SUBQUERY IN JOIN CLAUSE --
--> used to prepare the data(filter or aggregation) before joining it with other tables.

-- show all customer details and find the total orders for each customer.
-- main query
SELECT 
C.*, O. TotalOrders 
FROM Customers C
LEFT JOIN (
	SELECT
	CustomerID,
	COUNT(*) TotalOrders
	FROM orders 
	GROUP BY CustomerID
) O
ON C.CustomerID = O.CustomerID;

-- SUBQUERY IN WHERE CLAUSE --
--> used for complex filtering logic and makes query more flexible and dynamic

-- COMPARISON OPERATORS --
--> used to filter data by comparing two values.
--> subqueries must be scalar.

-- find the products that have higher price than the average price of all products.
SELECT
ProductID,
Price,
(SELECT AVG(Price) FROM Products) AvgPrice
FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products)

-- IN OPERATOR --
--> filter data based on multiple values.
--> checks whether a value matches a value in the list.
--> subquery can have multiplr rows.

-- show the details of orders made by customers from Germany.
SELECT 
*
FROM orders
WHERE CustomerID IN (
	SELECT
	CustomerID
	FROM Customers
	WHERE Country = 'Germany'
)
-- not in germany
SELECT 
*
FROM orders
WHERE CustomerID IN (
	SELECT
	CustomerID
	FROM Customers
	WHERE Country! = 'Germany'
)

-- ANY / ALL SUBQUERIES
--> ANY => checks if a value matches any value within a list,
-- used to check if a value is true for atleast one of the values in a list

-- find female employees whose salaries are greater than the salaries of any male employees
SELECT
	EmployeeID,
	FirstName,
	Salary
FROM Employees
WHERE Gender = 'F'
AND Salary > ANY (SELECT Salary FROM Employees WHERE Gender = 'M');

-- ALL => checks if a value matche ALL values within a list

-- find female employees whose salaries are greater than the salaries of all male employees.
SELECT
	EmployeeID,
	FirstName,
	Salary
FROM Employees
WHERE Gender = 'F'
AND Salary > ALL (SELECT Salary FROM Employees WHERE Gender = 'M');

-- BASED ON DEPENDENCIES --

-- NON-CORRELATED / CORRELATED SUBQUERIES
-- NON-CORRELATED => subquery that can run independent from main query.
-- CORRELATED => subquery that relies on values from the main query.

-- show all customer details and find the total orders of each customer
SELECT *,
(SELECT COUNT(*) FROM orders O WHERE O.CustomerID = C.CustomerID) TotalSales
FROM Customers C

-- EXISTS OPERATOR --
--> checks if a subquery returns any row.

-- show details of orders made by customers in Germany.
SELECT *
FROM orders O
WHERE EXISTS(
	SELECT 1
	FROM Customers C
	WHERE Country = 'Germany'
	AND O.CustomerID = C.CustomerID
)

SELECT *
FROM orders O
WHERE EXISTS(
	SELECT 3
	FROM Customers C
	WHERE Country = 'Germany'
	AND O.CustomerID = C.CustomerID
)

-- show details of orders made by customers not in Germany.
SELECT *
FROM orders O
WHERE NOT EXISTS(
	SELECT 1
	FROM Customers C
	WHERE Country = 'Germany'
	AND O.CustomerID = C.CustomerID
)

SELECT *
FROM orders O
WHERE NOT EXISTS(
	SELECT 3
	FROM Customers C
	WHERE Country = 'Germany'
	AND O.CustomerID = C.CustomerID
)