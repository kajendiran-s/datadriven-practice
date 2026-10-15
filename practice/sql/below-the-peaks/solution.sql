select src.team_name, src.amount
from cost_allocs src
where amount > (
select avg(amount) from cost_allocs filter1
where filter1.team_name= src.team_name
group by filter1.team_name)
and amount not in (
select amount from cost_allocs filter2
where filter2.team_name=src.team_name order by amount desc limit 5)
