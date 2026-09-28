with latest_acc as (
  select * from (
    select *, row_number() over(partition by mdl_name order by train_at desc, model_id desc) as rn
    from ml_models
    where train_at is not null and accuracy is not null
  ) cv where cv.rn = 1
),
earlier_avg as (select mdl_name, avg(accuracy) as earlier_acc_avg
from (
    select *, row_number() over(partition by mdl_name order by train_at desc, model_id desc) as rn
    from ml_models
    where train_at is not null and accuracy is not null
  ) cv where cv.rn <> 1 group by 1)
select
  t.mdl_name,
  round(avg(t.accuracy), 2) as avg_lifetime_accuracy,
  round(la.accuracy, 2) as latest_accuracy,
  round(la.accuracy-earlier_acc_avg , 2) as difference
from ml_models t
join latest_acc la on t.mdl_name = la.mdl_name
left  join earlier_avg ea on ea.mdl_name = t.mdl_name
where t.train_at is not null and t.accuracy is not null
group by 1, la.accuracy
