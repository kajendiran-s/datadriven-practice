WITH unique_users AS(
SELECT DISTINCT sender_id, channel FROM chat_msgs), 
connections AS(
SELECT distinct s.sender_id,  c.sender_id as conn_id
FROM unique_users s 
JOIN unique_users c 
ON s.sender_id != c.sender_id
AND s.channel = c.channel )
select 
distinct sender_id, page_url
from connections u
join page_views p
on p.user_id = u.conn_id
where NOT EXISTS(
select 1 from page_views own
where own.user_id = u.sender_id
and own.page_url = p.page_url)
