select channel, content, severity from chat_msgs cm
join err_tracks et on month(cm.sent_at) = month(et.first_at) and year(cm.sent_at) = year(et.first_at)
where content like '%latency%'
   or content like '%down%'
   or content like '%back%'
   or content like '%pipeline%'
