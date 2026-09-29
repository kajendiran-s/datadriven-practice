with grouped_product as (select product_id, sum(quantity) as total_qua from transactions group by product_id)
select p.category, sum(p.price * gp.total_qua)  as total_revenue
from products p join grouped_product gp on p.product_id = gp.product_id
group by 1 order by 1
