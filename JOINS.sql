-- JOINS IN SQL -- 
--> used to append multiple columns from different tables.

USE firstDatabase;

CREATE TABLE studentDetails(
	id INT PRIMARY KEY,
	name VARCHAR(50),
	department VARCHAR(10),
	age INT
);

INSERT INTO studentDetails
VALUES
(1, 'Venu', 'CSE-AIML', 20),
(2, 'Vandana', 'IT', 19),
(3, 'Abhishek', 'CSE-DS', 20),
(4, 'Rahul', 'CSE', 22),
(5, 'Rohit', 'CSE', 20),
(6, 'Manasa', 'CSO', 19),
(7, 'Gayatri', 'CSE-AIML', 20),
(8, 'Rahul', 'IT', 22);

SELECT * FROM studentDetails;

CREATE TABLE courseDetails(
	course_id INT PRIMARY KEY,
	course_name VARCHAR(50),
	department VARCHAR(10),
	fees INT,
	student_id INT
);

INSERT INTO courseDetails
VALUES
(101, 'OS', 'CSE-AIML', 200, 1),
(102, 'IoT', 'IT', 190, 2),
(103, 'BEFA', 'CSE-DS', 230, 3),
(104, 'SEM', 'CSE', 252, 4),
(105, 'SS', 'EEE', 422, NULL),
(106, 'SD', 'ECE', 456, NULL),
(107, 'EG', 'CE', 420, NULL),
(108, 'DM', 'ME', 256, NULL);

SELECT * FROM studentDetails;
SELECT * FROM courseDetails;

-- WHY DO WE NEED JOINS ? --
-- 1. To combine the data in order to get a complete picture.
-- 2. Enrich the data by getting additional information.
-- 3. Filter the data.

-- TYPES OF JOINS --

-- 1. NO JOIN --
--> does not join any table.
SELECT * FROM studentDetails;
SELECT * FROM courseDetails;

-- 2. INNER JOIN --
--> returns the matching rows from both tables.
--> inner join is the default join type.
--> Q) Get the details of all students who enrolled in a course.
SELECT *
FROM studentDetails
INNER JOIN courseDetails
ON studentDetails.id = courseDetails.student_id;

SELECT 
	s.id,
	s.name,
	c.course_id,
	c.department
FROM studentDetails AS s
INNER JOIN courseDetails AS c
ON s.id = c.student_id;

-- 3. LEFT JOIN --
--> returns all rows from left table and only matching data from right table.
SELECT 
	s.id,
	s.name,
	c.course_id,
	c.department
FROM studentDetails AS s
LEFT JOIN courseDetails AS c
ON s.id = c.student_id;

SELECT 
	c.course_id,
	c.department,
	s.id,
	s.name
FROM courseDetails AS c
LEFT JOIN studentDetails AS s
ON c.student_id = s.id;

-- 3. RIGHT JOIN --
--> returns all rows from right table and only matching data from left table.
--> left join is mostly preferred over right join
SELECT 
	c.course_id,
	c.department,
	s.id,
	s.name
FROM courseDetails AS c
RIGHT JOIN studentDetails AS s
ON c.student_id = s.id;

SELECT 
	s.id,
	s.name,
	c.course_id,
	c.department
FROM studentDetails AS s
RIGHT JOIN courseDetails AS c
ON s.id = c.student_id;

-- 4. FULL JOIN --
--> returns all rows from both tables.
--> no duplicates
SELECT *
FROM studentDetails AS s
FULL JOIN courseDetails AS c
ON s.id = c.student_id

-- 5. LEFT ANTI-JOIN --
--> returns all rows from left table that have no match in the right table.
SELECT *
FROM studentDetails AS s
LEFT JOIN courseDetails AS c
ON s.id = c.student_id
WHERE c.course_id IS NULL;

SELECT *
FROM courseDetails AS c
LEFT JOIN studentDetails AS s
ON c.course_id = s.id
WHERE c.student_id IS NULL;

-- 6. RIGHT ANTI-JOIN --
--> returns all rows from right table that have no match in the left table.
SELECT *
FROM studentDetails AS s
RIGHT JOIN courseDetails AS c
ON s.id = c.student_id
WHERE s.id IS NULL;

SELECT *
FROM courseDetails AS c
RIGHT JOIN studentDetails AS s
ON c.student_id = s.id
WHERE c.student_id IS NULL;

-- 7. FULL ANTI-JOIN --
--> returns rows that don't match in either rows.
SELECT *
FROM studentDetails AS s
FULL JOIN courseDetails AS c
ON s.id = c.course_id
WHERE 
	s.id IS NULL
OR
	c.course_id IS NULL

-- 8. ADVANCED INNER JOIN --
SELECT *
FROM studentDetails AS s
LEFT JOIN courseDetails AS c
ON s.id = c.student_id
WHERE c.student_id IS NOT NULL

-- 9. CROSS JOIN (CARTESIAN JOIN) --
--> returns all combination of all rows from both tables.
SELECT *
FROM studentDetails
CROSS JOIN courseDetails;