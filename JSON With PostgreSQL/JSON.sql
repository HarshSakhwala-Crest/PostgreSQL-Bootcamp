-- JSON SYNTAX
name : value
"name" : "Adam"
"number" : 4.8

"firstName" : "Adam", "country" : "USA"

{"country" : "USA"}
{"firstName" : "Adam", "country" : "USA"}

{"contacts" : [
	{"firstName" : "Adam", "lastName" : "Limbert"},
	{"firstName" : "Andrew", "lastName" : "Garfield"},
	{"firstName" : "Tobey", "lastName" : "Maguire"}
]}

"title" : "Lord of the Rings"
"price" : 20.49
"bestSeller" : TRUE
"discount" : NULL

{
	"title" : "Harry Potter",
	"author" : "J.K.Rowling",
	"details" : {
		"publisher" : "xyz"
	},
	"price" : [
		{
			"type" : "paperback",
			"price" : 20.59
		},
		{
			"type" : "kindle adition",
			"price" : 9.99
		}
	]
}


-- JSON OBJECTS
SELECT '{"title" : "Harry Potter"}';

SELECT '{"title" : "Harry Potter"}'::TEXT;

SELECT '{
	"title" : "Harry Potter",
	"author" : "J.K.Rowling"
}'::JSON;

SELECT '{
	"title" : "Harry Potter",
	"author" : "J.K.Rowling"
}'::JSONB;


-- JSON DATA TYPE IN TABLE
CREATE TABLE books (
	book_id SERIAL PRIMARY KEY,
	book_info JSONB
);

INSERT INTO books (book_info)
VALUES
('{
	"title" : "title1",
	"author" : "author1"
}'),
('{
	"title" : "title2",
	"author" : "author2"
}'),
('{
	"title" : "title3",
	"author" : "author3"
}');

SELECT * FROM books;


SELECT book_info -> 'title' FROM books;

SELECT book_info ->> 'author' FROM books;


SELECT book_info ->> 'title' AS "Title",
book_info ->> 'author' AS "Author"
FROM books
WHERE book_info ->> 'author' = 'author1';


-- ALTER JSON DATA
-- UPDATE JSON DATA
INSERT INTO books (book_info)
VALUES
('{
	"title" : "title4",
	"author" : "author4"
}');

SELECT * FROM books;


UPDATE books
SET book_info = book_info || '{"author" : "author5"}'
WHERE book_info ->> 'author' = 'author4';

SELECT * FROM books;

UPDATE books
SET book_info = book_info || '{"bestSeller" : "true"}'
WHERE book_info ->> 'author' = 'author5'
RETURNING *;

SELECT * FROM books;


UPDATE books
SET book_info = book_info || 
'{
	"category" : "science", 
	"pages" : 250
}'
WHERE book_info ->> 'author' = 'author3'
RETURNING *;


-- DELETE JSON DATA
UPDATE books
SET book_info = book_info - 'bestSeller'
WHERE book_info ->> 'author' = 'author5'
RETURNING *;


-- ADD NESTED ARRAY DATA
UPDATE books
SET book_info = book_info || '{"availability_locations" : [
	"New York",
	"New Jersey"
]}'
WHERE book_info ->> 'author' = 'author5'
RETURNING *;


-- #-
UPDATE books
SET book_info = book_info #- '{"availability_locations", 1}'
WHERE book_info ->> 'author' = 'author5'
RETURNING *;


-- JSON FROM TABLE
SELECT * FROM directors;

SELECT row_to_json(directors) FROM directors;

SELECT row_to_json(t) FROM
(
	SELECT director_id, 
	first_name, 
	last_name, 
	nationality 
	FROM directors
) AS t;


-- AGGREGATE DATA
SELECT * FROM movies;

SELECT * FROM directors;


SELECT *,
(
	SELECT json_agg(x) FROM
	(
		SELECT movie_name
		FROM movies
		WHERE director_id = directors.director_id
	) AS x
) AS "All Movies"
FROM directors;

SELECT director_id, first_name, last_name,
(
	SELECT json_agg(x) FROM
	(
		SELECT movie_name
		FROM movies
		WHERE director_id = directors.director_id
	) AS x
) AS "All Movies"
FROM directors;


-- JSON ARRAY
SELECT json_build_array(1, 2, 3, 4, 5);

SELECT json_build_array(1, 2, 3, 4, 5,'Hi');


SELECT json_build_object(1, 2, 3, 4, 5,'Hi');

SELECT json_build_object('name','Adam','email','a@b.com');


SELECT json_object('{name, email}','{"Adam", "a@b.com"}');


-- DOCUMENT FROM DATA
CREATE TABLE directors_docs (
	id SERIAL PRIMARY KEY,
	body JSONB
);

INSERT INTO directors_docs (body)
SELECT row_to_json(a)::JSONB FROM
(
	SELECT director_id,
	 first_name,
	 last_name,
	 date_of_birth,
	 nationality,
	 (
		SELECT json_agg(x) FROM
		(
			SELECT movie_name
			FROM movies
			WHERE director_id = directors.director_id
		) AS x
	 ) AS "All Movies"
	FROM directors
) AS a;

SELECT * FROM directors_docs;


-- NULL VALUES
SELECT * FROM directors_docs;

SELECT jsonb_array_elements(body -> 'All Movies') FROM directors_docs
WHERE (body -> 'All Movies') IS NOT NULL;

DELETE FROM directors_docs;


INSERT INTO directors_docs (body)
SELECT row_to_json(a)::JSONB FROM
(
	SELECT director_id,
	 first_name,
	 last_name,
	 date_of_birth,
	 nationality,
	 (
		SELECT CASE COUNT(x) WHEN 0 THEN '[]' ELSE json_agg(x) END AS "All Movies" FROM
		(
			SELECT movie_name
			FROM movies
			WHERE director_id = directors.director_id
		) AS x
	  )
	FROM directors
) AS a;

SELECT * FROM directors_docs;

SELECT jsonb_array_elements(body -> 'All Movies') FROM directors_docs;


-- DATA FROM DOCUMENT
SELECT * FROM directors_docs;

SELECT *,
jsonb_array_length(body -> 'All Movies') AS "Total Movies"
FROM directors_docs;


SELECT *,
jsonb_object_keys(body)
FROM directors_docs;


SELECT j.key,
j.value
FROM directors_docs, jsonb_each(directors_docs.body) AS j;


SELECT j.*
FROM directors_docs, jsonb_to_record(directors_docs.body) AS j(
	director_id INT,
	first_name VARCHAR(255),
	last_name VARCHAR(255),
	nationality VARCHAR(100)
);


-- EXISTENCE OPERATOR
SELECT *
FROM directors_docs
WHERE body -> 'first_name' ? 'John';

SELECT *
FROM directors_docs
WHERE body -> 'director_id' ? '1';


-- CONTAINMENT OPERATOR
SELECT *
FROM directors_docs
WHERE body @> '{"first_name" : "John"}';

SELECT *
FROM directors_docs
WHERE body @> '{"director_id" : 1}';


SELECT *
FROM directors_docs
WHERE body -> 'All Movies' @> '[{"movie_name" : "Toy Story"}]';


-- JSON SEARCH
SELECT *
FROM directors_docs
WHERE body ->> 'first_name' LIKE 'J%';

SELECT *
FROM directors_docs
WHERE body ->> 'director_id' > '2';

SELECT *
FROM directors_docs
WHERE (body ->> 'director_id')::INTEGER IN (1, 2, 3, 4, 5, 10);


-- INDEXING ON JSONB
SELECT * FROM contacts_docs;


EXPLAIN ANALYZE SELECT *
FROM contacts_docs
WHERE body @> '{"first_name" : "John"}';


CREATE INDEX idx_gin_contacts_docs_body ON contacts_docs USING GIN(body);

EXPLAIN ANALYZE SELECT *
FROM contacts_docs
WHERE body @> '{"first_name" : "John"}';


SELECT pg_size_pretty(pg_relation_size('idx_gin_contacts_docs_body'::regclass)) AS "Index Size";
"3664 kB"


CREATE INDEX idx_gin_contacts_docs_body_cool ON contacts_docs USING GIN(body jsonb_path_ops);

SELECT pg_size_pretty(pg_relation_size('idx_gin_contacts_docs_body_cool'::regclass)) AS "Index Size";
"2512 kB"


CREATE INDEX idx_gin_contacts_docs_body_fname ON contacts_docs USING GIN((body -> 'first_name') jsonb_path_ops);

SELECT pg_size_pretty(pg_relation_size('idx_gin_contacts_docs_body_fname'::regclass)) AS "Index Size";
"288 kB"