with recursive quarter_grid as (
select 1 as n,  'Q1' as quarter
UNION ALL
select n+1, 'Q'||(n+1) as quarter
from quarter_grid 
where n<4),
filtered as (select distinct department from employee_metrics ),
quarter_merged as (select department, quarter from filtered cross join (select quarter from quarter_grid )),
quarter_calculated as (select qm.department, qm.quarter as qm_quarter, em.fiscal_quarter as em_quarter, metric_value from quarter_merged qm left join employee_metrics em on em.department = qm.department and em.fiscal_quarter= qm.quarter)
select department, sum( case when qm_quarter = 'Q1' and em_quarter is not null then 1 else 0 end) as q1,
sum( case when qm_quarter  = 'Q2' and em_quarter is not null then 1 else 0 end ) as q2,
sum( case when qm_quarter  = 'Q3' and em_quarter is not null then 1 else 0 end ) as q3,
sum( case when qm_quarter = 'Q4' and em_quarter is not null then 1 else 0 end ) as q4
from quarter_calculated group by 1
