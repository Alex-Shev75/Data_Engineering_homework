/*
 Завдання на SQL до лекції 03.

1.
Вивести кількість фільмів в кожній категорії.
Результат відсортувати за спаданням.
*/

SELECT category_id, COUNT(*) AS film_count
FROM film_category
GROUP BY category_id
ORDER BY film_count DESC;

/*
2.
Вивести 10 акторів, чиї фільми брали на прокат найбільше.
Результат відсортувати за спаданням.
*/

SELECT first_name, last_name, COUNT(rental.rental_id) AS rental_count
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film ON film_actor.film_id = film.film_id
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY actor.actor_id
ORDER BY rental_count DESC
LIMIT 10;

/*
3.1
Вивести категорія фільмів, на яку було витрачено найбільше грошей
в прокаті
*/

SELECT category.name AS category, category.category_id, SUM(film.rental_rate) AS total_rental_sum
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN film ON film_category.film_id = film.film_id
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY category.category_id
ORDER BY total_rental_sum DESC
LIMIT 1;

/*
3.2
Вивести категорія фільмів, на яку було витрачено найбільше грошей
в прокаті
*/

SELECT category.name AS category, category.category_id, SUM(payment.amount) AS total_payment_sum
FROM payment
JOIN rental ON payment.rental_id = rental.rental_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film_category ON inventory.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY category.category_id, category.name
ORDER BY total_payment_sum DESC
LIMIT 1;

/*
4.
Вивести назви фільмів, яких не має в inventory.
Запит має бути без оператора IN
*/

SELECT film.title, inventory.inventory_id
FROM film
LEFT JOIN inventory ON film.film_id = inventory.film_id
WHERE inventory.film_id IS NULL;

/*
5.
Вивести топ 3 актори, які найбільше зʼявлялись в категорії фільмів “Children”.
*/

SELECT  actor.first_name, actor.last_name, category.name AS category, COUNT(film_category.category_id) AS number_of_times
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film_category ON film_actor.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE category.name = 'Children'
GROUP BY actor.first_name, actor.last_name, category.name
ORDER BY number_of_times DESC
LIMIT 3;
