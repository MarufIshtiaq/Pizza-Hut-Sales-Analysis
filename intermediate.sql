--Join the necessary tables to find the total quantity of each pizza category ordered.
select
	pt.category,
	count(od.quantity) as 'Total Order'
from
	order_details as od
join pizzas as p on p.pizza_id = od.pizza_id
join pizza_types as pt on pt.pizza_type_id = p.pizza_type_id
group by
	pt.category
order by 'Total Order' desc	


--Determine the distribution of orders by hour of the day.
select
	datepart(hour, o.time) as 'Order Hour',
	count(od.quantity) as 'Total Order'	
from
	orders as o
join order_details as od on od.order_details_id = o.order_id
group by
	datepart(hour, o.time)
order by 'Order Hour'


--Join relevant tables to find the category-wise distribution of pizzas.
select
	pt.category,
	sum(od.quantity) as 'Total Order'
from
	order_details as od
join pizzas as p on p.pizza_id = od.pizza_id
join pizza_types as pt on pt.pizza_type_id = p.pizza_type_id
group by
	pt.category


--Group the orders by date and calculate the average number of pizzas ordered per day.
with total_quantity as (
    select sum(od.quantity) as total_qty
    from orders o
    join order_details od on o.order_id = od.order_details_id
)

select
    o.date,
    sum(od.quantity) / cast(tq.total_qty as decimal(18,2)) as 'Average Order'
from
    orders o
join order_details od on o.order_id = od.order_details_id
cross join total_quantity tq
group by
    o.date, tq.total_qty


--Determine the top 3 most ordered pizza types based on revenue.
select
	top 3
	pt.name,
	sum(od.quantity * p.price) as 'Total Revenue'
from
	pizza_types as pt
join pizzas as p on p.pizza_type_id = pt.pizza_type_id
join order_details as od on od.pizza_id = p.pizza_id
group by
	pt.name
order by
	'Total Revenue' desc