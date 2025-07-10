-- RANKING WINDOW FUNCTIONS --
--> assigns a value to each row
--> integer based ranking and percentage based ranking.
--> expression is empty(except ntile).

USE firstDatabase;
SELECT * FROM orders;
SELECT * FROM OrdersArchive;

-- 1. ROW_NUMBER() --
--> assigns a unique number to each row.
--> it does not handle ties(rows with same val-ues).
--> no skipping of ranks.

SELECT 
OrderID, 
ProductID,
Sales,
ROW_NUMBER() OVER(ORDER BY Sales DESC) SalesRankRow
FROM orders;

-- 2 .RANK() --
--> assigns a rank to each row.
--> it handles ties.
--> it leaves gap in rankings.

SELECT 
OrderID, 
ProductID,
Sales,
ROW_NUMBER() OVER(ORDER BY Sales DESC) SalesRankRow,
RANK() OVER(ORDER BY Sales DESC) SalesRankRank
FROM orders;

-- 3. DENSE_RANK() --
--> assigns rank to each row.
--> it handles ties.
--> it does not leave gaps in ranking.

SELECT 
OrderID, 
ProductID,
Sales,
ROW_NUMBER() OVER(ORDER BY Sales DESC) SalesRankRow,
RANK() OVER(ORDER BY Sales DESC) SalesRankRank,
DENSE_RANK() OVER(ORDER BY Sales DESC) SalesRankDense
FROM orders;

-- USES CASES ==> TOP_N ANALYSIS
--> find top highest sales for each product.

SELECT * FROM
	(SELECT 
	OrderID, 
	ProductID,
	Sales,
	ROW_NUMBER() OVER(PARTITION BY ProductID ORDER BY Sales DESC) SalesRanKByProduct
FROM orders
)t WHERE SalesRanKByProduct = 1;

-- USES CASES ==> BOTTOM_N ANALYSIS
--> find lowest 2 customers based on their total sales.

SELECT *
FROM(
	SELECT 
		CustomerID,
		SUM(Sales) TotalSales,
		ROW_NUMBER() OVER(ORDER BY SUM(Sales) ASC) Lowest2Customers
	FROM orders
	GROUP BY CustomerID
)t
WHERE Lowest2Customers <= 2

-- USE CASES ==> GENERATE UNIQUE IDs --
--> assign unique IDs to the rows of the orders archive.

SELECT 
ROW_NUMBER() OVER(ORDER BY OrderID, OrderDate) UniqueID,
*
FROM OrdersArchive;

--> PAGINATING - the process of breaking down a large dataset into smaller, manageable chunks.

-- USE CASES ==> IDENTIFYING AND REMOVING DUPLICATES --
--> identify duplicate rows inthe table 'Orders Archive' and return a clean result without any duplicates.
SELECT *
FROM(
	SELECT
	ROW_NUMBER() OVER(PARTITION BY OrderID ORDER BY CreationTime DESC) rn,
	*
	FROM OrdersArchive
)t WHERE rn = 1;

SELECT *
FROM(
	SELECT
	ROW_NUMBER() OVER(PARTITION BY OrderID ORDER BY CreationTime DESC) rn,
	*
	FROM OrdersArchive
)t WHERE rn > 1;

-- 4. NTILE() --
--> divide the rows into specific number of equal groups(known as buckets).
--> bucket_size = no.of rows / no. of buckets.
--> larger size buckets come first then smaller.

SELECT 
OrderID,
Sales,
NTILE(1)  OVER(ORDER BY Sales DESC) OneBucket,
NTILE(2)  OVER(ORDER BY Sales DESC) TwoBucket,
NTILE(3)  OVER(ORDER BY Sales DESC) ThreeBucket,
NTILE(4)  OVER(ORDER BY Sales DESC) FourBucket,
NTILE(5)  OVER(ORDER BY Sales DESC) FiveBucket
FROM orders

-- NTILE USE CASES ==> DATA SEGMENTATION
-- segment all orders into 3 categories -high, medium, low - sales.

SELECT *,
CASE 
	WHEN Buckets = 1 THEN 'HIGH'
	WHEN Buckets = 2 THEN 'MEDIUM'
	WHEN Buckets = 3 THEN 'LOW'
END SalesSegmentations
FROM (
	SELECT
		OrderID,
		Sales,
		NTILE(3) OVER(ORDER BY Sales DESC) Buckets
	FROM orders
)t

-- NTILE USE CASES ==> EQUALIZING LOAD(LOAD BALANCING)
-- split the load -> ssend it -> recombine it

SELECT 
	NTILE(2) OVER(ORDER BY OrderID) Buckets,
	*
FROM orders

-- PERCENTAGE BASED RANKING
--> assign ranks rows on a continuous values basis between 0 and 1.

-- 1. CUME_DIST()
--> cumulative distribution calculates the distribution of data points within a window.
-- CUME_DIST = Position Number of the Value / Number of Rows
--> if a tie is found, the last position number is considered for both the tie values.

SELECT 
	OrderID,
	Sales,
	CUME_DIST()  OVER(ORDER BY Sales DESC) Cume_Dist_Rank
FROM orders

-- 2. PERCENT_RANK() --
--> calculate the relative position of each row within a window.
--> Percent_Rank = (Position Number - 1) / (Number of Rows -1)
--> if a tie is found, the first position number is considered for both the tie values.


SELECT 
    OrderID,
    Sales,
    CAST(PERCENT_RANK() OVER(ORDER BY Sales DESC) AS DECIMAL(4, 2)) AS Percent_Rank
FROM orders;

-- USES CASES
-- find the top 40% of sales.

SELECT *,
CONCAT (Cume_Dist_Rank * 100, '%')
FROM (
	SELECT 
		OrderID,
		Sales,
		CUME_DIST() OVER(ORDER BY Sales DESC) AS Cume_Dist_Rank
FROM orders
)t
WHERE Cume_Dist_Rank <= 0.4


SELECT *,
CONCAT (Percent_Rank * 100, '%')
FROM (
	SELECT 
		OrderID,
		Sales,
		PERCENT_RANK() OVER(ORDER BY Sales DESC) AS Percent_Rank
FROM orders
)t
WHERE Percent_Rank <= 0.4