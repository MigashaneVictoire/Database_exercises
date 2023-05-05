USE join_example_db;
SELECT database();
SHOW TABLES;

-- join_example_db
-- 1. Use the join_example_db. Select all the records from both the users and roles tables.
SELECT *
FROM users;

SELECT * 
FROM roles;

-- 2. Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results.
-- Inner join
SELECT *
FROM users
JOIN roles ON users.role_id = roles.id;

-- left join
SELECT *
FROM users
LEFT JOIN roles ON users.role_id = roles.id;
-- right join
SELECT *
FROM users
RIGHT JOIN roles ON users.role_id = roles.id;

-- 3. Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query.
SELECT roles.name, count(roles.id)
FROM users
JOIN roles ON users.role_id = roles.id
GROUP BY roles.name;

-- Employees Database
USE employees;
SELECT database();

SHOW TABLES;

SHOW CREATE TABLE departments; -- dept_no, dept_name
SELECT *
FROM departments;

SHOW CREATE TABLE dept_manager; -- emp_no, dept_no, 
SELECT *
FROM dept_manager;

SHOW CREATE TABLE dept_emp; -- name, emp_no
SHOW TABLES;
SELECT *
FROM dept_emp;

SHOW CREATE TABLE employees; -- name, emp_no
SELECT *
FROM employees
LIMIT 5;  

SHOW CREATE TABLE titles; -- emp_no, title
SELECT *
FROM titles
WHERE title LIKE "M%";

SHOW CREATE TABLE salaries; -- emp_no, salary
SELECT *
FROM salaries;

-- 2. Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department
SELECT 
    d.dept_name, CONCAT(first_name, last_name)
FROM
    dept_manager dm
        JOIN
    employees e ON dm.emp_no = e.emp_no
        JOIN
    departments d ON dm.dept_no = d.dept_no
WHERE
    dm.to_date LIKE '999%';


-- 3. Find the name of all departments currently managed by women.

SELECT 
    d.dept_name, CONCAT(first_name, last_name)
FROM
    dept_manager dm
        JOIN
    employees e ON dm.emp_no = e.emp_no
        JOIN
    departments d ON dm.dept_no = d.dept_no
WHERE
    dm.to_date LIKE '999%'
    AND e.gender = "F";

-- 4. Find the current titles of employees currently working in the Customer Service department.

SELECT 
    T.title, COUNT(T.title)
FROM
    dept_emp DE
        JOIN
    titles T ON DE.emp_no = T.emp_no
        JOIN
    departments D ON DE.dept_no = D.dept_no
WHERE
    T.to_date LIKE '9999%'
        AND D.dept_name = 'Customer Service'
GROUP BY T.title;


-- 5. Find the current salary of all current managers.

SELECT 
    d.dept_name,
    CONCAT(first_name, last_name),
    t.title,
    s.salary
FROM
    dept_emp de
        JOIN
    employees e ON de.emp_no = e.emp_no
        JOIN
    departments d ON de.dept_no = d.dept_no
        JOIN
    salaries s ON de.emp_no = s.emp_no
        JOIN
    titles t ON de.emp_no = t.emp_no
WHERE
    s.to_date LIKE '999%'
        AND t.title = 'Manager';

-- 6. Find the number of current employees in each department.

SELECT 
    de.dept_no, d.dept_name, COUNT(*) Num_employees
FROM
    dept_emp de
        JOIN
    departments d ON de.dept_no = d.dept_no
        LEFT JOIN
    employees e ON de.emp_no = e.emp_no
GROUP BY de.dept_no;

-- 7. Which department has the highest average salary? Hint: Use current not historic information.

SELECT 
    d.dept_name, AVG(s.salary) avg_salary
FROM
    dept_emp de
        JOIN
    departments d ON de.dept_no = d.dept_no
        JOIN
    salaries s ON de.emp_no = s.emp_no
WHERE
    de.to_date LIKE '999%'
GROUP BY d.dept_name
ORDER BY avg_salary DESC
LIMIT 1;

-- 8. Who is the highest paid employee in the Marketing department?
SELECT 
    e.first_name, e.last_name, s.salary, d.dept_name
FROM
    dept_emp de
        JOIN
    departments d ON de.dept_no = d.dept_no
        JOIN
    salaries s ON de.emp_no = s.emp_no
		JOIN
	employees e ON de.emp_no = e.emp_no
WHERE
    de.to_date LIKE '999%'
    AND d.dept_name = "Marketing"
ORDER BY s.salary DESC
LIMIT 1;

-- 9. Which current department manager has the highest salary?

SELECT 
    e.first_name, e.last_name, s.salary, d.dept_name
FROM
    dept_manager dm
        JOIN
    employees e ON dm.emp_no = e.emp_no
        JOIN
    departments d ON dm.dept_no = d.dept_no
		JOIN 
	salaries s ON dm.emp_no = s.emp_no
WHERE
    dm.to_date LIKE '999%'
ORDER BY s.salary DESC,1,2, d.dept_name;

-- 10.  Determine the average salary for each department. Use all salary information and round your results.

SELECT 
    d.dept_name, ROUND(AVG(s.salary),0) avg_salary
FROM
    dept_emp de
        JOIN
    departments d ON de.dept_no = d.dept_no
        JOIN
    salaries s ON de.emp_no = s.emp_no
WHERE
    de.to_date LIKE '999%'
GROUP BY d.dept_name
ORDER BY avg_salary DESC;

-- 11. Bonus Find the names of all current employees, their department name, and their current manager's name.

SELECT CONCAT(e.first_name, e.last_name), d.dept_name, 
	(SELECT CONCAT(e.first_name, e.last_name)
    WHERE t.title LIKE "M%")
FROM dept_emp de
JOIN employees e ON de.emp_no = e.emp_no
JOIN departments d ON de.dept_no = d.dept_no
JOIN titles t ON de.emp_no = t.emp_no
WHERE de.to_date LIKE '999%'