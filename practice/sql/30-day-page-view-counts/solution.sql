select user_id, count(view_id) from page_views 
where datediff(day,viewed_at,'2026-12-28') < 30
group by user_id
order by 1
