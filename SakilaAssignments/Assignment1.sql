USE sakila;

/*1. Find out the PG-13 rated comedy movies. DO NOT use the film_list table.*/
SELECT title,rating,name
FROM film_category INNER JOIN category 
ON (category.category_id)
INNER JOIN film 
ON (film.film_id)
WHERE category.name = 'Comedy'
and film.rating = 'PG-13';


/*2. Find out the top 3 rented horror movies.*/
select title, count(fl.title) as Rental_Count
from 
	film_list fl,
    rental r,
    inventory i
where 
	fl.category = 'Horror'
    and fl.FID = i.film_id
    and i.inventory_id = r.inventory_id
group by fl.title
order by count(fl.title) desc
limit 3;


/*3. Find out the list of customers from India who have rented sports movies.*/
select name
from 
	customer_list
where 
	country = 'India'
	and ID in (
		select r.customer_id
		from film_list fl,
		 inventory i,
         		rental r
	where 
		fl.category = 'Sports'
        and i.inventory_id = r.inventory_id
        and fl.FID = i.film_id 
group by r.customer_id
);


/*4. Find out the list of customers from Canada who have rented “NICK WAHLBERG” movies.*/
select name
from customer_list
where country = 'Canada'
and ID in (
	select r.customer_id
	from actor a,
		 film_actor fa,
		 inventory i,
         rental r
	where 
		a.first_name ='NICK'
        and a.last_name = 'WAHLBERG'
        and fa.actor_id = a.actor_id
        and i.inventory_id = r.inventory_id
        and fa.film_id = i.film_id 

);



/*5. Find out the number of movies in which “SEAN WILLIAMS” acted.*/
select count(distinct fa.film_id) as Acted_MoviesOf_SEAN 
from actor a inner join film_actor fa 
on(a.actor_id)
where  a.first_name ='SEAN'
	  and a.last_name = 'WILLIAMS';
