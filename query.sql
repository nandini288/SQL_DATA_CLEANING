select  * from customer_orders

SELECT
  table_name,
  column_name,
  data_type
FROM information_schema.columns
WHERE table_name = 'customer_orders';

SELECT
  table_name,
  column_name,
  data_type
FROM information_schema.columns
WHERE table_name = 'runner_orders';

SELECT
  table_name,
  column_name,
  data_type
FROM information_schema.columns
WHERE table_name = 'pizza_names';

SELECT
  table_name,
  column_name,
  data_type
FROM information_schema.columns
WHERE table_name = 'pizza_recipes';

SELECT
  table_name,
  column_name,
  data_type
FROM information_schema.columns
WHERE table_name = 'pizza_toppings';

select 
	order_id,
	customer_id,
	pizza_id,
    case 
        when exclusions = 'null' or exclusions = '' then NULL
        else exclusions
    end as exclusions,
    case 
        when extras = 'null' or extras = '' then NULL
        else extras
    end as extras,
    order_time
into #cleaned_customer_orders
from customer_orders

select * from #cleaned_customer_orders

select * from runner_orders



select order_id,runner_id,pickup_time,CAST(
        REPLACE(
            REPLACE(
                NULLIF(distance, 'null'), 
            'km', ''), 
        ' ', '') 
    AS FLOAT) as distance,
        cast(replace(replace(replace(NULLIF(duration, 'null'), 
                'minutes', ''),'mins',''),'minute','') as int) as duration,
        case 
            when cancellation = 'null' or cancellation = '' then NULL
            ELSE cancellation
            end as cancellation
            into #cleaned_runner_orders
from runner_orders

select * from #cleaned_runner_orders;

