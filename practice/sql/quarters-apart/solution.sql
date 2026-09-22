with orders as (select * from api_calls where year(call_time) <> 2026 and endpoint like '%orders'),
quarter_cal as (select *, 
case when month(call_time) in (4,5,6) THEN concat(year(call_time),'-Q2')
when month(call_time) in (7,8,9) THEN concat(year(call_time),'-Q3')
when month(call_time) in (10,11,12) THEN concat(year(call_time),'-Q4')
when month(call_time) in (1,2,3) THEN concat(year(call_time),'-Q1')
end as quarter
from orders),
quarters as (select 'Q1' as quarter 
UNION ALL select 'Q2' 
UNION ALL select 'Q3'
UNION ALL select 'Q4'),
quarter_grid as(select concat(years,'-',quarter) as quarter from 
(select distinct year(call_time) as years from orders) yr
cross join quarters q),
avg_quarter as (select qg.quarter, COALESCE(avg(latency),120) as avg_latency from quarter_grid qg left join quarter_cal qc on qg.quarter = qc.quarter group by qg.quarter),
prev_quarter as (select quarter, avg_latency, lag(avg_latency) over(order by quarter) as prev_latency from avg_quarter)
select *, avg_latency - prev_latency from prev_quarter
