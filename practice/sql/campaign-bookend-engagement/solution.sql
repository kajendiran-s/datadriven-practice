WITH date_cal AS (
  SELECT
    ad_campaign,
    MIN(DATE(impression_time)) AS min_time,
    MAX(DATE(impression_time)) AS max_time
  FROM ad_impressions
  GROUP BY 1
)
SELECT
  ad.ad_campaign,
  COUNT(
    CASE
      WHEN DATE(impression_time) = min_time THEN impression_id
    END
    )*100.0/COUNT(distinct impression_id) AS first_day_impression,
  COUNT(
    CASE
      WHEN  DATE(impression_time) = max_time THEN impression_id
    END
    )*100.0/COUNT(distinct impression_id)  AS last_day_impression
FROM ad_impressions AS ad
INNER JOIN date_cal AS dc
  ON dc.ad_campaign = ad.ad_campaign
GROUP BY 1
