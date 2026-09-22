select trigger, count(build_id) as total_builds, round(1.0*sum(case when status='success' then 1 else 0 end)/count(build_id),3) as success_rate
from ci_builds group by 1
