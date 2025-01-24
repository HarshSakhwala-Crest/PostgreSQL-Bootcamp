-- INNER JOIN
SELECT * FROM movies;

SELECT * FROM directors;


SELECT *
FROM movies INNER JOIN directors
ON movies.director_id = directors.director_id;

SELECT movies.movie_id, movies.movie_name, movies.director_id,
directors.first_name, directors.last_name
FROM movies INNER JOIN directors
ON movies.director_id = directors.director_id
ORDER BY director_id;


SELECT mv.movie_id, mv.movie_name, mv.director_id,
dr.first_name, dr.last_name
FROM movies AS mv INNER JOIN directors AS dr
ON mv.director_id = dr.director_id
ORDER BY director_id;


SELECT mv.movie_id, mv.movie_name, mv.movie_language, mv.director_id,
dr.first_name, dr.last_name
FROM movies AS mv INNER JOIN directors AS dr
ON mv.director_id = dr.director_id
WHERE movie_language = 'English'
ORDER BY director_id;


-- USING KEYWORD
SELECT *
FROM movies INNER JOIN directors
USING (director_id);

SELECT * FROM movies;

SELECT * FROM movies_revenues;

SELECT *
FROM movies INNER JOIN movies_revenues
USING (movie_id);


SELECT *
FROM movies INNER JOIN movies_revenues USING (movie_id)
INNER JOIN directors USING (director_id);


-- FILTER DATA
SELECT mv.movie_name,
dr.first_name || ' ' || dr.last_name AS "Director Name",
mr.revenues_domestic
FROM movies AS mv INNER JOIN directors AS dr USING (director_id)
INNER JOIN movies_revenues AS mr USING (movie_id);

SELECT mv.movie_name,
dr.first_name || ' ' || dr.last_name AS "Director Name",
mv.movie_language
FROM movies AS mv INNER JOIN directors AS dr USING (director_id)
INNER JOIN movies_revenues AS mr USING (movie_id)
WHERE mv.movie_language IN ('English','Chinese','Japanese') 
AND mr.revenues_domestic > 100
ORDER BY mv.movie_language;


SELECT mv.movie_name,
dr.first_name || ' ' || dr.last_name AS "Director Name",
mv.movie_language,
mr.revenues_domestic + mr.revenues_international AS "Total Revenues"
FROM movies AS mv INNER JOIN directors AS dr USING (director_id)
INNER JOIN movies_revenues AS mr USING (movie_id)
ORDER BY 4 DESC
NULLS LAST
LIMIT 5;


SELECT mv.movie_name,
dr.first_name || ' ' || dr.last_name AS "Director Name",
mv.movie_language,
mr.revenues_domestic + mr.revenues_international AS "Total Revenues"
FROM movies AS mv INNER JOIN directors AS dr USING (director_id)
INNER JOIN movies_revenues AS mr USING (movie_id)
WHERE mv.release_date BETWEEN '2005-01-01' AND '2008-12-31'
ORDER BY 4 DESC
LIMIT 10;


-- DIFFERENT COLUMN DATA TYPES
CREATE TABLE t1 (
	test INT
);

CREATE TABLE t2 (
	test VARCHAR(10)
);

INSERT INTO t1
VALUES
(1),
(2);

INSERT INTO t2
VALUES
('1'),
('2');

SELECT * FROM t1;

SELECT * FROM t2;

SELECT *
FROM t1 INNER JOIN t2 USING(test);

SELECT *
FROM t1 INNER JOIN t2 
ON t1.test = CAST(t2.test AS INT);