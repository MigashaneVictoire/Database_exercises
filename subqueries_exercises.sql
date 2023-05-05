 USE employees;
 SHOW TABLES;
         
SELECT *
FROM titles;

SELECT *
FROM employees;

SELECT *
FROM dept_emp;

SELECT *
FROM dept_manager;

SELECT *
FROM salaries;

SELECT *
FROM departments;
         
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

-- 3. How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.

SELECT count(*)
FROM employees
WHERE emp_no NOT IN (SELECT emp_no
				FROM salaries
				WHERE s.to_date > now()
				);
                
                
-- 4. Find all the current department managers that are female. List their names in a comment in your code.

SELECT concat(first_name, " ",last_name), gender
FROM employees
WHERE emp_no IN (-- Get all curr dept manager employee numbers
				SELECT emp_no
				FROM titles
				WHERE title = "Manager"
				AND to_date LIKE "999%"
				)
	AND gender = "F";

/* My subquery
SELECT emp_no
FROM employees
WHERE gender = 'F';*/
SELECT CONCAT(first_name, ' ', last_name)
FROM (
		SELECT emp_no, first_name, last_name
		FROM employees
		WHERE gender = 'F') AS e
JOIN dept_manager ON e.emp_no = dept_manager.emp_no
where dept_manager.to_date = '9999-01-01';

-- 5. Find all the employees who currently have a higher salary than the companies overall, historical average salary.
SELECT AVG(salary) -- historic average salary
FROM salaries;

SELECT *
FROM dept_emp
WHERE to_date > now()
AND salariy > (Select avg(salary) from salaries);
-- 6. How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?

select count(*)
from slaries
where to_date > now()
and salary > (
select max(salary) from salaries where to_date > now())
select std(salary) from slaries where to_date > now())
from salaries
where to_date > now()) * 100
-- Hint You will likely use multiple subqueries in a variety of ways
-- Hint It's a good practice to write out all of the small queries that you can. Add a comment above the query showing the number of rows returned. You will use this number (or the query that produced it) in other, larger queries.

-- BONUS
-- Find all the department names that currently have female managers.
-- Find the first and last name of the employee with the highest salary.
-- Find the department name that the employee with the highest salary works in.

-- Who is the highest paid employee within each department.