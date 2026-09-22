


select content_type, count(view_id)
from content_views cv
inner join content_items ct
on cv.content_id = ct.content_id
group by content_type
