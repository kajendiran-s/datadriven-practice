
select count(distinct u.user_id) from users u
join transactions t on t.user_id = u.user_id and u.account_status = 'active'
where extract(year from transaction_date)=2026 and 
extract(month from transaction_date)=4
