 # Subqueries
 
-- 1. Find all the current employees with the same hire date as employee 101010 using a subquery.
 SELECT *
 FROM employees
 WHERE hire_date = (SELECT hire_date
					FROM employees
					WHERE emp_no = "101010"
					);
-- 2. Find all the titles ever held by all current employees with the first name Aamod.

SELECT title
FROM titles t
WHERE emp_no IN (SELECT emp_no -- return all employees with first name Aamod
				FROM employees
				WHERE first_name LIKE "Aamod"
				)
		AND  t.to_date LIKE "999%"
GROUP BY t.title;

-- 3. How many people in the employees table are no longer working for the company? 
-- Give the answer in a comment in your code.

SELECT count(*)
FROM employees
WHERE emp_no NOT IN (SELECT emp_no
				FROM salaries
				WHERE s.to_date > now()
				);
                
                
-- 4. Find all the current department managers that are female. 
-- List their names in a comment in your code.

-- column sub-query
SELECT concat(first_name, " ",last_name), gender
FROM employees
WHERE emp_no IN (-- Get all curr dept manager employee numbers
				SELECT emp_no
				FROM titles
				WHERE title = "Manager"
				AND to_date > NOW()
				)
	AND gender = "F";

-- Table sub-query
SELECT CONCAT(first_name, ' ', last_name)
FROM (
		SELECT emp_no, first_name, last_name
		FROM employees
		WHERE gender = 'F') AS e
JOIN dept_manager ON e.emp_no = dept_manager.emp_no
where dept_manager.to_date = '9999-01-01';

-- 5. Find all the employees who currently have a higher salary than 
-- the companies overall, historical average salary.

-- Get history average salary
SELECT avg(salary)
FROM salaries
WHERE to_date < now();

-- Use row sub-query
-- connect employees to salaries and compare current salary to history salary 
SELECT emp_no, first_name, last_name, salary
FROM salaries
JOIN employees USING (emp_no)
WHERE salary > (SELECT avg(salary)
			FROM salaries
			WHERE to_date < now()) -- 63054.4341
	AND to_date > now();

-- 6. How many current salaries are within 1 standard deviation of the current highest salary? 
-- (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?

-- Find curr salaries
SELECT *
FROM salaries
WHERE to_date > now();

-- Find highest salary
SELECT max(salary)
FROM salaries
WHERE to_date > now();

-- Find the standard deviation
SELECT std(salary)
FROM salaries
WHERE to_date > now();

SELECT count(*)
FROM salaries
WHERE salary > (SELECT max(salary)
		FROM salaries
		WHERE to_date > now()) -
				(SELECT std(salary)
				FROM salaries
				WHERE to_date > now())
	AND to_date > now();