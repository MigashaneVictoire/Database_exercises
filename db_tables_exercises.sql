-- 3. See all available databases
SHOW DATABASES; 

-- 4. Avoid using the dot (.) notation by using USE
USE albums_db;

# 5. Show the database that we are using
SELECT database();

-- 6. See all available table
SHOW TABLES; 

# 7. Switch to a different database
USE employees;

# 8. Showe the new current database
SELECT DATABASE();

# 9. Show the tables in my current database
SHOW TABLES;

# shoe how the table was created
SHOW CREATE TABLE employees;
-- int, date, varchar(14), varchar(16), enum("M", "F"), date

DESCRIBE employees; -- used this syntax to solve question 11 to 13
# 11. Which table(s) do you think contain a numeric type column? (Write this question and your answer in a comment)
/* These table contains numeric datatypes:
dept_emp
dept_manager
salaries

*/
# 12. Which table(s) do you think contain a string type column? (Write this question and your answer in a comment)
/*
These table contains numeric datatypes:
departments
dept_emp
dept_manager
employees
*/

# Which table(s) do you think contain a date type column? (Write this question and your answer in a comment)
/*
These table contains numeric datatypes:
dept_emp
dept_manager
employees
salaries
titles
*/

# What is the relationship between the employees and the departments tables? (Write this question and your answer in a comment)
/*
departements has impormation about the department but employees has a detailed column description for employees
*/

# Show the SQL that created the dept_manager table. Write the SQL it takes to show this as your exercise solution.
-- SHOW CREATE TABLE dept_manager;



