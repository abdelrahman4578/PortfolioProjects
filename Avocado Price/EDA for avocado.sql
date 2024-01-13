-- EDA for Avocado Data with SQL Server
-- Showing all data

SELECT * FROM DBO.avocado

-- Showing the total number of columns

SELECT COUNT(*) AS total_number_of_rows FROM dbo.avocado 

-- Showing average price of avocado for each year

SELECT YEAR(Date) AS year ,ROUND(AVG(AveragePrice),2) AS average_price
FROM dbo.avocado
GROUP BY YEAR(Date)
ORDER BY average_price DESC

-- Showing the total number of avocado for each type

SELECT type,COUNT(type) AS total_number
FROM dbo.avocado
GROUP BY type
ORDER BY total_number DESC

-- Showing the average price of avocado for each type

SELECT type,ROUND(AVG(AveragePrice),2) AS average_price
FROM dbo.avocado
GROUP BY type
ORDER BY average_price DESC

-- Showing the total number of avocado for each year

SELECT year,COUNT(year) AS total_number
FROM dbo.avocado
GROUP BY year
ORDER BY total_number DESC

-- Showing the percentage of total volume for each type

SELECT type,ROUND(SUM([Total Volume])/(SELECT SUM([Total Volume]) FROM dbo.avocado)*100,1) AS percentage_of_total_volume
FROM dbo.avocado
GROUP BY type
ORDER BY percentage_of_total_volume DESC

-- Showing the percentage of avocado 4046 for each type

SELECT type,ROUND(SUM([4046])/(SELECT SUM([4046]) FROM dbo.avocado)*100,1) AS percentage_of_avocado_4046
FROM dbo.avocado
GROUP BY type
ORDER BY percentage_of_avocado_4046 DESC

-- Showing the percentage of avocado 4225 for each type

SELECT type,ROUND(SUM([4225])/(SELECT SUM([4225]) FROM dbo.avocado)*100,1) AS percentage_of_avocado_4225
FROM dbo.avocado
GROUP BY type
ORDER BY percentage_of_avocado_4225 DESC

-- Showing the percentage of avocado 4770 for each type

SELECT type,ROUND(SUM([4770])/(SELECT SUM([4770]) FROM dbo.avocado)*100,1) AS percentage_of_avocado_4770
FROM dbo.avocado
GROUP BY type
ORDER BY percentage_of_avocado_4770 DESC

-- Showing the percentage of total bags for each type

SELECT type,ROUND(SUM([Total Bags])/(SELECT SUM([Total Bags]) FROM dbo.avocado)*100,1) AS percentage_of_total_bags
FROM dbo.avocado
GROUP BY type
ORDER BY percentage_of_total_bags DESC

-- Showing the percentage of small bags for each type

SELECT type,ROUND(SUM([Small Bags])/(SELECT SUM([Small Bags]) FROM dbo.avocado)*100,1) AS percentage_of_small_bags
FROM dbo.avocado
GROUP BY type
ORDER BY percentage_of_small_bags DESC

-- Showing the percentage of large bags for each type

SELECT type,ROUND(SUM([Large Bags])/(SELECT SUM([Large Bags]) FROM dbo.avocado)*100,1) AS percentage_of_large_bags
FROM dbo.avocado
GROUP BY type
ORDER BY percentage_of_large_bags DESC

-- Showing the percentage of xlarge bags for each type

SELECT type,ROUND(SUM([XLarge Bags])/(SELECT SUM([XLarge Bags]) FROM dbo.avocado)*100,1) AS percentage_of_xlarge_bags
FROM dbo.avocado
GROUP BY type
ORDER BY percentage_of_xlarge_bags DESC

-- Showing the percentage of total volume for each year

SELECT year,ROUND(SUM([Total Volume])/(SELECT SUM([Total Volume]) FROM dbo.avocado)*100,1) AS percentage_of_total_volume
FROM dbo.avocado
GROUP BY year
ORDER BY percentage_of_total_volume DESC

-- Showing the percentage of avocado 4046 for each year

SELECT year,ROUND(SUM([4046])/(SELECT SUM([4046]) FROM dbo.avocado)*100,1) AS percentage_of_avocado_4046
FROM dbo.avocado
GROUP BY year
ORDER BY percentage_of_avocado_4046 DESC

-- Showing the percentage of avocado 4225 for each year

SELECT year,ROUND(SUM([4225])/(SELECT SUM([4225]) FROM dbo.avocado)*100,1) AS percentage_of_avocado_4225
FROM dbo.avocado
GROUP BY year
ORDER BY percentage_of_avocado_4225 DESC

-- Showing the percentage of avocado 4770 for each year

SELECT year,ROUND(SUM([4770])/(SELECT SUM([4770]) FROM dbo.avocado)*100,1) AS percentage_of_avocado_4770
FROM dbo.avocado
GROUP BY year
ORDER BY percentage_of_avocado_4770 DESC

-- Showing the percentage of total bags for each year

SELECT year,ROUND(SUM([Total Bags])/(SELECT SUM([Total Bags]) FROM dbo.avocado)*100,1) AS percentage_of_total_bags
FROM dbo.avocado
GROUP BY year
ORDER BY percentage_of_total_bags DESC

-- Showing the percentage of small bags for each year

SELECT year,ROUND(SUM([Small Bags])/(SELECT SUM([Small Bags]) FROM dbo.avocado)*100,1) AS percentage_of_small_bags
FROM dbo.avocado
GROUP BY year
ORDER BY percentage_of_small_bags DESC

-- Showing the percentage of large bags for each year

SELECT year,ROUND(SUM([Large Bags])/(SELECT SUM([Large Bags]) FROM dbo.avocado)*100,1) AS percentage_of_large_bags
FROM dbo.avocado
GROUP BY year
ORDER BY percentage_of_large_bags DESC

-- Showing the percentage of xlarge bags for each year

SELECT year,ROUND(SUM([XLarge Bags])/(SELECT SUM([XLarge Bags]) FROM dbo.avocado)*100,1) AS percentage_of_xlarge_bags
FROM dbo.avocado
GROUP BY year
ORDER BY percentage_of_xlarge_bags DESC

-- Showing total volume for each region

SELECT region,SUM([Total Volume]) AS total_volume
FROM dbo.avocado
WHERE region NOT IN ('TotalUS','West','Northeast','Southeast','Midsouth','SouthCentral')
GROUP BY region
ORDER BY total_volume DESC

-- Showing total bags for each region

SELECT region,SUM([Total Bags]) AS total_bags
FROM dbo.avocado
WHERE region NOT IN ('TotalUS','West','Northeast','Southeast','Midsouth','SouthCentral')
GROUP BY region
ORDER BY total_bags DESC