-- LEFT JOIN
CREATE TABLE left_products (
	product_id SERIAL PRIMARY KEY,
	product_name VARCHAR(100)
);

CREATE TABLE right_products (
	product_id SERIAL PRIMARY KEY,
	product_name VARCHAR(100)
);

INSERT INTO left_products (product_id, product_name)
VALUES
(1,'Computers'),
(2,'Laptops'),
(3,'Monitors'),
(4,'Mics');

SELECT * FROM left_products;

INSERT INTO right_products (product_id, product_name)
VALUES
(1,'Computers'),
(2,'Laptops'),
(3,'Monitors'),
(4,'Printers'),
(5,'Speakers');

SELECT * FROM right_products;

SELECT *
FROM left_products LEFT JOIN right_products
USING(product_id);


SELECT dr.first_name || ' ' || dr.last_name AS "Director Name",
mv.movie_name
FROM directors AS dr LEFT JOIN movies AS mv
USING(director_id);


INSERT INTO directors (first_name, last_name, date_of_birth, nationality)
VALUES
('James','David','2010-01-01','American');

SELECT dr.first_name || ' ' || dr.last_name AS "Director Name",
mv.movie_name
FROM directors AS dr LEFT JOIN movies AS mv
USING(director_id);

SELECT dr.first_name || ' ' || dr.last_name AS "Director Name",
mv.movie_name, mv.movie_language
FROM directors AS dr LEFT JOIN movies AS mv
USING(director_id)
WHERE mv.movie_language IN ('English','Chinese');


SELECT dr.first_name || ' ' || dr.last_name AS "Director Name",
COUNT(mv.movie_name)
FROM directors AS dr LEFT JOIN movies AS mv
USING(director_id)
GROUP BY director_id
ORDER BY COUNT(*) DESC;

SELECT mv.movie_name, mv.age_certificate,
dr.first_name || ' ' || dr.last_name AS "Director Name"
FROM directors AS dr LEFT JOIN movies AS mv
USING(director_id)
WHERE dr.nationality IN ('English','Chinese','Japanese');


SELECT dr.first_name || ' ' || dr.last_name AS "Director Name",
mv.movie_name,
mr.revenues_domestic + mr.revenues_international AS "Total Revenues"
FROM directors AS dr LEFT JOIN movies AS mv USING(director_id)
LEFT JOIN movies_revenues AS mr USING(movie_id)
WHERE mr.revenues_domestic + mr.revenues_international IS NOT NULL
ORDER BY 3 DESC;


-- RIGHT JOIN
SELECT *
FROM left_products RIGHT JOIN right_products
USING(product_id);


SELECT mv.movie_name,
dr.first_name || ' ' || dr.last_name AS "Director Name"
FROM directors AS dr RIGHT JOIN movies AS mv 
USING(director_id);

SELECT mv.movie_name,
dr.first_name || ' ' || dr.last_name AS "Director Name"
FROM directors AS dr RIGHT JOIN movies AS mv 
USING(director_id)
WHERE mv.movie_language IN ('English','Chinese');


SELECT dr.first_name || ' ' || dr.last_name AS "Director Name",
COUNT(mv.movie_name)
FROM directors AS dr RIGHT JOIN movies AS mv 
USING(director_id)
GROUP BY dr.director_id
ORDER BY COUNT(*) DESC, dr.first_name;


SELECT dr.first_name || ' ' || dr.last_name AS "Director Name",
mv.movie_name,
mr.revenues_domestic + mr.revenues_international AS "Total Revenues"
FROM directors AS dr RIGHT JOIN movies AS mv USING(director_id)
RIGHT JOIN movies_revenues AS mr USING(movie_id)
WHERE mr.revenues_domestic + mr.revenues_international IS NOT NULL
ORDER BY 3 DESC;


-- FULL JOIN
SELECT *
FROM left_products FULL JOIN right_products
USING(product_id);


SELECT dr.first_name || ' ' || dr.last_name AS "Director Name",
mv.movie_name
FROM movies AS mv FULL JOIN directors AS dr
USING(director_id)
ORDER BY 1;


SELECT dr.first_name || ' ' || dr.last_name AS "Director Name",
mv.movie_name, mv.movie_language
FROM movies AS mv FULL JOIN directors AS dr
USING(director_id)
WHERE movie_language IN ('English','Chinese')
ORDER BY 3, 1;