-- INDEXES
-- INDEX IS A STRUCTURED RELATION


-- CREATE INDEX
-- USING PGADMIN GUI : CREATE AN INDEX
-- ON SINGLE COLUMN
CREATE INDEX idx_orders_order_date ON orders (order_date);

CREATE INDEX idx_orders_ship_city ON orders (ship_city);


-- ON MULTIPLE COLUMNS
CREATE INDEX idx_orders_customer_id_order_id ON orders (customer_id, order_id);


-- UNIQUE INDEXES
-- ON SINGLE COLUMN
CREATE UNIQUE INDEX idx_u_products_product_id ON products (product_id);


CREATE UNIQUE INDEX idx_u_employees_employee_id ON employees (employee_id);


-- ON MULTIPLE COLUMNS
CREATE UNIQUE INDEX idx_u_orders_order_id_customer_id ON orders (order_id, customer_id);


CREATE UNIQUE INDEX idx_u_employees_employee_id_hire_date ON employees (employee_id, hire_date);


SELECT * FROM employees;

INSERT INTO employees (employee_id, first_name, last_name)
VALUES
(1, 'Jose','Pietrian');


CREATE TABLE t1 (
	id SERIAL PRIMARY KEY,
	tag TEXT
);

INSERT INTO t1 (tag)
VALUES
('A'),
('B');

SELECT * FROM t1;


CREATE UNIQUE INDEX idx_u_t1_tag ON t1 (tag);


INSERT INTO t1 (tag)
VALUES
('A');


-- LIST ALL INDEXES
SELECT * FROM pg_indexes;


SELECT * FROM pg_indexes
WHERE schemaname = 'public'
ORDER BY tablename, indexname;


SELECT * FROM pg_indexes
WHERE tablename = 'orders'
ORDER BY indexname;


-- SIZE OF TABLE INDEXES
SELECT pg_size_pretty(pg_indexes_size('orders'));


SELECT pg_size_pretty(pg_indexes_size('suppliers'));


CREATE INDEX idx_suppliers_region ON suppliers (region);

SELECT pg_size_pretty(pg_indexes_size('suppliers'));


CREATE UNIQUE INDEX idx_u_suppliers_supplier_id ON suppliers (supplier_id);

SELECT pg_size_pretty(pg_indexes_size('suppliers'));


-- LIST COUNTS OF INDEXES
SELECT * FROM pg_stat_all_indexes;


SELECT * FROM pg_stat_all_indexes
WHERE schemaname = 'public'
ORDER BY relname, indexrelname;


SELECT * FROM pg_stat_all_indexes
WHERE relname = 'orders'
ORDER BY indexrelname;


-- DROP INDEX
DROP INDEX idx_suppliers_region;


-- SQL STATEMENT EXECUTION STAGES
/*
PARSER - HANDLES TEXTUAL FORM OF A STATEMENT AND VERIFIES WHETHER IT IS CORRECT OR NOT
REWRITER - APPLY SYNTACTIC RULES TO REWRITE ORIGINAL SQL STATEMENT
OPTIMIZER - FIND VERY FASTEST PATH TO DATA THAT STATEMENT NEEDS
EXECUTOR - RESPONSIBLE FOR EFFECTIVELY GOING TO STORAGE AND ALTERING DATA AND GETS PHYSICAL ACCESS TO DATA
*/


-- OPTIMIZER
/*
HOW TO ACCESS DATA AS QUICKLY AS POSSIBLE
1. COST - SHOULD BE LOWEST
2. THREAD - AVAILABLE FROM POSTGRESQL VERSION 9.6 ONWARDS
3. NODES - STATEMENT DIVIDE INTO ACTIONS THAT ARE EXECUTED BY NODES SEPERATELY
4. NODES TYPES
*/


-- NODES TYPES
/*
NODES ARE AVAILABLE FOR - EVERY OPERATIONS
						   EVERY ACCESS METHODS

NODES ARE STACKABLE
PARENT NODE - COST ASSOCIATED
	CHILD NODE 1
		CHILD NODE 2
			.....

TYPES OF NODES - SEQUENTIAL SCAN
				- INDEX SCAN, INDEX ONLY SCAN, BITMAP INDEX SCAN
				- NESTED LOOP, HASH JOIN, MERGE JOIN					
				- GATHER AND MERGE PARALLEL NODES
*/

SELECT * FROM pg_am;


-- SEQUENTIAL NODES
/*
- DEFAULT WHEN NO OTHER VALUABLE ALTERNATIVE
- READ FROM BEGINING OF DATASET
- FILTERING CLAUSE IS NOT VERY LIMIING SUCH THAT END RESULT WILL GET ALMOST WHOLE TABLE CONTENT	
*/

EXPLAIN SELECT * FROM orders;
"Seq Scan on orders  (cost=0.00..22.30 rows=830 width=90)"

EXPLAIN SELECT * FROM orders
WHERE order_id IS NOT NULL;
"Seq Scan on orders  (cost=0.00..22.30 rows=830 width=90)"


-- INDEX NODES
/*
- INDEX IS USED TO ACCESS THE DATASET
- DATA FILE AND INDEX FILES ARE SEPERATED BUT THEY ARE NEARBY
- INDEX NODES TYPES - 
INDEX SCAN - INDEX -> SEEK THE TUPLES -> READ DATA AGAIN
INDEX ONLY SCAN - REQUESTED INDEX COLUMNS ONLY -> DIRECTLY GET DATA FROM INDEX FILE
BITMAP INDEX SCAN - BUILDS A MEMORY BITMAP FOR TUPLES THAT SATISFY STATEMENT CLAUSES
*/

EXPLAIN SELECT * FROM orders
WHERE order_id = 1;
"Index Scan using idx_u_orders_order_id_customer_id on orders  (cost=0.28..8.29 rows=1 width=90)"


EXPLAIN SELECT order_id FROM orders
WHERE order_id = 1;
"Index Only Scan using idx_u_orders_order_id_customer_id on orders  (cost=0.28..8.29 rows=1 width=2)"


-- JOIN NODES
/*
- USED WHEN JOINING THE TABLES
- WHEN JOINING LARGE NUMBER OF TABLES, GENETIC QUERY OPTIMIZER SETTINGS MAY AFFECT WHAT COMBINATIONS OF JOINS 
  ARE CONSIDERED
- JOIN NODES TYPES -
HASH JOIN - INNER TABLE - BUILD HASH TABLE FROM INNER TABLE, KEYED BY JOIN KEY
			OUTER TABLE - THEN SCAN OUTER TABLE, CHECKING IF A CORRESPONDING VALUE IS PRESENT
MERGE JOIN - JOIN TWO CHILDREN ALREADY SORTED BY THEIR SHARED JOIN KEY. THIS ONLY SCANS RELATION ONCE,
			BUT BOTH INPUTS NEED TO BE SORTED BY JOIN KEYS FIRST
NESTED LOOP - FOR EACH ROW IN OUTER TABLE, ITERATE THROUGH ALL ROWS IN INNER TABLE AND SEE IF THEY MATCH THE
			  JOIN CONDITION. IF INNER RELATION CAN BE SCANNED WITH AN INDEX, THAT CAN IMPROVE PERFORMANCE
			  OF NESTED LOOP JOIN
*/

SHOW work_mem;
"4MB"

EXPLAIN SELECT *
FROM orders
NATURAL JOIN customers;
"Hash Join  (cost=4.05..28.63 rows=830 width=210)"


-- INDEX TYPES
-- B-TREE INDEX
/*
- DEFAULT INDEX
- SELF-BALANCING TREE - SELECT, INSERT, DELETE, SEQUENTIAL ACCESS IN LOGARITHMIC TIME
- CAN BE USED FOR MOST OPERATORS AND COLUMN TYPES
- SUPPORT UNIQUE CONDITION
- NORMALLY USED TO BUILD PRIMARY KEY INDEXES
- USED WHEN COLUMNS INVOLVE OPERATORS - <, >, <=, >= , =, BETWEEN, IN, IS NULL, IS NOT NULL
- USED FOR PATTERN MATCHING
*/


-- HASH INDEX
/*
- USED ONLY FOR EQUALITY OPERATORS - =
- NOT FOR RANGE OR DISEQUALITY OPERATORS
- LARGER THAN B-TREE INDEXES
*/

CREATE INDEX idx_h_orders_order_date ON orders
USING hash (order_date);


SELECT * FROM orders
ORDER BY order_date;


EXPLAIN SELECT * FROM orders
WHERE order_date = '2020-01-01';
"Index Scan using idx_h_orders_order_date on orders  (cost=0.00..8.02 rows=1 width=90)"


-- BRIN INDEX
/*
- BLOCK RANGE INDEX
- DATA BLOCK - MIN TO MAX VALUE
- SMALLER INDEX
- LESS COSTLY TO MAINTAIN THAN B-TREE INDEX
- CAN BE USED ON LARGE TABLE
- USE LINEAR SORT ORDER 
*/


-- GIN INDEX
/*
- GENERALIZED INVERTED INDEX
- POINT TO MULTIPLE TUPLES
- USED FOR ARRAY TYPE DATA
- USED FOR FULL TEXT SERACH
- USEFUL WHEN MULTIPLE VALUES ARE STORED IN A SINGLE COLUMN
*/


-- EXPLAIN STATEMENT
/*
- SHOWS EXECUTION PLAN OF QUERY
- IT WON'T EXECUTE STATEMENT
- SHOWS EXECUTION NODES THAT EXECUTOR USES
- RETURNS EXECUTION NODES, LOWEST COST, ROWS, WIDTH
*/

EXPLAIN SELECT * FROM suppliers
WHERE supplier_id = 1;
"Seq Scan on suppliers  (cost=0.00..1.36 rows=1 width=740)"
"  Filter: (supplier_id = 1)"

EXPLAIN SELECT company_name FROM suppliers
ORDER BY company_name;
"Sort  (cost=1.99..2.07 rows=29 width=98)"
"  Sort Key: company_name"
"  ->  Seq Scan on suppliers  (cost=0.00..1.29 rows=29 width=98)"

EXPLAIN SELECT supplier_id FROM suppliers
WHERE supplier_id = 1
ORDER BY company_name, city;
"Sort  (cost=1.37..1.38 rows=1 width=148)"
"  Sort Key: company_name, city"
"  ->  Seq Scan on suppliers  (cost=0.00..1.36 rows=1 width=148)"
"        Filter: (supplier_id = 1)"


-- EXPLAIN OUTPUT OPTIONS
EXPLAIN (FORMAT JSON) SELECT * FROM orders
WHERE order_id = 1;
"[
  {
    ""Plan"": {
      ""Node Type"": ""Index Scan"",
      ""Parallel Aware"": false,
      ""Async Capable"": false,
      ""Scan Direction"": ""Forward"",
      ""Index Name"": ""idx_u_orders_order_id_customer_id"",
      ""Relation Name"": ""orders"",
      ""Alias"": ""orders"",
      ""Startup Cost"": 0.28,
      ""Total Cost"": 8.29,
      ""Plan Rows"": 1,
      ""Plan Width"": 90,
      ""Index Cond"": ""(order_id = 1)""
    }
  }
]"


-- EXPLAIN ANALYZE
/*
- RETURNS BEST PLAN TO EXECUTE QUERY
- REPORTS BACK SOME STATISTICAL INFORMATION
*/

EXPLAIN ANALYZE SELECT * FROM orders
WHERE order_id = 1
ORDER BY order_id;
"Index Scan using idx_u_orders_order_id_customer_id on orders  (cost=0.28..8.29 rows=1 width=90) (actual time=0.191..0.192 rows=0 loops=1)"
"  Index Cond: (order_id = 1)"
"Planning Time: 0.374 ms"
"Execution Time: 0.237 ms"


-- QUERY COST MODEL
CREATE TABLE t_big (
	id SERIAL,
	name TEXT
);

INSERT INTO t_big (name)
SELECT 'Adam' FROM generate_series(1, 2000000);

INSERT INTO t_big (name)
SELECT 'Linda' FROM generate_series(1, 2000000);

EXPLAIN SELECT * FROM t_big
WHERE id = 12345;


SHOW max_parallel_workers_per_gather;
"2"

SET max_parallel_workers_per_gather = 0;

SELECT pg_relation_size('t_big') / 8192.0;
21622.000000000000

SHOW seq_page_cost;
"1"

SHOW cpu_tuple_cost;
"0.01"

SHOW cpu_operator_cost;
"0.0025"

SELECT 21622.000000000000 * 1 + 4000000 * 0.01 + 4000000 * 0.0025;
71622.000000000000

SET max_parallel_workers_per_gather TO 2;


-- INDEX ARE NOT FREE
SELECT pg_size_pretty(pg_indexes_size('t_big'));
"0 bytes"
"86 MB"

SELECT pg_size_pretty(pg_total_relation_size('t_big'));
"169 MB"
"255 MB"


EXPLAIN ANALYZE SELECT * FROM t_big
WHERE id = 123456;
"Gather  (cost=1000.00..43455.43 rows=1 width=9) (actual time=31.372..654.282 rows=1 loops=1)"
"  Workers Planned: 2"
"  Workers Launched: 2"
"  ->  Parallel Seq Scan on t_big  (cost=0.00..42455.33 rows=1 width=9) (actual time=293.514..483.452 rows=0 loops=3)"
"        Filter: (id = 123456)"
"        Rows Removed by Filter: 1333333"
"Planning Time: 0.104 ms"
"Execution Time: 654.315 ms"

CREATE INDEX idx_t_big_id ON t_big (id);


SHOW max_parallel_maintenance_workers;
"2"


-- INDEX FOR SORTED OUTPUT
EXPLAIN SELECT * FROM t_big
ORDER BY id
LIMIT 20;
"Limit  (cost=0.43..1.06 rows=20 width=9)"
"  ->  Index Scan using idx_t_big_id on t_big  (cost=0.43..125505.43 rows=4000000 width=9)"


EXPLAIN SELECT * FROM t_big
ORDER BY name
LIMIT 20;
"Limit  (cost=83638.10..83640.43 rows=20 width=9)"
"  ->  Gather Merge  (cost=83638.10..472554.22 rows=3333334 width=9)"
"        Workers Planned: 2"
"        ->  Sort  (cost=82638.08..86804.74 rows=1666667 width=9)"
"              Sort Key: name"
"              ->  Parallel Seq Scan on t_big  (cost=0.00..38288.67 rows=1666667 width=9)"


EXPLAIN SELECT
MIN(id), MAX(id)
FROM t_big;
"Result  (cost=0.92..0.93 rows=1 width=8)"
"  InitPlan 1"
"    ->  Limit  (cost=0.43..0.46 rows=1 width=4)"
"          ->  Index Only Scan using idx_t_big_id on t_big  (cost=0.43..114700.43 rows=4000000 width=4)"
"  InitPlan 2"
"    ->  Limit  (cost=0.43..0.46 rows=1 width=4)"
"          ->  Index Only Scan Backward using idx_t_big_id on t_big t_big_1  (cost=0.43..114700.43 rows=4000000 width=4)"


-- MULTIPLE INDEXES
EXPLAIN SELECT * FROM t_big
WHERE id = 20 OR id = 40;
"Bitmap Heap Scan on t_big  (cost=8.88..16.85 rows=2 width=9)"
"  Recheck Cond: ((id = 20) OR (id = 40))"
"  ->  BitmapOr  (cost=8.88..8.88 rows=2 width=0)"
"        ->  Bitmap Index Scan on idx_t_big_id  (cost=0.00..4.44 rows=1 width=0)"
"              Index Cond: (id = 20)"
"        ->  Bitmap Index Scan on idx_t_big_id  (cost=0.00..4.44 rows=1 width=0)"
"              Index Cond: (id = 40)"


-- EXECUTION PLAN DEPENDS ON INPUT VALUES
CREATE INDEX idx_t_big_name ON t_big (name);

EXPLAIN SELECT * FROM t_big
WHERE name = 'Adam'
LIMIT 10;
"Limit  (cost=0.00..0.36 rows=10 width=9)"
"  ->  Seq Scan on t_big  (cost=0.00..71622.00 rows=2008133 width=9)"
"        Filter: (name = 'Adam'::text)"

EXPLAIN SELECT * FROM t_big
WHERE name = 'Adam'
OR name = 'Linda';
"Seq Scan on t_big  (cost=0.00..81622.00 rows=3000017 width=9)"
"  Filter: ((name = 'Adam'::text) OR (name = 'Linda'::text))"


EXPLAIN SELECT * FROM t_big
WHERE name = 'Adam1'
OR name = 'Linda1';
"Bitmap Heap Scan on t_big  (cost=8.88..12.89 rows=1 width=9)"
"  Recheck Cond: ((name = 'Adam1'::text) OR (name = 'Linda1'::text))"
"  ->  BitmapOr  (cost=8.88..8.88 rows=1 width=0)"
"        ->  Bitmap Index Scan on idx_t_big_name  (cost=0.00..4.44 rows=1 width=0)"
"              Index Cond: (name = 'Adam1'::text)"
"        ->  Bitmap Index Scan on idx_t_big_name  (cost=0.00..4.44 rows=1 width=0)"
"              Index Cond: (name = 'Linda1'::text)"


-- ORGANIZED VS RANDOM DATA
SELECT * FROM t_big
ORDER BY id
LIMIT 10;


EXPLAIN (ANALYZE TRUE, BUFFERS TRUE, TIMING TRUE)
SELECT * FROM t_big
WHERE id < 10000;
"Index Scan using idx_t_big_id on t_big  (cost=0.43..335.25 rows=9761 width=9) (actual time=0.043..4.664 rows=9999 loops=1)"
"  Index Cond: (id < 10000)"
"  Buffers: shared hit=4 read=81"
"Planning:"
"  Buffers: shared hit=4"
"Planning Time: 1.096 ms"
"Execution Time: 5.294 ms"


CREATE TABLE t_big_random AS
SELECT * FROM t_big ORDER BY random();

CREATE INDEX idx_t_big_random_id ON t_big_random (id);

SELECT * FROM t_big_random LIMIT 10;


VACUUM ANALYZE t_big_random;


EXPLAIN (ANALYZE TRUE, BUFFERS TRUE, TIMING TRUE)
SELECT * FROM t_big_random
WHERE id < 10000;
"Bitmap Heap Scan on t_big_random  (cost=196.30..18125.64 rows=10306 width=9) (actual time=5.187..181.825 rows=9999 loops=1)"
"  Recheck Cond: (id < 10000)"
"  Heap Blocks: exact=8067"
"  Buffers: shared hit=983 read=7114"
"  ->  Bitmap Index Scan on idx_t_big_random_id  (cost=0.00..193.73 rows=10306 width=0) (actual time=3.290..3.290 rows=9999 loops=1)"
"        Index Cond: (id < 10000)"
"        Buffers: shared hit=3 read=27"
"Planning:"
"  Buffers: shared hit=9 read=3"
"Planning Time: 0.322 ms"
"Execution Time: 183.621 ms"


SELECT tablename, attname, correlation
FROM pg_stats
WHERE tablename IN ('t_big','t_big_random')
ORDER BY 1, 2;


-- INDEX ONLY SCAN
EXPLAIN ANALYZE SELECT * FROM t_big
WHERE id = 123456;
"Index Scan using idx_t_big_id on t_big  (cost=0.43..8.45 rows=1 width=9) (actual time=0.889..0.893 rows=1 loops=1)"
"  Index Cond: (id = 123456)"
"Planning Time: 0.202 ms"
"Execution Time: 0.934 ms"

EXPLAIN ANALYZE SELECT id FROM t_big
WHERE id = 123456;
"Index Only Scan using idx_t_big_id on t_big  (cost=0.43..8.45 rows=1 width=4) (actual time=0.030..0.032 rows=1 loops=1)"
"  Index Cond: (id = 123456)"
"  Heap Fetches: 0"
"Planning Time: 0.152 ms"
"Execution Time: 0.062 ms"


-- PARTIAL INDEXES
SELECT pg_size_pretty(pg_indexes_size('t_big'));
"112 MB"
"86 MB"
"86 MB"

DROP INDEX idx_t_big_name;


CREATE INDEX idx_p_t_big_name ON t_big (name)
WHERE name NOT IN ('Adam','Linda');


SELECT * FROM customers;

UPDATE customers
SET is_active = 'N'
WHERE customer_id IN ('ALFKI','ANATR');

EXPLAIN ANALYZE SELECT * FROM customers
WHERE is_active = 'N';
"Seq Scan on customers  (cost=0.00..3.14 rows=1 width=134) (actual time=0.078..0.080 rows=2 loops=1)"
"  Filter: (is_active = 'N'::bpchar)"
"  Rows Removed by Filter: 89"
"Planning Time: 0.134 ms"
"Execution Time: 0.104 ms"


CREATE INDEX idx_p_customers_is_active ON customers (is_active)
WHERE is_active = 'N';


EXPLAIN ANALYZE SELECT * FROM customers
WHERE is_active = 'N';
"Seq Scan on customers  (cost=0.00..3.14 rows=1 width=134) (actual time=0.071..0.072 rows=2 loops=1)"
"  Filter: (is_active = 'N'::bpchar)"
"  Rows Removed by Filter: 89"
"Planning Time: 1.998 ms"
"Execution Time: 0.095 ms"


-- EXPRESSION INDEX
/*
- INDEX BASED ON EXPRESSION
- USED WHEN EXPRESSION APPEAR EITHER IN WHERE CLAUSE OR ORDER BY CLAUSE
- VERY EXPENSIVE INDEXES
*/

CREATE TABLE t_dates AS
SELECT d, repeat(md5(d::TEXT), 10) AS "Padding"
FROM generate_series(TIMESTAMP '1800-01-01', TIMESTAMP '2100-01-01', INTERVAL '1 DAY') AS s(d);

VACUUM ANALYZE t_dates;

SELECT COUNT(*) FROM t_dates;
109574

EXPLAIN ANALYZE SELECT * FROM t_dates
WHERE d BETWEEN '2001-01-01' AND '2001-01-31';
"Seq Scan on t_dates  (cost=0.00..6624.61 rows=32 width=332)"
"  Filter: ((d >= '2001-01-01 00:00:00'::timestamp without time zone) AND (d <= '2001-01-31 00:00:00'::timestamp without time zone))"
"  Rows Removed by Filter: 109543"
"Planning Time: 0.108 ms"
"Execution Time: 36.627 ms"

CREATE INDEX idx_t_dates_d ON t_dates (d);

EXPLAIN ANALYZE SELECT * FROM t_dates
WHERE d BETWEEN '2001-01-01' AND '2001-01-31';
"Index Scan using idx_t_dates_d on t_dates  (cost=0.42..10.06 rows=32 width=332) (actual time=0.102..0.115 rows=31 loops=1)"
"  Index Cond: ((d >= '2001-01-01 00:00:00'::timestamp without time zone) AND (d <= '2001-01-31 00:00:00'::timestamp without time zone))"
"Planning Time: 2.030 ms"
"Execution Time: 0.141 ms"


ANALYZE t_dates; -- TO GET THE FRESH DATA


EXPLAIN ANALYZE SELECT * FROM t_dates
WHERE EXTRACT(DAY FROM d) = 1;
"Seq Scan on t_dates  (cost=0.00..6624.61 rows=548 width=332) (actual time=0.540..57.490 rows=3601 loops=1)"
"  Filter: (EXTRACT(day FROM d) = '1'::numeric)"
"  Rows Removed by Filter: 105973"
"Planning Time: 1.081 ms"
"Execution Time: 57.756 ms"


CREATE INDEX idx_expr_t_dates_d ON t_dates (EXTRACT(DAY FROM d));


ANALYZE t_dates;

EXPLAIN ANALYZE SELECT * FROM t_dates
WHERE EXTRACT(DAY FROM d) = 1;
"Bitmap Heap Scan on t_dates  (cost=68.10..4908.49 rows=3572 width=332) (actual time=5.879..117.612 rows=3601 loops=1)"
"  Recheck Cond: (EXTRACT(day FROM d) = '1'::numeric)"
"  Heap Blocks: exact=3601"
"  ->  Bitmap Index Scan on idx_expr_t_dates_d  (cost=0.00..67.21 rows=3572 width=0) (actual time=4.081..4.082 rows=3601 loops=1)"
"        Index Cond: (EXTRACT(day FROM d) = '1'::numeric)"
"Planning Time: 0.352 ms"
"Execution Time: 7.226 ms"


-- ADDING DATA WHILE INDEXING
CREATE INDEX CONCURRENTLY idx_t_big_name ON t_big (name);


SELECT oid, relname, relpages, reltuples,
i.indisunique, i.indisclustered, i.indisvalid,
pg_catalog.pg_get_indexdef(i.indexrelid, 0, TRUE)
FROM pg_class AS c
JOIN pg_index AS i ON c.oid = i.indrelid
WHERE c.relname = 't_big';


-- INVALIDATE INDEX
SELECT oid, relname, relpages, reltuples,
i.indisunique, i.indisclustered, i.indisvalid,
pg_catalog.pg_get_indexdef(i.indexrelid, 0, TRUE)
FROM pg_class AS c
JOIN pg_index AS i ON c.oid = i.indrelid
WHERE c.relname = 'orders';

SELECT * FROM orders;

EXPLAIN SELECT * FROM orders
WHERE ship_country = 'USA';
"Seq Scan on orders  (cost=0.00..24.38 rows=122 width=90)"
"  Filter: ((ship_country)::text = 'USA'::text)"

CREATE INDEX idx_orders_ship_country ON orders (ship_country);

EXPLAIN SELECT * FROM orders
WHERE ship_country = 'USA';
"Bitmap Heap Scan on orders  (cost=5.10..20.62 rows=122 width=90)"
"  Recheck Cond: ((ship_country)::text = 'USA'::text)"
"  ->  Bitmap Index Scan on idx_orders_ship_country  (cost=0.00..5.07 rows=122 width=0)"
"        Index Cond: ((ship_country)::text = 'USA'::text)"


UPDATE pg_index
SET indisvalid = FALSE
WHERE indexrelid = (
	SELECT oid	FROM pg_class
	WHERE relkind = 'i'
	AND relname = 'idx_orders_ship_country'
);


EXPLAIN SELECT * FROM orders
WHERE ship_country = 'USA';
"Seq Scan on orders  (cost=0.00..24.38 rows=122 width=90)"
"  Filter: ((ship_country)::text = 'USA'::text)"


-- REBUILD INDEX
REINDEX INDEX idx_orders_customer_id_order_id;


REINDEX (VERBOSE) INDEX idx_orders_customer_id_order_id;


REINDEX (VERBOSE) TABLE orders;


REINDEX (VERBOSE) SCHEMA public;


REINDEX (VERBOSE) DATABASE northwind;


BEGIN
	REINDEX INDEX
	REINDEX TABLE
END


REINDEX (VERBOSE) TABLE CONCURRENTLY orders;