select u.username,
u.account_status,
u.signup_date,
us.session_start
from users u 
left join user_sessions us
on u.user_id = us.user_id
order by 1,4
