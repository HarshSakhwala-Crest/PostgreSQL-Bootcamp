-- JOINING MULTIPLE TABLES
SELECT *
FROM movies AS mv JOIN directors AS dr USING(director_id)
JOIN movies_revenues AS mr USING(movie_id);


SELECT *
FROM directors AS dr JOIN movies AS mv USING(director_id)
JOIN movies_revenues AS mr USING(movie_id);


SELECT *
FROM movies AS mv JOIN movies_revenues AS mr USING(movie_id)
JOIN directors AS dr USING(director_id);


SELECT *
FROM movies_revenues AS mr JOIN movies AS mv USING(movie_id)
JOIN directors AS dr USING(director_id);


SELECT *
FROM actors AS ac JOIN movies_actors AS ma USING(actor_id)
JOIN movies AS mv USING(movie_id)
JOIN directors AS dr USING(director_id)
JOIN movies_revenues AS mr USING(movie_id);


-- SELF JOIN
SELECT *
FROM left_products AS t1 INNER JOIN left_products AS t2
ON t1.product_id = t2.product_id;


SELECT *
FROM directors AS t1 INNER JOIN directors AS t2
ON t1.director_id = t2.director_id;


SELECT t1.movie_name, t2.movie_name, t1.movie_length
FROM movies AS t1 INNER JOIN movies AS t2
ON t1.movie_length = t2.movie_length
AND t1.movie_name <> t2.movie_name;


SELECT t1.movie_name, t2.director_id
FROM movies AS t1 INNER JOIN movies AS t2
ON t1.director_id = t2.movie_id
ORDER BY t2.director_id, t1.movie_name;


-- CROSS JOIN
SELECT *
FROM left_products CROSS JOIN right_products;


SELECT *
FROM left_products, right_products;


SELECT *
FROM left_products INNER JOIN right_products
ON TRUE;


SELECT *
FROM actors CROSS JOIN directors;


-- NATURAL JOIN
SELECT *
FROM left_products NATURAL INNER JOIN right_products;


SELECT *
FROM left_products NATURAL LEFT JOIN right_products;


SELECT *
FROM left_products NATURAL RIGHT JOIN right_products;


SELECT *
FROM movies NATURAL JOIN directors;

SELECT *
FROM movies NATURAL LEFT JOIN directors;

SELECT *
FROM movies NATURAL RIGHT JOIN directors;


-- TABLES WITH DIFFERENT COLUMNS
CREATE TABLE table1 (
	add_date DATE,
	col1 INT,
	col2 INT,
	col3 INT
);

CREATE TABLE table2 (
	add_date DATE,
	col1 INT,
	col2 INT,
	col3 INT,
	col4 INT,
	col5 INT
);

INSERT INTO table1
VALUES
('2020-01-01', 1, 2, 3),
('2020-01-02', 4, 5, 6);

SELECT * FROM table1;

INSERT INTO table2
VALUES
('2020-01-01', NULL, 7, 8, 9, 10),
('2020-01-02', 11, 12, 13, 14, 15),
('2020-01-03', 16, 17, 18, 19, 20);

SELECT * FROM table2;


SELECT COALESCE(t1.add_date, t2.add_date) AS add_date,
COALESCE(t1.col1, t2.col1) AS col1,
COALESCE(t1.col2, t2.col2) AS col2,
COALESCE(t1.col3, t2.col3) AS col3,
t2.col4,
t2.col5
FROM table1 AS t1 FULL OUTER JOIN table2 AS t2
ON t1.add_date = t2.add_date;