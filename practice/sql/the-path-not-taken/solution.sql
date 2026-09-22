with class_edit as(select user_id, viewed_at as viewed from page_views where page_url = 'classic_editor'),
new_edit as(select user_id, viewed_at as viewed from page_views where page_url = 'new_editor'),
first_new_edit_visit as(select user_id, min(viewed) as viewed from new_edit group by 1)
select distinct user_id from new_edit n where n.user_id not in(select c.user_id from class_edit c
where c.viewed 
< (select viewed  from first_new_edit_visit n2 where n2.user_id=n.user_id ))
