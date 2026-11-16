CREATE DATABASE jeevan_raksha_pharmacy;
USE jeevan_raksha_pharmacy;
CREATE TABLE orders (
    order_id     INT AUTO_INCREMENT PRIMARY KEY,
    customer_id  INT,
    order_date   DATE,
    total_amount DECIMAL(10,2),
    payment_mode ENUM('UPI', 'Cash', 'Card'),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(100),
    phone       VARCHAR(15),
    city        VARCHAR(50)
);
CREATE TABLE suppliers (
    supplier_id    INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name  VARCHAR(100),
    contact_person VARCHAR(100),
    phone          VARCHAR(15)
);

CREATE TABLE medicines (
    medicine_id    INT AUTO_INCREMENT PRIMARY KEY,
    name           VARCHAR(100),
    category       VARCHAR(50),
    price          DECIMAL(10,2),
    stock_quantity INT,
    expiry_date    DATE,
    supplier_id    INT,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

CREATE TABLE order_items (
    item_id     INT AUTO_INCREMENT PRIMARY KEY,
    order_id    INT,
    medicine_id INT,
    quantity    INT,
    subtotal    DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (medicine_id) REFERENCES medicines(medicine_id)
);

INSERT INTO customers (name, phone, city) VALUES
('Rahul Sharma', '9876543210', 'Mumbai'),
('Priya Verma',  '9123456789', 'Delhi'),
('Amit Patel',   '9988776655', 'Ahmedabad'),
('Sneha Reddy',  '8877665544', 'Hyderabad'),
('Vikram Singh', '7766554433', 'Mumbai');

INSERT INTO suppliers (supplier_name, contact_person, phone) VALUES
('Apollo Distributors',   'Rajesh Gupta', '022-123456'),
('MedPlus Supply Chain',  'Suresh Nair',  '040-987654'),
('Himalaya Wellness',     'Anjali Mehta', '011-456789');


INSERT INTO medicines (name, category, price, stock_quantity, expiry_date, supplier_id) VALUES
('Dolo 650',     'Tablet',    30.00,  500, '2025-12-31', 1),
('Azithral 500', 'Tablet',   120.00,   50, '2024-05-20', 1),
('Benadryl',     'Syrup',    110.00,   20, '2024-11-15', 2),
('Combiflam',    'Tablet',    45.00,  200, '2026-01-01', 3),
('Insulin Pen',  'Injection',800.00,    5, '2024-03-10', 2);

INSERT INTO orders (customer_id, order_date, total_amount, payment_mode) VALUES
(1, '2023-10-01', 150.00,  'UPI'),
(2, '2023-10-02', 240.00,  'Card'),
(3, '2023-10-05',  45.00,  'Cash'),
(1, '2023-10-10', 800.00,  'UPI'),
(4, '2023-10-12',1200.00,  'Card');

INSERT INTO order_items (order_id, medicine_id, quantity, subtotal) VALUES
(1, 1, 5, 150.00),  -- Rahul bought 5 Dolo 650
(2, 2, 2, 240.00),  -- Priya bought 2 Azithral 500
(3, 4, 1,  45.00),  -- Amit  bought 1 Combiflam
(4, 5, 1, 800.00),  -- Rahul bought 1 Insulin Pen
(5, 5, 1, 800.00),  -- Sneha bought 1 Insulin Pen
(5, 2, 2, 240.00),  -- Sneha bought 2 Azithral 500
(5, 1, 5, 150.00);  -- Sneha bought 5 Dolo 650

select name,city from customers;


CREATE INDEX idx_medicines_supplier   ON medicines(supplier_id);
CREATE INDEX idx_orders_customer      ON orders(customer_id);
CREATE INDEX idx_orderitems_order     ON order_items(order_id);
CREATE INDEX idx_orderitems_medicine  ON order_items(medicine_id);
CREATE INDEX idx_medicines_category   ON medicines(category);
CREATE INDEX idx_medicines_expiry     ON medicines(expiry_date);
CREATE INDEX idx_customers_city       ON customers(city);
CREATE INDEX idx_orders_paymentmode   ON orders(payment_mode);
CREATE INDEX idx_orders_date          ON orders(order_date);

SHOW INDEX FROM medicines;
-- SHOW INDEX FROM orders;
-- SHOW INDEX FROM order_items;

CREATE OR REPLACE VIEW view_order_details AS
SELECT
    o.order_id,
    c.name        AS customer_name,
    c.city        AS customer_city,
    o.order_date,
    o.total_amount,
    o.payment_mode
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;

CREATE OR REPLACE VIEW view_low_stock AS
SELECT
    m.medicine_id,
    m.name,
    m.stock_quantity,
    s.supplier_name
FROM medicines m
JOIN suppliers s ON m.supplier_id = s.supplier_id
WHERE m.stock_quantity < 50;

CREATE OR REPLACE VIEW view_customer_spend AS
SELECT
    c.customer_id,
    c.name,
    COUNT(o.order_id)                 AS total_orders,
    COALESCE(SUM(o.total_amount), 0)  AS total_spent
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;
CREATE OR REPLACE VIEW view_medicine_sales AS
SELECT
    m.medicine_id,
    m.name,
    COALESCE(SUM(oi.quantity), 0) AS total_qty_sold
FROM medicines m
LEFT JOIN order_items oi ON m.medicine_id = oi.medicine_id
GROUP BY m.medicine_id, m.name;

DROP PROCEDURE IF EXISTS sp_get_customer_orders;
DELIMITER $$
CREATE PROCEDURE sp_get_customer_orders(IN p_customer_id INT)
BEGIN
    SELECT o.order_id, o.order_date, o.total_amount, o.payment_mode
    FROM orders o
    WHERE o.customer_id = p_customer_id
    ORDER BY o.order_date;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_place_order;
DELIMITER $$
CREATE PROCEDURE sp_place_order(
    IN p_customer_id  INT,
    IN p_medicine_id  INT,
    IN p_quantity     INT,
    IN p_payment_mode VARCHAR(10)
)
BEGIN
    DECLARE v_price    DECIMAL(10,2);
    DECLARE v_stock    INT;
    DECLARE v_subtotal DECIMAL(10,2);
    DECLARE v_order_id INT;

    SELECT price, stock_quantity INTO v_price, v_stock
    FROM medicines
    WHERE medicine_id = p_medicine_id
    FOR UPDATE;

    IF v_stock < p_quantity THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Insufficient stock for this medicine';
    ELSE
        START TRANSACTION;
        SET v_subtotal = v_price * p_quantity;
        
   select name,phone from customers where city='MUMBAI';  
   
   SELECT* FROM MEDICINES WHERE EXPIRY_DATE<'2025-01-01';
   
   SELECT COUNT(*)AS UPI_ORDERS FROM ORDERS WHERE PAYMENT_MODE='UPI';
   
   SELECT COUNT(*)AS MEDICINE_COUNT FROM MEDICINES M 
   JOIN SUPPLIERS S ON M.SUPPLIER_ID=S.SUPPLIER_id
   WHERE S.SUPPLIER_NAME='APPOLO DISTRIBUTERS';
   
   SELECT C.NAME AS CUSTOMER_NAME,O.ORDER_DATE,O.TOTAL_AMOUNT
   FROM ORDERS O JOIN CUSTOMERS C ON O.CUSTOMER_ID=C.CUSTOMER_ID;
   
   SELECT PAYMENT_MODE,SUM(TOTAL_AMOUNT)AS REVENUE
   FROM ORDERS GROUP BY PAYMENT_MODE;
   
   SELECT C.NAME FROM CUSTOMERS C
   LEFT JOIN ORDERS O ON C.CUSTOMER_ID=O.CUSTOMER_ID
   WHERE O.ORDER_ID IS NULL;
   
   SELECT M.NAME FROM MEDICINES M
   LEFT JOIN OREDRS_ITEMS OI ON M.MEDICINE_ID=OI.MEDICINE_ID 
   WHERE OT.MEDICINE_ID IS NULL;
   
   SELECT PAYMENT_MODE,SUM(TOTAL_AMOUNT)AS REVENUE
   FROM ORDERS GROUP BY PAYMENT_MODE;
   
   SELECT C.CTIY,SUM(O.TOTAL_AMOUNT)AS CITY_REVENUE
   FROM CUSTOMER C LEFT JOIN ORDERS O ON C.CUSTOMER_ID=O.CUSTOMER_ID GROUP BY C.CITY;
   
  SELECT M.NAME,SUM(OI.QUANTITY)AS TOTAL_QTY
  FROM ORDER_ITEMS OT JOIN MEDICINES M ON OT.MEDICINES_ID M.MEDICINE_ID
  GROUP BY M.NAME ORDER BY TOTAL_QTY DESC LIMIT 1;
   
   
  SELECT C.NAME,SUM(O.TOTAL_AMOUNT)AS TOTAL_SPENT FROM CUSTOMERS C
  JOIN ORDERS O ON C.CUSTOMER_ID=O.CUSTOMER_ID
  GROUP BY C.NAME HAVING TOTAL_SPENT>1000
  ORDER BY TOTAL_SPENT DESC;
        
   SELECT M.NAME,M.STOCK_QUANTITY,S.SUPPLIER_NAME
   FROM MEDICINES M JOIN SUPPLIERS S ON M.SUPPLIER_ID
   WHERE M.STOCK_QUANTITY<50;