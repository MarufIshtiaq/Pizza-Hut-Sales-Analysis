--Calculate the percentage contribution of each pizza type to total revenue.
select
	pt.category,
	concat(
		sum(od.quantity * p.price) * 100 / sum(sum(od.quantity * p.price)) over(), '%'
		) as 'Revenue Percentage Contribution'
from
	order_details as od
join pizzas as p on p.pizza_id = od.pizza_id
join pizza_types as pt on p.pizza_type_id = pt.pizza_type_id
group by
	pt.category


--Analyze the cumulative revenue generated over time.
select
	o.date,
	round(sum(od.quantity * p.price), 2) as 'Total Revenue',
	round(sum(sum(od.quantity * p.price)) over(order by o.date), 2) as 'Cumulative Revenue'
from
	orders as o
join order_details as od on od.order_details_id = o.order_id
join pizzas as p on p.pizza_id = od.pizza_id
join pizza_types as pt on p.pizza_type_id = pt.pizza_type_id
group by
	o.date