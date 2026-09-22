SELECT
    strftime('%Y-%m', u.signup_date)                              AS signup_month,
    COUNT(DISTINCT u.user_id)                                      AS signups,
    COUNT(DISTINCT pv.user_id)                                     AS retained_users,
    ROUND(
        100.0 * COUNT(DISTINCT pv.user_id) / COUNT(DISTINCT u.user_id),
        1
    )                                                               AS retained_pct
FROM users u
LEFT JOIN page_views pv
    ON pv.user_id = u.user_id
   AND julianday(pv.viewed_at) >= julianday(u.signup_date) + 7
WHERE u.account_status<> 'pending_verification'
GROUP BY signup_month
ORDER BY signup_month;
