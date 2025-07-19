-- DB TABLES --
--> a table is a structured collection of data, similar to a spreadsheet or grid.
--> CTAS => Create Table As Select => creates a new table based on the result of an SQL query
USE firstDatabase

IF OBJECT_ID('MonthlyOrders', 'U') IS NOT NULL
	DROP TABLE MonthlyOrders
GO
SELECT 
	DATENAME(month,OrderDate) OrderMonth,
	COUNT(OrderID) TotalOrders
INTO MonthlyOrders
FROM orders GROUP BY DATENAME(month,OrderDate)

SELECT * FROM MonthlyOrders


-- to update data, drop the table and then create it again.
