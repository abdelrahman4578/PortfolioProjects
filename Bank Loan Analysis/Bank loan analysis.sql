-- EDA for bank loan data with SQL server

-- Show all data columns

SELECT *
FROM dbo.bank_loan_data

-- Showing total loan applications

SELECT COUNT(id) AS total_loan_applications
FROM dbo.bank_loan_data

-- Showing total loan applications for December

SELECT COUNT(id) AS MTD_total_loan_applications
FROM dbo.bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

-- Showing total loan applications for November

SELECT COUNT(id) AS PMTD_total_loan_applications
FROM dbo.bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

-- Showing total funded amount

SELECT SUM(loan_amount) AS total_funded_amount
FROM dbo.bank_loan_data

-- Showing total funded amount for December

SELECT SUM(loan_amount) AS MTD_total_funded_amount
FROM dbo.bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

-- Showing total funded amount for November

SELECT SUM(loan_amount) AS PMTD_total_funded_amount
FROM dbo.bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

-- Showing total amount received

SELECT SUM(total_payment) AS total_amount_received
FROM dbo.bank_loan_data

-- Showing total amount received for December

SELECT SUM(total_payment) AS MTD_total_amount_received
FROM dbo.bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

-- Showing total amount received for November

SELECT SUM(total_payment) AS PMTD_total_amount_received
FROM dbo.bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

-- Showing the average of interest rate

SELECT ROUND(AVG(int_rate)*100,2) AS avg_interest_rate
FROM dbo.bank_loan_data

-- Showing the average of interest rate for December

SELECT ROUND(AVG(int_rate)*100,2) AS MTD_avg_interest_rate
FROM dbo.bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

-- Showing the average of interest rate for November

SELECT ROUND(AVG(int_rate)*100,2) AS PMTD_avg_interest_rate
FROM dbo.bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

-- Showing the average of debt to income ratio

SELECT ROUND(AVG(dti)*100,2) AS avg_dti
FROM dbo.bank_loan_data

-- Showing the average of debt to income ratio for December

SELECT ROUND(AVG(dti)*100,2) AS MTD_avg_dti
FROM dbo.bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

-- Showing the average of debt to income ratio for November

SELECT ROUND(AVG(dti)*100,2) AS PMTD_avg_dti
FROM dbo.bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

-- Showing the percentage of good loan applications

SELECT (COUNT(CASE WHEN loan_status='Fully Paid' OR loan_status='Current' THEN id END)*100/COUNT(id)) AS good_loan_percentage
FROM dbo.bank_loan_data

-- Showing the total number of good loan applications

SELECT COUNT(id) AS good_loan_applications
FROM dbo.bank_loan_data
WHERE loan_status='Fully Paid' OR loan_status='Current'

-- Showing the total funded amount for good applications

SELECT SUM(loan_amount) AS good_loan_funded_amount
FROM dbo.bank_loan_data
WHERE loan_status='Fully Paid' OR loan_status='Current'

-- Showing the total received amount for good applications

SELECT SUM(total_payment) AS good_loan_received_amount
FROM dbo.bank_loan_data
WHERE loan_status='Fully Paid' OR loan_status='Current'

-- Showing the percentage of bad loan applications

SELECT (COUNT(CASE WHEN loan_status='Charged Off' THEN id END)*100.0)/COUNT(id) AS bad_loan_percentage
FROM dbo.bank_loan_data

-- Showing the total number of bad loan applications

SELECT COUNT(id) AS bad_loan_applications
FROM dbo.bank_loan_data
WHERE loan_status='Charged Off'

-- Showing the bad loan funded amount

SELECT SUM(loan_amount) AS bad_loan_funded_amount
FROM dbo.bank_loan_data
WHERE loan_status='Charged Off'

-- Showing the bad loan received amount

SELECT SUM(total_payment) AS bad_loan_received_amount
FROM dbo.bank_loan_data
WHERE loan_status='Charged Off'

-- Showing important metrics like total applications,average of dti and so on for each loan status

SELECT 
	loan_status,
	COUNT(id) AS total_applications,
	SUM(loan_amount) AS total_funded_amount,
	SUM(total_payment) AS total_received_amount,
	ROUND(AVG(int_rate * 100),2) AS avg_interest_rate,
	ROUND(AVG(dti * 100),2) AS avg_dti

FROM 
	dbo.bank_loan_data
GROUP BY 
	loan_status

-- Showing received and funded amounts for each loan status in December

SELECT 
	loan_status,
	SUM(loan_amount) AS MTD_total_funded_amount,
	SUM(total_payment) AS MTD_total_received_amount
	
FROM 
	dbo.bank_loan_data
WHERE
	MONTH(issue_date) = 12
GROUP BY 
	loan_status

-- Showing the total number of applications, received and funded amounts for each month

SELECT 
	MONTH(issue_date) month_number,
	DATENAME(MONTH,issue_date) AS month_name,
	COUNT(id) AS total_loan_applications,
	SUM(loan_amount) AS total_funded_amount,
	SUM(total_payment) AS total_received_amount
	
FROM 
	dbo.bank_loan_data
GROUP BY 
	MONTH(issue_date),DATENAME(MONTH,issue_date)
ORDER BY 
	MONTH(issue_date)

-- Showing the total number of applications, received and funded amounts for each state

SELECT 
	address_state AS stae,
	COUNT(id) AS total_loan_applications,
	SUM(loan_amount) AS total_funded_amount,
	SUM(total_payment) AS total_received_amount
	
FROM 
	dbo.bank_loan_data
GROUP BY 
	address_state
ORDER BY 
	COUNT(id) DESC

-- Showing the total number of applications, received and funded amounts for each term

SELECT 
	term AS term,
	COUNT(id) AS total_loan_applications,
	SUM(loan_amount) AS total_funded_amount,
	SUM(total_payment) AS total_received_amount
	
FROM 
	dbo.bank_loan_data
GROUP BY 
	term
ORDER BY 
	term

-- Showing the total number of applications, received and funded amounts for each employee length

SELECT 
	emp_length AS emp_length,
	COUNT(id) AS total_loan_applications,
	SUM(loan_amount) AS total_funded_amount,
	SUM(total_payment) AS total_received_amount
	
FROM 
	dbo.bank_loan_data
GROUP BY 
	emp_length
ORDER BY 
	COUNT(id) DESC

-- Showing the total number of applications, received and funded amounts for each purpose

SELECT 
	purpose AS purpose,
	COUNT(id) AS total_loan_applications,
	SUM(loan_amount) AS total_funded_amount,
	SUM(total_payment) AS total_received_amount
	
FROM 
	dbo.bank_loan_data
GROUP BY 
	purpose
ORDER BY 
	COUNT(id) DESC

-- Showing the total number of applications, received and funded amounts for each home ownership

SELECT 
	home_ownership AS home_ownership,
	COUNT(id) AS total_loan_applications,
	SUM(loan_amount) AS total_funded_amount,
	SUM(total_payment) AS total_received_amount
	
FROM 
	dbo.bank_loan_data
GROUP BY 
	home_ownership
ORDER BY 
	COUNT(id) DESC

-- Showing the total number of applications, received and funded amounts for each home ownership have grade A

SELECT 
	home_ownership AS home_ownership,
	COUNT(id) AS total_loan_applications,
	SUM(loan_amount) AS total_funded_amount,
	SUM(total_payment) AS total_received_amount
	
FROM 
	dbo.bank_loan_data
WHERE
	grade = 'A'
GROUP BY 
	home_ownership
ORDER BY 
	COUNT(id) DESC

-- Showing the total number of applications, received and funded amounts for each home ownership have grade A and in state california

SELECT 
	home_ownership AS home_ownership,
	COUNT(id) AS total_loan_applications,
	SUM(loan_amount) AS total_funded_amount,
	SUM(total_payment) AS total_received_amount
	
FROM 
	dbo.bank_loan_data
WHERE
	grade = 'A' AND address_state = 'CA'
GROUP BY 
	home_ownership
ORDER BY 
	COUNT(id) DESC





