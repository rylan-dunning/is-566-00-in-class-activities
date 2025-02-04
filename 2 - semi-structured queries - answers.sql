
use schema is566.semi_structured;


select 
    * 
from car_sales 
limit 2;


-- Write a query to extract the dealership and date fields from the SRC column, along with 
-- the name of the salesperson from the SALESPERSON_INFO column.
-- 
-- Then modify your query to derive the year of the sale from the date column.


select
    SRC:dealership as dealership
    ,SRC:date::date as sale_date
    ,salesperson_info:name as salesperson_name
    ,year(sale_date) as year_of_sale
from 
car_sales
limit 2;

-- Write a query to count the number of promotions (PROMOTIONS) applied to 
-- each sale. Include the dealership from the SRC column, and try it with
-- both the PROMOTIONS column as well as the promotions object nested within
-- the SRC column.



select
    SRC:dealership as dealership,
    SRC:promotions as src_promotions,
    PROMOTIONS as promotions,
    array_size(promotions) as prom_count_col,
    array_size(SRC:promotions) as prom_count_src
from
car_sales;



-- Write a query to find sales where there are multiple customers or multiple 
-- vehicles involved in the transaction. Include the date and dealership in 
-- the output.

select 
    * 
from car_sales 
limit 2;

select
    SRC:dealership as dealership  
    ,SRC:date::date as sale_date
    -- ,src:vehicle as vehicle_info
    -- ,src:customer as customer_info
    ,array_size(SRC:vehicle) as vehicle_count
    ,array_size(src:customer) as customer_count
from
    car_sales
-- where vehicle_count > 1 
--   or customer_count >1
;

-- List all distinct promotions from the PROMOTIONS column.
-- 
-- Modify your query to then provide a count of the number of times each 
-- promotion was applied.

select 
    *
from car_sales 
limit 2;


select distinct
    pr.VALUE as promotion
from
car_sales,
lateral flatten(input => promotions) pr
;



select 
    pr.VALUE as promotion,
    count(*) as times_used
from
car_sales,
lateral flatten(input => PROMOTIONS) pr
group by promotion
order by times_used desc
;


-- Write a query to flatten the VEHICLE_INFO array and extract the make, 
-- model, and price of each vehicle for every sale.

select 
    * 
from car_sales 
limit 2;

select
    sale_id,
    vi.VALUE as vehicle,
    -- vi.VALUE as vehicles_exploded,
    -- vehicle_info as vehicles_array
    vehicle:make as make,
    vehicle:model as model,
    vehicle:year as year
from
    car_sales,
lateral flatten(input => src:vehicle) vi
;


-- Using LATERAL FLATTEN, calculate the total revenue (price) from all 
-- vehicles sold at each dealership. Include the dealership name.

select 
    * 
from car_sales 
limit 2;

select 
    src:dealership as dealership,
    sum(v.VALUE:price) as total_revenue
from car_sales,
lateral flatten(input => src:vehicle) v
group by dealership
order by total_revenue desc;
