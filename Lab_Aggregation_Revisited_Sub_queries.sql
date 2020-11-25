"""# Lab | Aggregation Revisited - Sub queries

In this lab, you will be using the [Sakila](https://dev.mysql.com/doc/sakila/en/) database of movie rentals. You have been using this database for a couple labs already, but if you need to get the data again, refer to the official [installation link](https://dev.mysql.com/doc/sakila/en/sakila-installation.html).

### Instructions

Write the SQL queries to answer the following questions:

  - Select the first name, last name, and email address of all the customers who have rented a movie.
  - What is the average payment made by each customer (display the *customer id*, *customer name* (concatenated), and the *average payment made*).
  - Select the *name* and *email* address of all the customers who have rented the "Action" movies.

    - Write the query using multiple join statements
    - Write the query using sub queries with multiple WHERE clause and `IN` condition
    - Verify if the above two queries produce the same results or not

  - Use the case statement to create a new column classifying existing columns as either or high value transactions based on the amount of payment. If the amount is between 0 and 2, label should be `low` and if the amount is between 2 and 4, the label should be `medium`, and if it is more than 4, then it should be `high`.
  """
  
  #Select the first name, last name, and email address of all the customers who have rented a movie.
  
  select first_name, last_name, email from customer
  where active = 1
  
  #What is the average payment made by each customer (display the *customer id*, *customer name* (concatenated), and the *average payment made*).
  
  select c.customer_id, concat(c.first_name, ' ', c.last_name) as 'Customer Name', Round(AVG(p.amount),2) as 'Avg Payment'
  from customer c
  join payment p
  on c.customer_id = p.customer_id
  group by c.customer_id
  
  #Select the *name* and *email* address of all the customers who have rented the "Action" movies.
  
  
  select concat(c.first_name, ' ', c.last_name) as 'Customer Name', c.email
 from customer c
  join rental r
  using (customer_id)
  join inventory i
  using (inventory_id)
  join film_category fc
  using (film_id)
  join category ct
  using (category_id)
  where ct.name = 'Action'
  group by c.email
  