-- UPPER FUNCTION
SELECT UPPER('Amazing PostgreSQL');
"AMAZING POSTGRESQL"


SELECT
UPPER(first_name) AS "First Name",
UPPER(last_name) AS "Last Name"
FROM directors;


-- LOWER FUNCTION
SELECT LOWER('Amazing PostgreSQL');
"amazing postgresql"


-- INITCAP FUNCTION
SELECT INITCAP('the world is changing with a lightning speed');
"The World Is Changing With A Lightning Speed"


SELECT
INITCAP(CONCAT(first_name,' ', last_name)) AS "Full Name"
FROM directors
ORDER BY first_name ASC;


-- LEFT FUNCTION
SELECT LEFT('abcd', 1);
"a"

SELECT LEFT('abcd', -2);
"ab"


SELECT LEFT(first_name, 1) AS "Initial"
FROM directors
ORDER BY 1 ASC;

SELECT LEFT(first_name, 1) AS "Initial",
COUNT(*) AS "Total Initials"
FROM directors
GROUP BY 1
ORDER BY 1;


SELECT
movie_name, LEFT(movie_name, 6)
FROM movies;


-- RIGHT FUNCTION
SELECT RIGHT('abcd', 2);
"cd"

SELECT RIGHT('abcd', -1);
"bcd"


SELECT last_name
FROM directors
WHERE RIGHT(last_name, 2) = 'on';


-- REVERSE FUNCTION
SELECT REVERSE('Amazing PostgreSQL');
"LQSergtsoP gnizamA"

SELECT REVERSE('111AAA');
"AAA111"


-- SPLIT_PART FUNCTION
SELECT SPLIT_PART('1, 2, 3',', ', 2);
"2"

SELECT SPLIT_PART('One, Two, Three',', ', 3);
"Three"

SELECT SPLIT_PART('a|b|c|d','|', 3);
"c"

SELECT
movie_name,
release_date,
SPLIT_PART(release_date::TEXT,'-', 1) AS "Release Year"
FROM movies;


-- TRIM FUNCTION
SELECT TRIM(LEADING FROM '  Amazing PostgreSQL'),
TRIM(TRAILING FROM 'Amazing PostgreSQL   '),
TRIM(BOTH FROM '   Amazing PostgreSQL  ');
"Amazing PostgreSQL"	"Amazing PostgreSQL"	"Amazing PostgreSQL"

SELECT TRIM(LEADING '0' FROM CAST(000123456 AS TEXT));
"123456"


-- LTRIM FUNCTION
SELECT LTRIM('yummy','y');
"ummy"

SELECT LTRIM('  Amazing PostgreSQL');
"Amazing PostgreSQL"


-- RTRIM FUNCTION
SELECT RTRIM('yummy','y');
"yumm"

SELECT RTRIM('Amazing PostgreSQL   ');
"Amazing PostgreSQL"


-- BTRIM FUNCTION
SELECT BTRIM('yummy','y');
"umm"

SELECT BTRIM('   Amazing PostgreSQL  ');
"Amazing PostgreSQL"


-- LPAD FUNCTION
SELECT LPAD('Database', 15,'*');
"*******Database"

SELECT LPAD('1111', 6, 'A');
"AA1111"


SELECT mv.movie_name,
r.revenues_domestic,
LPAD('*', CAST(TRUNC(r.revenues_domestic / 10) AS INT),'*') AS "Chart"
FROM movies AS mv
INNER JOIN movies_revenues AS r
ON mv.movie_id = r.movie_id
ORDER BY 3 DESC
NULLS LAST;


-- RPAD FUNCTION
SELECT RPAD('Database', 15,'*');
"Database*******"


-- LENGTH FUNCTION
SELECT LENGTH('Amazing PostgreSQL');
18

SELECT LENGTH(CAST(1000123 AS TEXT));
7

SELECT CHAR_LENGTH('');
0

SELECT CHAR_LENGTH(' ');
1

SELECT CHAR_LENGTH(NULL);


SELECT CONCAT(first_name,' ', last_name) AS "Full Name",
LENGTH(first_name || ' ' || last_name) AS "Length"
FROM directors
ORDER BY 2 DESC;


-- POSITION FUNCTION
SELECT POSITION('Postgre' IN 'Amazing PostgreSQL');
9

SELECT POSITION('A' IN 'ClickAnalytics');
6


-- STRPOS FUNCTION
SELECT STRPOS('World Bank','Bank');
7


SELECT first_name, last_name
FROM directors
WHERE STRPOS(last_name,'on') > 0;


-- SUBSTRING FUNCTION
SELECT SUBSTRING('What a wonderful world' FROM 1 FOR 4);
"What"

SELECT SUBSTRING('What a wonderful world' FROM 8 FOR 10);
"wonderful "

SELECT SUBSTRING('What a wonderful world' FOR 7);
"What a "


SELECT first_name, last_name,
SUBSTRING(first_name, 1, 1) AS "Initial"
FROM directors
ORDER BY last_name;


-- REPEAT FUNCTION
SELECT REPEAT('a', 4);
"aaaa"

SELECT REPEAT(' ', 10);
"          "


-- REPLACE FUNCTION
SELECT REPLACE('abc xyz','x','1');
"abc 1yz"

SELECT REPLACE('What a wonderful world','a wonderful','an amazing');
"What an amazing world"

SELECT REPLACE('I like cats','cats','dogs');
"I like dogs"