-- STRING FUNCTIONS IN SQL --

-- STRING MANIPULATION FUNCTIONS --

USE firstDatabase;

SELECT * FROM studentDetails;
SELECT * FROM courseDetails;

-- 1. CONCAT() --
--> combines multiple strings into a string string.

SELECT 
	name,
	department,
CONCAT (name,' ', department) AS details
FROM studentDetails;

-- 2. UPPER() --
--> converts all characters into uppercase.

SELECT 
	name,
	department,
UPPER (name) AS details
FROM studentDetails;

-- 3. LOWER() --
--> converts all characters to lowercase.

SELECT 
	name,
	department,
LOWER (name) AS details
FROM studentDetails;

-- 4. TRIM() --
--> removes all spaces at the start and end of the string.

SELECT 
	name,
	TRIM(name) AS trimmed
FROM studentDetails
WHERE name != TRIM(name);


-- 5. LENGTH() --
--> returns the number of characters in the string.

SELECT
	name,
	LEN(name) AS length_name
FROM studentDetails;


-- 6.REPLACE() -- 
--> replaces or removes certain characters with other characters.

SELECT
	name,
REPLACE(name, 'V', 'v')
FROM studentDetails;

SELECT
	name,
REPLACE(name, 'V', '')
FROM studentDetails;

-- 7. LEFT() --
--> extracts specific number of characters from the start of the string.

SELECT 
	department,
LEFT(department, 2) AS first_two
FROM studentDetails;

-- 8. RIGHT() --
--> extracts specific number of characters from the end of the string.

SELECT 
	department,
RIGHT(department, 2) AS first_two
FROM studentDetails;

-- 9. SUBSTRING() --
--> extracts a particular set of characters from the string.

SELECT
	name,
	SUBSTRING(name, 2,2) AS sub_string
FROM studentDetails;

SELECT
	name,
	SUBSTRING(name, 2,6) AS sub_string
FROM studentDetails;

SELECT
	name,
	SUBSTRING(name, 2,LEN(name)) AS sub_string,
	LEN(SUBSTRING(name, 2,LEN(name))) AS sub_string
FROM studentDetails;