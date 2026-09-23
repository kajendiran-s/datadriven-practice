select exp_name,
count(distinct case when variant = 'control' then user_id end) as control_users,
count(distinct case when variant not in  ('control') then user_id end) as
treatment_users,
case when count(distinct case when variant = 'control' then user_id end) = count(distinct case when variant = 'holdout' then user_id end) then NULL else count(distinct case when variant not in  ('control') then user_id end)*1.0/count(distinct case when variant = 'control' then user_id end) end as treatment_to_control_ratio
from experiments group by 1
