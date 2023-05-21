CREATE SCHEMA case_study_2_pizza_runner;
SET search_path = case_study_2_pizza_runner;

DROP TABLE IF EXISTS runners;
CREATE TABLE runners (
  "runner_id" INTEGER,
  "registration_date" DATE
);
INSERT INTO runners
  ("runner_id", "registration_date")
VALUES
  (1, '2021-01-01'),
  (2, '2021-01-03'),
  (3, '2021-01-08'),
  (4, '2021-01-15');


DROP TABLE IF EXISTS customer_orders;
CREATE TABLE customer_orders (
  "order_id" INTEGER,
  "customer_id" INTEGER,
  "pizza_id" INTEGER,
  "exclusions" VARCHAR(4),
  "extras" VARCHAR(4),
  "order_time" TIMESTAMP
);

INSERT INTO customer_orders
  ("order_id", "customer_id", "pizza_id", "exclusions", "extras", "order_time")
VALUES
  ('1', '101', '1', '', '', '2020-01-01 18:05:02'),
  ('2', '101', '1', '', '', '2020-01-01 19:00:52'),
  ('3', '102', '1', '', '', '2020-01-02 23:51:23'),
  ('3', '102', '2', '', NULL, '2020-01-02 23:51:23'),
  ('4', '103', '1', '4', '', '2020-01-04 13:23:46'),
  ('4', '103', '1', '4', '', '2020-01-04 13:23:46'),
  ('4', '103', '2', '4', '', '2020-01-04 13:23:46'),
  ('5', '104', '1', 'null', '1', '2020-01-08 21:00:29'),
  ('6', '101', '2', 'null', 'null', '2020-01-08 21:03:13'),
  ('7', '105', '2', 'null', '1', '2020-01-08 21:20:29'),
  ('8', '102', '1', 'null', 'null', '2020-01-09 23:54:33'),
  ('9', '103', '1', '4', '1, 5', '2020-01-10 11:22:59'),
  ('10', '104', '1', 'null', 'null', '2020-01-11 18:34:49'),
  ('10', '104', '1', '2, 6', '1, 4', '2020-01-11 18:34:49');


DROP TABLE IF EXISTS runner_orders;
CREATE TABLE runner_orders (
  "order_id" INTEGER,
  "runner_id" INTEGER,
  "pickup_time" VARCHAR(19),
  "distance" VARCHAR(7),
  "duration" VARCHAR(10),
  "cancellation" VARCHAR(23)
);

INSERT INTO runner_orders
  ("order_id", "runner_id", "pickup_time", "distance", "duration", "cancellation")
VALUES
  ('1', '1', '2020-01-01 18:15:34', '20km', '32 minutes', ''),
  ('2', '1', '2020-01-01 19:10:54', '20km', '27 minutes', ''),
  ('3', '1', '2020-01-03 00:12:37', '13.4km', '20 mins', NULL),
  ('4', '2', '2020-01-04 13:53:03', '23.4', '40', NULL),
  ('5', '3', '2020-01-08 21:10:57', '10', '15', NULL),
  ('6', '3', 'null', 'null', 'null', 'Restaurant Cancellation'),
  ('7', '2', '2020-01-08 21:30:45', '25km', '25mins', 'null'),
  ('8', '2', '2020-01-10 00:15:02', '23.4 km', '15 minute', 'null'),
  ('9', '2', 'null', 'null', 'null', 'Customer Cancellation'),
  ('10', '1', '2020-01-11 18:50:20', '10km', '10minutes', 'null');


DROP TABLE IF EXISTS pizza_names;
CREATE TABLE pizza_names (
  "pizza_id" INTEGER,
  "pizza_name" TEXT
);
INSERT INTO pizza_names
  ("pizza_id", "pizza_name")
VALUES
  (1, 'Meatlovers'),
  (2, 'Vegetarian');


DROP TABLE IF EXISTS pizza_recipes;
CREATE TABLE pizza_recipes (
  "pizza_id" INTEGER,
  "toppings" TEXT
);
INSERT INTO pizza_recipes
  ("pizza_id", "toppings")
VALUES
  (1, '1, 2, 3, 4, 5, 6, 8, 10'),
  (2, '4, 6, 7, 9, 11, 12');


DROP TABLE IF EXISTS pizza_toppings;
CREATE TABLE pizza_toppings (
  "topping_id" INTEGER,
  "topping_name" TEXT
);
INSERT INTO pizza_toppings
  ("topping_id", "topping_name")
VALUES
  (1, 'Bacon'),
  (2, 'BBQ Sauce'),
  (3, 'Beef'),
  (4, 'Cheese'),
  (5, 'Chicken'),
  (6, 'Mushrooms'),
  (7, 'Onions'),
  (8, 'Pepperoni'),
  (9, 'Peppers'),
  (10, 'Salami'),
  (11, 'Tomatoes'),
  (12, 'Tomato Sauce');
  
  
SELECT * FROM runners ;
SELECT * FROM customer_orders;
SELECT * FROM runner_orders;
SELECT * FROM pizza_names;
SELECT * FROM pizza_recipes;
SELECT * FROM pizza_toppings;

/*
                                                    A. Pizza Metrics
How many pizzas were ordered?
How many unique customer orders were made?
How many successful orders were delivered by each runner?
How many of each type of pizza was delivered?
How many Vegetarian and Meatlovers were ordered by each customer?
What was the maximum number of pizzas delivered in a single order?
For each customer, how many delivered pizzas had at least 1 change and how many had no changes?
How many pizzas were delivered that had both exclusions and extras?
What was the total volume of pizzas ordered for each hour of the day?
What was the volume of orders for each day of the week?
                                            B. Runner and Customer Experience
How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)
What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?
Is there any relationship between the number of pizzas and how long the order takes to prepare?
What was the average distance travelled for each customer?
What was the difference between the longest and shortest delivery times for all orders?
What was the average speed for each runner for each delivery and do you notice any trend for these values?
What is the successful delivery percentage for each runner?
                                         C. Ingredient Optimisation
What are the standard ingredients for each pizza?
What was the most commonly added extra?
What was the most common exclusion?
Generate an order item for each record in the customers_orders table in the format of one of the following:
Meat Lovers
Meat Lovers - Exclude Beef
Meat Lovers - Extra Bacon
Meat Lovers - Exclude Cheese, Bacon - Extra Mushroom, Peppers
Generate an alphabetically ordered comma separated ingredient list for each pizza order from the customer_orders table and add a 2x in front of any relevant ingredients
For example: "Meat Lovers: 2xBacon, Beef, ... , Salami"
What is the total quantity of each ingredient used in all delivered pizzas sorted by most frequent first?
                                                D. Pricing and Ratings
If a Meat Lovers pizza costs $12 and Vegetarian costs $10 and there were no charges for changes - how much money has Pizza Runner made so far if there are no delivery fees?
What if there was an additional $1 charge for any pizza extras?
Add cheese is $1 extra
The Pizza Runner team now wants to add an additional ratings system that allows customers to rate their runner, how would you design an additional table for this new dataset - generate a schema for this new table and insert your own data for ratings for each successful customer order between 1 to 5.
Using your newly generated table - can you join all of the information together to form a table which has the following information for successful deliveries?
customer_id
order_id
runner_id
rating
order_time
pickup_time
Time between order and pickup
Delivery duration
Average speed
Total number of pizzas
If a Meat Lovers pizza was $12 and Vegetarian $10 fixed prices with no cost for extras and each runner is paid $0.30 per kilometre traveled - how much money does Pizza Runner have left over after these deliveries?
*/


------------------------------------------------------------A. Pizza Metrics--------------------------------------------------------------
--How many pizzas were ordered?
	SELECT count(1) as no_of_pizzas_ordered
	FROM customer_orders

--How many unique customer orders were made?
	SELECT COUNT(distinct(order_id)) as unique_customer_orders FROM customer_orders

--How many successful orders were delivered by each runner?
	SELECT runner_id,count(order_id) no_of_orders_delivered
	FROM runner_orders
	WHERE cancellation IS NULL OR cancellation IN ('','null')
	GROUP BY runner_id

--How many of each type of pizza was delivered?
	SELECT pn.pizza_name ,count(1) no_of_pizza
	FROM runner_orders ro
	JOIN customer_orders co ON ro.order_id=co.order_id
	JOIN pizza_names pn ON co.pizza_id=pn.pizza_id
	WHERE cancellation IS NULL OR cancellation IN ('','null')
	GROUP BY pn.pizza_name	


--How many Vegetarian and Meatlovers were ordered by each customer?
	SELECT co.customer_id,pn.pizza_name ,count(co.pizza_id) as no_of_pizza
	FROM customer_orders co
	JOIN pizza_names pn ON co.pizza_id=pn.pizza_id
	GROUP BY co.customer_id,pn.pizza_name
	ORDER BY co.customer_id,pn.pizza_name

--What was the maximum number of pizzas delivered in a single order?
	SELECT count(co.pizza_id) as max_no_of_pizza_delivered_in_single_order
	FROM runner_orders ro
	JOIN customer_orders co ON ro.order_id=co.order_id
	WHERE cancellation IS NULL OR cancellation IN ('','null')
	GROUP BY ro.order_id
	ORDER BY count(co.pizza_id) desc
	LIMIT 1

--For each customer, how many delivered pizzas had at least 1 change and how many had no changes?

UPDATE customer_orders
SET exclusions=NULL
WHERE exclusions='' OR exclusions='null'  ;

UPDATE customer_orders
SET extras=NULL
WHERE extras='' OR extras='null'  ;
	
	WITH t1 AS --Flaging the orders with changes and with no changes
			(SELECT *,
			CASE WHEN exclusions IS NULL AND extras IS NULL THEN 1 ELSE 0 END AS no_change_flag ,
			CASE WHEN exclusions IS NOT NULL OR extras IS NOT NULL THEN 1 ELSE 0 END AS change_flag
			FROM customer_orders ),
		t2 AS  -- Getting the orders which weren't cancelled .
			(SELECT *
			FROM runner_orders
			WHERE cancellation IS NULL OR cancellation IN ('','null'))
	-- Join the two tables t1 and t2 and giving out the result as Sum of no_change_flag & change_flag
	SELECT t1.customer_id,sum(t1.no_change_flag) pizza_with_no_changes , SUM(t1.change_flag) pizza_with_atleast_one_change
	FROM t1
	JOIN t2 ON t1.order_id=t2.order_id
	GROUP BY t1.customer_id 		
	ORDER BY t1.customer_id

--How many pizzas were delivered that had both exclusions and extras?
    SELECT COUNT (co.pizza_id) as no_of_pizza
	FROM customer_orders co 
	JOIN (SELECT *
		 FROM runner_orders
		 WHERE cancellation IS NULL OR cancellation IN ('','null'))x
	ON co.order_id=x.order_id	 
	WHERE exclusions IS NOT NULL AND extras IS NOT NULL 

--What was the total volume of pizzas ordered for each hour of the day?
	SELECT EXTRACT (hour FROM order_time) as Hour_of_day,count(pizza_id) as Volume_of_pizzas
	FROM customer_orders
	GROUP BY EXTRACT (hour FROM order_time)
	ORDER BY EXTRACT (hour FROM order_time);
--What was the volume of orders for each day of the week?
	SELECT  TO_CHAR(order_time,'Day') as week_day , COUNT(1) as volume_of_order
	FROM customer_orders
	GROUP BY TO_CHAR(order_time,'Day')
	ORDER BY TO_CHAR(order_time,'Day')
	
	
---------------------------------------------------B. Runner and Customer Experience--------------------------------------------------------------------

--How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)
	WITH runner_signups AS (
		SELECT runner_id,
			registration_date,
			registration_date - ((registration_date - '2021-01-01') % 7) AS starting_week
		FROM runners
	)
	SELECT starting_week,
		count(runner_id) AS n_runners
	from runner_signups
	GROUP BY starting_week
	ORDER BY starting_week;



--What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?
	WITH time_difference AS
			(SELECT DISTINCT ro.runner_id,ro.pickup_time::timestamp,co.order_time ,(ro.pickup_time::timestamp-co.order_time) as time_difference
			FROM runner_orders ro
			JOIN customer_orders co ON ro.order_id=co.order_id
			WHERE cancellation IS NULL OR cancellation IN ('','null'))
	SELECT runner_id,ROUND(AVG(EXTRACT(minutes FROM time_difference)+EXTRACT(seconds FROM time_difference)/60),2) average_time_in_minutes
	FROM time_difference
	GROUP BY runner_id




--Is there any relationship between the number of pizzas and how long the order takes to prepare?
	WITH t1 AS
			(SELECT ro.order_id ,count(co.pizza_id) as no_of_pizza
			FROM runner_orders ro
			JOIN customer_orders co ON ro.order_id=co.order_id
			WHERE cancellation IS NULL OR cancellation IN ('','null')
			GROUP BY ro.order_id
			ORDER BY ro.order_id),
		 t2 AS	
			(SELECT t1.order_id,t1.no_of_pizza , co.order_time ,ro.pickup_time::timestamp,(ro.pickup_time::timestamp-co.order_time) as time_difference
			 FROM t1 
			 JOIN customer_orders co ON co.order_id=t1.order_id
			 JOIN runner_orders ro ON ro.order_id=t1.order_id
			 )
	SELECT DISTINCT order_id,no_of_pizza, ROUND(SUM(EXTRACT(minutes FROM time_difference)+EXTRACT(seconds FROM time_difference)/60),2) AS time_to_prepare
	FROM t2
	GROUP BY order_id,no_of_pizza
	ORDER BY no_of_pizza

--What was the average distance travelled for each customer?
	SELECT co.customer_id,ROUND(AVG(translate(ro.distance,'km','')::numeric),2) average_distance_travelled_for_customer
	FROM runner_orders ro 
	JOIN customer_orders co ON ro.order_id=co.order_id
	WHERE (cancellation IS NULL OR cancellation IN ('','null'))
	GROUP BY  co.customer_id



--What was the difference between the longest and shortest delivery times for all orders?
	SELECT (MAX(LEFT(ro.duration,2)::int)-MIN(LEFT(ro.duration,2)::int)) as time_difference
	FROM runner_orders ro 
	JOIN customer_orders co ON ro.order_id=co.order_id
	WHERE (cancellation IS NULL OR cancellation IN ('','null'))
	


--What was the average speed for each runner for each delivery and do you notice any trend for these values?
	SELECT order_id,runner_id,ROUND((translate(distance,'km','')::numeric*60/(LEFT(duration,2)::int)),2) as speed_in_km_per_hour
	FROM runner_orders  
	WHERE (cancellation IS NULL OR cancellation IN ('','null'))	



--What is the successful delivery percentage for each runner?
	WITH total_order AS	
			(SELECT runner_id , COUNT(1) no_of_orders
			FROM runner_orders
			GROUP BY 1),
		completed_order AS
			(SELECT runner_id ,COUNT(1) total_orders
			FROM runner_orders  
			WHERE (cancellation IS NULL OR cancellation IN ('','null'))	
			GROUP BY 1)
	SELECT tos.runner_id , ROUND(co.total_orders*100.0/tos.no_of_orders,0) as successful_delivery_percentage
	FROM total_order tos
	JOIN completed_order co ON tos.runner_id=co.runner_id
	
------------------------------------------------------------C. Ingredient Optimisation------------------------------------------------------------
--What are the standard ingredients for each pizza?
	WITH unnested_pizza_toppings AS 
		(SELECT pizza_id ,UNNEST(string_to_array(toppings,','))::int as topping_id
		FROM pizza_recipes pr),
	   topping_name AS
		(SELECT t1.pizza_id ,pt.topping_name
		FROM unnested_pizza_toppings t1
		JOIN pizza_toppings pt ON t1.topping_id=pt.topping_id)
	SELECT pizza_id,string_agg(topping_name,',') ingredients
	FROM topping_name
	GROUP BY pizza_id
	ORDER BY pizza_id
--What was the most commonly added extra?
	WITH extras AS
		(SELECT (UNNEST(string_to_array(extras,',')))::INT as extras
		FROM customer_orders
		WHERE extras IS NOT NULL)
	SELECT pt.topping_name,COUNT(t1.extras) as no_of_time_added_as_extras
	FROM extras t1
	JOIN pizza_toppings pt ON t1.extras=pt.topping_id
	GROUP BY pt.topping_name
	ORDER BY COUNT(t1.extras) desc
--What was the most common exclusion?
	WITH t1 AS
		(SELECT (UNNEST(string_to_array(exclusions,',')))::INT as exclusions
		FROM customer_orders
		WHERE exclusions IS NOT NULL)
	SELECT pt.topping_name,COUNT(t1.exclusions) as no_of_time_excluded
	FROM t1
	JOIN pizza_toppings pt ON t1.exclusions=pt.topping_id
	GROUP BY pt.topping_name
	ORDER BY COUNT(t1.exclusions) desc
--Generate an order item for each record in the customers_orders table in the format of one of the following:
	WITH t AS
	       (SELECT row_number()over(order by customer_id)as rn , * 
			FROM customer_orders ),
		t1 AS	
			((SELECT rn, order_id,customer_id,pizza_id,(UNNEST(string_to_array(exclusions,',')))::INT as exclusions,(UNNEST(string_to_array(extras,',')))::INT as extras
			FROM t)
			UNION 
			(SELECT rn,order_id,customer_id,pizza_id,exclusions::INT,extras::INT
			FROM t
			WHERE extras IS  NULL OR exclusions IS NULL)),
		 t2 AS
			(SELECT t1.rn,t1.customer_id,t1.order_id,pn.pizza_name,pt.topping_name as exclusions,pt2.topping_name as extras 
			FROM t1 
			LEFT JOIN pizza_toppings pt ON t1.exclusions=pt.topping_id 
			LEFT JOIN pizza_toppings pt2 ON t1.extras=pt2.topping_id 
			JOIN pizza_names pn ON t1.pizza_id=pn.pizza_id
			ORDER BY t1.customer_id),
		 t3 AS 
			((SELECT rn,customer_id,order_id,pizza_name,exclusions ,extras
			FROM t2 
			WHERE exclusions is  NULL AND extras is  NULL)
			 UNION
			(SELECT rn,customer_id,order_id,pizza_name,string_agg(exclusions,',') as exclusions , string_agg(extras,',') as extras
			FROM t2 
			WHERE exclusions is NOT NULL OR extras is NOT NULL
			GROUP BY rn,customer_id,order_id,pizza_name))

	SELECT  customer_id,order_id, 
	CASE WHEN exclusions is null and extras is null THEN pizza_name
		 WHEN extras is null AND exclusions is NOT null THEN pizza_name||'-'||'Exclude'||' '||exclusions
		 WHEN extras is NOT null AND exclusions is null THEN pizza_name||'-'||'Extra'||' '||extras
		 WHEN extras is NOT null AND exclusions is NOT null THEN pizza_name||'-'||'Exclude'||' '||exclusions||'-'||'Extra'||' '||extras
		 END AS pizza_ordered
	FROM t3

--Generate an alphabetically ordered comma separated ingredient list for each pizza order from the customer_orders table and add a 2x in front of any relevant ingredients
	--For example: "Meat Lovers: 2xBacon, Beef, ... , Salami
	
	
---------------WORK IN PROGRESS ---------------------------	
	

--What is the total quantity of each ingredient used in all delivered pizzas sorted by most frequent first?	


---------------WORK IN PROGRESS -----------------------------------

WITH CTE AS
		(SELECT ro.order_id,co.customer_id,co.pizza_id ,coalesce (pr.toppings||','||co.extras,pr.toppings)as toppings,co.exclusions,row_number()over(order by ro.order_id)as rn
		FROM runner_orders ro
		JOIN customer_orders co ON ro.order_id=co.order_id
		JOIN pizza_recipes pr ON co.pizza_id=pr.pizza_id
		WHERE (cancellation IS NULL OR cancellation IN ('','null')) )
	,exclusions AS
		(SELECT rn , order_id,customer_id,pizza_id,UNNEST(string_to_array(exclusions,','))::int as exclusion
		FROM CTE) 
	,toppings_with_exclusions AS	
		(SELECT rn,order_id,customer_id,pizza_id,UNNEST(string_to_array(toppings,','))::int as toppings
		FROM CTE WHERE exclusions IS NOT NULL )
SELECT *
FROM toppings_with_exclusions t
JOIN exclusions e ON t.rn=e.rn AND t.order_id=e.order_id AND t.customer_id=e.customer_id AND t.toppings<>e.exclusion

-----------------------------------------------------------D. Pricing and Ratings-----------------------------------------------------------------------
--If a Meat Lovers pizza costs $12 and Vegetarian costs $10 and there were no charges for changes - how much money has Pizza Runner made so far if there are no delivery fees?
	SELECT SUM(total_sale) as total_money_made
	FROM (SELECT co.pizza_id,pn.pizza_name,count(1)
		,case when co.pizza_id=1 THEN 12*count(1) 
			  ELSE 10*count(1) END AS total_sale      
		FROM runner_orders ro
		JOIN customer_orders co ON ro.order_id=co.order_id
		JOIN pizza_names pn ON co.pizza_id=pn.pizza_id
		WHERE (cancellation IS NULL OR cancellation IN ('','null'))	
		GROUP BY co.pizza_id,pn.pizza_name)x

--What if there was an additional $1 charge for any pizza extras?
	SELECT SUM(total_sale) as total_money_made
	FROM
		(SELECT ro.order_id,co.extras,pn.pizza_id 
		,case when co.pizza_id=1 AND extras IS NULL THEN 12
			  WHEN co.pizza_id=1 AND extras IS NOT NULL THEN 12+1
			  when co.pizza_id=2 AND extras IS NULL THEN 10
			  WHEN co.pizza_id=2 AND extras IS NOT NULL THEN 10+1 END AS total_sale 
		FROM runner_orders ro
		JOIN customer_orders co ON ro.order_id=co.order_id
		JOIN pizza_names pn ON co.pizza_id=pn.pizza_id
		WHERE (cancellation IS NULL OR cancellation IN ('','null')))x	



--Add cheese is $1 extra
WITH CTE AS
		((SELECT row_number() over(order by ro.order_id)as rn, ro.order_id,pn.pizza_id  ,(UNNEST(string_to_array(extras,',')))::INT  as extras
		FROM runner_orders ro
		JOIN customer_orders co ON ro.order_id=co.order_id
		JOIN pizza_names pn ON co.pizza_id=pn.pizza_id
		WHERE (cancellation IS NULL OR cancellation IN ('','null')))
		UNION ALL 
		(SELECT row_number() over(order by ro.order_id)as rn, ro.order_id,pn.pizza_id  ,co.extras::int
		FROM runner_orders ro
		JOIN customer_orders co ON ro.order_id=co.order_id
		JOIN pizza_names pn ON co.pizza_id=pn.pizza_id
		WHERE (cancellation IS NULL OR cancellation IN ('','null')) AND co.extras IS NULL)),
   price_chart AS
		(SELECT * , 
		CASE WHEN extras=4 THEN 1
			 WHEN extras IS NULL AND pizza_id=1 THEN 12
			 WHEN extras IS NULL AND pizza_id=2 THEN 10
			 WHEN extras IS NOT NULL AND pizza_id=1 THEN 12+1
			 WHEN extras IS NOT NULL AND pizza_id=2 THEN 10+1
			 END AS charges
		FROM CTE) 
SELECT order_id,pizza_id,SUM(charges) as cost_of_order
FROM price_chart
GROUP BY rn,order_id,pizza_id
ORDER BY order_id

--The Pizza Runner team now wants to add an additional ratings system that allows customers to rate their runner, how would you design an additional table for this new dataset - generate a schema for this new table and insert your own data for ratings for each successful customer order between 1 to 5.

CREATE TABLE runner_rating (
  rating_id   INT,	
  order_id INTEGER,
  rating int
  	);
INSERT INTO runner_rating VALUES
  (1,1,4),
  (2,2,4),
  (3,3,5),
  (4,4,5),
  (5,5,3),
  (6,7,2),
  (7,8,4),
  (8,10,5);

     

--Using your newly generated table - can you join all of the information together to form a table which has the following information for successful deliveries?
  /*customer_id
	order_id
	runner_id
	rating
	order_time
	pickup_time
	Time between order and pickup
	Delivery duration
	Average speed
	Total number of pizzas*/

	SELECT co.customer_id,MIN(ro.order_id)order_id,MIN(ro.runner_id)runner_id,MIN(rr.rating)rating,MIN(co.order_time)order_time,
		   MIN(ro.pickup_time::timestamp)pickup_time,MIN(ro.pickup_time::timestamp-co.order_time)AS Time_between_order_and_pickup ,MIN(CONCAT((LEFT(ro.duration,2)),' ','mins')) as Delivery_duration,
		   ROUND(AVG((translate(ro.distance,'km','')::numeric/(LEFT(ro.duration,2)::int))),2)as speed_in_km_per_min,
		   COUNT(co.pizza_id) as no_of_pizzas
	FROM runner_orders ro
	JOIN customer_orders co ON ro.order_id=co.order_id
	JOIN pizza_names pn ON co.pizza_id=pn.pizza_id
	JOIN runner_rating rr ON ro.order_id=rr.order_id
	WHERE cancellation IS NULL OR cancellation IN ('','null')
	GROUP BY co.customer_id
	ORDER BY co.customer_id
			   			   
--If a Meat Lovers pizza was $12 and Vegetarian $10 fixed prices with no cost for extras and each runner is paid $0.30 per kilometre traveled - how much money does Pizza Runner have left over after these deliveries?
	SELECT ROUND(SUM(total_sale-runner_payment),2) as total_revenue 
	FROM
	(SELECT  ro.order_id ,
	SUM(case when co.pizza_id=1 THEN 12 
		ELSE 10 END) AS total_sale ,
	MIN((translate(ro.distance,'km','')::numeric*.3))	AS runner_payment
	FROM runner_orders ro
	JOIN customer_orders co ON ro.order_id=co.order_id
	JOIN pizza_names pn ON co.pizza_id=pn.pizza_id
	WHERE (cancellation IS NULL OR cancellation IN ('','null'))
	GROUP BY ro.order_id )x	
