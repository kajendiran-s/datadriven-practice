select tbl_name,
avg(fail_pct) as avg_fail_pct
from dq_checks
where fail_pct is not NULL
group by tbl_name
