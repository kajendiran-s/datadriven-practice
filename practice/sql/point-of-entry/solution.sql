with ordered as (select user_id, event_type, first_value(event_type) over(partition by user_id order by event_timestamp) as first_val from event_data)
select  user_id, count(case when event_type='purchase' then 1 end) as pur_cnt from ordered 
where first_val = 'page_view'
group by 1
order by 2 desc
