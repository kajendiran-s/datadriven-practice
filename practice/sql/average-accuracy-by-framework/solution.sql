with filtered as (select *
from ml_models
where lower(status) = 'deployed' and regexp_matches(version,'v?([12]\.\d+|3\.0+)[-beta]?'))
select framework, avg(accuracy) from filtered group by framework
