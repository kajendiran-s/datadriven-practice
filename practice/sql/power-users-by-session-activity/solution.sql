select u.user_id,
username,
count(distinct session_id) as sessioncount,
sum(pages_viewed) as total_pages
from users u
inner join user_sessions us
on u.user_id = us.user_id
and account_status = 'active'
group by u.user_id
having count(distinct session_id) > 3
and sum(pages_viewed) > 100
