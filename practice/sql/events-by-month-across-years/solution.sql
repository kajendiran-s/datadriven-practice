with monthly as (select event_id, month(event_timestamp) as month from event_data)
select month, count(event_id) from monthly group by month
