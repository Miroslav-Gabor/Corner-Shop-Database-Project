
-- Use cornerShop schema
use cornerShop;

-- -----------------------------------------------------
-- Where
-- -----------------------------------------------------

-- Get all employees with the last name 'Reid'
SELECT * FROM EMPLOYEE 
WHERE lastName = 'Reid';

-- Get products that cost more than 3 euro
SELECT * FROM PRODUCT 
WHERE price > 3;


-- Get all sales paid by card
SELECT * FROM SALE 
WHERE paymentMethod = 'Card';

-- Get all shifts on a specific date
SELECT * FROM SHIFT
WHERE startTime BETWEEN '2025-01-01 00:00:00' AND '2025-01-01 23:59:59';

--  Get suppliers located in Ireland
SELECT * FROM SUPPLIER 
WHERE country = 'Ireland';

-- -----------------------------------------------------
-- WHERE….IN
-- -----------------------------------------------------

--  Get employees whose IDs are 1, 4, or 10
SELECT * FROM EMPLOYEE 
WHERE employeeId IN (1, 4, 10);

-- Get all products that belong to categories 1, 2, or 3
SELECT * FROM PRODUCT 
WHERE categoryId IN (1, 2, 3);

--  Get all sales made on any of these three dates
SELECT * FROM SALE 
WHERE DATE(saleTime) IN ('2025-01-01', '2025-01-05', '2025-01-10');

-- -----------------------------------------------------
-- WHERE….BETWEEN
-- -----------------------------------------------------

-- Products priced between 1.00 and 3.00
SELECT * FROM PRODUCT 
WHERE price BETWEEN 1.00 AND 3.00;

--  Employee IDs between 5 and 12
SELECT * FROM EMPLOYEE 
WHERE employeeId BETWEEN 5 AND 12;

-- Sales made during the first hour of a certain day
SELECT * FROM SALE
WHERE DATE(saleTime) = '2025-01-03' AND TIME(saleTime) BETWEEN '00:00:00' AND '01:00:00';


-- Shifts that last between 4 and 8 hours
SELECT shiftId, startTime, endTime
FROM SHIFT
WHERE TIMESTAMPDIFF(HOUR, startTime, endTime) BETWEEN 4 AND 8;

-- -----------------------------------------------------
-- WHERE….LIKE
-- -----------------------------------------------------

-- Employees with first names starting with 'J'
SELECT * FROM EMPLOYEE 
WHERE firstName LIKE 'J%';

-- Products with the word 'Bread' in their name
SELECT * FROM PRODUCT 
WHERE productName LIKE '%Bread%';

-- Suppliers with emails ending in '.ie'
SELECT * FROM SUPPLIER 
WHERE email1 LIKE '%.ie';

-- Employees whose last name contains 'ly'
SELECT * FROM EMPLOYEE 
WHERE lastName LIKE '%ly%';

-- -----------------------------------------------------
-- Date functions
-- -----------------------------------------------------

-- Extract the date part of all start times
SELECT shiftId, DATE(startTime) 
AS shiftDate FROM SHIFT;

-- Count sales made today
SELECT COUNT(*) AS salesToday 
FROM SALE 
WHERE DATE(saleTime) = CURDATE();

-- Show the weekday name for each sale
SELECT saleId, saleTime, DAYNAME(saleTime) AS weekday
FROM SALE;

-- Format the saleTime as DD/MM/YYYY
SELECT saleId, DATE_FORMAT(saleTime, '%d/%m/%Y') AS formattedDate
FROM SALE;

-- -----------------------------------------------------
-- Aggregate functions
-- -----------------------------------------------------
-- Number of employees
SELECT COUNT(*) AS totalEmployees 
FROM EMPLOYEE;

-- Average product price
SELECT AVG(price) AS avgPrice 
FROM PRODUCT;

-- Total quantity sold across all sales (line items)
SELECT SUM(quantity) AS totalUnits
FROM PRODUCT_SALE;

-- Highest total sale amount
SELECT MAX(totalAmount) AS highestSale
FROM SALE;

-- -----------------------------------------------------
-- Group By
-- -----------------------------------------------------
--  Number of sales per shift
SELECT shiftId, COUNT(*) AS saleCount
FROM SALE
GROUP BY shiftId;

-- Total quantity sold of each product
SELECT productId, SUM(quantity) AS totalSold
FROM PRODUCT_SALE
GROUP BY productId;

-- Number of products supplied by each supplier
SELECT supplierId, COUNT(productId) AS productCount
FROM PROD_SUPPLIER
GROUP BY supplierId;

-- Total revenue per day
SELECT DATE(saleTime) AS saleDate, SUM(totalAmount) AS revenue
FROM SALE
GROUP BY DATE(saleTime);

-- -----------------------------------------------------
-- GROUP BY…HAVING
-- -----------------------------------------------------

-- Shifts with more than 2 sales
SELECT shiftId, COUNT(*) AS saleCount
FROM SALE
GROUP BY shiftId
HAVING COUNT(*) > 2;

-- Products where more than 2 units were sold
SELECT productId, SUM(quantity) AS totalQty
FROM PRODUCT_SALE
GROUP BY productId
HAVING SUM(quantity) > 2;

-- Days with total sales over €10
SELECT DATE(saleTime) AS saleDate, SUM(totalAmount) AS total
FROM SALE
GROUP BY DATE(saleTime)
HAVING SUM(totalAmount) > 10;

-- -----------------------------------------------------
-- ORDER BY
-- -----------------------------------------------------

-- List employees by last name alphabetically
SELECT * FROM EMPLOYEE 
ORDER BY lastName ASC;

-- Products sorted by price high to low
SELECT * FROM PRODUCT 
ORDER BY price DESC;

-- Sales sorted by highest totalAmount
SELECT * FROM SALE 
ORDER BY totalAmount DESC;

-- Shifts sorted by date and then startTime
SELECT * FROM SHIFT 
ORDER BY DATE(startTime), 
TIME(startTime);

-- -----------------------------------------------------
-- OUTER JOINs
-- -----------------------------------------------------

-- List all employees and their assigned shifts (including employees with NONE)
SELECT E.employeeId, E.firstName, ES.shiftId
FROM EMPLOYEE E
LEFT JOIN EMPLOYEE_SHIFT ES ON E.employeeId = ES.employeeId;

-- List all shifts and the employees working them (including empty shifts)
SELECT SH.shiftId, SH.startTime, ES.employeeId
FROM SHIFT SH
LEFT JOIN EMPLOYEE_SHIFT ES ON SH.shiftId = ES.shiftId;

-- List all products and their suppliers, including products with no supplier
SELECT P.productId, P.productName, S.supplierName
FROM PRODUCT P
LEFT JOIN PROD_SUPPLIER PS ON P.productId = PS.productId
LEFT JOIN SUPPLIER S ON PS.supplierId = S.supplierId;
