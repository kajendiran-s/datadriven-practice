WITH first_session AS
(SELECT user_id,  MIN(session_start) AS first_session 
FROM user_sessions GROUP BY user_id), 
retented_users AS
(SELECT DISTINCT u1.user_id AS retented FROM user_sessions u1 
INNER JOIN first_session f1 
ON f1.user_id = u1.user_id 
WHERE session_start > first_session 
AND session_start < date(first_session,'+90 days'))
SELECT
(SELECT 
COUNT(retented) 
FROM retented_users) * 1.0 / NULLIF(COUNT(first_session ),  0) 
FROM first_session
