-- Select all columns/rows in a table 

SELECT *
FROM hr.employees;

SELECT *
FROM hr.departments;

-- Select specific colums

SELECT DEPARTMENT_ID, DEPARTMENT_NAME
FROM hr.departments;

-- Arithmetic expressions (+, -, *, /)

SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, SALARY+100, SALARY+(SALARY*0.10)
FROM hr.employees;

-- Column alias (Renames a column heading)

Select LAST_NAME, LAST_NAME AS name, LAST_NAME lname, LAST_NAME " LAS Name"
FROM hr.employees;

-- Concatenation Operator || Links colums or character strings
-- Literal (A literal is a character, a number, or date that is included in the select statement)

SELECT FIRST_NAME, LAST_NAME, FIRST_NAME||LAST_NAME " Full Name "
FROM hr.employees;

SELECT FIRST_NAME|| ' work in department '|| DEPARTMENT_ID
FROM hr.employees;

-- DISTINCT for olny distinct values

SELECT DISTINCT DEPARTMENT_ID
FROM hr.employees;

SELECT DISTINCT DEPARTMENT_ID, JOB_ID
FROM hr.employees;

-- Describe or DESC command to display the structure of a table

DESC HR.employees;

-- We use WHERE to limit the Rows That Are Selected and it come always after the FROM clause
SELECT * 
FROM EMPLOYEES
WHERE DEPARTMENT_ID=90;

SELECT * 
FROM EMPLOYEES
WHERE salary=24000;

-- Using where in char column 
SELECT EMPLOYEE_ID, FIRST_NAME, last_name, JOB_ID
FROM EMPLOYEES
WHERE FIRST_NAME='Steven';

-- Data is Case sensitive
SELECT EMPLOYEE_ID, FIRST_NAME, last_name, JOB_ID
FROM EMPLOYEES
WHERE FIRST_NAME='steven';

-- Using where in date column, default date display format is DD-MON-RR and date values are format-sensitive.
SELECT * 
FROM   EMPLOYEES
WHERE  HIRE_DATE = '17-OCT-03' ;

-- Using comparison operators

SELECT * 
FROM EMPLOYEES
WHERE SALARY>=10000;

SELECT * 
FROM   employees
WHERE  HIRE_DATE > '17-OCT-03' ;

SELECT * 
FROM EMPLOYEES
WHERE FIRST_NAME>'Alberto';

SELECT * 
FROM EMPLOYEES
WHERE FIRST_NAME>'Alberto'
order by FIRST_NAME;

SELECT * 
FROM EMPLOYEES
WHERE FIRST_NAME<'Alberto'
order by FIRST_NAME;









