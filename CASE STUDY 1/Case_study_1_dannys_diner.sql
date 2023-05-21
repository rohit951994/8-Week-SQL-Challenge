CREATE SCHEMA Case_study_1_dannys_diner;
SET search_path to Case_study_1_dannys_diner;

CREATE TABLE sales (
  "customer_id" VARCHAR(1),
  "order_date" DATE,
  "product_id" INTEGER
);

INSERT INTO sales
  ("customer_id", "order_date", "product_id")
VALUES
  ('A', '2021-01-01', '1'),
  ('A', '2021-01-01', '2'),
  ('A', '2021-01-07', '2'),
  ('A', '2021-01-10', '3'),
  ('A', '2021-01-11', '3'),
  ('A', '2021-01-11', '3'),
  ('B', '2021-01-01', '2'),
  ('B', '2021-01-02', '2'),
  ('B', '2021-01-04', '1'),
  ('B', '2021-01-11', '1'),
  ('B', '2021-01-16', '3'),
  ('B', '2021-02-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-07', '3');
 

CREATE TABLE menu (
  "product_id" INTEGER,
  "product_name" VARCHAR(5),
  "price" INTEGER
);

INSERT INTO menu
  ("product_id", "product_name", "price")
VALUES
  ('1', 'sushi', '10'),
  ('2', 'curry', '15'),
  ('3', 'ramen', '12');
  

CREATE TABLE members (
  "customer_id" VARCHAR(1),
  "join_date" DATE
);

INSERT INTO members
  ("customer_id", "join_date")
VALUES
  ('A', '2021-01-07'),
  ('B', '2021-01-09');
  
  
SELECT * FROM sales ;
SELECT * FROM menu ;
SELECT * FROM members ;



--1 What is the total amount each customer spent at the restaurant?
	SELECT s.customer_id,SUM(m.price)
	FROM sales s
	JOIN menu m ON s.product_id=m.product_id
	GROUP BY s.customer_id
	ORDER BY s.customer_id

--2 How many days has each customer visited the restaurant?
	SELECT customer_id,count( DISTINCT order_date) as no_of_days
	FROM sales
	GROUP BY customer_id

--3 What was the first item from the menu purchased by each customer?
	WITH CTE AS
		(SELECT customer_id,order_date,product_id,
				rank()over(partition by customer_id order by order_date) as rank
		FROM sales)
	SELECT t1.customer_id,t1.order_date,t2.product_name
	FROM CTE t1
	JOIN menu t2 ON t1.product_id=t2.product_id
	WHERE rank=1
	ORDER BY t1.customer_id

--4 What is the most purchased item on the menu and how many times was it purchased by all customers?
    SELECT m.product_name,count(1) as no_of_times_ordered
	FROM menu m
	JOIN sales s ON m.product_id=s.product_idConcepts to learn from this c
	GROUP BY m.product_name
	ORDER BY count(1) desc 
	LIMIT 1 ;

--5 Which item was the most popular for each customer?
	WITH CTE AS
	   (SELECT s.customer_id ,m.product_name,count(m.product_name)as no_of_time_ordered, rank()over(partition by customer_id order by count(m.product_name) desc)
		FROM sales s
		JOIN menu m ON s.product_id=m.product_id
		GROUP BY s.customer_id ,m.product_name
		ORDER BY s.customer_id,m.product_name)
	SELECT customer_id,product_name,no_of_time_ordered
	FROM CTE 
	WHERE rank=1

--6 Which item was purchased first by the customer after they became a member?
	WITH membership_status AS
	   (SELECT s.customer_id,s.order_date ,m.product_name,m.price,
		CASE WHEN s.order_date>=me.join_date THEN 'Y'
			 ELSE 'N' END AS membership_status
		FROM sales s
		JOIN menu m ON s.product_id=m.product_id
		JOIN members me ON  s.customer_id=me.customer_id
		ORDER BY s.customer_id,s.order_date),
	   membership_flag AS
		(SELECT *, 
		CASE WHEN membership_status='Y' AND lag(membership_status)over(partition by customer_id order by order_date)='N'THEN 1 ELSE 0 END AS FLAG
		FROM membership_status ) 
	SELECT customer_id,order_date,product_name
	FROM membership_flag
	WHERE flag=1

--7 Which item was purchased just before the customer became a member?
	WITH CTE AS
	   
	   SELECT s.customer_id,s.order_date ,m.product_name,m.price,
		CASE WHEN s.order_date>=me.join_date THEN 'Y'
			 ELSE 'N' END AS membership_status
		FROM sales s
		JOIN menu m ON s.product_id=m.product_id
		JOIN members me ON  s.customer_id=me.customer_id
		ORDER BY s.customer_id,s.order_date(SELECT s.customer_id,s.order_date ,m.product_name,m.price,
		CASE WHEN s.order_date>=me.join_date THEN 'Y'
			 ELSE 'N' END AS membership_status
		FROM sales s
		JOIN menu m ON s.product_id=m.product_id
		JOIN members me ON  s.customer_id=me.customer_id
		ORDER BY s.customer_id,s.order_date),
	   t2 AS
		(SELECT *, 
		CASE WHEN membership_status='N' AND lead(membership_status)over(partition by customer_id order by order_date)='Y'THEN 1 ELSE 0 END AS FLAG
		FROM CTE ) 
	SELECT customer_id,order_date,product_name
	FROM t2
	WHERE flag=1

--8 What is the total items and amount spent for each member before they became a member?
	WITH CTE AS
	   (SELECT s.customer_id,s.order_date ,m.product_name,m.price,
		CASE WHEN s.order_date>=me.join_date THEN 'Y'
			 ELSE 'N' END AS membership_status
		FROM sales s
		JOIN menu m ON s.product_id=m.product_id
		JOIN members me ON  s.customer_id=me.customer_id
		ORDER BY s.customer_id,s.order_date)

	SELECT customer_id,count(product_name) as no_of_items,sum(price) as total_amount
	FROM CTE 
	WHERE membership_status='N'
	GROUP BY customer_id

--9 If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
	WITH CTE AS
	   (SELECT s.customer_id,s.order_date ,m.product_name,m.price ,
		CASE WHEN product_name='sushi' THEN price*10*2 
			 ELSE price*10 END AS points
		FROM sales s
		JOIN menu m ON s.product_id=m.product_id
		ORDER BY s.customer_id,s.order_date)
	SELECT customer_id,SUM(points) as total_points
	FROM CTE
	GROUP BY customer_id

--10 In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?
	WITH CTE AS
	   (SELECT s.customer_id,s.order_date ,m.product_name,m.price,me.join_date,(me.join_date+6) as one_week_from_membership,
		CASE WHEN s.order_date>=me.join_date THEN 'Y'
			 ELSE 'N' END AS membership_status
		FROM sales s
		JOIN menu m ON s.product_id=m.product_id
		JOIN members me ON  s.customer_id=me.customer_id
		WHERE order_date<='2021-01-31'
		ORDER BY s.customer_id,s.order_date)
	SELECT customer_id,SUM(price*2*10) as total_point
	FROM CTE 
	WHERE order_date between join_date AND  one_week_from_membership
	GROUP BY customer_id
	
--11 The following questions is related creating basic data tables that Danny and his team can use to quickly derive insights without needing to join the above tables using SQL.column required customer_id,order_date,product_name,price,member

     SELECT s.customer_id,s.order_date ,m.product_name,m.price,
     CASE WHEN s.order_date>=me.join_date THEN 'Y'
		 ELSE 'N' END AS membership_status
	 FROM sales s
	 JOIN menu m ON s.product_id=m.product_id
	 LEFT JOIN members me ON  s.customer_id=me.customer_id
	 ORDER BY s.customer_id,s.order_date,m.product_name

--12 Danny also requires further information about the ranking of customer products, but he purposely does not need the ranking for non-member purchases so he expects null ranking values for the records when customers are not yet part of the loyalty program.

SELECT * FROM sales ;
SELECT * FROM menu ;
SELECT * FROM members ;	

WITH CTE AS
		(SELECT s.customer_id,s.order_date ,m.product_name,m.price,
		CASE WHEN s.order_date>=me.join_date THEN 'Y'
			ELSE 'N' END AS membership_status
		FROM sales s
		JOIN menu m ON s.product_id=m.product_id
		LEFT JOIN members me ON  s.customer_id=me.customer_id
		ORDER BY s.customer_id,s.order_date,m.product_name)
SELECT customer_id,order_date,product_name,price,membership_status,
CASE WHEN membership_status='N' THEN NULL 
     ELSE rank()over (partition by customer_id,membership_status order by order_date) END AS ranking
FROM CTE
