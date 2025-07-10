-- VALUE WINDOW FUNCTIONS --
--> used to access values from other rows based on data from the current row.

USE firstDatabase;

--------------- LEAD() & LAG() ---------------

--> LEAD() ==> access a value from the next row within a window.
--> LAG() ==> access a value from the previous row within a window.
--> expression can be any data type and compulsory.
--> offset(optional) ==> no. of rows forward or backward from current row, default is 1.
--> default value(optional) ==> returns default value if next/previous row is not available, default is 'NULL'.
--> PARTITION BY is optional, ORDER BY is compulsory.

-- find sales for next/previous month
SELECT 
	OrderID,
	OrderDate,
	ProductID,
	Sales,
	LEAD(Sales) OVER (ORDER BY OrderDate) AS Lead_Values,
	LAG(Sales) OVER (ORDER BY OrderDate) AS Lag_Values
FROM orders;

-- sales two months ahead/ago
SELECT 
	OrderID,
	OrderDate,
	ProductID,
	Sales,
	LEAD(Sales, 2, 0) OVER (ORDER BY OrderDate) AS Lead_Values,
	LAG(Sales, 2, 0) OVER (ORDER BY OrderDate) AS Lag_Values
FROM orders;

--------------- Time Series Analysis ---------------
-- analyze the month-over-month(MoM) performance by finding the percentage change in sales between the current and previous month.

SELECT *,
CurrentMonthSales - PreviousMonthSales AS MoM_Changes,
ROUND(CAST((CurrentMonthSales - PreviousMonthSales) AS FLOAT)/PreviousMonthSales * 100, 2) AS MoMChangesMonth
FROM (
	SELECT 
		MONTH(OrderDate) OrderMonth,
		SUM(Sales) CurrentMonthSales,
		LAG(SUM(Sales)) OVER (ORDER BY MONTH(OrderDate)) PreviousMonthSales,
		LEAD(SUM(Sales)) OVER (ORDER BY MONTH(OrderDate)) NextMonthSales
FROM orders
GROUP BY MONTH(OrderDate)
)t

-- CUSTOMER RETENTION ANALYSIS
--> measuring a customer's behaviour and loyalty to help businesses build string relationships with customers.
-- analyze customer loyalty by ranking customers based on the average number of days between orders.

SELECT 
CustomerID,
AVG(OrdersGap) AvgGap,
RANK() OVER (ORDER BY COALESCE(AVG(OrdersGap), 999999)) RankAvg
FROM (
	SELECT 
	OrderID,
	CustomerID,
	OrderDate AS CurrentOrder,
	LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate) NextOrder,
	DATEDIFF(day, OrderDate, LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate)) OrdersGap
FROM orders
)t
GROUP BY CustomerID

--------------- FIRST_VALUE & LAST_VALUE ---------------
--> access values from first/last row within the window.
-- find the lowest and highest sales of each product.

SELECT 
	OrderID,
	ProductID,
	Sales,
	FIRST_VALUE(Sales) OVER (PARTITION BY ProductID ORDER BY Sales) LowestSales,
	LAST_VALUE(Sales) OVER (PARTITION BY ProductID ORDER BY Sales
	ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) HighestSales
FROM orders

-- other method using first value
SELECT 
	OrderID,
	ProductID,
	Sales,
	FIRST_VALUE(Sales) OVER (PARTITION BY ProductID ORDER BY Sales) LowestSales,
	FIRST_VALUE(Sales) OVER (PARTITION BY ProductID ORDER BY Sales DESC) HighestSales
FROM orders

-- another way using MIN/MAX
SELECT 
	OrderID,
	ProductID,
	Sales,
	MIN(Sales) OVER (PARTITION BY ProductID) LowestSales,
	MAX(Sales) OVER (PARTITION BY ProductID) HighestSales
FROM orders