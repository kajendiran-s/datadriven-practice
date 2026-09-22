with fail_sum as (
select tbl_name, sum(fail_pct) as sum_fail from dq_checks
group by tbl_name)
select max(sum_fail) - min(sum_fail) from fail_sum
