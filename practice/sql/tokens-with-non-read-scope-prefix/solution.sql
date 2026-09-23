select count(distinct case when scope not like 'read%' then owner_id end) from api_tokens
