-- EDA for HR Data with SQL Server

-- Showing all data 

SELECT *
FROM dbo.hrdata

-- Showing the total number of employees

SELECT SUM(employee_count) AS total_employees
FROM dbo.hrdata

-- Showing the total number of employees whose education is high school

SELECT SUM(employee_count) AS total_employees
FROM dbo.hrdata
WHERE education='High School'

-- Showing the total number of employees whose department is sales

SELECT SUM(employee_count) AS total_employees
FROM dbo.hrdata
WHERE department = 'Sales'

-- Showing the total number of employees whose department is R&D

SELECT SUM(employee_count) AS total_employees
FROM dbo.hrdata
WHERE department = 'R&D'

-- Showing the total number of employees whose education field is Medical

SELECT SUM(employee_count) AS total_employees
FROM dbo.hrdata
WHERE education_field = 'Medical'

-- Showing the total number of employees who left the company

SELECT COUNT(attrition) AS total_employees
FROM dbo.hrdata
WHERE attrition = 1

-- Showing the total number of employees who left the company has doctoral degree

SELECT COUNT(attrition) AS total_employees
FROM dbo.hrdata
WHERE attrition = 1 AND education = 'Doctoral Degree'

-- Showing the total number of employees who left the company in the r&d department

SELECT COUNT(attrition) AS total_employees
FROM dbo.hrdata
WHERE attrition = 1 AND department = 'R&D'

-- Showing the total number of medical employees who left the company in the r&d department

SELECT COUNT(attrition) AS total_employees
FROM dbo.hrdata
WHERE attrition = 1 AND department = 'R&D' AND education_field = 'Medical'

-- Showing the total number of medical employees who left the company in the r&d department whose education is high school

SELECT COUNT(attrition) AS total_employees
FROM dbo.hrdata
WHERE attrition = 1 AND department = 'R&D' AND education_field = 'Medical' AND education = 'High School'

-- Showing the attrition rate by deviding the total number of attrition by the total number of employees

SELECT ROUND((SELECT COUNT(attrition) FROM dbo.hrdata WHERE attrition=1)*100/(CAST (SUM(employee_count) AS FLOAT)),2) AS attrition_rate
FROM dbo.hrdata

-- Showing the attrition rate for sales departmen employees

SELECT ROUND((SELECT COUNT(attrition) FROM dbo.hrdata WHERE attrition=1 AND department = 'Sales')*100/(CAST (SUM(employee_count) AS FLOAT)),2) AS attrition_rate
FROM dbo.hrdata
WHERE department = 'Sales'

-- Showing the total number of active employees

SELECT (SUM(employee_count)-(SELECT COUNT(attrition) FROM dbo.hrdata WHERE attrition=1)) AS active_employees
FROM dbo.hrdata

-- Showing the total number of active male employees

SELECT (SUM(employee_count)-(SELECT COUNT(attrition) FROM dbo.hrdata WHERE attrition=1 AND gender='Male')) AS active_employees
FROM dbo.hrdata
WHERE gender='Male'

-- Showing the average age for employees

SELECT ROUND(AVG(CAST(age AS FLOAT)),0) AS avg_age
FROM dbo.hrdata

-- Showing the attrition by gender

SELECT gender, COUNT(attrition) AS attrition_count
FROM dbo.hrdata
WHERE attrition=1
GROUP BY gender
ORDER BY attrition_count DESC

-- Showing the attrition by gender for employees has high school

SELECT gender, COUNT(attrition) AS attrition_count
FROM dbo.hrdata
WHERE attrition=1 AND education = 'High School'
GROUP BY gender
ORDER BY attrition_count DESC

-- Showing the total number and percentage of attrition by department

SELECT department, COUNT(attrition) AS attrition_count, ROUND(COUNT(attrition)*100/CAST((SELECT COUNT(attrition) FROM dbo.hrdata WHERE attrition=1) AS FLOAT),2) AS attrition_rate
FROM dbo.hrdata
WHERE attrition=1
GROUP BY department
ORDER BY attrition_count DESC

-- Showing the total number and percentage of attrition by department for female emplyees

SELECT department, COUNT(attrition) AS attrition_count, ROUND(COUNT(attrition)*100/CAST((SELECT COUNT(attrition) FROM dbo.hrdata WHERE attrition=1 AND gender = 'Female') AS FLOAT),2) AS attrition_rate
FROM dbo.hrdata
WHERE attrition=1 AND gender = 'Female'
GROUP BY department
ORDER BY attrition_count DESC

-- Showing the total number of employees by age

SELECT age, SUM(employee_count) AS total_employees
FROM dbo.hrdata
GROUP BY age
ORDER BY total_employees DESC

-- Showing the total number of employees by age in r&d department

SELECT age, SUM(employee_count) AS total_employees
FROM dbo.hrdata
WHERE department = 'R&D'
GROUP BY age
ORDER BY total_employees DESC

-- Showing the attrition by education field

SELECT education_field, COUNT(attrition) AS attrition_count
FROM dbo.hrdata
WHERE attrition=1 
GROUP BY education_field
ORDER BY attrition_count DESC

-- Showing the attrition by education field for sales department

SELECT education_field, COUNT(attrition) AS attrition_count
FROM dbo.hrdata
WHERE attrition=1 AND department = 'Sales'
GROUP BY education_field
ORDER BY attrition_count DESC

-- Showing the total number and percentage of attrition by age and gender

SELECT age_band, gender, COUNT(attrition) AS attrition_count,
ROUND(COUNT(attrition)*100/CAST((SELECT COUNT(attrition) FROM dbo.hrdata WHERE attrition=1) AS FLOAT),2) AS attrition_rate
FROM dbo.hrdata
WHERE attrition=1
GROUP BY age_band, gender
ORDER BY age_band, gender

-- Showing the total number of employees by job role and job satisfacation

SELECT job_role,
SUM(CASE WHEN job_satisfaction=1 THEN employee_count ELSE NULL END) AS one,
SUM(CASE WHEN job_satisfaction=2 THEN employee_count ELSE NULL END) AS two,
SUM(CASE WHEN job_satisfaction=3 THEN employee_count ELSE NULL END) AS three,
SUM(CASE WHEN job_satisfaction=4 THEN employee_count ELSE NULL END) AS four
FROM dbo.hrdata
GROUP BY job_role
ORDER BY job_role

-- Showing the total number of emloyees by age and gender

SELECT age_band, gender, SUM(employee_count) AS total_employees
FROM dbo.hrdata
GROUP BY age_band, gender
ORDER BY age_band, gender















