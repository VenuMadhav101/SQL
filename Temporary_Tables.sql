---------- TEMPORARY TABLES ---------
--> stores intermediate results in temporary storage within the database during the session.
-- > db drops the tables after the session ends.

USE firstDatabase;

SELECT 
*
INTO #orders
FROM orders


SELECT *
FROM #orders


DELETE FROM #orders
WHERE OrderStatus = 'Delivered'

SELECT 
*
INTO ordersTest
FROM orders

