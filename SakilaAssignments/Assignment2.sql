USE sakila;



/*1. Find out the number of documentaries with deleted scenes.*/ 
select count(title)
from
	film
where 
	special_features like '%Deleted scenes%'
    and film_id in(
		select film_id
        from 
			category inner join film_category
            on (film_category.film_id)
		where 
			name = 'Documentary'
    );
    
    
    
/*2. Find out the number of sci-fi movies rented by the store managed by Jon Stephens.*/    
select count(*)
from 
	film_list fl,
    staff s,
    inventory i,
    rental r
where 
	fl.category = 'sci-fi'
    and fl.FID = i.film_id
    and i.inventory_id = r.inventory_id
    and r.staff_id = s.staff_id
    and s.first_name='Jon'
    and s.last_name='Stephens';
    


/*3. Find out the total sales from Animation movies.*/
select sum(p.amount)
from 
	film_list fl,
    inventory i,
    rental r,
    payment p
where 
	fl.category = 'Animation'
	and fl.FID = i.film_id
    and i.inventory_id = r.inventory_id
    and r.rental_id = p.rental_id;



/*4. Find out the top 3 rented category of movies by “PATRICIA JOHNSON”.*/
select fl.category, count(ALL fl.category) as total_rented
from 
	film_list fl
where
	fl.FID in (
		select i.film_id
        from 
			customer_list cl,
            rental r,
            inventory i
        where
            cl.name = 'PATRICIA JOHNSON'
			and cl.ID = r.customer_id
			and r.inventory_id = i.inventory_id
    )
group by fl.category
order by total_rented desc
limit 3;



/*5. Find out the number of R rated movies rented by “SUSAN WILSON”.*/
select fl.title
from 
	film_list fl,
    inventory i,
    rental r,
    customer_list cl
where 
	fl.rating = 'R'
	and cl.name = 'SUSAN WILSON'
	and r.customer_id =cl.ID
    and i.inventory_id = r.inventory_id
    and fl.FID = i.film_id
    
    
















