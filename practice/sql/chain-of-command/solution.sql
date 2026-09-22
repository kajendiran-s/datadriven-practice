with recursive org_chart as(
select employee_id, emp_name,
0 as depth, emp_name as path from employees where manager_id is NULL

UNION ALL

select e.employee_id, e.emp_name,
oc.depth+1 as depth, oc.path+'/'+ e.emp_name as path from employees e
join org_chart oc
on e.manager_id= oc.employee_id
)

select * from org_chart order by path
