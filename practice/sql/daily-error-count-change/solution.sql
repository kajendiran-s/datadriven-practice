

-- with err_cnt as(select date(first_at) as error_date, count as err_count,
-- lag(count) over( from err_tracks)
-- select * from err_cnt where err_count > 1

with err_cnt as (select date(first_at) as first_at, count(*) as error_count,
lag(count(*)) over(order by date(first_at)) as prev_count 
from err_tracks
group by 1
order by 1)
select first_at, error_count, prev_count , error_count - prev_count as day_over_day_change from err_cnt
