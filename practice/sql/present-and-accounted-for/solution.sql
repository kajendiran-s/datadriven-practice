select product_name, sum(coalesce(total_amount,0)) as electronics_total from products p left join transactions t on p.product_id = t.product_id
and category = 'Electronics' group by 1 order by electronics_total desc
