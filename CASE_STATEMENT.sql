-- CASE STATEMENT --
--> evaluates a list of conditions and returns a value when the first condition is met.
/* syntax :
CASE
	WHEN condition_1 THEN result_1
	WHEN condition_2 THEN result_2
	ELSE result
END
*/
--> when no else condition is mentioned, 'NULL' is returned.
--> the datatype of result must be matching for every case.

USE firstDatabase;

SELECT * FROM timeStamps;
SELECT * FROM studentDetails;
SELECT * FROM tableA;
-- APPLICATIONS
--> CATEGORIZING DATA
SELECT
sales_category,
SUM(sales) AS total
FROM(
SELECT 
    tableA.sales,
    CASE 
        WHEN tableA.sales > 50 THEN 'HIGH'
        WHEN tableA.sales > 30 THEN 'MEDIUM'
        ELSE 'LOW'
    END AS sales_category
FROM tableA
)t
GROUP BY sales_category
ORDER BY total DESC;


--> MAPPING VALUES
--> transforms values from one form to another.
SELECT
age_group,
COUNT(*) AS total
FROM(
SELECT 
    studentDetails.age,
    CASE 
        WHEN studentDetails.age = 20 THEN 'Eligible'
        WHEN studentDetails.age < 20 THEN 'Not Eligible'
        ELSE 'Error'
    END AS age_group
FROM studentDetails
)t
GROUP BY age_group

--> QUICK FORM
--> works on only one column and works only on '=' operator.
/*
CASE 
    WHEN 'Germany' THEN 'DE'
    WHEN 'India' THEN 'IN'
    WHEN 'United States' THEN 'US'
    WHEN 'United Kingdom' THEN 'UK'
    ELSE 'N/A'
END
*/

--> HANDLING NULLS
SELECT
orderYear,
orderType,
CASE 
    WHEN tableA.orderType IS NULL THEN '0'
    WHEN tableA.orderType IS NOT NULL THEN tableA.orderType
END revisedScore
FROM tableA;