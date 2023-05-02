SHOW DATABASES;
USE employees;
SELECT database();
DESCRIBE employees;
/*
1. Find all current or previous employees with first names 'Irena', 'Vidya', 
or 'Maya' using IN. What is the employee number of the top three results?
*/
SELECT emp_no
FROM employees
WHERE first_name IN ('Irena','Vidya', 'Maya')
LIMIT 3;
/*
Find all current or previous employees with first names 'Irena', 'Vidya', 
or 'Maya', as in Q2, but use OR instead of IN. What is the employee number 
of the top three results? Does it match the previous question?
*/
SELECT emp_no
FROM employees
WHERE first_name = 'Irena' or 'Vidya' or 'Maya' -- Incorrect, will only find Irena
LIMIT 3;
#10200, 1397, 10610

/*
Solution: 
first_name = 'Irena' 
OR first_name = 'Vidya'
OR first_name = 'Maya'
*/

/*
3. Find all current or previous employees with first names 'Irena', 
'Vidya', or 'Maya', using OR, and who is male. What is the employee 
number of the top three results.
*/
SELECT emp_no
FROM employees
WHERE gender = "M"
AND first_name = 'Irena' or 'Vidya' or 'Maya' -- Incorrect, will only find Irena
LIMIT 3;

/*
Solution: 
first_name = 'Irena' 
OR first_name = 'Vidya'
OR first_name = 'Maya'
*/


# 4. Find all unique last names that start with 'E'
SELECT DISTINCT last_name
FROM employees
WHERE last_name LIKE "E%";

# 5. Find all unique last names that start or end with 'E'
SELECT DISTINCT last_name
FROM employees
WHERE last_name LIKE "E%" 
OR last_name LIKE "%E";

# 6. Find all uniques last names that end with E, but does not start with E?
SELECT DISTINCT last_name
FROM employees
WHERE last_name LIKE "%E" 
AND NOT last_name LIKE "E%";

# 7. Find all unique last names that start and end with E.
SELECT DISTINCT last_name
FROM employees
WHERE last_name LIKE "%E" -- Better solution WHERE last_name LIKE "E%E" 
AND last_name LIKE "E%"; 

# 8. Find all current or previous employees hired in the 90s, Ebdter a cinnebt witg tio three enplyee bumbers .
SELECT *
FROM employees
WHERE hire_date LIKE "199%"
LIMIT 3;

# 9. Find all current or previous employees born on Christmas. Enter a comment with top three employee numbers.
SELECT *
FROM employees
WHERE birth_date LIKE "%12-25"
LIMIT 3;

# 10. Find all current or previous employees hired in the 90s and born on Christmas. Enter a comment with top three employee numbers.
SELECT *
FROM employees
WHERE hire_date LIKE "199%"
AND birth_date LIKE "%12-25"
LIMIT 3;

# 11. Find all unique last names that have a 'q' in their last name
SELECT DISTINCT last_name
FROM employees
WHERE last_name LIKE "%q%";

# 12. Find all unique last names that have a 'q' in their last name but not 'qu'.
SELECT DISTINCT last_name
FROM employees
WHERE last_name LIKE "%q%"
AND last_name NOT LIKE "%qu%";
