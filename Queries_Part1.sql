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

-- Using between and. always the  lower limit first, then higher limit

SELECT * FROM EMPLOYEES
WHERE SALARY BETWEEN 10000 AND 20000;

-- We can use operators also IN varchar columns
SELECT * FROM EMPLOYEES
WHERE FIRST_NAME BETWEEN 'A' AND 'C'
order by FIRST_NAME;  

SELECT * FROM EMPLOYEES
order by FIRST_NAME

-- Using the IN operator. Here the order is not important
SELECT * FROM EMPLOYEES
WHERE SALARY IN (10000, 25000,17000);

/* Using the like operator and it comes usualy with _ and %
% mean zero or more characters
_ mean one character
*/

--ALL THE FIRST NAME which sart with S
SELECT * FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'S%'; 

--ALL THE FIRST NAME which end  with s
SELECT * FROM EMPLOYEES
WHERE FIRST_NAME LIKE '%s'; 

--ALL THE FIRST NAME which include am 
SELECT * FROM EMPLOYEES
WHERE FIRST_NAME LIKE '%am%'; 

-- The first_name which has d in second letter
SELECT * FROM EMPLOYEES
WHERE FIRST_NAME LIKE '_d%';

-- The first_name which has s in third letter
SELECT * FROM EMPLOYEES
WHERE FIRST_NAME LIKE '__s%';

/*
Supose there is value in any column contain _  or %  ( example job_id)
then how you to search for theses Letters?
For example I need all the job_id which contain the string SA_ 
*/

SELECT JOB_ID 
FROM  JOBS
WHERE JOB_ID LIKE 'SA/_%' escape '/';

-- Using is null operator

SELECT first_name, COMMISSION_PCT
FROM EMPLOYEES;

-- Pick all the employes who doesnt have commesion
SELECT * 
FROM EMPLOYEES
where COMMISSION_PCT is null; 

/* COMMISSION_PCT=' ' is not correct 
SELECT * 
FROM EMPLOYEES
where COMMISSION_PCT=null;
*/

-- Using not whic can be used in =  not like, not in , is not null , not between  and 

-- All the employees that doesn´t have ID equal to 100 or 101
SELECT * 
FROM EMPLOYEES
WHERE EMPLOYEE_ID NOT IN (100, 101);

-- All the employees that have commission
SELECT * 
FROM EMPLOYEES
where COMMISSION_PCT is not null;

-- All the frist name which does not start with "S"
SELECT * FROM EMPLOYEES
WHERE FIRST_NAME not LIKE 'S%'; 

-- Different ways to write "different". The next 2 queries are the same

SELECT * 
FROM employees
WHERE DEPARTMENT_ID<>50;

SELECT * 
FROM employees
WHERE DEPARTMENT_ID !=50;

-- Defining Conditions Using the Logical Operators ( and/ or /  not )

-- AND requires both the component conditions to be true
SELECT employee_id, last_name, job_id, salary, DEPARTMENT_ID
FROM   employees
WHERE  SALARY >= 10000
AND    DEPARTMENT_ID=90;

-- OR requires either component condition to be true
SELECT employee_id, last_name, job_id, salary, DEPARTMENT_ID
FROM   employees
WHERE  SALARY >= 10000
OR    DEPARTMENT_ID=90;

-- 3 AND
SELECT employee_id, last_name, job_id, salary, DEPARTMENT_ID,COMMISSION_PCT
FROM   employees
WHERE  SALARY > 2000
AND    DEPARTMENT_ID in (60,90)
AND COMMISSION_PCT is null






