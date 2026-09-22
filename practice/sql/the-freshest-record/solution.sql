with recent as (select log_id, server_name, log_level, response_time_ms, message, log_timestamp
from server_logs
where  date(now())-date(log_timestamp) <= 90
order by log_timestamp),
not_recent as (select log_id, server_name, log_level,response_time_ms, message, log_timestamp
from server_logs where date(now())-date(log_timestamp) > 90
order by log_timestamp),
msg as (select log_id, server_name, log_level, message, response_time_ms, log_timestamp, row_number() over(partition by server_name, message order by log_timestamp) as rnk
from recent r
where NOT EXISTS (select 1 from not_recent nr where nr.server_name = r.server_name and nr.message = r.message))
select log_id, server_name, log_level, message, response_time_ms, log_timestamp from msg where rnk =1
