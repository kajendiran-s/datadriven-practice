WITH page_users AS(SELECT ad.* FROM ad_impressions ad LEFT JOIN page_views p ON ad.user_id = p.user_id WHERE p.user_id IS NOT NULL), 
count_cte AS (SELECT ad_campaign,  COUNT(*) AS total_count,  SUM(CASE WHEN clicked = 1 THEN 1 ELSE 0 END) AS clicked_count FROM page_users group by ad_campaign)
select ad_campaign, round(100.0*clicked_count/total_count,2) as clicked_pct from count_cte
order by 2 desc
