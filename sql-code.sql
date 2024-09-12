select * from df_orders;

--find top 10 highest reveue generating products 
select product_id, sum(sale_price*discount) as sales
from df_orders
group by product_id
order by sales desc limit 10;




--find top 5 highest selling products in each region
with sales_cte as (
	select product_id, region, sum(sale_price*discount) as sales,
	row_number() over(partition by region order by sum(sale_price*discount) desc ) as rank
	from df_orders
	group by product_id, region
) 

select product_id, region, sales from sales_cte
where rank<=5;

--find month over month growth comparison for 2022 and 2023 sales eg : jan 2022 vs jan 2023

with monthly_sales as (
SELECT 
EXTRACT(YEAR FROM order_date) AS order_year,
EXTRACT(MONTH FROM order_date) AS order_month,
SUM(sale_price * quantity) AS sales
FROM df_orders
WHERE EXTRACT(YEAR FROM order_date) IN (2022, 2023)
GROUP BY EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date)
	)
select order_month
, sum(case when order_year=2022 then sales else 0 end) as sales_2022
, sum(case when order_year=2023 then sales else 0 end) as sales_2023
from monthly_sales
group by order_month; 

--for each category which month had highest sales: 
WITH cte AS (
    SELECT 
        category,
        TO_CHAR(order_date, 'YYYYMM') AS order_year_month,
        SUM(sale_price * quantity) AS sales
    FROM df_orders
    GROUP BY category, TO_CHAR(order_date, 'YYYYMM')
)
SELECT *
FROM (
    SELECT 
        *,
        ROW_NUMBER() OVER (PARTITION BY category ORDER BY sales DESC) AS rn
    FROM cte
) a
WHERE rn = 1;


--which sub category had highest growth by profit in 2023 compare to 2022:

WITH cte AS (
    SELECT 
        sub_category,
        EXTRACT(YEAR FROM order_date) AS order_year,
        SUM(sale_price * quantity) AS sales
    FROM df_orders
    GROUP BY sub_category, EXTRACT(YEAR FROM order_date)
),
cte2 AS (
    SELECT 
        sub_category,
        SUM(CASE WHEN order_year = 2022 THEN sales ELSE 0 END) AS sales_2022,
        SUM(CASE WHEN order_year = 2023 THEN sales ELSE 0 END) AS sales_2023
    FROM cte 
    GROUP BY sub_category
)
SELECT 
    sub_category,
    sales_2022,
    sales_2023,
    (sales_2023 - sales_2022) AS profit_growth
FROM cte2
ORDER BY profit_growth DESC
LIMIT 1;
