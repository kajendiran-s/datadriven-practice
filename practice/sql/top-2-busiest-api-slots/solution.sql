with count_msg as (select status, strftime('%H', call_time) as hrs,
case when strftime('%H', call_time) >= '00' and strftime('%H', call_time) < '12' then 'Morning'
when strftime('%H', call_time) >= '12' and strftime('%H', call_time) < '15' then 'Early Afternoon'
when strftime('%H', call_time) >= '15' then 'Late Afternoon'
end as time_segment
from api_calls where err_msg is not null)
select status, time_segment, call_count from (
select status, time_segment, count(*) as call_count, dense_rank() over(order by count(*) desc) as rnk from count_msg group by status, time_segment) as inp
where inp.rnk <=3
