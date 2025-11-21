USE sakila;

#1. Identiify there are duplicates in Customer table. Don't use customer id to check the duplicates
SELECT email, COUNT(*) AS duplicate_count
FROM customer
GROUP BY email
HAVING COUNT(*) > 1;

#2. Number of times letter 'a' is repeated in film descriptions
SELECT film_id, title,
    LENGTH(description) - LENGTH(REPLACE(LOWER(description), 'a', '')) AS a_count
FROM film;

#3. Number of times each vowel is repeated in film descriptions
SELECT
    film_id,
    title,
    LENGTH(desc_lower) - LENGTH(REPLACE(desc_lower, 'a', '')) AS a_count,
    LENGTH(desc_lower) - LENGTH(REPLACE(desc_lower, 'e', '')) AS e_count,
    LENGTH(desc_lower) - LENGTH(REPLACE(desc_lower, 'i', '')) AS i_count,
    LENGTH(desc_lower) - LENGTH(REPLACE(desc_lower, 'o', '')) AS o_count,
    LENGTH(desc_lower) - LENGTH(REPLACE(desc_lower, 'u', '')) AS u_count
FROM (
    SELECT 
        film_id,
        title,
        LOWER(description) AS desc_lower
    FROM film
) AS f;

#4. Display the payments made by each customer
# MONTH-WISE:
SELECT 
    customer_id,
    YEAR(payment_date)  AS pay_year,
    MONTH(payment_date) AS pay_month,
    SUM(amount) AS total_amount
FROM payment
GROUP BY 
    customer_id,
    YEAR(payment_date),
    MONTH(payment_date);

# YEAR WISE:
SELECT 
    customer_id,
    YEAR(payment_date) AS pay_year,
    SUM(amount)        AS total_amount
FROM payment
GROUP BY 
    customer_id,
    YEAR(payment_date);

# WEEK WISE:
SELECT 
    customer_id,
    YEAR(payment_date)    AS pay_year,
    WEEK(payment_date, 1) AS pay_week,
    SUM(amount)           AS total_amount
FROM payment
GROUP BY 
    customer_id,
    YEAR(payment_date),
    WEEK(payment_date, 1);
    
# 5. Check if any given year is a leap year or not. You need not consider any table from sakila database. Write within the select query with hardcoded date
    SELECT 
    '2100-01-01' AS given_date,
    YEAR('2100-01-01') AS given_year,
    CASE
        WHEN YEAR('2100-01-01') % 400 = 0 THEN 'Leap Year'
        WHEN YEAR('2100-01-01') % 100 = 0 THEN 'Not a Leap Year'
        WHEN YEAR('2100-01-01') % 4 = 0 THEN 'Leap Year'
        ELSE 'Not a Leap Year'
    END AS result;
    
#6. Display number of days remaining in the current year from today
SELECT 
    CURDATE() AS today,
    LAST_DAY(CONCAT(YEAR(CURDATE()), '-12-01')) AS last_day_of_year,
    DATEDIFF(
        LAST_DAY(CONCAT(YEAR(CURDATE()), '-12-01')), 
        CURDATE()
    ) AS days_remaining;
    
    






