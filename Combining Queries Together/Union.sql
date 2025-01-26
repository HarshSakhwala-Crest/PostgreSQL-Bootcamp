-- UNION
SELECT product_id, product_name 
FROM left_products
UNION
SELECT product_id, product_name 
FROM right_products;


SELECT product_id, product_name 
FROM left_products
UNION ALL
SELECT product_id, product_name 
FROM right_products;


SELECT first_name, last_name
FROM directors
UNION
SELECT first_name, last_name
FROM actors;

SELECT first_name, last_name,
'director' AS "Role"
FROM directors
UNION
SELECT first_name, last_name,
'actor' AS "Role"
FROM actors
ORDER BY first_name;


SELECT first_name, last_name
FROM directors
UNION
SELECT first_name, date_of_birth
FROM actors;


SELECT first_name, last_name,
'director' AS "Role"
FROM directors
WHERE nationality IN ('English','Chinese','Japanese')
UNION
SELECT first_name, last_name,
'actor' AS "Role"
FROM actors
WHERE gender = 'F'
ORDER BY first_name;

SELECT first_name, last_name,
'director' AS "Role"
FROM directors
WHERE date_of_birth > '1990-12-31'
UNION
SELECT first_name, last_name,
'actor' AS "Role"
FROM actors
WHERE date_of_birth > '1990-12-31'
ORDER BY first_name;

SELECT first_name, last_name,
'director' AS "Role"
FROM directors
WHERE first_name LIKE 'A%'
UNION
SELECT first_name, last_name,
'actor' AS "Role"
FROM actors
WHERE first_name LIKE 'A%'
ORDER BY first_name;


SELECT first_name, last_name, date_of_birth,
'director' AS "Role"
FROM directors
UNION
SELECT first_name, last_name,
'actor' AS "Role"
FROM actors
ORDER BY first_name;


-- UNION DIFFERENT NUMBER OF COLUMNS
SELECT col1, col2
FROM table1
UNION
SELECT col1, NULL AS col2
FROM table2;


-- INTERSECT
SELECT product_id, product_name
FROM left_products
INTERSECT
SELECT product_id, product_name
FROM right_products;


SELECT first_name, last_name
FROM directors
INTERSECT
SELECT first_name, last_name
FROM actors;


-- EXCEPT
SELECT product_id, product_name
FROM left_products
EXCEPT
SELECT product_id, product_name
FROM right_products;

SELECT first_name, last_name
FROM directors
EXCEPT
SELECT first_name, last_name
FROM actors;

SELECT first_name, last_name
FROM directors
EXCEPT
SELECT first_name, last_name
FROM actors
WHERE gender = 'F';