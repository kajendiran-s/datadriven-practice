-- with date_cte as(select distinct date(event_timestamp) as event_day from event_data),
-- err_events as (
-- select date(event_timestamp) as event_day, event_type from event_data where 
-- event_type IN ('open','error','crash')),
-- select date(event_timestamp),
-- case when event_type='open' then count(event_type) as open_count
-- when event_type='error' then count(event_type) as error_count
-- when event_type='crash' then count(event_type) as crash
-- group by date(event_timestamp)
-- from err_events 


with err_cnt as (select age_bucket, date(event_timestamp) as event_day,
sum(case when event_type='open' then 1 end) as open_cnt,
sum(case when event_type='error' then 1 end) as err_cnt,
sum(case when event_type='crash' then 1 end) as crash_cnt 
from users u
join event_data e 
on u.user_id = e.user_id 
and event_type IN ('open','error','crash')
group by 2)
select  event_day,age_bucket, coalesce(err_cnt+crash_cnt,0)/open_cnt from err_cnt 
