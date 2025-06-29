-- SET OPERATORS --

--> RULES FOR SET OPERATORS --
--> combine the result of multiple queries into a single set result.
--> set operators can be used almost in all clauses :
--> WHERE, JOIN, GROUP BY, HAVING.
--> ORDER BY is allowed only once at the end of query.
--> the number of columns in each query must be the same.
--> data types of columns in each query must be compatible.
--> the order of columns in each query must be same.
--> the column names in the result set are determined by the column names specified in the first query.


USE firstDatabase;

SELECT *
FROM studentDetails;

SELECT *
FROM courseDetails;

-- 1. UNION --
--> returns all distinct rows from both queries.
--> removes duplicate rows from final result.
--> order of queries does not matter.
SELECT 
	id,
	name
FROM studentDetails
UNION
SELECT 
	course_id,
	course_name
FROM courseDetails;

-- 2. UNION ALL --
--> return all rows from both queries, including duplicates.

SELECT 
	id,
	name
FROM studentDetails
UNION ALL
SELECT 
	course_id,
	course_name
FROM courseDetails;

-- 3. EXCEPT --
--> returns distinct rows from first query that are not present in the second query.
--> order of queries is important.

SELECT
	id,
	name
FROM studentDetails
EXCEPT
SELECT
	course_id,
	course_name
FROM courseDetails;

-- 4. INTERSECT --
--> returns common rows between two queries.

SELECT
	id,
	name
FROM studentDetails
INTERSECT
SELECT
	course_id,
	course_name
FROM courseDetails;























