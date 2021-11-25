# Lab | SQL Joins on multiple tables

#In this lab, you will be using the [Sakila](https://dev.mysql.com/doc/sakila/en/) database of movie rentals.

### Instructions

#1. Write a query to display for each store its store ID, city, and country.
select *  from sakila.store;
select * from sakila.city;
select * from sakila.address;
select * from sakila.country;

select store_id, city, country from sakila.store st join sakila.address a using(address_id) 
join sakila.city cit using (city_id) join sakila.country coun using(country_id);

#2. Write a query to display how much business, in dollars, each store brought in.
select * from sakila.payment;
select * from  sakila.store;
select * from sakila.rental;

select concat('$', format(sum(amount), 2)) as 'total Business' , st.store_id from sakila.payment p join sakila.store st
on p.staff_id = st.manager_staff_id
group by staff_id;


#3. What is the average running time of films by category?
select * from sakila.category;
select * from sakila.film;
select * from sakila.film_category;

select concat(round(avg(length),2), 'min') as 'Average length of film' , cat.name as 'Film category' from sakila.film f 
join sakila.film_category fc using(film_id) 
join sakila.category cat using(category_id)
group by cat.category_id
order by cat.name;

#4. Which film categories are longest?
select concat(round(avg(length),2), 'min') as 'Average length of film' , cat.name as 'Film category' from sakila.film f 
join sakila.film_category fc using(film_id) 
join sakila.category cat using(category_id)
group by cat.category_id
order by avg(length) desc;

#5. Display the most frequently rented movies in descending order.
select * from sakila.rental;
select * from sakila.inventory;
select * from sakila.film;
select count(rental_id) as 'frequency rented', title from sakila.film f join sakila.inventory i using (film_id) 
join sakila.rental r using (inventory_id)
group by f.film_id
order by count(rental_id) desc;


#6. List the top five genres in gross revenue in descending order.
select * from sakila.payment;
select * from sakila.rental;
select * from sakila.inventory;
select * from sakila.film;
select * from sakila.category;
select * from sakila.film_category;

select sum(amount) as 'gross revenue', cat.name from sakila.film f 
join sakila.inventory i using (film_id) join sakila.film_category fc using (film_id) join sakila.category cat using (category_id)
join sakila.rental r using (inventory_id) join sakila.payment p using(rental_id)
group by cat.category_id
order by (sum(amount)) desc
limit 5;


#7. Is "Academy Dinosaur" available for rent from Store 1?
select * from sakila.inventory;
select * from sakila.rental;
select * from sakila.film;
select * from sakila.store;
select inventory_id, title, rental_date, return_date , store_id from sakila.rental r join sakila.inventory i using (inventory_id)
join sakila.film f using (film_id) 
where title='Academy Dinosaur' and store_id = 1;
## not sure, if it is possible to make it better....
