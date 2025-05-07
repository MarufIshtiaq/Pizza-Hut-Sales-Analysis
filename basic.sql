-- Retrieve the total number of orders placed.
select
	sum(order_details_id) as 'Total Orders'
from
	order_details


--Calculate the total revenue generated from pizza sales.
select
	round(sum(od.quantity * p.price), 2) as 'Total Revenue'
from
	order_details as od
join pizzas as p on p.pizza_id = od.pizza_id


--Identify the highest-priced pizza.
select
	top 1
	pt.name,
	round(p.price, 2) as 'Price'
from 
	pizza_types as pt
join pizzas as p on p.pizza_type_id = pt.pizza_type_id
order by p.price desc


--Identify the most common pizza size ordered.
select
	Top 1
	p.size,
	count(od.quantity) as 'Total Order'
from
	pizzas as p
join order_details as od on p.pizza_id = od.pizza_id
group by
	p.size


--List the top 5 most ordered pizza types along with their quantities.
select
	top 5
	pt.pizza_type_id,
	count(od.quantity) as 'Total Order'
from
	order_details as od
join pizzas as p on p.pizza_id = od.pizza_id
join pizza_types as pt on pt.pizza_type_id = p.pizza_type_id
group by
	pt.pizza_type_id
order by 'Total Order' desc