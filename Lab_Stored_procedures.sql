# Lab | Stored procedures
# In this lab, we will continue working on the [Sakila](https://dev.mysql.com/doc/sakila/en/) database of movie rentals. 
### Instructions
#Write queries, stored procedures to answer the following questions:
#- In the previous lab we wrote a query to find first name, last name, and emails of all the customers who rented `Action` movies. Convert the query into a simple stored procedure. Use the following query:

  ```sql
    select first_name, last_name, email
    from customer
    join rental on customer.customer_id = rental.customer_id
    join inventory on rental.inventory_id = inventory.inventory_id
    join film on film.film_id = inventory.film_id
    join film_category on film_category.film_id = film.film_id
    join category on category.category_id = film_category.category_id
    where category.name = "Action"
    group by first_name, last_name, email;
  ```
#- Now keep working on the previous stored procedure to make it more dynamic. Update the stored procedure in a such manner that it can take a string argument for the category name and return the results for all customers that rented movie of that category/genre. 
#      	For eg., it could be `action`, `animation`, `children`, `classics`, etc.


drop procedure if exists SP_customer_by_catagory;

delimiter //
create procedure SP_customer_by_catagory (IN param1 VARCHAR(25))
begin
select first_name, last_name, email
    from customer
    join rental on customer.customer_id = rental.customer_id
    join inventory on rental.inventory_id = inventory.inventory_id
    join film on film.film_id = inventory.film_id
    join film_category on film_category.film_id = film.film_id
    join category on category.category_id = film_category.category_id
    where category.name = param1
    group by first_name, last_name, email;
end; 
// delimiter ; 

call SP_customer_by_catagory('Classics');



#Write a query to check the number of movies released in each movie category. 

select c.category_id, c.name, count(f.film_id) as films_available from film f
join film_category fc using (film_id)
join category c using (category_id)
group by c.name


#Convert the query in to a stored procedure to filter only those categories that have movies released greater than a certain number. 

drop procedure if exists SP_films_in_category_above_x;

delimiter //
create procedure SP_films_in_category_above_x (IN param1 tinyint(2))
begin
	select c.category_id, c.name, count(f.film_id) as films_available from film f
	join film_category fc using (film_id)
	join category c using (category_id)
    group by c.name
    having films_available > param1;
end; 
// delimiter ;

#Pass that number as an argument in the stored procedure.

call SP_films_in_category_above_x(60);