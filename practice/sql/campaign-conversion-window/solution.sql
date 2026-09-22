with total_impression as (select ad_campaign, count(*) as impression, sum(case when clicked = 1 then 1 else 0 end) as clicked_count from ad_impressions group by ad_campaign),
distinct_user as (select distinct ad_campaign,  user_id, impression_time from ad_impressions where clicked = 1),
distinct_user_count as (select ad_campaign, count(distinct user_id) as user_cnt from distinct_user group by 1),
conversion_join as (select ad_campaign, du.user_id, t.user_id as t_user_id, t.transaction_date, impression_time from distinct_user du left join transactions t on du.user_id = t.user_id and t.transaction_date <=date(impression_time)  + INTERVAL  '7 days' and t.transaction_date >=date(impression_time)),
conversion_amount as (
select ad_campaign, coalesce(count(distinct t_user_id),0) as conversions from conversion_join group by ad_campaign)
select ti.ad_campaign, impression, clicked_count as clicks,
round(100.0*clicked_count/impression,2) as ctr_pct, conversions, NULLIF(100.0*conversions/user_cnt,0) as conversion_pct from total_impression ti
join distinct_user_count du on ti.ad_campaign = du.ad_campaign
join conversion_amount ca on ca.ad_campaign  = ti.ad_campaign 
where clicked_count >=4
order by conversion_pct desc, impression desc
