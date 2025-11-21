USE sakila;

-- 1. Get all customers whose first name starts with 'J' and who are active.
SELECT *
FROM customer
WHERE first_name LIKE 'J%'
  AND active = 1;


-- 2. Find all films where the title contains 'ACTION' or the description contains 'WAR'.
SELECT *
FROM film
WHERE title LIKE '%ACTION%'
   OR description LIKE '%WAR%';


-- 3. List all customers whose last name is not 'SMITH' and whose first name ends with 'a'.
SELECT *
FROM customer
WHERE last_name <> 'SMITH'
  AND first_name LIKE '%a';


-- 4. Get all films where the rental rate is greater than 3.0 and the replacement cost is not null.
SELECT *
FROM film
WHERE rental_rate > 3.0
  AND replacement_cost IS NOT NULL;


-- 5. Count how many customers exist in each store who have active status = 1.
SELECT store_id,
       COUNT(*) AS active_customer_count
FROM customer
WHERE active = 1
GROUP BY store_id;


-- 6. Show distinct film ratings available in the film table.
SELECT DISTINCT rating
FROM film;


-- 7. Number of films for each rental duration where the average length is more than 100 minutes.
SELECT rental_duration,
       COUNT(*) AS film_count,
       AVG(length) AS avg_length
FROM film
GROUP BY rental_duration
HAVING AVG(length) > 100;


-- 8. Payment dates and total amount paid per date, only for days where more than 100 payments were made.
SELECT DATE(payment_date) AS payment_date,
       COUNT(*) AS payment_count,
       SUM(amount) AS total_amount
FROM payment
GROUP BY DATE(payment_date)
HAVING COUNT(*) > 100;


-- 9. Customers whose email address is null or ends with '.org'.
SELECT *
FROM customer
WHERE email IS NULL
   OR email LIKE '%.org';


-- 10. All films with rating 'PG' or 'G', ordered by rental rate descending.
SELECT *
FROM film
WHERE rating IN ('PG', 'G')
ORDER BY rental_rate DESC;


-- 11. Count how many films exist for each length where the title starts with 'T'
--     and the count is more than 5.
SELECT length,
       COUNT(*) AS film_count
FROM film
WHERE title LIKE 'T%'
GROUP BY length
HAVING COUNT(*) > 5;


-- 12. List all actors who have appeared in more than 10 films.
SELECT a.actor_id,
       a.first_name,
       a.last_name,
       COUNT(fa.film_id) AS film_count
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
HAVING COUNT(fa.film_id) > 10;


-- 13. Top 5 films with highest rental rates, then longest lengths.
SELECT film_id,
       title,
       rental_rate,
       length
FROM film
ORDER BY rental_rate DESC,
         length DESC
LIMIT 5;


-- 14. All customers with total number of rentals, ordered from most to least.
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       COUNT(r.rental_id) AS total_rentals
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_rentals DESC;


-- 15. Film titles that have never been rented.
SELECT f.film_id,
       f.title
FROM film f
WHERE NOT EXISTS (
    SELECT 1
    FROM inventory i
    JOIN rental r ON i.inventory_id = r.inventory_id
    WHERE i.film_id = f.film_id
);


-- 16. All staff members with total payments they have processed, ordered by total desc.
SELECT s.staff_id,
       s.first_name,
       s.last_name,
       SUM(p.amount) AS total_payments
FROM staff s
JOIN payment p ON s.staff_id = p.staff_id
GROUP BY s.staff_id, s.first_name, s.last_name
ORDER BY total_payments DESC;


-- 17. Category name with total number of films in each category.
SELECT c.category_id,
       c.name AS category_name,
       COUNT(fc.film_id) AS film_count
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
GROUP BY c.category_id, c.name;


-- 18. Top 3 customers who have spent the most money in total.
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       SUM(p.amount) AS total_spent
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC
LIMIT 3;


-- 19. Films that were rented in the month of May (any year)
--     and have rental_duration > 5 days.
SELECT DISTINCT f.film_id,
       f.title,
       f.rental_duration
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
WHERE MONTH(r.rental_date) = 5
  AND f.rental_duration > 5;


-- 20. Average rental rate for each film category,
--     only include categories with more than 50 films.
SELECT c.category_id,
       c.name AS category_name,
       AVG(f.rental_rate) AS avg_rental_rate,
       COUNT(*) AS film_count
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.category_id, c.name
HAVING COUNT(*) > 50;

