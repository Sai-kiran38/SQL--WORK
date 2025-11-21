use sakila;

# LPAD
SELECT film_id,
       LPAD(film_id, 5, '0') AS padded_id
FROM film
LIMIT 7;

# RPAD
SELECT title,
       RPAD(title, 20, '.') AS right_pad
FROM film
LIMIT 8;

# SUBSTRING
SELECT title,
       SUBSTRING(title, 1, 5) AS first_five
FROM film
LIMIT 2;

# CONCAT
SELECT CONCAT(title, ' – ', rating) AS film_info
FROM film
LIMIT 2;

# REVERSE
SELECT title, REVERSE(title) AS reversed
FROM film
LIMIT 2;

# LENGTH
SELECT title, LENGTH(title) AS len
FROM film
LIMIT 2;

# LOCATE
SELECT title,
       LOCATE('A', title) AS first_A_pos
FROM film
LIMIT 2;

# SUBSTRING_INDEX
SELECT title,
       SUBSTRING_INDEX(title, ' ', -1) AS first_word
FROM film
LIMIT 2;

# UPPER & LOWER
SELECT LOWER(title) AS lower_t, UPPER(title) AS upper_t
FROM film
LIMIT 2;

# LEFT & RIGHT
SELECT title,
       LEFT(title, 4)  AS left4,
       RIGHT(title, 4) AS right4
FROM film
LIMIT 2;

# REPLACE
SELECT title,
       REPLACE(title, ' ', '_') AS snake_title
FROM film
LIMIT 2;

# ASCII
SELECT title,
       ASCII(title) AS ascii_first_char
FROM film
LIMIT 3;

# INSERT(str, pos, len, newstr)
SELECT title,
  INSERT(title, 1, 3, '***') AS masked
FROM film
LIMIT 3;

# FIELD
SELECT title,
       FIELD(rating, 'G','PG','PG-13','R') AS rating_index
FROM film
LIMIT 5;

SELECT title, rating FROM film WHERE title = 'ADAPTATION HOLES';

# SUBSTRING + LOCATE:
SELECT 
    address,
    SUBSTRING(
        address,
        LOCATE(' ', address) + 1
    ) AS street_name
FROM address
LIMIT 5;

# LIKE with UPPER & LOWER:
SELECT 
    first_name,
    last_name
FROM actor
WHERE UPPER(last_name) LIKE '%SON%';

#LEFT + GROUP BY
SELECT 
    LEFT(city, 1) AS first_letter,
    COUNT(*)      AS city_count
FROM city
GROUP BY LEFT(city, 1)
ORDER BY city_count DESC;

# CASE expression:
## group actors into buckets based on the first letter of last_name
SELECT last_name,
    CASE 
        WHEN LEFT(last_name, 1) BETWEEN 'A' AND 'H' THEN 'Group A–H'
        WHEN LEFT(last_name, 1) BETWEEN 'I' AND 'P' THEN 'Group I–P'
        WHEN LEFT(last_name, 1) BETWEEN 'Q' AND 'Z' THEN 'Group Q–Z'
        ELSE 'Other'
    END AS name_group
FROM actor
LIMIT 15;

# REGEXP:
#1.actors whose last name has two consecutive vowels
SELECT 
    first_name,
    last_name
FROM actor
WHERE last_name REGEXP '[aeiouAEIOU]{2}';

#2. film titles that start with “THE ”
SELECT 
    title
FROM film
WHERE UPPER(title) REGEXP '^THE ';

#3. titles that end with a digit
SELECT 
    title
FROM film
WHERE title REGEXP '[0-9]$';

















