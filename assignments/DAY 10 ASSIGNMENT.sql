USE DA8;
SHOW TABLES;
CREATE TABLE sales 
( 
sale_id INT PRIMARY KEY,
product VARCHAR(50),
category VARCHAR(50), 
units_sold INT, 
unit_price INT, 
region VARCHAR(50)
);

INSERT INTO sales (sale_id, product, category, units_sold, unit_price,region) VALUES 
 (1,'Keyboard', 'Electronics', 10, 1200, 'North'), 
 (2,'Monitor', 'Electronics', 5, 7000, 'South'), 
 (3, 'Chair', 'Furniture',15, 2500, 'North'), 
 (4, 'Desk', 'Furniture', 7, 4500, 'West'),
 (5,'Mouse', 'Electronics', 20, 800, 'East'), 
 (6, 'Sofa', 'Furniture', 3,15000, 'South'), 
 (7, 'Headphones', 'Electronics', 8, 1800, 'North'), 
 (8,'Laptop', 'Electronics', 6, 55000, 'West'), 
 (9, 'Table', 'Furniture',12, 6000, 'East'), 
 (10, 'Fan', 'HomeAppliance', 18, 3000, 'South'), 
 (11,'AC', 'HomeAppliance', 4, 35000, 'North'), 
 (12, 'Cupboard', 'Furniture',5, 12000, 'West'), 
 (13, 'Printer', 'Electronics', 9, 9000, 'East'), 
 (14,'Bed', 'Furniture', 2, 25000, 'South'), 
 (15, 'Mobile', 'Electronics',14, 20000, 'North');
SELECT*FROM SALES;	
SELECT*FROM SALES WHERE CATEGORY='ELECTRONICS';
SELECT*FROM SALES WHERE UNIT_PRICE>10000;
SELECT*FROM SALES WHERE REGION='NORTH';
SELECT*FROM SALES WHERE UNITS_SOLD BETWEEN 5 AND 15;
SELECT*FROM SALES WHERE CATEGORY='FURNITURE' AND UNIT_PRICE>5000;
SELECT category, SUM(units_sold) AS total_units 
FROM sales 
GROUP BY category 
HAVING SUM(units_sold) > 20;
SELECT region, SUM(units_sold * unit_price) AS total_revenue 
FROM sales 
GROUP BY region 
HAVING SUM(units_sold * unit_price) > 50000;
SELECT category, COUNT(*) AS product_count 
FROM sales 
GROUP BY category 
HAVING COUNT(*) > 2;
SELECT category, AVG(unit_price) AS avg_price 
FROM sales 
GROUP BY category 
HAVING AVG(unit_price) < 5000;
SELECT region, COUNT(*) AS electronics_count 
FROM sales 
WHERE category = 'Electronics' 
GROUP BY region 
HAVING COUNT(*) > 1;
SELECT category, SUM(units_sold) AS total_units 
FROM sales 
GROUP BY category 
ORDER BY total_units DESC;
SELECT region, AVG(unit_price) AS avg_price 
FROM sales 
GROUP BY region 
ORDER BY region ASC;
SELECT category, SUM(units_sold * unit_price) AS total_revenue 
FROM sales 
GROUP BY category 
ORDER BY total_revenue DESC;
SELECT region, COUNT(*) AS product_count 
FROM sales 
GROUP BY region 
ORDER BY product_count DESC;
SELECT region, SUM(units_sold) AS total_units 
FROM sales 
GROUP BY region 
ORDER BY region ASC;
SELECT region, SUM(units_sold * unit_price) AS total_revenue 
FROM sales 
GROUP BY region 
HAVING SUM(units_sold * unit_price) > 20000 
ORDER BY total_revenue DESC;
SELECT category, SUM(units_sold) AS total_units 
FROM sales 
GROUP BY category 
HAVING SUM(units_sold) > 10 
ORDER BY category ASC;
SELECT region, COUNT(*) AS product_count 
FROM sales 
GROUP BY region 
HAVING COUNT(*) > 1 
ORDER BY region ASC;
SELECT category, AVG(unit_price) AS avg_price 
FROM sales 
GROUP BY category 
HAVING AVG(unit_price) < 6000 
ORDER BY avg_price ASC;
SELECT category, AVG(units_sold) AS avg_units 
FROM sales 
GROUP BY category 
HAVING AVG(units_sold) > 5 
ORDER BY avg_units DESC;
SELECT region, SUM(units_sold) AS total_units 
FROM sales 
WHERE category = 'Electronics' 
GROUP BY region 
HAVING SUM(units_sold) > 15 
ORDER BY total_units DESC;
SELECT category, SUM(units_sold * unit_price) AS total_revenue 
FROM sales 
WHERE unit_price > 2000 
GROUP BY category 
HAVING SUM(units_sold * unit_price) > 100000 
ORDER BY total_revenue DESC;
SELECT region, AVG(unit_price) AS avg_price 
FROM sales 
WHERE units_sold >= 5 
GROUP BY region 
HAVING AVG(unit_price) > 5000 
ORDER BY region ASC;
SELECT category, COUNT(*) AS product_count 
FROM sales 
WHERE region IN ('North', 'South') 
GROUP BY category 
HAVING COUNT(*) > 2 
ORDER BY product_count DESC;
SELECT region, SUM(units_sold * unit_price) AS total_revenue 
FROM sales 
WHERE unit_price < 10000 
GROUP BY region 
HAVING SUM(units_sold * unit_price) > 50000 
ORDER BY total_revenue DESC;
SELECT region, SUM(units_sold * unit_price) AS total_revenue 
FROM sales 
WHERE unit_price < 10000 
GROUP BY region 
HAVING SUM(units_sold * unit_price) > 50000 
ORDER BY total_revenue DESC;


