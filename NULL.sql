-- NULL IN SQL --
--> NULL meaning no value. It means "nothing"
--> it indicates a missing value.

USE firstDatabase;
SELECT * FROM studentDetails;
SELECT * FROM courseDetails;

-- NULL FUNCTIONS --

-- 1. IS NULL() --
--> replaces 'NULL' with a specific value.
--> limited to two values.
--> sql server => ISNULL
--> oracle => NVL
--> mysql => IFNULL
/*
syntax:
ISNULL(value, replacement_value)
*/

-- 2. COALESCE() --
--> returns first non-NULL value.
--> unlimited values.
--> same across all databases.
--> syntax ==> COALSCE(value1, value2, value3)

--> handling nulls in aggregation functions
SELECT course_id, student_id,
COALESCE(student_id, 0),
AVG(student_id) OVER() AvgId,
AVG(COALESCE(student_id, 0)) OVER() Avgid
FROM courseDetails;

--> handling nulls in mathematical operations
SELECT course_id, student_id,
COALESCE(student_id, 0) AS col1,
course_id + '' + COALESCE(student_id, 0) AS col2,
(course_id + COALESCE(student_id, 0) + 10) AS col3
FROM courseDetails;

--> using nulls to handle joins
CREATE TABLE tableA(
	orderYear INT PRIMARY KEY,
	orderType VARCHAR(10),
	sales INT
);

CREATE TABLE tableB(
	orderYear INT PRIMARY KEY,
	orderType VARCHAR(10),
	sales INT
);

INSERT INTO tableA
VALUES
(2022, 'A', 60),
(2023, NULL, 30),
(2024, 'B', 50),
(2025, NULL, 70)

INSERT INTO tableB
VALUES
(2022, 'A', 60),
(2023, NULL, 300),
(2024, 'B', 500),
(2025, NULL, 700)

SELECT
tableA.orderYear, tableA.orderType, tableB.sales
FROM tableA
JOIN tableB
ON tableA.orderYear = tableB.orderYear
AND ISNULL (tableA.orderType, '') = ISNULL (tableB.orderType, '');

--> using nulls to handle sorting data
SELECT 
student_id,
fees
FROM courseDetails
ORDER BY student_id;

-- NULLIF() --
--> compares two values and returns NULL if they are equal, and returns first value if they are not
--> syntax : NULLIF(Value1, value2,)
SELECT orderType,
NULLIF(orderType, 'c')
FROM tableA

-- preventing divide by zero
/*
SELECT
orderYear,
sales
sales / NULLIF(quantiy,0)
FROM tableA;
*/

-- ISNULL() --
--> returns true if value is null otherwise false.
--> synatx : "Value IS NULL", "Value IS NOT NULL"

SELECT *
FROM tableA
WHERE orderType IS NULL;

SELECT *
FROM tableA
WHERE orderType IS NOT NULL;

-- NULL vs EMPTY STRING vs BLANK SPACES
--> NULL ==> no value
--> EMPTY STRING ==> string is empty but is there
--> BLANK SPACES ==> empty white space but a string of size










































