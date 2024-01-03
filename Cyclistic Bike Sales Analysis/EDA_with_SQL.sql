-- EDA for ride data with SQL queries

-- Showing first 5 rows 

SELECT top(5)*
FROM CaseStudyy.dbo.Data

-- Showing the total number of rows

SELECT COUNT(*)	AS total_rows
FROM CaseStudyy.dbo.Data

-- Showing total number of rides for each start station

SELECT start_station_name,COUNT(ride_id) AS total_rides
FROM CaseStudyy.dbo.Data
GROUP BY start_station_name
ORDER BY total_rides DESC


SELECT start_station_name,COUNT(ride_id) AS total_rides
FROM CaseStudyy.dbo.Data
GROUP BY start_station_name
ORDER BY total_rides 

-- Showing total number of rides for each end station

SELECT end_station_name,COUNT(ride_id) AS total_rides
FROM CaseStudyy.dbo.Data
WHERE end_station_name IS NOT NULL
GROUP BY end_station_name
ORDER BY total_rides DESC

SELECT end_station_name,COUNT(ride_id) AS total_rides
FROM CaseStudyy.dbo.Data
WHERE end_station_name IS NOT NULL
GROUP BY end_station_name
ORDER BY total_rides 

-- Showing the total number of members and casual
	
SELECT member_casual,COUNT(ride_id) AS total_customers
FROM CaseStudyy.dbo.Data
GROUP BY member_casual

-- Showing total rides for each day of week 1 as Sunday and 2 as Saturday

SELECT day_of_week,COUNT(ride_id) AS total_rides
FROM CaseStudyy.dbo.Data
GROUP BY day_of_week
ORDER BY total_rides DESC

SELECT 
CASE
	WHEN day_of_week=1 THEN 'Sun' 
	WHEN day_of_week=2 THEN 'Mon'
	WHEN day_of_week=3 THEN 'Tue'
	WHEN day_of_week=4 THEN 'Wed'
	WHEN day_of_week=5 THEN 'Thu'
	WHEN day_of_week=6 THEN 'Fri'
ELSE
	'Sat'
END AS week_day
,COUNT(ride_id) AS total_rides
FROM CaseStudyy.dbo.Data
GROUP BY day_of_week
ORDER BY total_rides DESC

-- Showing average ride lenth for each start station name

SELECT start_station_name,ROUND(AVG(CAST (ride_length AS float)),2) AS average_ride_length
FROM CaseStudyy.dbo.Data
GROUP BY start_station_name
ORDER BY average_ride_length DESC

-- Showing average ride lenth for each end station name

SELECT end_station_name,ROUND(AVG(CAST (ride_length AS float)),2) AS average_ride_length
FROM CaseStudyy.dbo.Data
WHERE end_station_name IS NOT NULL
GROUP BY end_station_name
ORDER BY average_ride_length DESC

-- Showing averge ride length for each customer

SELECT member_casual,ROUND(AVG(CAST (ride_length AS float)),2) AS average_ride_length
FROM CaseStudyy.dbo.Data
GROUP BY member_casual
ORDER BY average_ride_length DESC


