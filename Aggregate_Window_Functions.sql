-- WINDOW AGGREGATE FUNCTIONS --
--> function_name(expression) OVER (PARTITION BY column ORDER BY column)
--> expression must always be a numeric value.
--> partion by and order by are optional.

USE firstDatabase;

SELECT * FROM orders;

-- 1. COUNT() --
--> returns number of rows within each window(including null).
--> works for any datatype.
--> COUNT(*) counts null also but COUNT(ColName) excludes null values.
--> COUNT(*) and COUNT(1) give the same result.
--> used to find duplicate rows.

SELECT 
OrderID,
OrderDate,
COUNT(*) OVER()totalOrders,
COUNT(1) OVER(PARTITION BY CustomerID) OrdersByCustomers
FROM orders;

SELECT *,
COUNT(BillAddress) OVER() TotalAddresses
FROM orders;

-- finding duplicates
SELECT OrderID,CustomerID,
COUNT(*) OVER(PARTITION BY OrderID) CheckPK
FROM orders;

SELECT OrderID,CustomerID,
COUNT(*) OVER(PARTITION BY CustomerID) CheckPK
FROM orders;

-- 2. SUM() --
--> returns sum of values within a window
--> accepts only numbers.

SELECT
OrderID,
OrderDate,
Sales,
SUM(Sales) OVER() TotalSales
FROM orders;

SELECT
OrderID,
OrderDate,
Sales,
ProductID,
SUM(Sales) OVER(PARTITION BY ProductID) SalesByID
FROM orders;

-- FIND PERCENTAGE CONTRIBUTION OF EACH PRODUCT'S SALES TO TOTAL SALES
--(part to whole analysis)
SELECT
OrderID,
ProductID,
Sales,
SUM(Sales) OVER() TotalSales,
ROUND(CAST (Sales AS Float) / SUM(Sales) OVER() * 100, 2) PercentageTotal
FROM orders;

-- 3. AVG() --
--> returns average of values within each window.

SELECT
OrderID,
OrderDate,
Sales,
AVG(Sales) OVER() AvgSales
FROM orders;

SELECT
OrderID,
OrderDate,
Sales,
ProductID,
AVG(COALESCE (Sales,0)) OVER(PARTITION BY ProductID) AvgSalesByID
FROM orders;

-- find all orders where sales are higher than average sales across all orders.
SELECT * FROM(
	SELECT
	OrderID,
	Sales,
	ProductID,
	AVG(Sales) OVER() AvgSales
	FROM orders
)t
WHERE Sales > AvgSales

-- 4. MIN() & MAX() --
--> MIN() -- returns lowest value within the window
--> MAX() -- returns highest value within the window

SELECT
OrderID,
OrderDate,
ProductID,
Sales,
MAX(Sales) OVER() HighestSales
FROM orders;

SELECT
OrderID,
OrderDate,
ProductID,
Sales,
MIN(Sales) OVER() LowestSales
FROM orders;

SELECT
OrderID,
OrderDate,
ProductID,
Sales,
MAX(Sales) OVER(PARTITION BY ProductID) HighestSalesByProduct
FROM orders;

SELECT
OrderID,
OrderDate,
ProductID,
Sales,
MIN(Sales) OVER(PARTITION BY ProductID) LowestSalesByProduct
FROM orders;

-- calculate the deviation of each sale from both the minimum and maximum sale amounts.

SELECT
OrderID,
OrderDate,
ProductID,
Sales,
MAX(Sales) OVER() HighestSales,
MIN(Sales) OVER() LowestSales,
Sales - MIN(Sales) OVER() DeviationFromMin,
MAX(Sales)  OVER() - Sales DeviationFromMax
FROM orders;

-- RUNNING TOTAL & ROLLING TOTAL -
--> aggregate sequence of members, and the aggregation is updated each time a new member is added.
--> used for tracking the data.
--> RUNNING => aggregate all values from beginning up to the current point without dropping off older data
--> ROLLING => aggregate all values within a fixed time window, as new data is added older data point will be dropped.

-- MOVING AVERAGES(RUNNING AVERAGE)

SELECT
OrderID,
OrderDate,
ProductID,
Sales,
AVG(Sales) OVER(PARTITION BY ProductID) AvgSalesByProduct,
AVG(Sales) OVER(PARTITION BY ProductID ORDER BY OrderDate) MovingAvg,
AVG(Sales) OVER(PARTITION BY ProductID ORDER BY OrderDate
	ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) RollingAvg
FROM orders;