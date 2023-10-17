# Employees Database Analysis

## Project Goal
I analyzed a sample employees dataset comprising around 1 million rows of salary data since I was curious about the general factors that affect an employee's salary in a company. To find answers, I used key SQL concepts like joins, subqueries and stored procedures, combined with data visualization in tableau to create an Interactive Dashboard that showcases some of the factors that affect an employee's salary. The full dashboard can be found on Tableau public server: https://public.tableau.com/app/profile/abhiram.naredla/viz/Salary_Project_Dashboard/EmployeeSalaryDashboard

## Data Dictionary
The file employees.zip contains a employees.sql file that contains the employees database and all of the following tables.

### employees table
emp_no - employee unique id

birth_date - birth date

first_name - first name

last_name - last name

gender - gender

hire_date - hire date

### departments table
dept_no - department unique id

dept_name - department name

### salaries table
emp_no - employee unique id

salary - salary

from_date - salary from date

to_date - salary to date

### titles table
emp_no - employee unique id

title - job title

from_date - job title from date

to_date - job title to date

### dept_manager table
dept_no - department unique id

emp_no - employee unique id

from_date - manager from date

to_date - manager to date

## Results
The results of my meticulous analysis show that the factors that affect an employee's salary are age, department and position in the company. Managers and Senior Staff members, and employees that work in lucrative departments like marketing and sales tend to earn higher salaries. Moreover, older employees tend to earn higher wages due to their valuable experience and ability to perform a task better than youngsters. Through thorough data analysis, I provide my audience with a general understanding of the drivers behind employee pay in a business.
