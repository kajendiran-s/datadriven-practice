select account_status,
count(transaction_id) as transaction_count,
count(distinct u.user_id) as user_count,
sum(total_amount) as total_revenue
from users u
left join transactions t
on u.user_id = t.user_id
group by account_status
having count(transaction_id) >= 5
