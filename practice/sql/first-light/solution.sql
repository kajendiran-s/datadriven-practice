with first_success as (select repo_name, built_at,row_number() over(partition by repo_name order by built_at) as rnk from ci_builds where status = 'success')
select author, avg(added), avg(removed) from repo_commits rc
join first_success ci on rc.repo_name = ci.repo_name 
and ci.rnk =1
and rc.commit_at < ci.built_at
group by 1
order by 2
