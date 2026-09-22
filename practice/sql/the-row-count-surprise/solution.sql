with in_join as(
select count(*) as cnt from users u
inner join ad_impressions ad
on u.user_id = ad.user_id),
left_join as(
select count(*) as cnt from users u
left join ad_impressions ad
on u.user_id = ad.user_id),
outer_join as (
select count(*) as cnt from users u
full outer join ad_impressions ad
on u.user_id = ad.user_id)
select 'inner_join' as join_type, cnt
from in_join
union
select  'left_join' ,cnt  from left_join
union
select  'full_outer_join',cnt from outer_join
