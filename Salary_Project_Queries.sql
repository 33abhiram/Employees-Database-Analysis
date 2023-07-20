/*
	I was curios about this employees database i found on github so I decided to implement a statistical data analysis on it to answer my question:
	What are the factors that affect an employees salary in the company?

	My hypothesis is that the following factors would possibly affect an employee's salary:
	years of experience/age
	job title
	department
	is a manager
	gender

	In order to test my hypothesis and find answers, I created several queries in sql and visualizations in tableau.
    Here are my SQL queries written in MySQL!
*/

# What is the average salary of a contract in the company?
SELECT 
    ROUND(AVG(salary), 2) AS average_salary
FROM
    salaries;

# What is the average employee salary by their hire age (years of experience)?
# I first create a table with a new field called hire_age that contains the age each employee was hired at.
CREATE TABLE emp_hire_age SELECT *, FLOOR(DATEDIFF(hire_date, birth_date) / 365) AS hire_age FROM
    employees;
    
# Query to retreive average salary by hire age
SELECT 
    e.hire_age, e.gender, ROUND(AVG(s.salary), 2) AS average_salary
FROM
    emp_hire_age e
        JOIN
    salaries s ON e.emp_no = s.emp_no
GROUP BY hire_age, gender
ORDER BY hire_age ASC;

# Average employee salary by department?
SELECT 
    d.dept_name, ROUND(AVG(s.salary), 2) AS average_salary
FROM
    departments d
        JOIN
    dept_emp de ON d.dept_no = de.dept_no
        JOIN
    salaries s ON de.emp_no = s.emp_no
GROUP BY dept_name;

# Average employee salary by job title?
SELECT 
    t.title, ROUND(AVG(s.salary), 2) AS average_salary
FROM
    titles t
        JOIN
    salaries s ON t.emp_no = s.emp_no
GROUP BY title;

# Do managers earn higher salaries than other employees?         
SELECT 'Average Manager Salary' AS category, ROUND(AVG(s.salary), 2) AS average_salary
FROM dept_manager m
JOIN salaries s ON m.emp_no = s.emp_no
WHERE s.from_date >= m.from_date
UNION
SELECT 'Average Employee Salary' AS category, ROUND(AVG(salary), 2) AS average_salary
FROM salaries
WHERE salary NOT IN (
        SELECT s.salary
        FROM dept_manager m
        JOIN salaries s ON m.emp_no = s.emp_no
        WHERE s.from_date >= m.from_date
    );
    
# Does gender play a role in employee salary?
# Average salary by gender across all departments and job titles
SELECT 
    e.gender,
    d.dept_name,
    t.title,
    ROUND(AVG(s.salary), 2) AS average_salary
FROM
    employees e
        JOIN
    dept_emp de ON e.emp_no = de.emp_no
        JOIN
    departments d ON de.dept_no = d.dept_no
        JOIN
    titles t ON e.emp_no = t.emp_no
        JOIN
    salaries s ON t.emp_no = s.emp_no
GROUP BY gender , dept_name , title
ORDER BY dept_name , title , gender;

# HELPER PROCEDURE AND FUNCTION
# A procedure that takes in an employee number to obtain an output containing the department and avaerage contract salary of the employee.
DROP procedure IF EXISTS last_dept;

DELIMITER $$
CREATE PROCEDURE last_dept (in p_emp_no integer)
BEGIN
SELECT
    e.emp_no, d.dept_no, d.dept_name, ROUND(AVG(s.salary), 2) AS average_salary
FROM
    employees e
		JOIN 
	salaries s on e.emp_no = s.emp_no
        JOIN
    dept_emp de ON e.emp_no = de.emp_no
        JOIN
    departments d ON de.dept_no = d.dept_no
WHERE
    e.emp_no = p_emp_no
        AND de.from_date = (SELECT
            MAX(from_date)
        FROM
            dept_emp
        WHERE
            emp_no = p_emp_no)
GROUP BY
	e.emp_no, d.dept_no, d.dept_name;
END$$
DELIMITER ;

call employees.last_dept(10010);

# A function that retrieves the largest contract salary value of an employee.
DROP FUNCTION IF EXISTS f_highest_salary;

DELIMITER $$
CREATE FUNCTION f_highest_salary (p_emp_no INTEGER) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN

DECLARE v_highest_salary DECIMAL(10,2);

SELECT
    MAX(s.salary)
INTO v_highest_salary FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.emp_no = p_emp_no;

RETURN v_highest_salary;
END$$

DELIMITER ;

SELECT f_highest_salary(10010);






    

    

