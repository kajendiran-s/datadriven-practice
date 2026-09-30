select user_id, transaction_date, total_amount, sum(total_amount) over(partition by user_id order by transaction_date rows between 6 preceding
 and current row)
from transactions order by user_id, transaction_date, total_amount
