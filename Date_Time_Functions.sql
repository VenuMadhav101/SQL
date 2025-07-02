-- DATE & TIME FUNCTIONS IN SQL --
--> also known as timestamp in PostgreSQL, and MySQL.

USE firstDatabase;

CREATE TABLE timeStamps (
	orderID INT PRIMARY KEY,
	orderDate DATE,
	deliveryDate DATE,
	deliveryTime TIME
);

SELECT * FROM timeStamps;

INSERT INTO timeStamps
VALUES
(1, '2025-06-20', '2025-06-25', '12:45:34'),
(2, '2025-06-22', '2025-06-25', '17:23:54'),
(3, '2025-06-25', '2025-06-29', '09:06:22'),
(4, '2025-06-25', '2025-06-29', '20:02:15'),
(5, '2025-06-26', '2025-06-30', '21:57:23'),
(6, '2025-06-27', '2025-07-01', '16:47:12'),
(7, '2025-06-29', '2025-07-01', '20:02:15'),
(8, '2025-06-29', '2025-07-01', '21:16:45'),
(9, '2025-06-30', '2025-07-02', '08:02:09'),
(10, '2025-06-30', '2025-07-02', '11:45:11');

-- GETTING DATES FROM TABLE --

SELECT * FROM timeStamps;

SELECT orderDate FROM timeStamps;

SELECT 
	orderDate,
	'2025-07-02' AS Hardcoded
FROM timeStamps;

SELECT 
GETDATE() Today
FROM timeStamps;

-- DATE AND TIME FUNCTIONS --

--> get the date
SELECT 
	deliveryDate,
	DAY(deliveryDate)
FROM timeStamps;

--> get the month
SELECT 
	deliveryDate,
	MONTH(deliveryDate)
FROM timeStamps;

--> get the year
SELECT 
	deliveryDate,
	YEAR(deliveryDate) Year
FROM timeStamps;

-- DATEPART() --
--> returns specific part of the date as a number.

--> get month
SELECT
DATEPART(month, deliveryDate) AS month_part
FROM timeStamps;

SELECT
DATEPART(mm, deliveryDate) AS month_part
FROM timeStamps;

--> get year
SELECT
DATEPART(year, deliveryDate) AS Year_Part
FROM timeStamps;

--> get day
SELECT
DATEPART(day, deliveryDate) AS day_Part
FROM timeStamps;

--> get hour
SELECT
DATEPART(hour, deliveryTime) AS hour_Part
FROM timeStamps;

--> get minutes
SELECT
DATEPART(minute, deliveryTime) AS minute_Part
FROM timeStamps;

--> get seconds
SELECT
DATEPART(second, deliveryTime) AS second_Part
FROM timeStamps;

--> get quarter
SELECT
DATEPART(quarter, orderDate) AS q_Part
FROM timeStamps;

--> get day of week
SELECT
DATEPART(weekday, deliveryDate) AS week_day_Part
FROM timeStamps;

--> get week
SELECT
DATEPART(week, deliveryDate) AS week_Part
FROM timeStamps;

-- DATENAME() --
--> returns specific part of the date as a string.

SELECT
DATENAME(year, deliveryDate)
FROM timeStamps;

--> get month name
SELECT
DATENAME(month, deliveryDate)
FROM timeStamps;

--> get day name
SELECT
DATENAME(weekday, deliveryDate)
FROM timeStamps;

SELECT
DATENAME(day, deliveryDate)
FROM timeStamps;

-- DATETRUNC() --
--> truncates the date to a specific part.

SELECT
DATETRUNC(year, deliveryDate)
FROM timeStamps;

SELECT
DATETRUNC(month, deliveryDate)
FROM timeStamps;

SELECT
DATETRUNC(day, deliveryDate)
FROM timeStamps;

SELECT
DATETRUNC(hour, deliveryTime)
FROM timeStamps;

SELECT
DATETRUNC(minute, deliveryTime)
FROM timeStamps;

SELECT
DATETRUNC(second, deliveryTime)
FROM timeStamps;


SELECT
DATETRUNC(month, orderDate),
COUNT(*)
FROM timeStamps
GROUP BY DATETRUNC(month, orderDate);

-- EOMONTH() --
--> returns the last day of a month.

SELECT
EOMONTH(orderDate) EndofMonth
FROM timeStamps;

--> get first day of month
SELECT
DATETRUNC(MONTH, orderDate)
FROM timeStamps;

-- DATE FORMAT --
--> yyyy-MM-dd HH-mm-ss ==> FORMAT SPECIFIERS
--> ISO STANDARD ==> yyyy-MM-dd
--> USA STANDARD ==> MM-dd-yyyy
--> EUROPEAN STANDARD ==> dd-MM-yyyy
--> INDIAN STANDARD ==> dd-MM-yyyy

-- FORMATTING AND CASTING --
--> FORMATTING ==> changing the appearance of date.
--> CASTING ==> changing the datatype of data.

-- FORMAT() --
SELECT
FORMAT(orderDate, 'dd/MM/yyyy')
FROM timeStamps;

SELECT
FORMAT(orderDate, 'dddd')
FROM timeStamps;

SELECT
FORMAT(orderDate, 'ddd')
FROM timeStamps;

SELECT
FORMAT(orderDate, 'dd')
FROM timeStamps;

SELECT
FORMAT(orderDate, 'MM')
FROM timeStamps;

SELECT
FORMAT(orderDate, 'MMM')
FROM timeStamps;

SELECT
FORMAT(orderDate, 'MMMM')
FROM timeStamps;

SELECT
FORMAT(orderDate,'MM-dd-yyyy')
FROM timeStamps;

SELECT
FORMAT(12345678.99, 'D', 'en-US')
FROM timeStamps;

SELECT
    'Day ' + FORMAT(orderDate, 'ddd MMM') +
    ' Q' + DATENAME(QUARTER, orderDate) + ' ' +
    FORMAT(orderDate, 'yyyy') + ' ' +
    FORMAT(CAST(deliveryTime AS DATETIME), 'HH:mm:ss tt')
FROM timeStamps;

-- CONVERT() --

SELECT
CONVERT(INT, '1234')

SELECT
CONVERT(INT, 'VENU')
--> error

SELECT
CONVERT(DATE, '2025-03-24')

SELECT
CONVERT(DATE, orderDate)
FROM timeStamps

SELECT
CONVERT(VARCHAR, orderDate, 32)
FROM timeStamps

SELECT
CONVERT(VARCHAR, orderDate, 34)
FROM timeStamps

-- CAST() --
SELECT
CAST(123 AS VARCHAR),
CAST('123' AS INT),
CAST('2025-08-20' AS DATE),
CAST('2025-08-20' AS DATETIME)

-- DATEADD() --
--> adds/subtracts a specific time interval to/from a date.
SELECT
DATEADD(year, 2 , orderDate)
FROM timeStamps;

SELECT
DATEADD(month, -3 , orderDate)
FROM timeStamps;

-- DATEDIFF() --
--> find the difference between two dates.
SELECT
DATEDIFF(year, orderDate, deliveryDate)
FROM timeStamps;

SELECT
DATEDIFF(month, orderDate, deliveryDate)
FROM timeStamps;

SELECT
DATEDIFF(day, orderDate, deliveryDate)
FROM timeStamps;

-- ISDATE() --
--> check whether a value is date or not, returns '0' if no, '1' if yes.
SELECT
ISDATE('2025-09-23')

SELECT
ISDATE('2025-9-2')

SELECT
ISDATE('2025')

SELECT
ISDATE('2025-09')

SELECT
ISDATE('202')