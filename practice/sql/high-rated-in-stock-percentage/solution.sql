select 100.0*sum(
case when in_stock = 1 and rating >=4 then 1 else 0 end) /count(product_id) as 
pct_in_stock_high_rated from products
