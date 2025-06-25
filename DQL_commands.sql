-- DATA QUERY LANGUAGE --
--> used to retrieve/query data in the database.
--> mostly works with 'SELECT' command.

USE firstDatabase;

CREATE TABLE course(
	courseID INT PRIMARY KEY,
	courseName VARCHAR(50),
	instructor VARCHAR(50),
	enrollments INT
);

INSERT INTO course(courseID, courseName, instructor, enrollments)
VALUES 
(101, 'OS', 'Shradha', 45),
(102, 'DBMS', 'Riti', 56),
(103, 'SD', 'Raj', 78),
(104, 'CN', 'Kunal', 67)

INSERT INTO student (id, name, age) VALUES (3, 'Divya', 22);
INSERT INTO student (id, name, age) VALUES (4, 'Keerthi', 22);

-- 1. "SELECT *" COMMAND --
--> retrieves the entire data in the table.
SELECT * FROM student;
SELECT * FROM course;

-- 2. "SELECT column" COMMAND --
--> retrieves specific columns from the table.
SELECT 
	id,
	name
FROM student;
SELECT 
	courseID,
	courseName
FROM course;

-- 3. FILTER DATA WITH "WHERE" --
--> retrieves data that satisfies the given condition.
SELECT *
FROM student
WHERE id = 1;

-- 4. SORT THE DATA USING "ORDER BY" --
--> sorts the data in ascending or descending order.
SELECT * 
FROM student
ORDER BY name ASC, age DESC;
SELECT * FROM course ORDER BY courseID DESC;
SELECT * FROM course ORDER BY enrollments ASC;

-- 5. GROUPING DATA USING "GROUP BY" --
--> groups the data.
SELECT SUM(enrollments)
FROM course
GROUP BY courseName;

SELECT SUM(enrollments)
FROM course
GROUP BY courseName, instructor;

-- MULTIPLE GROUP BY COLUMNS --
/*
SELECT country, first_name, SUM(score) AS total_score
FROM customers
GROUP BY country, first_name;

-- GROUP BY + COUNT()
SELECT country, COUNT(id) AS total_customers, SUM(score) AS total_score
FROM customers
GROUP BY country;
*/

-- 6. GROUPING DATA USING "HAVING" --
SELECT SUM(enrollments) AS totalEnrollments
FROM course
GROUP BY courseName
HAVING SUM(enrollments) > 40;

-- 7. SELECTING DISTINCT VALUES --
SELECT DISTINCT name FROM student;

-- 8. LIMITING RESULTS USING "TOP" --
--> returns only specified number number of rows/columns.
SELECT TOP 2 * FROM course ORDER BY enrollments DESC;

-- 9. ADDING STATIC COLUMNS --
--> does not change anything in the actual database.
SELECT id, name, 'New Student' AS department FROM student;