select email,
 count(user_id) as cnt, 
 min(signup_date) as earliest_signup,
 max(signup_date) as latest_signup
from users
where email is not null
group by email
having cnt > 1
order by 2
