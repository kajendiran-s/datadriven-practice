select query_id, case when clicked_result <= 3 and clicked_result >=1 then 3
when clicked_result > 3 then 2
when clicked_result = 0 then 1
else NULL
end as rating
from search_queries
