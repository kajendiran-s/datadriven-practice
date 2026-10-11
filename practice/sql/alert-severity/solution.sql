with cte as (select topic, offset, 
Lag(offset) over(partition by topic) as lag1,
dense_rank() over(partition by topic order by offset) as msg_rnk, 
row_number() over(partition by topic order by offset) as msg_row_num,
Lead(offset) over(partition by topic) as lead1
from stream_msgs)
select topic, offset, lag1 as prev_offset, msg_rnk, msg_row_num, 
1.0*msg_rnk/msg_row_num as dis_off_cnt
from cte where lag1 is not null


-- Look at what "previous" means for each message. The comparison only holds once each topic's messages are sequenced by their numbers, so check whether every calculation in your row shares that same sequence, not just some of them. Also consider what counts as a new number: a repeated one should not add to the share.
