-- || OPERATOR
SELECT 'Hello' || ' ' || 'World' AS new_string;

SELECT first_name || ' ' || last_name AS "Actor Name" 
FROM actors
ORDER BY first_name ASC;

SELECT first_name || ', ' || last_name || ', ' || date_of_birth
FROM actors
ORDER BY first_name ASC;

SELECT 'Hello' || NULL || 'World';


-- CONCAT FUNCTION
SELECT CONCAT('Hello','World') AS new_string;

SELECT CONCAT(first_name, ' ', last_name) AS "Actor Name"
FROM actors
ORDER BY first_name ASC;

SELECT CONCAT(first_name, ', ', last_name, ', ', date_of_birth)
FROM actors
ORDER BY first_name ASC;

SELECT revenues_domestic, revenues_international, CONCAT(revenues_domestic, ' | ', revenues_international) AS "Profits"
FROM movies_revenues;


-- CONCAT_WS FUNCTION
SELECT CONCAT_WS('|','Hello','World') AS new_string;

SELECT CONCAT_WS(' ', first_name, last_name) AS "Actor Name"
FROM actors
ORDER BY first_name ASC;

SELECT CONCAT_WS(', ', first_name, last_name, date_of_birth)
FROM actors
ORDER BY first_name ASC;

SELECT revenues_domestic, revenues_international, CONCAT_WS(' | ', revenues_domestic, revenues_international) AS "Profits"
FROM movies_revenues;