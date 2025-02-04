-- ARRAY FUNCTIONS
-- RANGE_TYPE FUNCTION
SELECT INT4RANGE(1, 6) AS "[)",
NUMRANGE(1.4213, 6.2986, '[]') AS "[]",
DATERANGE('20100101','20200101','()') AS "()",
TSRANGE(LOCALTIMESTAMP, LOCALTIMESTAMP + INTERVAL '8 DAYS','(]') AS "(]";
"[1,6)"		"[1.4213,6.2986]"		"[2010-01-02,2020-01-01)"		"(""2025-01-27 09:33:46.553719"",""2025-02-04 09:33:46.553719""]"


-- CONSTRUCTING ARRAYS
SELECT ARRAY[1, 2, 3] AS "Int Array",
ARRAY[2.12225::FLOAT] AS " Float Array",
ARRAY[CURRENT_DATE, CURRENT_DATE + 5] AS "Date Array";
{1,2,3}		{2.12225}	"{2025-01-27,2025-02-01}"


-- COMPARISON OPERATORS
SELECT ARRAY[1, 2, 3, 4] = ARRAY[1, 2, 3, 4] AS "Is Equal",
ARRAY[1, 2, 3, 4] = ARRAY[2, 3, 4] AS "Is Equal",
ARRAY[1, 2, 3, 4] <> ARRAY[2, 3, 4, 5] AS "Is Not Equal",
ARRAY[1, 2, 3, 4] < ARRAY[2, 3, 4, 5] AS "Is Less Than",
ARRAY[1, 2, 3, 4] <= ARRAY[2, 3, 4, 5] AS "Is Less Than Or Equal",
ARRAY[1, 2, 3, 4] > ARRAY[2, 3, 4, 5] AS "Is Greater Than",
ARRAY[1, 2, 3, 4] >= ARRAY[2, 3, 4, 5] AS "Is Greater Than Or Equal";
true	false	true	true	true	false	false


-- INCLUSION OPERATORS
SELECT ARRAY[1, 2, 3, 4] @> ARRAY[2, 3, 4] AS "Is Contains",
ARRAY['a','b'] <@ ARRAY['a','b'] AS "Is Contains By",
ARRAY[1, 2, 3, 4] && ARRAY[2, 3, 4] AS "Is Overlaps";
true	true 	true


SELECT INT4RANGE(1, 4) @> INT4RANGE(2, 3) AS "Is Contains",
DATERANGE(CURRENT_DATE, CURRENT_DATE + 30) @> CURRENT_DATE + 15 AS "Is Contains",
NUMRANGE(1.6, 5.2) && NUMRANGE(0, 4);
true	true	true


-- ARRAY CONSTRUCTION
SELECT ARRAY[1, 2, 3] || ARRAY[4, 5, 6];
{1,2,3,4,5,6}

SELECT ARRAY_CAT(ARRAY[1, 2, 3], ARRAY[4, 5, 6]);
{1,2,3,4,5,6}

SELECT 4 || ARRAY[1, 2, 3];
{4,1,2,3}

SELECT ARRAY_PREPEND(4, ARRAY[1, 2, 3]);
{4,1,2,3}

SELECT ARRAY[1, 2, 3] || 4;
{1,2,3,4}

SELECT ARRAY_APPEND(ARRAY[1, 2, 3], 4);
{1,2,3,4}


-- ARRAY METADATA FUNCTIONS
-- ARRAY_NDIMS FUNCTION
SELECT ARRAY_NDIMS(ARRAY[1, 2, 3, 4]);
1

SELECT ARRAY_NDIMS(ARRAY[[1], [2]]);
2

SELECT ARRAY_NDIMS(ARRAY[[1, 2, 3], [4, 5, 6]]);
2


-- ARRAY_DIMS FUNCTION
SELECT ARRAY_DIMS(ARRAY[[1], [2]]);
"[1:2][1:1]"


-- ARRAY_LENGTH FUNCTION
SELECT ARRAY_LENGTH(ARRAY[1, 2, 3, 4], 1);
4

SELECT ARRAY_LENGTH(ARRAY[]::INTEGER[], 1);


-- ARRAY_LOWER FUNCTION
SELECT ARRAY_LOWER(ARRAY[1, 2, 3, 4], 1);
1

SELECT ARRAY_LOWER(ARRAY[1, 4], 1);
1


-- ARRAY_UPPER FUNCTION
SELECT ARRAY_UPPER(ARRAY[1, 2, 3, 4], 1);
4


-- CARDINALITY FUNCTION
SELECT CARDINALITY(ARRAY[[1], [2], [3], [4]]),
CARDINALITY(ARRAY[[1], [2], [3], [4], [5]]);
4	5


-- ARRAY SEARCH FUNCTIONS
-- ARRAY_POSITION FUNCTION
SELECT ARRAY_POSITION(ARRAY['Jan','Feb','March','Apr'],'Feb');
2

SELECT ARRAY_POSITION(ARRAY[1, 2, 3, 4], 3);
3

SELECT ARRAY_POSITION(ARRAY[1, 2, 2, 3, 4], 2, 3);
3


-- ARRAY_POSITIONS FUNCTION
SELECT ARRAY_POSITIONS(ARRAY[1, 2, 2, 3, 4], 2);
{2,3}

SELECT ARRAY_POSITIONS(ARRAY[1, 2, 2, 3, 4], 10);
{}


-- ARRAY MODIFICATION FUNCTIONS
SELECT ARRAY_CAT(ARRAY['Jan','Feb'], ARRAY['Mar','Apr']);
"{Jan,Feb,Mar,Apr}"

SELECT ARRAY_APPEND(ARRAY[1, 2, 3], 4);
{1,2,3,4}

SELECT ARRAY_PREPEND(4, ARRAY[1, 2, 3]);
{4,1,2,3}


-- ARRAY_REMOVE FUNCTION
SELECT ARRAY_REMOVE(ARRAY[1, 2, 3, 4], 4);
{1,2,3}


-- ARRAY_REPLACE FUNCTION
SELECT ARRAY_REPLACE(ARRAY[1, 2, 3, 4], 2, 5);
{1,5,3,4}

SELECT ARRAY_REPLACE(ARRAY[1, 2, 3, 2, 4], 2, 5);
{1,5,3,5,4}


-- ARRAY COMPARISON
-- IN OPERATOR
SELECT 20 IN (1, 2, 20, 40) AS "Is There";
true

SELECT 25 IN (1, 2, 20, 40) AS "Is There";
false


-- NOT IN OPERATOR
SELECT 20 NOT IN (1, 2, 20, 40) AS "Is Not There";
false

SELECT 25 NOT IN (1, 2, 20, 40) AS "Is Not There";
true


-- ALL OPERATOR
SELECT 25 = ALL(ARRAY[20, 25, 30, 35, 40]) AS "Is All";
false

SELECT 25 = ALL(ARRAY[25, 25]) AS "Is All";
true


-- ANY/SOME OPERATOR
SELECT 25 = ANY(ARRAY[1, 2, 25]) AS "Is Any";
true

SELECT 20 = ANY(ARRAY[1, 2, 25]) AS "Is Any";
false

SELECT 25 = ANY(ARRAY[1, 2, 25, NULL]) AS "Is Any";
true

SELECT 25 <> ANY(ARRAY[1, 2, 25, NULL]) AS "Is Any";
true


SELECT 25 = SOME(ARRAY[1, 2, 3, 4]) AS "Is Some";
false

SELECT 25 = SOME(ARRAY[1, 2, 3, 4, 25]) AS "Is Some";
true


-- FORMATTING AND CONVERTING
-- STRING_TO_ARRAY FUNCTION
SELECT STRING_TO_ARRAY('1, 2, 3, 4, 5',', ');
"{1,2,3,4,5}"

SELECT STRING_TO_ARRAY('1, 2, 3, 4, abc',', ','abc');
"{1,2,3,4,NULL}"

SELECT STRING_TO_ARRAY('1, 2, 3, 4, , 6',', ','');
"{1,2,3,4,NULL,6}"


-- ARRAY_TO_STRING FUNCTION
SELECT ARRAY_TO_STRING(ARRAY[1, 2, 3, 4],'|');
"1|2|3|4"

SELECT ARRAY_TO_STRING(ARRAY[1, 2, NULL, 4],'|');
"1|2|4"

SELECT ARRAY_TO_STRING(ARRAY[1, 2, NULL, 4],'|','EMPTY_DATA');
"1|2|EMPTY_DATA|4"


-- ARRAYS IN TABLES
CREATE TABLE teachers (
	teacher_id SERIAL PRIMARY KEY,
	name VARCHAR(150),
	phones TEXT[]
);

CREATE TABLE teachers (
	teacher_id SERIAL PRIMARY KEY,
	name VARCHAR(150),
	phones TEXT ARRAY
);


-- INSERT INTO ARRAYS
INSERT INTO teachers (name, phones)
VALUES
('Adam', ARRAY['(111)-222-3333','(555)-666-7777']);

INSERT INTO teachers (name, phones)
VALUES
('Linda','{"(111)-123-4567"}'),
('Jeff','{"(222)-555-9999","(444)-789-1234"}');

SELECT * FROM teachers;


-- QUERY ARRAY DATA
SELECT name, phones FROM teachers;

SELECT name, phones[1] FROM teachers;


SELECT * FROM teachers
WHERE phones[1] = '(111)-222-3333';

SELECT * FROM teachers
WHERE '(111)-222-3333' = ANY(phones);


-- MODIFY ARRAY DATA
SELECT * FROM teachers;

UPDATE teachers
SET phones[2] = '(800)-123-4567'
WHERE teacher_id = 2;

UPDATE teachers
SET phones[1] = '(888)-222-3333'
WHERE teacher_id = 1;

SELECT * FROM teachers;


-- IGNORED ARRAY DIMENSIONS
CREATE TABLE teachers2 (
	teacher_id SERIAL PRIMARY KEY,
	name VARCHAR(150),
	phones TEXT ARRAY[1]
);

INSERT INTO teachers2 (name, phones)
VALUES
('Adam', ARRAY['(111)-222-3333','(555)-666-7777']);

SELECT * FROM teachers2;


-- DISPLAY ARRAY ELEMENTS
SELECT teacher_id, name, unnest(phones)
FROM teachers;

SELECT teacher_id, name, unnest(phones)
FROM teachers
ORDER BY 3;


-- MULTI DIMENSIONAL ARRAYS
CREATE TABLE students (
	student_id SERIAL PRIMARY KEY,
	student_name VARCHAR(100),
	student_grade INTEGER[][]
);

INSERT INTO students (student_name, student_grade)
VALUES
('S1','{90, 2020}');

SELECT * FROM students;

INSERT INTO students (student_name, student_grade)
VALUES
('S2','{80, 2020}'),
('S3','{70, 2019}'),
('S2','{60, 2019}');

SELECT * FROM students;


SELECT student_grade[1] FROM students;

SELECT student_grade[2] FROM students;


SELECT * FROM students
WHERE student_grade[2] = '2020';

SELECT * FROM students
WHERE student_grade @> '{2020}';

SELECT * FROM students
WHERE 2020 = ANY(student_grade);

SELECT * FROM students
WHERE student_grade[1] > '80';