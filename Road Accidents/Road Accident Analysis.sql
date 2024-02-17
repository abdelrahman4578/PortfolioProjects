-- EDA for road accident data with SQL Server

-- Show all data

SELECT * FROM dbo.road_accident

-- Show the total number of casualties

SELECT SUM(number_of_casualties) AS Total_Casualties 
FROM dbo.road_accident

-- Show the current total number of casualties

SELECT SUM(number_of_casualties) AS CY_Casualties 
FROM dbo.road_accident
WHERE YEAR(accident_date)=2022

-- Show the current total number of casualties for dry road surface

SELECT SUM(number_of_casualties) AS CY_Casualties 
FROM dbo.road_accident
WHERE YEAR(accident_date)=2022 AND road_surface_conditions='Dry'

-- Show the current total number of accidents

SELECT COUNT(DISTINCT accident_index) AS CY_Accidents
FROM dbo.road_accident
WHERE YEAR(accident_date)=2022

-- Show the current total number of fatal casualties

SELECT SUM(number_of_casualties) AS CY_Fatal_Casualties 
FROM dbo.road_accident
WHERE YEAR(accident_date)=2022 AND accident_severity='Fatal'

-- Show the total number of fatal casualties

SELECT SUM(number_of_casualties) AS Fatal_Casualties 
FROM dbo.road_accident
WHERE accident_severity='Fatal'

-- Show the total number of serious casualties

SELECT SUM(number_of_casualties) AS Serious_Casualties 
FROM dbo.road_accident
WHERE accident_severity='Serious'

-- Show the current total number of serious casualties

SELECT SUM(number_of_casualties) AS CY_Serious_Casualties 
FROM dbo.road_accident
WHERE YEAR(accident_date)=2022 AND accident_severity='Serious'

-- Show the current total number of slight casualties

SELECT SUM(number_of_casualties) AS CY_Slight_Casualties 
FROM dbo.road_accident
WHERE YEAR(accident_date)=2022 AND accident_severity='Slight'

-- Show the total number of slight casualties

SELECT SUM(number_of_casualties) AS CY_Slight_Casualties 
FROM dbo.road_accident
WHERE accident_severity='Slight'

-- Show the percentage of slight casualties

SELECT CAST((CAST(SUM(number_of_casualties) AS DECIMAL(10,2))*100/(SELECT CAST(SUM(number_of_casualties) AS DECIMAL(10,2)) FROM dbo.road_accident)) AS DECIMAL(10,1)) AS PCT
FROM dbo.road_accident
WHERE accident_severity='Slight'

-- Show the percentage of serioust casualties

SELECT CAST((CAST(SUM(number_of_casualties) AS DECIMAL(10,2))*100/(SELECT CAST(SUM(number_of_casualties) AS DECIMAL(10,2)) FROM dbo.road_accident)) AS DECIMAL(10,1)) AS PCT
FROM dbo.road_accident
WHERE accident_severity='Serious'

-- Show the percentage of fatal casualties

SELECT CAST((CAST(SUM(number_of_casualties) AS DECIMAL(10,2))*100/(SELECT CAST(SUM(number_of_casualties) AS DECIMAL(10,2)) FROM dbo.road_accident)) AS DECIMAL(10,1)) AS PCT
FROM dbo.road_accident
WHERE accident_severity='Fatal'

-- Show the current total casualties by vehicle type

SELECT 
	CASE
		WHEN vehicle_type IN ('Agricultural vehicle') THEN 'Agricltural'
		WHEN vehicle_type IN ('Car','Taxi/Private hire car') THEN 'Cars'
		WHEN vehicle_type IN ('Motorcycle 125cc and under','Motorcycle 50cc and under','Motorcycle over 125cc and up to 500cc','Motorcycle over 500cc','Pedal cycle') THEN 'Bike'
		WHEN vehicle_type IN ('Bus or coach (17 or more pass seats)','Minibus (8 - 16 passenger seats)') THEN 'Bus'
		WHEN vehicle_type IN ('Goods 7.5 tonnes mgw and over','Goods over 3.5t. and under 7.5t','Van / Goods 3.5 tonnes mgw or under') THEN 'Van'
	ELSE
		'Other' END AS Vehicle_Type,SUM(number_of_casualties) AS CY_Casualties
	
FROM dbo.road_accident
WHERE YEAR(accident_date)=2022
GROUP BY CASE
		WHEN vehicle_type IN ('Agricultural vehicle') THEN 'Agricltural'
		WHEN vehicle_type IN ('Car','Taxi/Private hire car') THEN 'Cars'
		WHEN vehicle_type IN ('Motorcycle 125cc and under','Motorcycle 50cc and under','Motorcycle over 125cc and up to 500cc','Motorcycle over 500cc','Pedal cycle') THEN 'Bike'
		WHEN vehicle_type IN ('Bus or coach (17 or more pass seats)','Minibus (8 - 16 passenger seats)') THEN 'Bus'
		WHEN vehicle_type IN ('Goods 7.5 tonnes mgw and over','Goods over 3.5t. and under 7.5t','Van / Goods 3.5 tonnes mgw or under') THEN 'Van'
	ELSE
		'Other' END 
ORDER BY CY_Casualties DESC

-- Show the total casualties by vehicle type

SELECT 
	CASE
		WHEN vehicle_type IN ('Agricultural vehicle') THEN 'Agricltural'
		WHEN vehicle_type IN ('Car','Taxi/Private hire car') THEN 'Cars'
		WHEN vehicle_type IN ('Motorcycle 125cc and under','Motorcycle 50cc and under','Motorcycle over 125cc and up to 500cc','Motorcycle over 500cc','Pedal cycle') THEN 'Bike'
		WHEN vehicle_type IN ('Bus or coach (17 or more pass seats)','Minibus (8 - 16 passenger seats)') THEN 'Bus'
		WHEN vehicle_type IN ('Goods 7.5 tonnes mgw and over','Goods over 3.5t. and under 7.5t','Van / Goods 3.5 tonnes mgw or under') THEN 'Van'
	ELSE
		'Other' END AS Vehicle_Type,SUM(number_of_casualties) AS CY_Casualties
	
FROM dbo.road_accident
GROUP BY CASE
		WHEN vehicle_type IN ('Agricultural vehicle') THEN 'Agricltural'
		WHEN vehicle_type IN ('Car','Taxi/Private hire car') THEN 'Cars'
		WHEN vehicle_type IN ('Motorcycle 125cc and under','Motorcycle 50cc and under','Motorcycle over 125cc and up to 500cc','Motorcycle over 500cc','Pedal cycle') THEN 'Bike'
		WHEN vehicle_type IN ('Bus or coach (17 or more pass seats)','Minibus (8 - 16 passenger seats)') THEN 'Bus'
		WHEN vehicle_type IN ('Goods 7.5 tonnes mgw and over','Goods over 3.5t. and under 7.5t','Van / Goods 3.5 tonnes mgw or under') THEN 'Van'
	ELSE
		'Other' END 
ORDER BY CY_Casualties DESC

-- Show the monthly trend for current year total number of casualties 

SELECT DATENAME(MONTH,accident_date) AS Month_Name,SUM(number_of_casualties) AS CY_Casualties
FROM dbo.road_accident
WHERE YEAR(accident_date)=2022
GROUP BY DATENAME(MONTH,accident_date)

-- Show the monthly trend for previous year total number of casualties 

SELECT DATENAME(MONTH,accident_date) AS Month_Name,SUM(number_of_casualties) AS PY_Casualties
FROM dbo.road_accident
WHERE YEAR(accident_date)=2021
GROUP BY DATENAME(MONTH,accident_date)

-- Show the current total number of casualties by road type

SELECT road_type,SUM(number_of_casualties) AS CY_Casualties
FROM dbo.road_accident
WHERE YEAR(accident_date)=2022
GROUP BY road_type
ORDER BY CY_Casualties DESC

-- Show the percentage of current year casualties by area

SELECT urban_or_rural_area,CAST((CAST(SUM(number_of_casualties) AS DECIMAL(10,2))*100/CAST((SELECT SUM(number_of_casualties) FROM dbo.road_accident WHERE YEAR(accident_date)=2022)AS DECIMAL(10,2))) AS DECIMAL(10,1)) AS PCT
FROM dbo.road_accident
WHERE YEAR(accident_date)=2022
GROUP BY urban_or_rural_area
ORDER BY PCT DESC

-- Show the percentage of casualties by area

SELECT urban_or_rural_area,SUM(number_of_casualties) AS Total_Casualties,CAST((CAST(SUM(number_of_casualties) AS DECIMAL(10,2))*100/CAST((SELECT SUM(number_of_casualties) FROM dbo.road_accident)AS DECIMAL(10,2))) AS DECIMAL(10,1)) AS PCT
FROM dbo.road_accident
GROUP BY urban_or_rural_area
ORDER BY PCT DESC

-- Show the percentage of current year casualties by light condition

SELECT 
	CASE
		WHEN light_conditions IN ('Darkness - lighting unknown','Darkness - lights lit','Darkness - lights unlit','Darkness - no lighting') THEN 'Night'
		WHEN light_conditions IN ('Daylight') THEN 'Day'
	END AS Light_Condition,CAST((CAST(SUM(number_of_casualties) AS DECIMAL(10,2))*100/CAST((SELECT SUM(number_of_casualties) FROM dbo.road_accident WHERE YEAR(accident_date)=2022)AS DECIMAL(10,2))) AS DECIMAL(10,2)) AS PCT
	
FROM dbo.road_accident
WHERE YEAR(accident_date)=2022
GROUP BY CASE
		WHEN light_conditions IN ('Darkness - lighting unknown','Darkness - lights lit','Darkness - lights unlit','Darkness - no lighting') THEN 'Night'
		WHEN light_conditions IN ('Daylight') THEN 'Day'
	END
ORDER BY PCT DESC

-- Show the total number of casualties by location

SELECT TOP 10 local_authority,SUM(number_of_casualties) AS CY_Casualties
FROM dbo.road_accident
GROUP BY local_authority
ORDER BY CY_Casualties DESC



