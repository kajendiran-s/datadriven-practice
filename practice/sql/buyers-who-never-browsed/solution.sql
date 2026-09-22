select distinct username, total_amount as total_amount
from transactions t
inner join users u on u.user_id = t.user_id
left join page_views p
on t.user_id = p.user_id
where p.view_id is null
order by 2
