USE sakila;

# Scalar/Single-row Subquery:
## Find the film(s) in the film table that have the highest rental_rate
SELECT title, rental_rate
FROM film
WHERE rental_rate = (
    SELECT MAX(rental_rate)
    FROM film
);

# Multi-row Subquery:
## Find customers who have made at least one payment.
SELECT customer_id, first_name, last_name
FROM customer
WHERE customer_id IN (
    SELECT DISTINCT customer_id 
    FROM payment
);

# Subquery in SELECT clause:
## Show each customer and the total amount they paid
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    (SELECT SUM(amount)
     FROM payment p
     WHERE p.customer_id = c.customer_id) AS total_paid
FROM customer c;

# DERIVED TABLE : Subquery inside FROM
## Find customers who paid more than 100 total.
SELECT *
FROM (
    SELECT customer_id, SUM(amount) AS total_amount
    FROM payment
    GROUP BY customer_id
) AS t
WHERE t.total_amount > 100;

# CORRELATED SUBQUERY
## Find films longer than the average length of films with the same rating
SELECT f1.title, f1.rating, f1.length
FROM film f1
WHERE f1.length >
(
    SELECT AVG(f2.length)
    FROM film f2
    WHERE f2.rating = f1.rating   -- correlated
);



