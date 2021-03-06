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

-- All the employees that doesn??t have ID equal to 100 or 101
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

/* Here the priorities in this select have are 2 conditions
   First condition  JOB_ID = 'AD_PRES' and SALARY > 15000
   Second condition JOB_ID = 'SA_REP'
*/

SELECT last_name, job_id, salary
FROM   employees
WHERE  JOB_ID = 'SA_REP'
OR     JOB_ID = 'AD_PRES' AND    SALARY > 15000;

--  Above and this query are the same  
SELECT last_name, job_id, salary
FROM   employees
WHERE  JOB_ID = 'SA_REP'
OR     (JOB_ID = 'AD_PRES' AND    SALARY > 15000);

-- Whith parantheses () you can override and/or priorities
SELECT last_name, job_id, salary
FROM   EMPLOYEES
WHERE  (job_id = 'SA_REP' OR     job_id = 'AD_PRES')
AND    SALARY > 15000;


-- Using order by 

--Default order always ASC: Ascending 
SELECT * FROM EMPLOYEES
ORDER BY HIRE_DATE; 


SELECT * FROM EMPLOYEES
ORDER BY HIRE_DATE ASC; 

-- Order by desc: Descending 
SELECT * FROM EMPLOYEES
ORDER BY HIRE_DATE desc; 

-- Using where and order by
SELECT * FROM EMPLOYEES
WHERE DEPARTMENT_ID=90
ORDER BY EMPLOYEE_ID;

-- Null values in order by. By default null come last in Ascending order
SELECT * FROM EMPLOYEES
ORDER BY COMMISSION_PCT ; 

---- By default null come first in Descending order
SELECT * FROM EMPLOYEES
ORDER BY COMMISSION_PCT desc 

-- We can use NULLS FIRST to make null values appear first
SELECT * FROM EMPLOYEES
ORDER BY COMMISSION_PCT NULLS FIRST;

-- We you can sort also using column alias
SELECT FIRST_NAME n
FROM EMPLOYEES
ORDER BY N;

-- We can sort by Expression
SELECT EMPLOYEE_ID , SALARY, SALARY+100
FROM EMPLOYEES
order by SALARY+100;

-- We can sort by column not in the select even but this is not logical 

SELECT EMPLOYEE_ID , SALARY
FROM EMPLOYEES
order by DEPARTMENT_ID;

-- We can also sort by more than one column

SELECT DEPARTMENT_ID,first_name,salary
FROM EMPLOYEES
ORDER BY DEPARTMENT_ID,FIRST_NAME;

SELECT DEPARTMENT_ID,first_name,salary
FROM EMPLOYEES
ORDER BY DEPARTMENT_ID ASC ,FIRST_NAME DESC ;


-- We can sory by column number in the select

-- Here 1 means the first column in select which is the DEPARTMENT_ID
SELECT DEPARTMENT_ID,first_name,salary
FROM EMPLOYEES
ORDER BY 1; 

SELECT DEPARTMENT_ID,first_name,salary
FROM EMPLOYEES
ORDER BY 1,3; 

--Using SQL Row Limiting Clause in a Query

SELECT employee_id, first_name
FROM EMPLOYEES
ORDER BY EMPLOYEE_ID
FETCH first 5 ROWS ONLY;
 
SELECT employee_id, first_name
FROM EMPLOYEES
ORDER BY EMPLOYEE_ID
FETCH first 50 PERCENT ROWS ONLY;
 
SELECT employee_id, first_name
FROM employees
ORDER BY EMPLOYEE_ID
offset 5 ROWS FETCH NEXT 5 ROWS ONLY;

SELECT employee_id, first_name
FROM EMPLOYEES
ORDER BY EMPLOYEE_ID
offset 4 ROWS FETCH NEXT 50 PERCENT ROWS ONLY;

--If multiple rows share the same value and we do this only the first 2 will appear ignoring the ones that have the same value
SELECT EMPLOYEE_ID, first_name,SALARY
FROM EMPLOYEES
ORDER BY SALARY DESC
FETCH FIRST 2 ROWS  only;

-- For that we can use the TIES command which will bring them
SELECT EMPLOYEE_ID,first_name, SALARY
FROM EMPLOYEES
ORDER BY SALARY DESC
FETCH FIRST 2 ROWS  with TIES;


