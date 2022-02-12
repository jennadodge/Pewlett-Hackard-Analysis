-- Use Dictinct with Orderby to remove duplicate rows
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees AS e
	JOIN titles AS t
		ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952_01_01' AND '1955-12-31')
ORDER BY emp_no ASC, title DESC;

-- make a new table with current titles
SELECT DISTINCT ON (emp_no) emp_no,
	first_name,
	last_name,
	title
INTO unique_titles 
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no ASC, to_date DESC;

-- Retrieve the number of employees by their most recent job title who are about to retire
SELECT COUNT(title),title
FROM unique_titles
INTO retiring_titles
GROUP BY title
ORDER BY count DESC;

-- Create a mentorship eligibility table that holds employees who are eligible to participate in mentorship program
SELECT DISTINCT ON (emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibility
FROM employees AS e
	JOIN dept_emp AS de 
		ON (e.emp_no = de.emp_no)
	JOIN titles AS t
		ON (e.emp_no = t.emp_no)
WHERE (de.to_date = '9999-01-01') 
AND (e.birth_date BETWEEN '1965_01_01' AND '1965-12-31')
ORDER BY emp_no ASC;

