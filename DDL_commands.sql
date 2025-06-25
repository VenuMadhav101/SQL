-- DATA DEFINITION LANGUAGE --

--> DDL commands are used to define the schema of the database.
--> Once created, they cannot be rolled back.
--> COMMANDS => 'CREATE', 'ALTER', 'DROP', 'TRUNCATE', 'RENAME'

-- 1. CREATE COMMAND --
--> Used to create new database objects like tables, views etc.

-- create and use database
CREATE DATABASE firstDatabase;
USE firstDatabase;

-- create a table
CREATE TABLE student (
	id INT PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	age INT
);

-- 2. ALTER COMMAND -- 
--> modify the table columns.
ALTER TABLE student ADD email VARCHAR(50);
ALTER TABLE student DROP COLUMN age;
SELECT * FROM student;

-- 3. RENAME COMMAND --
--> change the name of the table.
--> in Microsoft SQL Server =>EXEC sp_rename 'student', 'studentRecords';
--> in MySQL => RENAME TABLE student TO studentRecords;
--> in PostgreSQL => ALTER TABLE student RENAME TO studentRecords;

-- 4. TRUNCATE COMMAND --
--> removes the entire data from the table, but keeps the table.
TRUNCATE TABLE studentRecords;

-- 5. DROP COMMAND --
--> deletes the entire table from the database.
DROP TABLE studentRecords;
