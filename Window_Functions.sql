-- WINDOW FUNCTIONS --
--> perform calculations on a specific subset of data, without losing the level of details of rows.
--> used for advanced data analysis, that overcome the limitations of 'GROUP BY'.

-- RULES FOR WINDOW FUNCTIONS --
--> 1. Window functions can be used only in 'SELECT' and 'ORDER BY' clauses
--> 2. Window functions cannot be used to filter data.
--> 3. Nesting of window functions is not allowed.
--> 4. SQL executes Window Functions after 'WHERE' clause.
--> 5. Window functions can be used together with 'GROUP BY' in the same query, only if the same columns are used.


USE firstDatabase;

CREATE TABLE sales(
	orderID INT,
	orderDate DATE,
	productID INT,
	productName VARCHAR(50),
	price INT,
	totalSales INT
);

DROP TABLE sales

INSERT INTO sales
VALUES
(101, '2025-06-30', 1, 'Caps', 199, 94),
(102, '2025-06-30', 2, 'Gloves', 499, 94),
(103, '2025-07-01', 3, 'Helmets', 499, 94),
(104, '2025-07-01', 4, 'Shirts', 299, 120),
(105, '2025-07-01', 5, 'Pants', 399, 120),
(106, '2025-07-02', 2, 'Gloves', 499, 34),
(107, '2025-07-03', 3, 'Helmets', 499, 21),
(108, '2025-07-03', 6, 'Shades', 199, 100),
(109, '2025-07-04', 4, 'Shirts', 299, 22),
(110, '2025-07-04', 5, 'Pants', 199, 22)

SELECT * FROM sales;

SELECT 
	SUM(totalSales) AS Total_Sales
FROM sales;

-- OVER() --
--> tells SQL that the function used is a window function. It defines a window or subset of data.

SELECT 
	SUM(totalSales) OVER()
FROM sales;

SELECT 
	SUM(totalSales) OVER(PARTITION BY productID) SalesByID
FROM sales;

SELECT 
	orderID,
	orderDate,
	productID,
	SUM(totalSales) OVER(PARTITION BY productID) SalesByID
FROM sales;

-- SYNTAX OF WINDOW FUNCTIONS --
--> Window Function (PARTITION CLAUSE / ORDER CLAUSE / FRAME CLAUSE)

-- PARTITION BY --
--> divides the dataset into groups(partitions).
--> optional for aggregation, rank, value.


SELECT 
	orderID,
	orderDate,
	SUM(totalSales) OVER()
FROM sales;

SELECT 
	orderID,
	orderDate,
	productID,
	SUM(totalSales) OVER(PARTITION BY productID) SalesByID
FROM sales;

SELECT 
	orderID,
	orderDate,
	productID,
	totalSales AS sales,
	SUM(totalSales) OVER() TotalSales,
	SUM(totalSales) OVER(PARTITION BY productID) SalesByID
FROM sales;

SELECT 
	orderID,
	orderDate,
	productID,
	totalSales AS sales,
	price,
	SUM(totalSales) OVER() TotalSales,
	SUM(totalSales) OVER(PARTITION BY productID) SalesByID,
	SUM(totalSales) OVER(PARTITION BY productID, price) SalesByPrice
FROM sales;

-- ORDER BY --
--> optional for aggregation, required for rank, value.

SELECT 
	orderID,
	orderDate,
	productID,
	totalSales AS sales,
	price,
	RANK() OVER(ORDER BY totalSales DESC) RankBySales
FROM sales;

-- WINDOW FRAME --
--> defines a subset of rows within each window that is relevant for calculation.

SELECT 
	orderID,
	orderDate,
	productID,
	totalSales AS sales,
	price,
	SUM(totalSales) OVER(PARTITION BY ProductID ORDER BY totalSales
	ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) TotalSales
FROM sales;

SELECT 
	orderID,
	orderDate,
	productID,
	totalSales AS sales,
	price,
	SUM(totalSales) OVER(ORDER BY totalSales DESC
	ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) TotalSales
FROM sales;

SELECT 
	orderID,
	orderDate,
	productID,
	totalSales AS sales,
	price,
	SUM(totalSales) OVER(ORDER BY totalSales DESC
	ROWS 2 PRECEDING) TotalSales
FROM sales;