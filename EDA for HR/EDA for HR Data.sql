-- EDA for HR data with SQL server

-- Showing all data

SELECT * FROM dbo.HR_data

-- Showing total number of employees

SELECT COUNT(DISTINCT EmployeeID) AS total_employees
FROM dbo.HR_data

-- Showing all unique jobs rules in the dataset

SELECT DISTINCT JobRole
FROM dbo.HR_data

-- Showing average age for employees

SELECT ROUND(AVG(Age),2) AS average_age
FROM dbo.HR_data

--  Showing the names and ages of employees who have worked at the company for more than 5 years

SELECT [Emp Name] AS employee_name, Age
FROM dbo.HR_data
WHERE YearsAtCompany > 5

-- Showing total number of employees for each department

SELECT Department,COUNT(EmployeeID) AS total_eployees
FROM dbo.HR_data
GROUP BY Department
ORDER BY total_eployees DESC

-- Showing employees who have High Job Satisfaction

SELECT [Emp Name] AS employee_name
FROM dbo.HR_data
WHERE JobSatisfaction = 'Very High'
ORDER BY employee_name DESC

-- Showing the highest Monthly Income in the dataset

SELECT MAX(MonthlyIncome) AS highest_income
FROM dbo.HR_data

-- Showing employees who have Travel_Rarely as their BusinessTravel type

SELECT [Emp Name] AS employee_name
FROM dbo.HR_data
WHERE BusinessTravel = 'Travel_Rarely'
ORDER BY employee_name 

--  Showing the distinct MaritalStatus categories in the dataset

SELECT DISTINCT MaritalStatus
FROM dbo.HR_data

-- Showing a list of employees with more than 2 years of work experience but less than 4 years in their current role

SELECT [Emp Name] AS employee_name
FROM dbo.HR_data
WHERE TotalWorkingYears > 2 AND YearsSinceLastPromotion < 4
ORDER BY employee_name

-- Showing employees who have changed their job roles within the company (JobLevel and JobRole differ from their previous job)

SELECT [Emp Name] AS employee_name,YearsAtCompany,YearsSinceLastPromotion
FROM dbo.HR_data
WHERE YearsAtCompany > YearsSinceLastPromotion AND YearsSinceLastPromotion > 0
ORDER BY employee_name

--  Showing the average distance from home for employees in each department

SELECT Department,ROUND(AVG(DistanceFromHome),2) AS average_distance
FROM dbo.HR_data
GROUP BY Department
ORDER BY average_distance DESC

-- Showing the top 5 employees with the highest MonthlyIncome

SELECT TOP(5) [Emp Name] AS employee_name , MonthlyIncome
FROM dbo.HR_data
ORDER BY MonthlyIncome DESC

-- Showing the percentage of employees who have had a promotion in the last year

SELECT (COUNT(CASE WHEN YearsSinceLastPromotion<=1 THEN 1
END)*100/COUNT(*)) AS percentage_of_employees
FROM dbo.HR_data

-- Showing the employees with the highest and lowest EnvironmentSatisfaction

SELECT [Emp Name] AS employee_name,EnvironmentSatisfaction
FROM dbo.HR_data
WHERE EnvironmentSatisfaction = 'Low' OR EnvironmentSatisfaction = 'Very High'
ORDER BY EnvironmentSatisfaction DESC
 
-- Showing the employees with the highest TotalWorkingYears who also have a PerformanceRating of 4

SELECT [Emp Name] AS employee_name,TotalWorkingYears,PerformanceRating
FROM dbo.HR_data
WHERE TotalWorkingYears=(SELECT MAX(TotalWorkingYears)
FROM dbo.HR_data
WHERE EmployeeID IN (SELECT  EmployeeID 
FROM dbo.HR_data
WHERE PerformanceRating LIKE 'V%')) 
ORDER BY employee_name

-- Showing the average Age and JobSatisfaction for each BusinessTravel type

SELECT distinct BusinessTravel, JobSatisfaction, 
	AVG(Age) over(partition by BusinessTravel) as average_age
FROM dbo.HR_data
ORDER BY BusinessTravel

-- Showing the most common EducationField among employees

SELECT TOP(1) EducationField,COUNT(EmployeeID) AS total_employees
FROM dbo.HR_data
GROUP BY EducationField
ORDER BY total_employees DESC

-- Showing the employees who have worked for the company the longest but haven't had a promotion

SELECT [Emp Name],YearsSinceLastPromotion,YearsAtCompany,RNK
FROM (
SELECT [Emp Name],YearsSinceLastPromotion,YearsAtCompany,
DENSE_RANK() OVER(ORDER BY YearsAtCompany DESC) AS RNK
FROM dbo.HR_data
WHERE YearsSinceLastPromotion=0
) RANKEDDATA
ORDER BY YearsAtCompany DESC









