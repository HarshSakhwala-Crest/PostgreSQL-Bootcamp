-- ORDERS SHIPPING TO USA OR FRANCE
SELECT * FROM orders
ORDER BY ship_country;

SELECT * FROM orders
WHERE ship_country IN ('USA','France')
ORDER BY ship_country;


-- TOTAL NUMBER OF ORDERS SHIPPING TO USA OR FRANCE
SELECT ship_country, COUNT(*)
FROM orders
WHERE ship_country = 'USA'
OR ship_country = 'France'
GROUP BY ship_country
ORDER BY 2 DESC;


-- ORDERS SHIPPING TO ANY COUNTRY WITHIN LATIN AMERICA
SELECT * FROM orders
WHERE ship_country IN ('Brazil','Mexico','Argentina','Venezuela')
ORDER BY ship_country;


-- ORDER TOTAL AMOUNT PER EACH ORDER LINE
SELECT * FROM order_details;

SELECT order_id, product_id, unit_price, quantity, discount, (unit_price * quantity) - discount AS "Amount"
FROM order_details;


-- FIRST AND LATEST ORDER DATE
SELECT MIN(order_date) AS "First Order",
MAX(order_date) AS "Latest Order"
FROM orders;


SELECT MIN(quantity) AS "Min Qty",
MAX(quantity) AS "Max Qty"
FROM order_details;


-- TOTAL PRODUCTS IN EACH CATEGORY
SELECT c.category_id, c.category_name, COUNT(p.product_name) AS "Total Products"
FROM products AS p
INNER JOIN categories AS c USING (category_id)
GROUP BY c.category_id
ORDER BY 1;	


-- LIST PRODUCTS THAT NEEDS RE-ORDERING
SELECT product_id, product_name, units_in_stock, reorder_level
FROM products
WHERE units_in_stock <= reorder_level;


-- FREIGHT ANALYSIS
SELECT * FROM orders
ORDER BY freight DESC
LIMIT 5;

SELECT ship_country, AVG(freight)
FROM orders
GROUP BY ship_country
ORDER BY 2 DESC
LIMIT 5;



SELECT ship_country, AVG(freight)
FROM orders
WHERE order_date BETWEEN '1997-01-01' AND '1997-12-31'
GROUP BY ship_country
ORDER BY 2 DESC
LIMIT 5;


SELECT ship_country, AVG(freight)
FROM orders
WHERE EXTRACT(YEAR FROM order_date) >= EXTRACT(YEAR FROM (SELECT MAX(order_date) FROM orders))
GROUP BY ship_country
ORDER BY 2 DESC
LIMIT 5;


-- CUSTOMERS WITH NO ORDERS
SELECT c.customer_id, c.company_name
FROM customers AS c
LEFT JOIN orders AS o USING (customer_id)
WHERE o.order_id IS NULL;


-- TOP CUSTOMERS WITH THEIR TOTAL ORDER AMOUNT SPEND
SELECT c.customer_id, c.company_name,
SUM((od.unit_price * od.quantity) - od.discount) AS "Total Amount"
FROM customers AS c
INNER JOIN orders AS o USING (customer_id)
INNER JOIN order_details AS od USING (order_id)
GROUP BY c.customer_id
ORDER BY 3 DESC
LIMIT 10;


-- ORDERS WITH MANY LINE OF ITEMS
SELECT order_id, COUNT(*)
FROM order_details
GROUP BY order_id
HAVING COUNT(*) > 1
ORDER BY 2 DESC;


-- ORDERS WITH DOUBLE ENTRY LINE ITEMS
SELECT order_id, quantity
FROM order_details
WHERE quantity > 60
GROUP BY order_id, quantity
HAVING COUNT(*) > 1;


WITH duplicate_entries AS
(
	SELECT order_id, quantity
	FROM order_details
	WHERE quantity > 60
	GROUP BY order_id, quantity
	HAVING COUNT(*) > 1
)
SELECT * FROM order_details
WHERE order_id IN (SELECT order_id FROM duplicate_entries);


-- LATE SHIPPED ORDERS BY EMPLOYEES
SELECT * FROM orders
WHERE shipped_date > required_date;


WITH late_orders AS
(
	SELECT employee_id, COUNT(*) AS "Late Orders"
	FROM orders
	WHERE shipped_date > required_date
	GROUP BY employee_id
),
all_orders AS
(
	SELECT employee_id, COUNT(*) AS "Total Orders"
	FROM orders
	GROUP BY employee_id
)
SELECT employees.employee_id, employees.first_name, employees.last_name,
all_orders."Total Orders",
late_orders."Late Orders"
FROM employees
JOIN all_orders USING (employee_id)
JOIN late_orders USING (employee_id)
ORDER BY 5 DESC;


-- COUNTRIES WITH CUSTOMERS OR SUPPLIERS
-- WITH UNION
SELECT country
FROM customers
UNION
SELECT country
FROM suppliers
ORDER BY country;


SELECT DISTINCT country
FROM customers
UNION ALL
SELECT DISTINCT country
FROM suppliers
ORDER BY country;


-- WITH CTE
WITH countries_customers AS
(
	SELECT DISTINCT country
	FROM customers
),
countries_suppliers AS
(
	SELECT DISTINCT country
	FROM suppliers
)
SELECT cc.country AS "Customers Countries",
cs.country AS "Suppliers Countries"
FROM countries_customers AS cc
FULL JOIN countries_suppliers AS cs USING (country);


-- CUSTOMERS WITH MULTIPLE ORDERS
WITH next_order_date AS
(
	SELECT customer_id, order_date,
	LEAD(order_date, 1) OVER (PARTITION BY customer_id ORDER BY customer_id, order_date) AS next_order_date
	FROM orders
)
SELECT customer_id, order_date, next_order_date,
(next_order_date - order_date) AS days_between_orders
FROM next_order_date
WHERE (next_order_date - order_date) <= 4;


-- FIRST ORDER FROM EACH COUNTRY
SELECT ship_country, MIN(order_date) AS "First Order"
FROM orders
GROUP BY ship_country;


WITH orders_by_country AS
(
	SELECT ship_country, order_id, order_date,
	ROW_NUMBER() OVER (PARTITION BY ship_country ORDER BY ship_country, order_date) AS country_row_number
	FROM orders
)
SELECT ship_country, order_id, order_date
FROM orders_by_country
WHERE country_row_number = 1;