# CASE Exercises

USE employees;
show databases;
select database();
-- 1. Write a query that returns all employees, their department number, 
-- their start date, their end date, and a new column 'is_current_employee' that 
-- is a 1 if the employee is still with the company and 0 if not.
--  DO NOT WORRY ABOUT DUPLICATE EMPLOYEES.
SELECT *,
	case
		when to_date > now() then 1
        else 0
    end is_current_employee
FROM dept_emp;

-- Or 
SELECT *,
	if (to_date > now(), 1, 0) is_current_employee
FROM dept_emp;

-- 2. Write a query that returns all employee names (previous and current), 
-- and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending 
-- on the first letter of their last name.
SELECT concat(first_name, " ", last_name),
	case
		when UPPER(LEFT(last_name, 1)) between "A" and "H" then "A-H"
        when UPPER(LEFT(last_name, 1)) between "I" and "Q" then "I-Q"
        when UPPER(LEFT(last_name, 1)) between "R" and "Z" then "R-Z"
    end alpha_group
FROM employees;

-- 3. How many employees (current or previous) were born in each decade?
SELECT
	case
		when birth_date LIKE "195%" then 1950
        when birth_date LIKE "196%" then 1960
    end decade, count(*) count
FROM employees
GROUP BY decade;
-- 4. What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?
SELECT 
	case
    when d.dept_name LIKE "Research" OR dept_name LIKE "Development" then "R&D"
    when d.dept_name LIKE "Sales" OR dept_name LIKE "Marketing" then "Sales & Marketing"
    when d.dept_name LIKE "Production" OR dept_name LIKE "Quality Management" then "Production & QM"
    when d.dept_name LIKE "Finance" OR dept_name LIKE "Human Resources" then "Finance & HR"
    else "Customer Service"
    end dept_groups,
    avg(salary) avg_salary
FROM dept_emp
JOIN salaries s USING (emp_no)
JOIN departments d USING (dept_no)
WHERE s.to_date > now()
GROUP BY dept_groups
ORDER BY avg_salary;


