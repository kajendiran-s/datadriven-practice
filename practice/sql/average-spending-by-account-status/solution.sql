SELECT
  u.account_status,
  AVG(total_amount)
FROM users AS u
LEFT JOIN (
  SELECT
    user_id,
    SUM(total_amount) AS total_amount
  FROM transactions
  GROUP BY user_id
) AS t
  ON u.user_id = t.user_id
GROUP BY u.account_status
