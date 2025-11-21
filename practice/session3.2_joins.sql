USE sakila;

# TYPES OF JOINS

# 1. INNER JOIN
##Show rental details along with the customer who made the rental.
SELECT r.rental_id, r.rental_date, c.first_name
FROM rental r
INNER JOIN customer c 
    ON r.customer_id = c.customer_id
LIMIT 5;

# 2. LEFT JOIN
##List all customers and check if they have any rentals.
SELECT c.customer_id, c.first_name, r.rental_id
FROM customer c
LEFT JOIN rental r 
    ON c.customer_id = r.customer_id
LIMIT 10;

# 3. RIGHT JOIN
##Show all rentals and see which customer each rental belongs to.
SELECT r.rental_id, r.rental_date, c.first_name
FROM customer c
RIGHT JOIN rental r
    ON c.customer_id = r.customer_id
LIMIT 10;

# 4. SELF JOIN
##Find films that have the same rental duration as other films.
SELECT f1.title AS film1, f2.title AS film2
FROM film f1
JOIN film f2 
    ON f1.rental_duration = f2.rental_duration
   AND f1.film_id <> f2.film_id
LIMIT 10;

# 5. CROSS JOIN
##Generate all combinations of the first few actors and categories.
SELECT a.first_name, c.name
FROM actor a
CROSS JOIN category c
LIMIT 10;

# 6. FULL OUTER JOIN
##Get a list of all customers and rentals — including unmatched rows.
SELECT c.customer_id, r.rental_id
FROM customer c
LEFT JOIN rental r 
    ON c.customer_id = r.customer_id

UNION

SELECT c.customer_id, r.rental_id
FROM customer c
RIGHT JOIN rental r 
    ON c.customer_id = r.customer_id;
    
# 7. DISTINCT with JOIN
##How many unique films were rented?
SELECT DISTINCT f.title
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
LIMIT 10;




