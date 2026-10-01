select endpoint, avg(latency) from (
select *, row_number() over(partition by user_id order by call_time asc) as rn from api_calls order by user_id, endpoint) ac where ac.rn <> 1 group by 1 order by 2 desc
