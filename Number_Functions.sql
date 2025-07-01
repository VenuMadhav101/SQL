-- NUMBER FUNCTIONS IN SQL --

USE firstDatabase;

-- 1. ROUND() --
--> rounds off a value upto a certain specified position.
SELECT 
	3.324324,
ROUND(3.324324, 3) AS round_3;

SELECT 
	3.324324,
ROUND(3.324324, 2) AS round_2;

SELECT 
	3.324324,
ROUND(3.324324, 1) AS round_1;

SELECT 
	3.324324,
ROUND(3.324324, 0) AS round_0;

-- 2. ABS() --
--> converts negative numbers or positive numbers into positive values.
SELECT
	-10,
ABS(-10);