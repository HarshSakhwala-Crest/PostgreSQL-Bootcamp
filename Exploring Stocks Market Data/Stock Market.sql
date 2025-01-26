-- STOCK MARKET DATA
SELECT * FROM stocks_prices
WHERE symbol_id = 1
ORDER BY price_date ASC
OFFSET 10
LIMIT 10;

SELECT * FROM stocks_prices
WHERE symbol_id = 1
ORDER BY price_date ASC
OFFSET 10
FETCH FIRST 10 ROWS ONLY;


SELECT symbol_id,
MIN(price_date) AS "Price Date"
FROM stocks_prices
GROUP BY symbol_id;

SELECT symbol_id,
MAX(price_date) AS "Price Date"
FROM stocks_prices
GROUP BY symbol_id;


SELECT CBRT(4) AS "Cube Root";
1.5874010519681994


SELECT close_price,
CBRT(close_price)
FROM stocks_prices
WHERE symbol_id = 1
ORDER BY price_date DESC;