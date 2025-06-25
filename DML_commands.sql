-- DATA MANIPULATION LANGUAGE --
--> DML commands are used to manipulate or change data in the tables
--> COMMANDS => 'INSERT', 'UPDATE', 'DELETE'

USE firstDatabase;
-- 1. INSERT COMMAND --
--> inserts data into the existing table.
INSERT INTO student (id, name, age) VALUES (1, 'Arjun', 20);
INSERT INTO student (id, name, age) VALUES (2, 'Venu', 20);
INSERT INTO student (id, name, age) VALUES (3, 'Divya', 22);

SELECT *
FROM student;

-- 2. UPDATE COMMAND --
--> updates existing values in the table.
UPDATE student SET age = 21 WHERE id = 1;

-- 3. DELETE COMMAND --
--> deletes existing records from the table.
DELETE FROM student WHERE id = 3;

SELECT * FROM student;









