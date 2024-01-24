-- EDA for pharma data with SQL server

-- Retrieve all columns for all records in the dataset

SELECT *
FROM dbo.Pharma_data

-- Showing the total number of unique countries

SELECT COUNT(DISTINCT Country) AS total_number_of_countries
FROM dbo.Pharma_data

-- Showing the names of all the customers on the 'Retail' channel

SELECT DISTINCT [Customer Name], [Sub-channel]
FROM dbo.Pharma_data
WHERE [Sub-channel] ='Retail'
ORDER BY [Customer Name]

-- Showing the total quantity sold for the ' Antibiotics' product class

SELECT [Product Class], ROUND(SUM(Quantity),2) AS total_quantity
FROM dbo.Pharma_data
WHERE [Product Class] = 'Antibiotics'
GROUP BY [Product Class]

-- List all the distinct months present in the dataset

SELECT DISTINCT Month
FROM dbo.Pharma_data

-- Showing the total sales for each year

SELECT Year, ROUND(SUM(Sales),2) AS total_sales
FROM dbo.Pharma_data
GROUP BY Year
ORDER BY total_sales DESC

-- Find the customer with the highest sales value

SELECT TOP(1) [Customer Name],SUM(Sales) AS highest_sales_value
FROM dbo.Pharma_data
GROUP BY [Customer Name]
ORDER BY highest_sales_value DESC

-- Showing the names of all employees who are Sales Reps and are managed by 'James Goodwill'

SELECT DISTINCT [Name of Sales Rep],Manager
FROM dbo.Pharma_data
WHERE Manager = 'James Goodwill'

-- Retrieve the top 5 cities with the highest sales

SELECT TOP(5) City,SUM(Sales) AS highest_sales
FROM dbo.Pharma_data
GROUP BY City
ORDER BY highest_sales DESC

-- Calculate the average price of products in each sub-channel

SELECT [Sub-channel], ROUND(AVG(Price),2) AS average_price
FROM dbo.Pharma_data
GROUP BY [Sub-channel]
ORDER BY average_price DESC

-- Showing the sales rep and the sales

SELECT [Name of Sales Rep] , Sales
FROM dbo.Pharma_data

-- Showing all sales made by employees from ' Rendsburg ' in the year 2018

SELECT City,SUM(Sales) AS sales
FROM dbo.Pharma_data
WHERE Year=2018 AND City ='Rendsburg'
GROUP BY City

-- Showing the total sales for each product class, for each month, and order the results by year, month, and product class

SELECT [Product Class],Year,Month,SUM(Sales) AS sales
FROM dbo.Pharma_data
GROUP BY [Product Class], Month,Year
ORDER BY Year ASC,Month ASC ,[Product Class] ASC

--  Showing the top 3 sales reps with the highest sales in 2019

SELECT TOP(3) [Name of Sales Rep],ROUND(SUM(Sales),2) AS highest_sales
FROM dbo.Pharma_data
GROUP BY [Name of Sales Rep]
ORDER BY highest_sales DESC

-- Showing the monthly total sales for each sub-channel, and then calculate the average monthly sales for each sub-channel over the years

WITH monthly_total_sales AS (
SELECT [Sub-channel],Year,Month, SUM(Sales) AS total_sales
FROM dbo.Pharma_data
GROUP BY [Sub-channel],Year,Month) 
SELECT [Sub-channel],ROUND(AVG(total_sales),2) AS average_monthly_sales
FROM monthly_total_sales
GROUP BY [Sub-channel]
ORDER BY average_monthly_sales DESC

-- Create a summary report that includes the total sales, average price, and total quantity sold for each product class

SELECT [Product Class], ROUND(SUM(Sales),2) AS total_sales, ROUND(AVG(Price),2) AS  average_price, ROUND(SUM(Quantity),2) AS total_quantity
FROM dbo.Pharma_data
GROUP BY [Product Class]
ORDER BY total_sales DESC

-- Showing the top 5 customers with the highest sales for each year.

WITH RankedCustomers AS (
    SELECT 
        [Year],
        [Customer Name],
        ROUND(SUM(Sales), 2) AS total_sales,
        ROW_NUMBER() OVER (PARTITION BY [Year] ORDER BY SUM(Sales) DESC) AS RowNum
    FROM 
        dbo.Pharma_data
    GROUP BY 
        [Year],
        [Customer Name]
)
SELECT 
    [Customer Name],
    [Year],
    total_sales
FROM 
    RankedCustomers
WHERE 
    RowNum <= 5
ORDER BY 
    [Year],
    total_sales DESC;

-- Calculate the year-over-year growth in sales for each country

WITH YOY AS (
    SELECT 
		Country,
        [Year],
        ROUND(SUM(Sales), 2) AS total_sales,
        LAG(SUM(Sales)) OVER(PARTITION BY Country ORDER BY [Year] ASC) AS pv_year_sales
    FROM 
        dbo.Pharma_data
    GROUP BY 
        Country,
        [Year]
)
SELECT 
    Country,
    [Year],
	total_sales,
	pv_year_sales,
	ROUND(((total_sales-pv_year_sales)/pv_year_sales),2) AS yoy_growth
FROM 
    YOY

-- List the months with the lowest sales for each year

WITH lowest_month_sales AS (
SELECT Year,Month,SUM(Sales) AS total_sales,
ROW_NUMBER() OVER(PARTITION BY Year ORDER BY SUM(Sales) ASC) AS Rnk
FROM dbo.Pharma_data
GROUP BY Year,Month
)
SELECT Year,Month,total_sales
FROM lowest_month_sales
WHERE Rnk=1
ORDER BY Year ASC

-- Calculate the total sales for each sub-channel in each country

SELECT Country,[Sub-channel],ROUND(SUM(Sales),2) AS total_sales
FROM dbo.Pharma_data
GROUP BY Country,[Sub-channel]
ORDER BY Country

-- Showing the country with the highest total sales for each sub-channel

WITH highest_country_sales AS (
SELECT [Sub-channel],Country,ROUND(SUM(Sales),2) AS total_sales,
ROW_NUMBER() OVER(PARTITION BY [Sub-channel] ORDER BY SUM(Sales) DESC) AS Rnk
FROM dbo.Pharma_data
GROUP BY [Sub-channel],Country
)
SELECT [Sub-channel],Country,total_sales
FROM highest_country_sales
WHERE Rnk=1
