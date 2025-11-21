USE sakila;
------------------------------------------------
-- 1. Basic SELECT + DISTINCT
-- All actors
SELECT * FROM sakila.actor;

-- Distinct LAST names instead of first names
SELECT DISTINCT last_name
FROM sakila.actor;

------------------------------------------------
-- 2. Simple WHERE on film
------------------------------------------------

-- Films where original_language_id is NOT NULL (reverse of trainer)
SELECT *
FROM sakila.film
WHERE original_language_id IS NOT NULL;

-- Count all films
SELECT COUNT(*) AS total_films
FROM sakila.film;

-- Distinct ratings among films with no original_language_id
SELECT DISTINCT rating
FROM sakila.film
WHERE original_language_id IS NULL;

-- Count of distinct ratings in film table
SELECT COUNT(DISTINCT rating) AS distinct_ratings
FROM sakila.film;

------------------------------------------------
-- 3. COUNT vs COUNT(DISTINCT)
------------------------------------------------

-- Count of all actor last names (NULLs ignored)
SELECT COUNT(last_name) AS last_name_count
FROM sakila.actor;

-- Count of distinct actor last names
SELECT COUNT(DISTINCT last_name) AS distinct_last_name_count
FROM sakila.actor;

------------------------------------------------
-- 4. Select specific columns
------------------------------------------------

SELECT actor_id, first_name, last_name
FROM sakila.actor;

------------------------------------------------
-- 5. LIMIT
------------------------------------------------

SELECT actor_id, first_name, last_name
FROM sakila.actor
ORDER BY actor_id
LIMIT 10;

------------------------------------------------
-- 6. Filtering with WHERE
------------------------------------------------

-- Distinct film ratings
SELECT DISTINCT rating
FROM sakila.film;

-- Films that are PG-13 and longer than 120 mins
SELECT *
FROM sakila.film
WHERE rating = 'PG-13'
  AND length > 120;

-- All films with rental_duration greater than or equal to 6 days
SELECT title, rental_duration
FROM sakila.film
WHERE rental_duration >= 6;

------------------------------------------------
-- 7. Sorting with ORDER BY
------------------------------------------------

-- All unique rental rates sorted ascending
SELECT DISTINCT rental_rate
FROM sakila.film
ORDER BY rental_rate ASC;

-- Films sorted by length (descending)
SELECT title, length
FROM sakila.film
ORDER BY length DESC;

------------------------------------------------
-- 8. AND / OR examples
------------------------------------------------

-- Films that are PG and rental_duration = 7
SELECT *
FROM sakila.film
WHERE rating = 'PG'
  AND rental_duration = 7
ORDER BY rental_rate ASC;

-- Films that are G OR have rental_duration >= 6
SELECT *
FROM sakila.film
WHERE rating = 'G'
   OR rental_duration >= 6
ORDER BY length DESC;

------------------------------------------------
-- 9. NOT examples
------------------------------------------------

-- Films whose rating is NOT 'R'
SELECT *
FROM sakila.film
WHERE rating <> 'R';

-- Films whose rental_duration is NOT 3, 4, or 5
SELECT *
FROM sakila.film
WHERE rental_duration NOT IN (3, 4, 5)
ORDER BY rental_duration, title;

------------------------------------------------
-- 10. Combined conditions with brackets
------------------------------------------------

-- rental_duration = 5 and rating is either PG or PG-13
SELECT *
FROM sakila.film
WHERE rental_duration = 5
  AND (rating = 'PG' OR rating = 'PG-13')
ORDER BY rental_rate ASC;

------------------------------------------------
-- 11. LIKE with wildcards
------------------------------------------------
-- % = 0 or more chars
-- _ = exactly 1 char

-- Cities that start with 'S' and end with 'a'
SELECT city
FROM sakila.city
WHERE city LIKE 'S%a';

-- Cities where second letter is 'a'
SELECT city
FROM sakila.city
WHERE city LIKE '_a%';

------------------------------------------------
-- 12. NULL values
-- Rentals that DO have a return_date (not null)
SELECT rental_id, inventory_id, customer_id, return_date
FROM sakila.rental
WHERE return_date IS NOT NULL;

-- Payments where amount is not null (all, but just for syntax)
SELECT payment_id, customer_id, amount
FROM sakila.payment
WHERE amount IS NOT NULL;

------------------------------------------------
-- 13. BETWEEN
-- Rentals returned between specific dates
SELECT rental_id, inventory_id, customer_id, return_date
FROM sakila.rental
WHERE return_date BETWEEN '2005-06-01' AND '2005-06-15';

-- Payments between 2 and 6 dollars
SELECT payment_id, customer_id, amount, payment_date
FROM sakila.payment
WHERE amount BETWEEN 2.00 AND 6.00;

------------------------------------------------
-- 14. GROUP BY + HAVING (duplicates / aggregates)
-- How many rentals each customer has
SELECT customer_id, COUNT(*) AS rental_count
FROM sakila.rental
GROUP BY customer_id
HAVING rental_count >= 20
ORDER BY rental_count DESC;

-- Total payment per customer, only those > 80
SELECT customer_id, SUM(amount) AS total_paid
FROM sakila.payment
GROUP BY customer_id
HAVING SUM(amount) > 80
ORDER BY total_paid DESC;

------------------------------------------------
-- 15. WHERE vs HAVING example
-- WHERE filters individual rows
SELECT *
FROM sakila.payment
WHERE amount > 5;

-- HAVING filters groups AFTER GROUP BY
SELECT customer_id, SUM(amount) AS total_paid
FROM sakila.payment
GROUP BY customer_id
HAVING SUM(amount) > 100;

------------------------------------------------
-- 16. ORDER of execution:
-- FROM  (table) -> JOIN -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY -> LIMIT
