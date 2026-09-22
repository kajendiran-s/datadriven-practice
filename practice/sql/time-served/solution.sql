with active_tokens as (
select scope, date(issued) as issued from api_tokens
where expires is null or date(expires) >= date(now()) order by 1),
date_grid as (select scope, 
max(issued) as newest, min(issued) as oldest from active_tokens group by scope)
select scope, newest-oldest as day_spread,
(select count(*) from api_tokens ap where ap.scope = dg.scope and ap.issued = dg.oldest) as tokens_at_earliest,
(select count(*) from api_tokens ap where ap.scope = dg.scope and ap.issued = dg.newest) as tokens_at_latest
from date_grid dg
order by 2 desc
