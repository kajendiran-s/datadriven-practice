with sess_count as(
select user_id,
count(session_id) as ses_cnt
from user_sessions
group by user_id),
avg_count as(
select avg(ses_cnt) as avg_cnt from sess_count)
select user_id,
ses_cnt from sess_count 
where ses_cnt > (
select avg(ses_cnt) as avg_cnt from sess_count)
