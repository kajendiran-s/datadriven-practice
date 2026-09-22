select svc_name,
bill_date,
amount,
amount-lag(amount) over(partition by svc_name order by bill_date) as last_amount
from cloud_costs
