select count(check_id) from dq_checks where severity = 'low' and year(run_at) = 2026
