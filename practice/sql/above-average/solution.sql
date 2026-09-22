with ca_avg as(
select avg(price) as catalog_avg
from products)
select product_name,
category,
price,
catalog_avg
from products,
ca_avg
where catalog_avg < price
