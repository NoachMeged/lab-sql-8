-- Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.

SELECT title, length,
RANK() OVER (ORDER BY length) AS film_rank
FROM sakila.film
WHERE length IS NOT NULL AND length > 0;

-- Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). In your output, only select the columns title, length, rating and rank.

SELECT title, length, rating,
RANK() OVER (PARTITION BY rating ORDER BY length) AS film_rank
FROM film
WHERE length IS NOT NULL AND length > 0;

-- How many films are there for each of the categories in the category table? Hint: Use appropriate join between the tables "category" and "film_category".

SELECT
    COUNT(film_id) AS film_count,
    category_id
FROM
    film_category
GROUP BY
    category_id;
    
-- Which actor has appeared in the most films? 

SELECT a.actor_id, a.first_name, a.last_name, COUNT(fa.film_id) AS film_count
FROM actor as a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY film_count DESC
LIMIT 1;

-- Which is the most active customer (the customer that has rented the most number of films)?\

SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS rental_count
FROM customer as c
JOIN rental as r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY rental_count DESC
LIMIT 1;

--  Which is the most rented film? (The answer is Bucket Brotherhood).

SELECT f.film_id, f.title AS most_rented_film, COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
ORDER BY rental_count DESC
LIMIT 1;

