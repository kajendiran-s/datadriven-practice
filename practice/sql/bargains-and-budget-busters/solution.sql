with combined as (
select svc_name, region, amount from cloud_costs
union all 
select svc_name, region, amount from cost_allocs),
biggest as(
select region, svc_name, rank() over(partition by region order by amount desc)as max_rnk, 
rank() over(partition by region order by amount asc)as min_rnk
from combined )
select distinct region,
(select svc_name from biggest b where max_rnk = 1 and b.region = c.region) as most_expensive,
(select svc_name from biggest b where min_rnk = 1 and b.region = c.region ) as cheapest
from cost_allocs c
order by 1

-- select region, svc_name, amount,
-- rank() over(partition by region order by amount asc)as min_rnk
-- from cloud_costs where region= 'eu-west-1'
