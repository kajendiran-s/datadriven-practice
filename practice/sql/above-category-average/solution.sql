with cte as (SELECT
  product_name,
  AVG(total_amount) OVER(PARTITION BY category) AS category_avg,
  AVG(total_amount) as product_avg
FROM transactions t
INNER JOIN products p
  ON t.product_id = p.product_id
group by product_name
)
select product_name,
product_avg,
category_avg
from cte
where product_avg > category_avg
