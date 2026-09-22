select category,
count(distinct transaction_id) as unique_transactions,
sum(total_amount) as total_revenue
from products p
inner join transactions t
on p.product_id = t.product_id
and extract(year from transaction_date) = 2026
group by category
order by 3 desc
