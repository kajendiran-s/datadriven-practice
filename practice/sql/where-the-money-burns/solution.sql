

with cte as(select svc_name, avg(amount) as avg_amnt from cloud_costs
group by svc_name)
select svc_name from cte 
where avg_amnt > (select avg(amount) from cloud_costs)
