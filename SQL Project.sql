USE sakila;
Select first_name,last_name
From actor;

Select UPPER(concat(first_name,last_name)) As 'Actor Name'
From actor;

Select first_name,last_name,actor_id
From actor where first_name = 'Joe';

Select first_name,last_name, actor_id
From actor where last_name like '%GEN%';

Select first_name,last_name
From actor where last_name like '%LI%'
Order by last_name,first_name;

Select country, country_id
From country
Where country in ('Afghanistan','Bangladesh','China'
);

Alter Table actor
Add description BLOB;
Select * From actor;

Alter Table actor
Drop column description;
Select * From actor;

Select last_name, Count(last_name) as 'Last Name Counts '
from actor
Group by last_name; 

Select last_name, Count(last_name) as 'Last Name Counts'
from actor
Group by last_name
Having count(last_name)> 1;

Select * from actor
Where first_name = 'GROUCHO' and last_name='WILLIAMS';

Update actor
set first_name= 'HARPO' 
where first_name= 'GROUCHO' and last_name ='WILLIAMS';

Select * from actor 
Where first_name = 'GROUCHO' and last_name ='WILLIAMS';

Create table address_tb (
	address_id INT(11) NOT NULL AUTO_INCREMENT,
	address VARCHAR(50) NOT NULL,
	address2 VARCHAR(50) NOT NULL,
	district VARCHAR(50) NOT NULL,
	city_id INT(11) NOT NULL,
	postal_code VARCHAR(10) NOT NULL,
	location VARCHAR(30) NOT NULL,
	last_update timestamp,
    PRIMARY KEY (address_id)
);

select staff.first_name as 'First Name',
staff.last_name as 'Last Name', address.address as 'Address'
from staff as staff
join address as address
on address.address_id= staff.address_id;

select staff.first_name, staff.last_name, sum(payment.amount)
as "Total Amount Rung Up" from payment
join staff 
on payment.staff_id = staff.staff_id
where payment_date like '2005-08%'
group by staff.staff_id;

select f.title as 'Film', count(filma.actor_id)
as 'Total Number Of Actors' from film as f
join film_actor as filma
on f.film_id = filma.film_id
group by f.title; 

select f.film_id, f.title, count(f.film_id)
as 'Total Number of Copies' from film as f
join inventory as i 
on f.film_id = i.film_id 
where f.title = "Hunchback Impossible"
group By f.film_id;

Select c.first_name, c.last_name, sum(payment.amount)
as "Total Amount Paid per Customer"
from payment as payment
join customer as c
on c.customer_id =payment.payment_id
group by c.customer_id order by c.last_name ASC;

select title
from film 
where language_id = 
(select language_id 
from language where name = 'English')
and title like 'K%' or 'Q%';

select  first_name, last_name
from actor
Where actor_id in
(select actor_id from film_actor where film_id in
(select film_id from film where title = "ALONE TRIP")
);

select c.first_name, c.last_name, c.email
from customer c
join address as ad on c.address_id = ad.address_id
join city as cy on ad.city_id = cy.city_id
join country as ct on ct.country_id =cy.country_id 
where country ='CANADA';

select f.title as 'Film Title'
from film as f
join film_category as fc
on fc.film_id = f.film_id
join category as c
on c.category_id = fc.category_id
where c.name ='Family';

select f.title as 'Movie', count(r.rental_id)
as "Total Rentals"
from film as f
join inventory as i
on f.film_id = i.film_id
join rental as r
on i.inventory_id = r.inventory_id
group by i.film_id order by count(r.rental_id)DESC;

select s.store_id, sum(py.amount) as 'Total Sales'
from store as s 
join inventory as i
on s.store_id = i.store_id
join rental as r
on i.inventory_id = r.inventory_id
join payment as py
on r.rental_id =py.rental_id
group by s.store_id;

select s.store_id, cy.city, ct.country
from store as s
join address as ad
on s.address_id= ad.address_id
join city as cy
on ad.city_id=cy.city_id
join country as ct
on ct.country_id= cy.country_id;

select c.name as "Film Name", sum(py.amount) as 'GR'
from category as c
join film_category as fc
on c.category_id =fc.category_id
join inventory as i
on fc.film_id =i.film_id
join rental as r
on i.inventory_id= r.inventory_id
join payment as py
on r.rental_id =py.rental_id
group by c.category_id order by sum(py.amount)DESC;

create view Top_5_Genres_per_GR
as select c.name as 'Movie Types', sum(py.amount)
as 'GR'
from category as c
join film_category as fc
on c.category_id=fc.category_id
join inventory as i 
on fc.film_id=i.film_id
join rental as r 
on i.inventory_id = r.inventory_id
join payment as py
on r.rental_id=py.rental_id
group by c.category_id order by sum(py.amount)DESC;

Select * From Top_5_Genres_per_GR;

Drop view Top_5_Genres_per_GR;















