with ranked as (
select svc_name, uptime, dense_rank() over(order by uptime asc)
as rnk from (select svc_name, min(uptime) as uptime from svc_health where uptime is not null group by svc_name))
select svc_name, uptime as min_uptime from ranked 
where rnk <= 10
order by min_uptime
