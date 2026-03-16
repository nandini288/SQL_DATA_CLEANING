select  * from customer_orders

SELECT
  table_name,
  column_name,
  data_type
FROM information_schema.columns
WHERE table_name = 'customer_orders';

OUTPUT:
	table_name		column_name	data_type
	customer_orders	order_id	int
	customer_orders	customer_id	int
	customer_orders	pizza_id	int
	customer_orders	exclusions	varchar
	customer_orders	extras		varchar
	customer_orders	order_time	datetime
------------------------------------------------------------------	
SELECT
  table_name,
  column_name,
  data_type
FROM information_schema.columns
WHERE table_name = 'runner_orders';

OUTPUT:
	table_name		column_name	data_type
	runner_orders	order_id	int
	runner_orders	runner_id	int
	runner_orders	pickup_time	varchar
	runner_orders	distance	varchar
	runner_orders	duration	varchar
	runner_orders	cancellationvarchar
-----------------------------------------------------------------------	
SELECT
  table_name,
  column_name,
  data_type
FROM information_schema.columns
WHERE table_name = 'pizza_names';

OUTPUT:
	table_name	column_name	data_type
	pizza_names	pizza_id	int
	pizza_names	pizza_name	nvarchar
-----------------------------------------------------------------------------------
SELECT
  table_name,
  column_name,
  data_type
FROM information_schema.columns
WHERE table_name = 'pizza_recipes';

OUTPUT:
	table_name		column_name	data_type
	pizza_recipes	pizza_id	int
	pizza_recipes	toppings	nvarchar
------------------------------------------------------------------------------------
SELECT
  table_name,
  column_name,
  data_type
FROM information_schema.columns
WHERE table_name = 'pizza_toppings';

OUTPUT:
	table_name		column_name	data_type
	pizza_toppings	topping_id	int
	pizza_toppings	topping_name	nvarchar
------------------------------------------------------------------------------------------
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

OUTPUT:
	order_id	customer_id	pizza_id	exclusions	extras	order_time
	1			101			1			NULL		NULL	2020-01-01 18:05:02.000
	2			101			1			NULL		NULL	2020-01-01 19:00:52.000
	3			102			1			NULL		NULL	2020-01-02 12:51:23.000
	3			102			2			NULL		NULL	2020-01-02 12:51:23.000
	4			103			1			4			NULL	2020-01-04 13:23:46.000
	4			103			1			4			NULL	2020-01-04 13:23:46.000
	4			103			2			4			NULL	2020-01-04 13:23:46.000
	5			104			1			NULL		1		2020-01-08 21:00:29.000
	6			101			2			NULL		NULL	2020-01-08 21:03:13.000
	7			105			2			NULL		1		2020-01-08 21:20:29.000
	8			102			1			NULL		NULL	2020-01-09 23:54:33.000
	9			103			1			4			1, 5	2020-01-10 11:22:59.000
	10			104			1			NULL		NULL	2020-01-11 18:34:49.000
	10			104			1			2, 6		1, 4	2020-01-11 18:34:49.000

----------------------------------------------------------------------------------------
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

OUTPUT:
	order_id	runner_id	pickup_time				distance	duration	cancellation
	1			1			2020-01-01 18:15:34	20	32			NULL
	2			1			2020-01-01 19:10:54	20	27			NULL
	3			1			2020-01-02 00:12:37		13.4		20			NULL
	4			2			2020-01-04 13:53:03		23.4		40			NULL
	5			3			2020-01-08 21:10:57		10			15			NULL
	6			3			null					NULL		NULL		Restaurant Cancellation
	7			2			2020-01-08 21:30:45	25	25			NULL
	8			2			2020-01-10 00:15:02		23.4		15			NULL
	9			2			null					NULL		NULL		Customer Cancellation
	10			1			2020-01-11 18:50:20		10			10			NULL
