SELECT * FROM departments;

-- Retirement elgibility
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952_01_01' AND '1955-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952_01_01' AND '1952-12-31';

SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952_01_01' AND '1955-12-31') 
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952_01_01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Put results into a new table retirement_info
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952_01_01' AND '1955-12-31') 
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Now view the table
SELECT * FROM retirement_info