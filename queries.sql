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
SELECT * FROM retirement_info;

-- Recreate the retirement_info table with the emp_no column
-- First, drop the retirement_info table
DROP TABLE retirement_info;

-- Now recreate the table with the emp_no column
-- Put results into a new table retirement_info
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952_01_01' AND '1955-12-31') 
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;

--Joining departments and department_manager tables
SELECT departments.dept_name,
	dept_manager.emp_no,
	dept_manager.from_date,
	dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
	retirement_info.first_name,
	retirement_info.last_name,
	dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;

-- Using Aliases for cleaner code
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no;

SELECT d.dept_name,
	dm.emp_no,
	dm.from_date,
	dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;

-- Left join of retirement_info and dept_emp tables into new table
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01'); -- to get current employees

-- Create new table to hold
-- CREATE TABLE emp

-- Employee count by department nuber
SELECT COUNT(ce.emp_no), de.dept_no
INTO retirement_info_by_dept
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

SELECT * FROM retirement_info_by_dept;

SELECT * FROM salaries
ORDER BY to_date DESC;

SELECT e.emp_no,
	e.first_name,
	e.last_name,
	e.gender,
	s.salary,
	de.to_date
INTO emp_info
FROM employees AS e
INNER JOIN salaries AS s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952_01_01' AND '1955-12-31') 
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01');

-- List of managers per department
SELECT dm.dept_no,
	d.dept_name,
	dm.emp_no,
	ce.first_name,
	ce.last_name,
	dm.from_date,
	dm.to_date
INTO manager_info
FROM dept_manager as dm	
	INNER JOIN departments as d
		ON (dm.dept_no = d.dept_no)
	INNER JOIN current_emp as ce
		ON (dm.emp_no = ce.emp_no);

-- Add deartment to current_emp
SElECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
INTO dept_info
FROM current_emp AS ce
	INNER JOIN dept_emp as de
		ON (ce.emp_no = de.emp_no)
	INNER JOIN departments as d
		ON (de.dept_no = d.dept_no);

-- Add department to current_emp, sales dept only
SElECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
--INTO dept_info
FROM current_emp AS ce
	INNER JOIN dept_emp as de
		ON (ce.emp_no = de.emp_no)
	INNER JOIN departments as d
		ON (de.dept_no = d.dept_no)
WHERE (d.dept_no = 'd007');

-- add department to current_emp, sales and development dept only
SElECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
--INTO dept_info
FROM current_emp AS ce
	INNER JOIN dept_emp as de
		ON (ce.emp_no = de.emp_no)
	INNER JOIN departments as d
		ON (de.dept_no = d.dept_no)
WHERE d.dept_no IN ('d007','d005');