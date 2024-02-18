-- EDA for pizza sales using SQL server

-- Showing all columns of pizza data

SELECT *
FROM dbo.pizza_sales

-- Calculating the total revenue of pizza sales

SELECT ROUND(SUM(total_price),2) AS total_revenue
FROM dbo.pizza_sales

-- Calculating average order value by dividing total revenue by the total number of orders 

SELECT ROUND(SUM(total_price)/COUNT(DISTINCT order_id),2) AS average_order_value
FROM dbo.pizza_sales

-- Calculating the total pizza sold

SELECT SUM(quantity) AS total_pizza_sold
FROM dbo.pizza_sales

-- Calculating the total orders

SELECT COUNT(DISTINCT order_id) AS total_orders
FROM dbo.pizza_sales

-- Calculating the average pizzas per order by dividing the total number of pizza sold by the total number of orders

SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2))/CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS average_pizzas_per_order
FROM dbo.pizza_sales

-- Calculating daily trend for total orders

SELECT DATENAME(DW,order_date) AS order_day,COUNT(DISTINCT order_id) AS total_orders
FROM dbo.pizza_sales
GROUP BY DATENAME(DW,order_date)
ORDER BY total_orders DESC

-- Calculating hourly trend for total orders

SELECT DATEPART(HOUR,order_time) AS order_hours, COUNT(DISTINCT order_id) AS total_orders
FROM dbo.pizza_sales
GROUP BY DATEPART(HOUR,order_time)
ORDER BY total_orders DESC

-- Calculating hourly trend for total pizza sold

SELECT DATEPART(HOUR,order_time) AS order_hours, SUM(quantity) AS total_pizzas_sold
FROM dbo.pizza_sales
GROUP BY DATEPART(HOUR,order_time)
ORDER BY DATEPART(HOUR,order_time)

-- Calculating weekly trend for total orders

SELECT DATEPART(ISO_WEEK,order_date) AS week_number,YEAR(order_date) AS order_year, COUNT(DISTINCT order_id) AS total_orders
FROM dbo.pizza_sales
GROUP BY DATEPART(ISO_WEEK,order_date),YEAR(order_date)
ORDER BY DATEPART(ISO_WEEK,order_date),YEAR(order_date)

-- Calculating total sales and percentage of sales by pizza category

SELECT pizza_category,ROUND(SUM(total_price),2) AS total_sales, ROUND(SUM(total_price)*100/(SELECT SUM(total_price) FROM dbo.pizza_sales),2) AS sales_percentage
FROM dbo.pizza_sales
GROUP BY pizza_category
ORDER BY sales_percentage DESC

-- Calculating total sales and percentage of sales by pizza category for month january

SELECT pizza_category,ROUND(SUM(total_price),2) AS total_sales, ROUND(SUM(total_price)*100/(SELECT SUM(total_price) FROM dbo.pizza_sales WHERE MONTH(order_date)=1),2) AS sales_percentage
FROM dbo.pizza_sales
WHERE MONTH(order_date)=1
GROUP BY pizza_category
ORDER BY sales_percentage DESC

-- Calculating total sales and percentage of sales by pizza category for quarter 1

SELECT pizza_category,ROUND(SUM(total_price),2) AS total_sales, ROUND(SUM(total_price)*100/
(SELECT SUM(total_price) FROM dbo.pizza_sales WHERE DATEPART(QUARTER,order_date)=1),2) AS sales_percentage
FROM dbo.pizza_sales
WHERE DATEPART(QUARTER,order_date)=1
GROUP BY pizza_category
ORDER BY sales_percentage DESC

-- Calculating total sales and percentage of sales by pizza size

SELECT pizza_size,ROUND(SUM(total_price),2) AS total_sales, ROUND(SUM(total_price)*100/(SELECT SUM(total_price) FROM dbo.pizza_sales),2) AS sales_percentage
FROM dbo.pizza_sales
GROUP BY pizza_size
ORDER BY sales_percentage DESC

-- Calculating total sales and percentage of sales by pizza size for month january

SELECT pizza_size,ROUND(SUM(total_price),2) AS total_sales, ROUND(SUM(total_price)*100/(SELECT SUM(total_price) FROM dbo.pizza_sales WHERE MONTH(order_date)=1),2) AS sales_percentage
FROM dbo.pizza_sales
WHERE MONTH(order_date)=1
GROUP BY pizza_size
ORDER BY sales_percentage DESC

-- Calculating total sales and percentage of sales by pizza size for quarter 1

SELECT pizza_size,ROUND(SUM(total_price),2) AS total_sales, ROUND(SUM(total_price)*100/
(SELECT SUM(total_price) FROM dbo.pizza_sales WHERE DATEPART(QUARTER,order_date)=1),2) AS sales_percentage
FROM dbo.pizza_sales
WHERE DATEPART(QUARTER,order_date)=1
GROUP BY pizza_size
ORDER BY sales_percentage DESC

-- Calculating total pizza sold by pizza category

SELECT pizza_category, SUM(quantity) AS total_pizza_sold
FROM dbo.pizza_sales
GROUP BY pizza_category
ORDER BY total_pizza_sold DESC

-- Showing top 5 Best sellers by total pizzas sold

SELECT TOP 5 pizza_name, SUM(quantity) AS total_pizza_sold
FROM dbo.pizza_sales
GROUP BY pizza_name
ORDER BY total_pizza_sold DESC

-- Showing bottom 5 worst sellers by total revenue

SELECT TOP 5 pizza_name, ROUND(SUM(total_price),2) AS total_revenue
FROM dbo.pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue 

-- Showing top 5 Best sellers by total revenue

SELECT TOP 5 pizza_name, SUM(total_price) AS total_revenue
FROM dbo.pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue DESC

-- Showing top 5 best sellers by total pizzas sold for month january

SELECT TOP 5 pizza_name, SUM(quantity) AS total_pizza_sold
FROM dbo.pizza_sales
WHERE MONTH(order_date)=1
GROUP BY pizza_name
ORDER BY total_pizza_sold DESC

-- Showing top 5 best sellers by total pizzas sold for for quarter 1

SELECT TOP 5 pizza_name, SUM(quantity) AS total_pizza_sold
FROM dbo.pizza_sales
WHERE DATEPART(QUARTER,order_date)=1
GROUP BY pizza_name
ORDER BY total_pizza_sold DESC

-- Showing bottom 5 worst sellers by total pizzas sold

SELECT TOP 5 pizza_name, SUM(quantity) AS total_pizza_sold
FROM dbo.pizza_sales
GROUP BY pizza_name
ORDER BY total_pizza_sold 

-- Showing bottom 5 worst sellers by total pizzas sold for month january

SELECT TOP 5 pizza_name, SUM(quantity) AS total_pizza_sold
FROM dbo.pizza_sales
WHERE MONTH(order_date)=1
GROUP BY pizza_name
ORDER BY total_pizza_sold 

-- Showing bottom 5 worst sellers by total pizzas sold for quarter 1

SELECT TOP 5 pizza_name, SUM(quantity) AS total_pizza_sold
FROM dbo.pizza_sales
WHERE DATEPART(QUARTER,order_date)=1
GROUP BY pizza_name
ORDER BY total_pizza_sold 

-- Showing bottom 5 worst sellers by total orders

SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS total_orders
FROM dbo.pizza_sales
GROUP BY pizza_name
ORDER BY total_orders 

-- Showing top 5 Best sellers by total orders

SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS total_orders
FROM dbo.pizza_sales
GROUP BY pizza_name
ORDER BY total_orders DESC